terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}
provider "yandex" {
  token     = var.ya_api_token
  cloud_id  = var.ya_cloud_id
  folder_id = var.ya_folder_id
  zone      = var.ya_available_zone
}

resource "yandex_kubernetes_cluster" "my_k8s" {
  name        = "k8s-hw"
  description = "Kuber for otus HW"

  network_id = "enp5u3uqlu8dif5tnns8"

  master {
    zonal {
      zone      = var.ya_available_zone
      subnet_id = "e9blbdmdhapalqtcgj55"

    }

    version   = "1.21"
    public_ip = true

    maintenance_policy {
      auto_upgrade = false
    }
  }

  service_account_id      = "aje3e9j8v7va0b1pa7pl"
  node_service_account_id = "aje3e9j8v7va0b1pa7pl"
  release_channel         = "RAPID"
}
resource "yandex_kubernetes_node_group" "my_node" {
  cluster_id  = yandex_kubernetes_cluster.my_k8s.id
  name        = "workers"
  description = "description"
  version     = "1.21"

  instance_template {
    platform_id = "standard-v2"
    metadata = {
      ssh-keys = "grart:${file("~/.ssh/id_rsa.pub")}"
    }
    network_interface {
      nat = true
      subnet_ids = ["e9blbdmdhapalqtcgj55"]

    }

    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  maintenance_policy {
    auto_upgrade = false
    auto_repair  = false
  }
}
