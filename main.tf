# Configure the Google Cloud provider
provider "google" {
  project     = var.project
  region      = var.region  # Specify your preferred region
  zone        = var.zone    # You can choose the zone
  credentials = var.credentials  # Path to the service account credentials
}

# Define the Google Cloud Network (VPC)
resource "google_compute_network" "network" {
  name = "google-network"  # Ensure network name is lowercase and hyphen-separated
}

# Define the Google Cloud Subnetwork
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name  # Correct variable reference (subnet_name)
  region        = var.region      # Same as your region
  network       = google_compute_network.network.name
  ip_cidr_range = "10.0.0.0/24"
}

# Create the GKE Cluster
resource "google_container_cluster" "google_gke" {
  name                     = var.my_gke_cluster  # Correct variable reference (my_gke_cluster)
  location                 = var.location
  remove_default_node_pool = true
  networking_mode          = "VPC_NATIVE"
  initial_node_count       = 1

  # Specify the VPC and Subnet for the cluster
  network    = google_compute_network.network.name
  subnetwork = google_compute_subnetwork.subnet.name

  # Optionally disable deletion protection
  deletion_protection = false
}

# Create the Node Pool for the GKE Cluster
resource "google_container_node_pool" "my_node_pool" {
  name       = var.my_node_pool  # Correct variable reference (my_node_pool)
  cluster    = google_container_cluster.google_gke.name
  location   = google_container_cluster.google_gke.location
  node_count = 3  # Set the number of nodes to 3

  # Define machine type for nodes
  node_config {
    machine_type = "e2-medium"  # Example machine type (2 vCPUs, 4GB RAM)
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"  # Necessary for GKE nodes
    ]
  }

  # Optional: Set autoscaling for the node pool
  autoscaling {
    min_node_count = 3
    max_node_count = 5
  }
}
