module "oci_security_policies" {
  source = "git::ssh://devops.scmservice.us-ashburn-1.oci.oraclecloud.com/namespaces/id9de6bj2yv6/projects/claro-devops/repositories/terraform-oci-network-sec-list?ref=v0.2.3"

  for_each = var.security_lists

  default_compartment_id = data.oci_identity_compartments.network_cmp[each.key].compartments[0].id
  vcn_id                 = data.oci_core_vcns.vcns[each.key].virtual_networks[0].id

  security_lists = each.value["security_list"]
}