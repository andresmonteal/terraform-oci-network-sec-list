# default values
locals {
  #general defaults
  compartment_id = try(data.oci_identity_compartments.compartment[0].compartments[0].id, var.compartment_id)
  vcn_id         = try(data.oci_core_vcns.vcns[0].virtual_networks[0].id, var.vcn_id)
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-network-sec-list"
  }

  #security list defaults  
  default_security_list_opt = {
    display_name = "sl-default-${var.sn_name}"
    egress_rules = [
      {
        stateless       = false
        descriptionrule = "Egress all"
        protocol        = "all"
        dst             = "0.0.0.0/0"
        dst_type        = "CIDR_BLOCK"
        src             = null
        src_type        = null
        src_port        = null
        dst_port        = null
        icmp_type       = null
        icmp_code       = null
      }
    ]
    ingress_rules = [
      {
        stateless       = false
        descriptionrule = "Ingress all"
        protocol        = "all"
        src             = "0.0.0.0/0"
        src_type        = "CIDR_BLOCK"
        src_port        = null
        dst             = null
        dst_type        = null
        dst_port        = null
        icmp_type       = null
        icmp_code       = null
      }
    ]
  }
  sec_list_keys = keys(var.security_lists)

  #nsg defaults      
  default_nsgs_opt = {
    display_name   = "unnamed"
    compartment_id = null
    ingress_rules  = []
    egress_rules   = []
  }
  nsgs_keys        = keys(var.nsgs)
  local_nsg_ids    = { for i in oci_core_network_security_group.this : i.display_name => i.id }
  remote_nsg_ids   = { for i in data.oci_core_network_security_groups.this.network_security_groups : i.display_name => i.id }
  nsg_ids          = merge(local.remote_nsg_ids, local.local_nsg_ids)
  nsg_ids_reversed = { for k, v in local.nsg_ids : v => k }
}