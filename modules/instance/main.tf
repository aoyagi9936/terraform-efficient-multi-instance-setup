variable inst_num    {}
variable inst_prop   {}
variable inst_nw     {}
variable inst_nw_sub {}

resource "google_compute_instance" "default" {
  count        = var.inst_num
  
  name         = var.inst_prop[count.index].name
  machine_type = var.inst_prop[count.index].machine_type
  zone         = var.inst_prop[count.index].zone

  tags = var.inst_prop[count.index].tags

  boot_disk {
    initialize_params {
      image = var.inst_prop[count.index].image
    }
  }

  network_interface {
    network    = var.inst_nw
    subnetwork = var.inst_nw_sub
    network_ip = var.inst_prop[count.index].private_ip    
  }

  scheduling {
    preemptible       = var.inst_prop[count.index].preemptible
    automatic_restart = var.inst_prop[count.index].automatic_restart
  }
}
