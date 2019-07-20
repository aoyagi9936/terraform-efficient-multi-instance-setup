variable "project" {
  type = "map"
  default = {
    project_id = "[YOUR_PROJECT_ID]"
    region     = "[YOUR_REGION]"
  }
}

variable "network" {
  type = "map"
  default = {    
    vpc_name        = "my-network"
    region          = "us-central1"
    ip_cidr_range   = "10.1.0.0/16"
    vpc_subnet_name = "my-network-subnet"
  }
}

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
