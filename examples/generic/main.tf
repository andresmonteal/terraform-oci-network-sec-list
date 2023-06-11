// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

module "security_lists" {
  source = "../../"

  tenancy_ocid = var.tenancy_ocid
  compartment  = var.compartment
  vcn_name     = var.vcn_name

  security_lists = var.security_lists
}