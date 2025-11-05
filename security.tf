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

resource "akamai_appsec_match_target" "my-match-target" {
  config_id    = resource.akamai_appsec_configuration.my_security_configuration.id
  match_target = jsonencode(
    {
      "type": "website",
      "isNegativePathMatch": false,
      "isNegativeFileExtensionMatch": false,
      "hostnames": [
        "www.hvdtflab.com",
      ],
      "filePaths": [
        "/*"
      ],
      "securityPolicy": {
        "policyId": akamai_appsec_security_policy.my-sec-policy.security_policy_id
      }
    }
  )
}