tenancy_ocid = "tenant-id"
compartment  = "cmp-networking"
vcn_name     = "vcn-name"

security_lists = {
  sec-list-name = {
    compartment_id = null
    defined_tags   = {}
    freeform_tags  = null
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
}