## Overview
This script is an example to create multiple instances using complex objects that be passed to child modules as inputs.

## Requirement
Required Terraform Version >= 0.12

The link below is an example to execute terraform with docker-compose.  
[docker-compose-examples](https://github.com/aoyagi9936/docker-compose-examples/tree/master/terraform/gcp)

## Usage

### Define terraform variables
```
variable "instances" {
  type = list(object({
    name         = string
    machine_type = string
    zone         = string
    tags         = list(string)
    image        = string
    private_ip   = string
    preemptible  = bool
    automatic_restart = bool
  }))
  
  default = [
    {
      name         = "instance-1"
      machine_type = "f1-micro"
      zone         = "us-central1-a"
      tags         = ["web"]      
      image        = "debian-cloud/debian-9"
      private_ip   = "10.1.0.10"
      preemptible  = true
      automatic_restart = false
    },
    {
      name         = "instance-2"
      machine_type = "f1-micro"
      zone         = "us-central1-b"
      tags         = ["db"]
      image        = "centos-cloud/centos-7"
      private_ip   = "10.1.0.11"
      preemptible  = true
      automatic_restart = false
    },
    {
      name         = "instance-3"
      machine_type = "f1-micro"
      zone         = "us-central1-c"
      tags         = ["cache"]
      image        = "ubuntu-os-cloud/ubuntu-1804-lts"
      private_ip   = "10.1.0.12"
      preemptible  = true
      automatic_restart = false
    }
  ]
}
```

### Set to module variables
```
module "module_instance" {
  source = "./modules/instance"
  inst_num    = "${length(var.instances)}"
  inst_prop   = "${var.instances}"
  inst_nw     = "${google_compute_network.private-network.self_link}"
  inst_nw_sub = "${google_compute_subnetwork.private-network-subnet.self_link}"
}
```

### Execute terraform
```shell
$ docker-compose terraform --rm init
$ docker-compose terraform --rm plan
$ docker-compose terraform --rm apply
```
