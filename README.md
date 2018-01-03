# HomeWork 07

## Билд с применением файла с переменными

packer build -var-file=variables.json ubuntu16.json

# HomeWork 05
## Подключение к Someinternalhost в одну строку
 $ ssh -At asomirl@35.205.183.251 ssh 10.132.0.3 Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.13.0-1002-gcp x86_64)

Documentation: https://help.ubuntu.com
Management: https://landscape.canonical.com
Support: https://ubuntu.com/advantage
Get cloud support with Ubuntu Advantage Cloud Guest: http://www.ubuntu.com/business/services/cloud

0 packages can be updated. 0 updates are security updates.

Last login: Mon Dec 18 20:46:42 2017 from 10.132.0.2

Подключение в одну команду
На локальной машине прописываем в ~/.ssh/config следующее:

Host bastion Hostname 35.205.183.251 User asomirl CertificateFile ~/ssh/asomirl Host someinternalhost Hostname 10.132.0.3 User asomirl CertificateFile ~/ssh/asomirl ProxyCommand ssh bastion -W %h:%p 

Затем можем подключиться командой

'''ssh someinternalhost'''

Host bastion internal ip 10.132.0.2 external ip 35.205.183.251 Host someinternalhost	internal ip 10.132.0.3

# Homework 06
## Startup script, который будет запускаться для создания инстанса.

gcloud compute instances create reddit-app-3 --zone=europe-west1-d --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --metadata-from-file startup-script=startup_script.sh --restart-on-failure

## Скрипт создания правил Файрволла для Пума сервера с 9292 портом

gcloud compute --project=infra-189218 firewall-rules create default-puma-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:9292 --source-ranges=0.0.0.0/0 --target-tags=puma-server 

