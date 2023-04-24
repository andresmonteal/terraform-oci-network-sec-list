security_lists = {
  "SECURITY-LIST-NAME" = {
    vcn         = "VCN-NAME"
    network_cmp = "NETWORKING"
    security_list = {
      SECURITY-LIST-NAME = {
        compartment_id = null
        defined_tags   = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
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
  },
  "SECURITY-LIST-NAME-2" = {
    vcn         = "VCN-NAME"
    network_cmp = "NETWORKING"
    security_list = {
      SECURITY-LIST-NAME-2 = {
        compartment_id = null
        defined_tags   = { "NAMESPACE.TAG" = "VALUE", "NAMESPACE.TAG" = "VALUE-2" }
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
  }
}