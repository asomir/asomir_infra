variable region {
 description = "Region"
 default = "europe-west1"
}
variable zone {
 description = "Zone"
 default = "europe-west1-b"
}
variable app_disk_image {
 description = "Disk image for reddit app"
 default = "reddit-app-base-20180104-125540"
}
variable public_key_path {
 description = "Path to the public key used for ssh access"
}
#variable private_key_path {
# description = "Path to the private key used for ssh access"
#}