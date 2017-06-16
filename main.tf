

# Target VPC config
variable "vpc_id" {
    description = "ID of target VPC."
}
variable "vpc_region" {
    description = "Region of the target VPC"
}

# Server config
variable "server_name" {
    description = "Name of the Rancher server. Best not to include non-alphanumeric characters."
}
variable "server_hostname" {
    description = "Hostname of the Rancher server."
}
variable "server_key" {
    description = "Public key file for the Rancher server instance."
}
variable "server_subnet_id" {
    description = "Public subnet id in which to place the rancher server instance."
}
variable "server_instance_type" {
    description = "EC2 instance type to use for the rancher server."
    default = "t2.micro"
}
variable "server_ami" {
    description = "Amazon Linux AMI id for the target region."
    default = {
        eu-west-1      = "ami-f9dd458a"
        eu-central-1   = "ami-ea26ce85"
        us-west-1      = "ami-31490d51"
        us-west-2      = "ami-7172b611"
        us-east-1      = "ami-6869aa05"
        ap-northeast-1 = "ami-374db956"
        ap-northeast-2 = "ami-2b408b45"
        ap-south-1     = "ami-ffbdd790"
        ap-southeast-1 = "ami-a59b49c6"
        ap-southeast-2 = "ami-dc361ebf"
        sa-east-1      = "ami-6dd04501"
    }
}

# this must be entered in the form 'key=value&key2=value2&...'
variable "cattle_host_labels" {
  default = "terraform=true"
}

variable "server_root_volume_type" {
    default = "gp2"
}
variable "server_root_volume_size" {
    default = "64"
}
variable "server_root_volume_delete_on_terminate" {
    default = true
}

# Rancher commands
variable "agent_version" {
  description = "Version of the rancher agent to use"
}

variable "agent_image" {
  default = "rancher/agent"
}

# the rancher host url
variable "rancher_host_url" {
  description = "The rancher host url, looks something like https://<api-end-point>/v1/scripts/XX:XX:XX"
}
