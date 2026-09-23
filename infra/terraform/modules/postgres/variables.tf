variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "postgres_admin_username" {
  type = string
}

variable "postgres_admin_password" {
  type      = string
  sensitive = true
}

variable "postgres_version" {
  type = string
}

variable "postgres_storage_mb" {
  type = number
}

variable "postgres_sku_name" {
  type = string
}