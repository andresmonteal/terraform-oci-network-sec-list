# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

######################
# Security List(s)
######################

# resource definitions
resource "oci_core_security_list" "this" {
  count          = length(local.sec_list_keys) == 0 ? 1 : length(local.sec_list_keys)
  compartment_id = local.compartment_id
  vcn_id         = local.vcn_id
  display_name   = can(local.sec_list_keys[count.index]) ? local.sec_list_keys[count.index] : "${local.default_security_list_opt.display_name}-${count.index}"
  defined_tags   = try(var.security_lists[local.sec_list_keys[count.index]].defined_tags, {})
  freeform_tags  = can(local.sec_list_keys[count.index]) ? merge(var.security_lists[local.sec_list_keys[count.index]].freeform_tags, local.default_freeform_tags) : local.default_freeform_tags

  #  egress, proto: TCP  - no src port, no dst port
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        descriptionrule : x.descriptionrule
    } if x.protocol == "6" && x.src_port == null && x.dst_port == null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule
    }
  }

  #  egress, proto: TCP  - src port, no dst port
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        src_port_min : x.src_port.min
        src_port_max : x.src_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "6" && x.src_port != null && x.dst_port == null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule

      tcp_options {
        source_port_range {
          max = rule.value.src_port_max
          min = rule.value.src_port_min
        }
      }
    }
  }

  #  egress, proto: TCP  - no src port, dst port
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        dst_port_min : x.dst_port.min
        dst_port_max : x.dst_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "6" && x.src_port == null && x.dst_port != null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule

      tcp_options {
        max = rule.value.dst_port_max
        min = rule.value.dst_port_min
      }
    }
  }

  #  egress, proto: TCP  - src port, dst port
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        src_port_min : x.src_port.min
        src_port_max : x.src_port.max
        dst_port_min : x.dst_port.min
        dst_port_max : x.dst_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "6" && x.src_port != null && x.dst_port != null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule

      tcp_options {
        max = rule.value.dst_port_max
        min = rule.value.dst_port_min

        source_port_range {
          max = rule.value.src_port_max
          min = rule.value.src_port_min
        }
      }
    }
  }

  #  egress, proto: UDP  - no src port, no dst port
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        descriptionrule : x.descriptionrule
    } if x.protocol == "17" && x.src_port == null && x.dst_port == null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule
    }
  }

  #  egress, proto: UDP  - src port, no dst port
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        src_port_min : x.src_port.min
        src_port_max : x.src_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "17" && x.src_port != null && x.dst_port == null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule

      udp_options {
        source_port_range {
          max = rule.value.src_port_max
          min = rule.value.src_port_min
        }
      }
    }
  }

  #  egress, proto: UDP  - no src port, dst port
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        dst_port_min : x.dst_port.min
        dst_port_max : x.dst_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "17" && x.src_port == null && x.dst_port != null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule

      udp_options {
        max = rule.value.dst_port_max
        min = rule.value.dst_port_min
      }
    }
  }

  #  egress, proto: UDP  - src port, dst port
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        src_port_min : x.src_port.min
        src_port_max : x.src_port.max
        dst_port_min : x.dst_port.min
        dst_port_max : x.dst_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "17" && x.src_port != null && x.dst_port != null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule

      udp_options {
        max = rule.value.dst_port_max
        min = rule.value.dst_port_min

        source_port_range {
          max = rule.value.src_port_max
          min = rule.value.src_port_min
        }
      }
    }
  }

  #  egress, proto: ICMP  - no type, no code
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        descriptionrule : x.descriptionrule
    } if x.protocol == "1" && x.icmp_type == null && x.icmp_code == null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule
    }
  }

  #  egress, proto: ICMP  - type, no code
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        type : x.icmp_type
        descriptionrule : x.descriptionrule
    } if x.protocol == "1" && x.icmp_type != null && x.icmp_code == null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule

      icmp_options {
        type = rule.value.type
      }
    }
  }

  #  egress, proto: ICMP  - type, code
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        type : x.icmp_type
        code : x.icmp_code
        descriptionrule : x.descriptionrule
    } if x.protocol == "1" && x.icmp_type != null && x.icmp_code != null]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule

      icmp_options {
        type = rule.value.type
        code = rule.value.code
      }
    }
  }

  #  egress, proto: other (non-TCP, UDP or ICMP)
  dynamic "egress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].egress_rules : local.default_security_list_opt.egress_rules : local.default_security_list_opt.egress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        descriptionrule : x.descriptionrule
    } if x.protocol != "1" && x.protocol != "6" && x.protocol != "17"]

    content {
      protocol         = rule.value.proto
      destination      = rule.value.dst
      destination_type = rule.value.dst_type
      stateless        = rule.value.stateless
      description      = rule.value.descriptionrule
    }
  }

  # ingress, proto: TCP  - no src port, no dst port
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        descriptionrule : x.descriptionrule
    } if x.protocol == "6" && x.src_port == null && x.dst_port == null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule
    }
  }

  # ingress, proto: TCP  - src port, no dst port
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        src_port_min : x.src_port.min
        src_port_max : x.src_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "6" && x.src_port != null && x.dst_port == null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule

      tcp_options {
        source_port_range {
          max = rule.value.src_port_max
          min = rule.value.src_port_min
        }
      }
    }
  }

  # ingress, proto: TCP  - no src port, dst port
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        dst_port_min : x.dst_port.min
        dst_port_max : x.dst_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "6" && x.src_port == null && x.dst_port != null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule

      tcp_options {
        max = rule.value.dst_port_max
        min = rule.value.dst_port_min
      }
    }
  }

  # ingress, proto: TCP  - src port, dst port
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        src_port_min : x.src_port.min
        src_port_max : x.src_port.max
        dst_port_min : x.dst_port.min
        dst_port_max : x.dst_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "6" && x.src_port != null && x.dst_port != null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule

      tcp_options {
        max = rule.value.dst_port_max
        min = rule.value.dst_port_min

        source_port_range {
          max = rule.value.src_port_max
          min = rule.value.src_port_min
        }
      }
    }
  }

  # ingress, proto: UDP  - no src port, no dst port
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        descriptionrule : x.descriptionrule
    } if x.protocol == "17" && x.src_port == null && x.dst_port == null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule
    }
  }

  # ingress, proto: UDP  - src port, no dst port
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        src_port_min : x.src_port.min
        src_port_max : x.src_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "17" && x.src_port != null && x.dst_port == null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule

      udp_options {
        source_port_range {
          max = rule.value.src_port_max
          min = rule.value.src_port_min
        }
      }
    }
  }

  # ingress, proto: UDP  - no src port, dst port
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        dst_port_min : x.dst_port.min
        dst_port_max : x.dst_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "17" && x.src_port == null && x.dst_port != null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule

      udp_options {
        max = rule.value.dst_port_max
        min = rule.value.dst_port_min
      }
    }
  }

  # ingress, proto: UDP  - src port, dst port
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        src_port_min : x.src_port.min
        src_port_max : x.src_port.max
        dst_port_min : x.dst_port.min
        dst_port_max : x.dst_port.max
        descriptionrule : x.descriptionrule
    } if x.protocol == "17" && x.src_port != null && x.dst_port != null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule

      udp_options {
        max = rule.value.dst_port_max
        min = rule.value.dst_port_min

        source_port_range {
          max = rule.value.src_port_max
          min = rule.value.src_port_min
        }
      }
    }
  }

  # ingress, proto: ICMP  - no type, no code
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        dst : x.dst
        dst_type : x.dst_type
        stateless : x.stateless
        descriptionrule : x.descriptionrule
    } if x.protocol == "1" && x.icmp_type == null && x.icmp_code == null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule
    }
  }

  # ingress, proto: ICMP  - type, no code
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        type : x.icmp_type
        descriptionrule : x.descriptionrule
    } if x.protocol == "1" && x.icmp_type != null && x.icmp_code == null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule

      icmp_options {
        type = rule.value.type
      }
    }
  }

  # ingress, proto: ICMP  - type, code
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        type : x.icmp_type
        code : x.icmp_code
        descriptionrule : x.descriptionrule
    } if x.protocol == "1" && x.icmp_type != null && x.icmp_code != null]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule

      icmp_options {
        type = rule.value.type
        code = rule.value.code
      }
    }
  }

  # ingress, proto: other (non-TCP, UDP or ICMP)
  dynamic "ingress_security_rules" {
    iterator = rule
    for_each = [for x in can(local.sec_list_keys[count.index]) ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules != null ? var.security_lists[keys(var.security_lists)[count.index]].ingress_rules : local.default_security_list_opt.ingress_rules : local.default_security_list_opt.ingress_rules :
      {
        proto : x.protocol
        src : x.src
        src_type : x.src_type
        stateless : x.stateless
        descriptionrule : x.descriptionrule
    } if x.protocol != "1" && x.protocol != "6" && x.protocol != "17"]

    content {
      protocol    = rule.value.proto
      source      = rule.value.src
      source_type = rule.value.src_type
      stateless   = rule.value.stateless
      description = rule.value.descriptionrule
    }
  }
}
