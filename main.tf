data "akamai_group" "my_group" {
     group_name   = "Harsh V"
     contract_id  = "ctr_M-26EUYKK"
}

data "akamai_appsec_configuration" "my_config" {
  name = "hvd-security-stuff"
}

data "akamai_property" "my_property" {
    name = "hvd-lab-stuff"
    version = "1"
}

data "akamai_property_hostnames" "current_ehn" {
  group_id = data.akamai_group.my_group.id
  contract_id = data.akamai_group.my_group.contract_id
  property_id = data.akamai_property.my_property.id
}

data "akamai_property_rules_template" "template-update" {
  template_file = abspath("${path.root}/main.json")
}

data "akamai_property" "my_tf_property" {
  name =  resource.akamai_property.my-tf-property.name
  version = resource.akamai_property.my-tf-property.latest_version
}

locals {
  notes = join("-", ["TF-3001", "${data.akamai_group.my_group.id}"])
}