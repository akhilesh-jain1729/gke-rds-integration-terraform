variable username {}
variable password {}
variable rds_dbhost {}
variable rdspasswd {}
variable rdsusername {}
variable rds_dbname {}
variable nodepool {}
variable host {}
variable client_certificate {}
variable client_key {}
variable cluster_ca_certificate {}

provider "kubernetes" {
  host     = var.host
  username = var.username
  password = var.password
  client_certificate     = "${base64decode(var.client_certificate)}"
  client_key             = "${base64decode(var.client_key)}"
  cluster_ca_certificate = "${base64decode(var.cluster_ca_certificate)}"
}

resource "kubernetes_service" "wpservice" {
  metadata {
    name = "wpserviceport"
    labels = {
      app = "wordpress"
    }
    }
  spec {
    type = "LoadBalancer"
    selector = {
      app = "${kubernetes_replication_controller.example
      .metadata.0.labels.app}"
    }
    session_affinity = "ClientIP"
    port {
      name        = "wp-port"
      port        = 80    
      target_port = "80"
      node_port = "30029"
    }   
  }
}

resource "kubernetes_replication_controller" "example" {
depends_on=[
    var.nodepool, var.rds_dbhost
  ] 
metadata {
    name = "wprc"
    labels = {
      app = "wordpress"
    }
  }
   spec {
    selector = {   
      app = "wordpress"
        }
   replicas = 2
    template {
      metadata {
        labels = {
         app= "wordpress"
                }     
         }  
  spec {
    container {
      image = "wordpress:latest"
      name  = "wordpresscontainer"
       port {
            container_port = 80
          }
      env {
             name = "WORDPRESS_DB_HOST" 
             value =  var.rds_dbhost
          }
      env {
         name = "WORDPRESS_DB_USER"
         value =  var.rdsusername
          }
      env {
             name = "WORDPRESS_DB_PASSWORD"
             value = var.rdspasswd
             }
      env {
             name = "WORDPRESS_DB_NAME"
             value = var.rds_dbname
             }
                 }     
                  } 
                  }       
                   }    
  timeouts {
    create = "60m"
  }
}