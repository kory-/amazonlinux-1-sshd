# amazonlinux-1-sshd

docker amazonlinux version1 image
use docker-compose

need   
`id_rsa.pub`

build  
`docker-compose build`

run  
`docker-compose up -d`

ssh  
`ssh -i <id_rsa> ec2-user@localhost -p 2022`
