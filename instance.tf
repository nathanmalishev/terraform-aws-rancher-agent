#############################
## Docker server instance  ##
#############################

# Import the keypair
resource "aws_key_pair" "keypair" {

    key_name   = "${var.server_name}-key"
    public_key = "${file("${var.server_key}")}"

    lifecycle {
        create_before_destroy = true
    }

}


# User-data template
resource "template_file" "user_data" {

    template = "${file("${path.module}/files/userdata.template")}"

    vars {

        # VPC config
        # TODO
        vpc_region = "${var.vpc_region}"

        # Server config
        agent_version            = "${var.agent_version}"
        rancher_agent_command      = "${var.rancher_agent_command}"

    }

    lifecycle {
        create_before_destroy = true
    }

}

# Create instance
resource "aws_instance" "docker_instance" {

    # Amazon linux
    ami = "${lookup(var.server_ami, var.vpc_region)}"

    # Target subnet - should be public
    subnet_id = "${var.server_subnet_id}"
    associate_public_ip_address = true

    # Security groups
    vpc_security_group_ids = [
        "${aws_security_group.docker_server_sg.id}"
    ]

    # SSH key
    key_name = "${aws_key_pair.keypair.key_name}"

    # User-data
    # Installs docker, starts containers and performs initial server setup
    user_data = "${template_file.user_data.rendered}"

    # Instance profile - sets required permissions to access other aws resources
    iam_instance_profile = "${aws_iam_instance_profile.docker_server_instance_profile.id}"

    root_block_device {
        volume_type = "${var.server_root_volume_type}"
        volume_size = "${var.server_root_volume_size}"
        delete_on_termination = "${var.server_root_volume_delete_on_terminate}"
    }

    # Misc
    instance_type = "${var.server_instance_type}"

    tags {
        Name = "${var.server_name}"
        ManagedBy = "terraform"
    }

    lifecycle {
        create_before_destroy = true
    }

}

output "server_public_ip" {
    value = "${aws_instance.docker_instance.public_ip}"
}

output "server_keyname" {
    value = "${aws_key_pair.keypair.key_name}"
}
