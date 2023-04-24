data "oci_identity_compartments" "network_cmp" {

  for_each       = var.security_lists
  compartment_id = var.tenancy_ocid
  name           = each.value["network_cmp"]
}

data "oci_core_vcns" "vcns" {

  for_each       = var.security_lists
  compartment_id = data.oci_identity_compartments.network_cmp[each.key].compartments[0].id
  display_name   = each.value["vcn"]
}