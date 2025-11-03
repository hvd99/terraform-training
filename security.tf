//Creating security config

resource "akamai_appsec_configuration" "my_security_configuration" {
 name        = "hvd-tf-security-config"
 description = "This is my new configuration using Terraform."
 contract_id = substr(data.akamai_group.my_group.contract_id, 4, -1)
 group_id    = data.akamai_group.my_group.id
 host_names  = ["www.hvdtflab.com"]
}

//Creating security policy
resource "akamai_appsec_security_policy" "my-sec-policy" {
  config_id              = resource.akamai_appsec_configuration.my_security_configuration.id
  security_policy_name   = "hvd-policy1"
  security_policy_prefix = "hvtf"
}


// match target

resource "akamai_appsec_aap_selected_hostnames" "my_aap_selected_hostnames" {
  config_id = resource.akamai_appsec_configuration.my_security_configuration.id
  protected_hosts = resource.akamai_appsec_configuration.my_security_configuration.host_names
  security_policy_id = akamai_appsec_security_policy.my-sec-policy.security_policy_id
}