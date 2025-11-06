//Create a new hostname to test this

resource "akamai_edge_hostname" "my_edge_hostname" {
  product_id    = "prd_SPM"
  contract_id   = data.akamai_group.my_group.contract_id
  group_id      = data.akamai_group.my_group.id
  edge_hostname = "hvdtflab.com.edgesuite.net"
  ip_behavior   = "IPV4"
}

resource "akamai_property" "my-tf-property" {
    name        = "hvd-tf-lab-stuff"
    product_id  = "prd_SPM"
    contract_id = data.akamai_group.my_group.contract_id
    group_id    = data.akamai_group.my_group.id
    rule_format = "latest"
    hostnames {                                     # Hostname configuration
      cname_from = "www.hvdtflab.com"
      cname_to = "hvdtflab.com.edgesuite.net"
      cert_provisioning_type = "CPS_MANAGED"
    }

    dynamic "hostnames" {
      for_each = local.apps_hostnames
      content {
        cname_from = hostnames.value
        cname_to = "hvdtflab.com.edgesuite.net"
        cert_provisioning_type = "CPS_MANAGED"
      }
    }
    rules       = data.akamai_property_rules_template.template-update.json
}

//staging activation resource
resource "akamai_property_activation" "my_staging_activation" {
  property_id = data.akamai_property.my_tf_property.id
  contact     = ["hvardhan@akamai.com"]
  version     = resource.akamai_property.my-tf-property.latest_version
  network     = "staging"
  note        = "Activating my property on staging via terraform"
  depends_on = [ akamai_property.my-tf-property ]
}

#--Practice below---------------------------

variable "example_domains" {
  default = [ "www", "api", "blog", "shop", "cdn"]
}

locals {
  apps_hostnames = [for domain in var.example_domains : "${domain}.hvdtflab.com"]
}