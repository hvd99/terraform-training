output "output_group" {
    value = data.akamai_group.my_group.id
}

output "output_appsec_config" {
    value = data.akamai_appsec_configuration.my_config.id
}

output "output_property" {
  value = data.akamai_property.my_property.id
}

output "output_appsec_config_contractid" {
    value = data.akamai_group.my_group.contract_id
}

/*
output "output_edgehostname_id" {
  value = resource.akamai_edge_hostname.my_edge_hostname
}


output "existing_ehn_details" {
    value = data.akamai_property_hostnames.current_ehn
}*/

output "output_tf_property_staging_activation" {
    value = resource.akamai_property_activation.my_staging_activation
}

output "output_appsec_config_id" {
    value = resource.akamai_appsec_configuration.my_security_configuration.id
}

output "output_securitypolicy_details" {
    value = resource.akamai_appsec_security_policy.my-sec-policy
}