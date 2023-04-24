
# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.

variable "tenancy_ocid" {
  description = "root compartment"
  default     = "ocid1.tenancy.oc1..aaaaaaaawttxo6zmedll5b35bsjcvdx5bmobygwx7avyofsxxawvwaps26xq"
}

# general oci parameters

variable "security_lists" {
  type = map(any)
}