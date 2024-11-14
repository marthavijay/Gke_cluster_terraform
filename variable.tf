variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The GCP zone"
  type        = string
}

variable "credentials" {
  description = "Path to the service account credentials"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "my_gke_cluster" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "location" {
  description = "The location of the GKE cluster"
  type        = string
}

variable "my_node_pool" {
  description = "The name of the node pool"
  type        = string
}
