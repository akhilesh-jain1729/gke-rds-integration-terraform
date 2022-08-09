module "gcp" {
     source = "./gcp"
     username = var.username
     password = var.password
     gcpprojectid = var.gcpprojectid
}

module "aws" {
     source = "./aws"
     rdsusername = var.rdsusername
     rdspasswd = var.rdspasswd
}

module "k8s" {
   source = "./kubernetes"
   rdsusername            = var.rdsusername    
   rds_dbname             = module.aws.rds_dbname
   rdspasswd              = var.rdspasswd
   rds_dbhost             = module.aws.rds_dbhost
   username               = var.username
   password               = var.password
   nodepool               = module.gcp.nodepool
   host                   = module.gcp.host
   client_certificate     = module.gcp.client_certificate
   client_key             = module.gcp.client_key
   cluster_ca_certificate = module.gcp.cluster_ca_certificate
}