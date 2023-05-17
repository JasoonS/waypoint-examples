# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

project = "kubernetes-nodejs"

app "kubernetes-nodejs-web" {
  labels = {
    "service" = "kubernetes-nodejs-web",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "aws-ecr" {
        region     = "us-east-2"
        repository = "envio-repository"
        tag        = "latest"
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
      // Sets up a load balancer to access released application
      load_balancer = true
      port          = 3000
    }
  }
}
