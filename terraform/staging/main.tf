module "resources" {
  source      = "../resources"
  environment = "staging"
  region      = "West Europe"
  # subscription = "Planetary Computer"

  # AKS ----------------------------------------------------------------------
  kubernetes_version = "1.21.2"
  # 2GiB of RAM, 1 CPU core
  core_vm_size              = "Standard_A2_v2"
  user_pool_min_count       = 1
  cpu_worker_pool_min_count = 0

  # Logs ---------------------------------------------------------------------
  workspace_id = "83dcaf36e047a90f"

  # DaskHub ------------------------------------------------------------------
  dns_label                 = "aza-pcc-staging"
  jupyterhub_host           = "aza-pcc-staging.westeurope.cloudapp.azure.com"
  user_placeholder_replicas = 0
  stac_url                  = "https://planetarycomputer-staging.microsoft.com/api/stac/v1/"

  jupyterhub_singleuser_image_name = "daunnc/planetary-computer-python" # "mcr.microsoft.com/planetary-computer/python"
  jupyterhub_singleuser_image_tag  = "2021.11.30.0"
  python_image                     = "daunnc/planetary-computer-python:2021.11.30.0" # mcr.microsoft.com/planetary-computer/python:2021.11.30.0
  pyspark_image                    = "daunnc/planetary-computer-pyspark:2021.11.29.0-gdal3.4-3.1-rf"
  r_image                          = "mcr.microsoft.com/planetary-computer/r:2021.11.19.0"
  gpu_pytorch_image                = "mcr.microsoft.com/planetary-computer/gpu-pytorch:2021.12.02.1"
  gpu_tensorflow_image             = "mcr.microsoft.com/planetary-computer/gpu-tensorflow:2021.11.30.0"
  qgis_image                       = "pcccr.azurecr.io/planetary-computer/qgis:3.18.0"

  kbatch_proxy_url = "http://dhub-staging-kbatch-proxy.staging.svc.cluster.local"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "pc-manual-resources"
    storage_account_name = "pctfstateazavea"
    container_name       = "pcc"
    key                  = "staging.tfstate"
  }
}

output "resources" {
  value     = module.resources
  sensitive = true
}
