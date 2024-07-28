variable "vm_map1" {
  description = "Map of VMs for the first group"
  type = map(object({
    name = string
  }))
  default = {
    vm1 = {
      name = "vm1"
    }
    vm2 = {
      name = "vm2"
    }
    vm3 = {
      name = "vm3"
    }
    vm4 = {
      name = "vm4"
    }
  }
}

variable "vm_ip1" {
  description = "Map of VMs and their IPs for the first group"
  type = map(object({
    name = string
    ip   = list(string)
  }))
  default = {
    vm1 = {
      name = "vm1"
      ip   = ["10.0.0.10"]
    }
    vm2 = {
      name = "vm2"
      ip   = ["10.0.0.11"]
    }
    vm3 = {
      name = "vm3"
      ip   = ["10.0.0.12"]
    }
    vm4 = {
      name = "vm4"
      ip   = ["10.0.0.13"]
    }
  }
}

variable "vm_map2" {
  description = "Map of VMs for the second group"
  type = map(object({
    name = string
  }))
  default = {
    vm1 = {
      name = "vm5"
    }
    vm2 = {
      name = "vm6"
    }
    vm3 = {
      name = "vm7"
    }
    vm4 = {
      name = "vm8"
    }
  }
}

variable "vm_ip2" {
  description = "Map of VMs and their IPs for the second group"
  type = map(object({
    name = string
    ip   = list(string)
  }))
  default = {
    vm1 = {
      name = "vm5"
      ip   = ["10.0.2.10"]
    }
    vm2 = {
      name = "vm6"
      ip   = ["10.0.2.11"]
    }
    vm3 = {
      name = "vm7"
      ip   = ["10.0.2.12"]
    }
    vm4 = {
      name = "vm8"
      ip   = ["10.0.2.13"]
    }
  }
}
