
data "template_file" "pumaservice" {
  template = "${file("${path.module}/files/puma.service.tpl")}"

  vars {
    db_address = "${var.db_address}"
  }
}
# Создаём машинку в гугле с именем App
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  provisioner "file" {
    content = "${data.template_file.pumaservice.rendered}"
    destination = "/tmp/puma.service"
  }

 metadata {
    sshKeys = "asomirl:${file(var.public_key_path)}"
  }

 connection {
    type        = "ssh"
    user        = "asomirl"
    agent       = "false"
    private_key = "${file(var.private_key_path)}"
  }

  # Выполняем наш скрыпт деплоя
 provisioner "remote-exec" {
 	script = "${path.module}/files/deploy.sh"
	}

}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

# Создание правила для firewall
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

