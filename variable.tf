variable "firstvar" {
  validation {
    condition = can(index(["w", "a"], var.firstvar))
    error_message = "Outside expected values"
  }
}

variable "edgerc_path" {
  type = string
  description = "edgerc key path"
  //default = "~/.edgerc"
}

variable "config_section" {
  type = string
  description = "Edgerc section to be used"
  //default = "EMEA Sec Services"
}