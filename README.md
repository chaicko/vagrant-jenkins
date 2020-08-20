Run latest Jenkins instance on Ubuntu 18.04 LTS using vagrant.

## Prerequisites
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [Ansible](https://www.ansible.com/)

## Installation
Build the vagrant box

```
vagrant up
```

To access the Jenkins server

```
http://localhost:8080
```

or, add the following line to the hosts file

```
127.0.0.1   jenkins.local
```

and then run the server with

```
http://jenkins.local:8080
```

## First time accessing Jenkins

Jenkins is set up with one user with
```
username: admin
password: admin
```
usual caveat about changing the password once setup.

## Acknowledgements

* [darkwizard242](https://github.com/darkwizard242/devopsubuntu1804)
