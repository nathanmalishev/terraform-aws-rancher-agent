# Terraform module: AWS Instance -> Rancher Agent

This is a terraform module to create an Rancher agent on AWS.  

### Example usage
```
module "pinger_server" {
  source = "github.com/nathanmalishev/terraform-aws-rancher-agent"

  ## I used a super simple vpc module i created, that creates an instance 
  ## in a public vpc - https://github.com/nathanmalishev/terraform-aws-rancher-agent-vpc
  vpc_id                 = "${module.vpc.vpc_id}"
  vpc_region             = "${module.vpc.vpc_region}"

  server_name = "agent-cluster"
  server_hostname = "<server_hostname>"
  server_subnet_id = "${module.vpc.vpc_public_subnet_id}"
  server_key = "~./ssh/key"

  agent_version = "v1.2.2"
  agent_image = "rancher/agent"
  rancher_host_url = "https://<rancher_host_url>/v1/scripts/XX:YY:ZZ"
  cattle_host_labels = "terraform=true&branch=develop"

}

provider "aws" {
  region = "ap-southeast-2"
}
```


### Example DNS
```
resource "aws_route53_record" "server_hostname" {

    zone_id = "Z1H3G5FATXYYOR"
    name = "<server_hostname>"
    type = "A"
    ttl = "30"
    records = [
        "${module.pinger_server.server_public_ip}"
    ]

    lifecycle {
        create_before_destroy = true
    }

  }
```

### Example VPC
```
module "vpc" {
  source = "github.com/nathanmalishev/terraform-aws-rancher-agent-vpc"

  vpc_name = "rancher-develop"
  vpc_region = "ap-southeast-2"
  vpc_nat_key_file = "~/.ssh/key"

}
```
