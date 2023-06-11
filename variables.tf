# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "tenancy_ocid" {
  description = "(Required) (Updatable) The OCID of the root compartment."
  type        = string
  default     = null
}

variable "compartment_id" {
  type        = string
  description = "The default compartment OCID to use for resources (unless otherwise specified)."
  default     = null
}
variable "compartment" {
  description = "compartment name where to create all resources"
  type        = string
  default     = null
}

variable "vcn_id" {
  type        = string
  description = "The VCN ID where the Security List(s) should be created."
  default     = null
}

variable "vcn_name" {
  type        = string
  description = "The VCN name where the Security List(s) should be created."
  default     = null
}

variable "sn_name" {
  type        = string
  description = "The subnet name where the default Security List(s) should be created."
  default     = ""
}

variable "security_lists" {
  type = map(object({
    compartment_id = string,
    defined_tags   = map(string),
    freeform_tags  = map(string),
    ingress_rules = list(object({
      stateless       = bool,
      descriptionrule = string,
      protocol        = string,
      src             = string,
      src_type        = string,
      src_port = object({
        min = number,
        max = number
      }),
      dst_port = object({
        min = number,
        max = number
      }),
      icmp_type = number,
      icmp_code = number
    })),
    egress_rules = list(object({
      stateless       = bool,
      descriptionrule = string,
      protocol        = string,
      dst             = string,
      dst_type        = string,
      src_port = object({
        min = number,
        max = number
      }),
      dst_port = object({
        min = number,
        max = number
      }),
      icmp_type = number,
      icmp_code = number
    }))
  }))
  description = "Parameters for customizing Security List(s)."
  default     = {}
}

variable "nsgs" {
  type = map(object({
    compartment_id = string,
    defined_tags   = map(string),
    freeform_tags  = map(string),
    ingress_rules = list(object({
      description = string,
      stateless   = bool,
      protocol    = string,
      src         = string,
      # Allowed values: CIDR_BLOCK, SERVICE_CIDR_BLOCK, NETWORK_SECURITY_GROUP, NSG_NAME
      src_type = string,
      src_port = object({
        min = number,
        max = number
      }),
      dst_port = object({
        min = number,
        max = number
      }),
      icmp_type = number,
      icmp_code = number
    })),
    egress_rules = list(object({
      description = string,
      stateless   = bool,
      protocol    = string,
      dst         = string,
      # Allowed values: CIDR_BLOCK, SERVICE_CIDR_BLOCK, NETWORK_SECURITY_GROUP, NSG_NAME
      dst_type = string,
      src_port = object({
        min = number,
        max = number
      }),
      dst_port = object({
        min = number,
        max = number
      }),
      icmp_type = number,
      icmp_code = number
    }))
  }))
  description = "Parameters for customizing Network Security Group(s)."
  default     = {}
}

variable "standalone_nsg_rules" {
  type = object({
    ingress_rules = list(object({
      nsg_id      = string,
      description = string,
      stateless   = bool,
      protocol    = string,
      src         = string,
      # Allowed values: CIDR_BLOCK, SERVICE_CIDR_BLOCK, NETWORK_SECURITY_GROUP, NSG_NAME
      src_type = string,
      src_port = object({
        min = number,
        max = number
      }),
      dst_port = object({
        min = number,
        max = number
      }),
      icmp_type = number,
      icmp_code = number
    })),
    egress_rules = list(object({
      nsg_id      = string,
      description = string,
      stateless   = bool,
      protocol    = string,
      dst         = string,
      # Allowed values: CIDR_BLOCK, SERVICE_CIDR_BLOCK, NETWORK_SECURITY_GROUP, NSG_NAME
      dst_type = string,
      src_port = object({
        min = number,
        max = number
      }),
      dst_port = object({
        min = number,
        max = number
      }),
      icmp_type = number,
      icmp_code = number
    }))
  })
  description = "Any standalone NSG rules that should be added (whether or not the NSG is defined here)."
  default = {
    ingress_rules : [],
    egress_rules : []
  }
}
