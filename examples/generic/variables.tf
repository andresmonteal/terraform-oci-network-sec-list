// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

variable "tenancy_ocid" {
  description = "(Required) (Updatable) The OCID of the root compartment."
  type        = string
}

variable "vcn_name" {
  description = "virtual cloud network name"
  type        = string
}

variable "compartment" {
  description = "compartment name"
  type        = string
}

variable "security_lists" {
  type = map(any)
}