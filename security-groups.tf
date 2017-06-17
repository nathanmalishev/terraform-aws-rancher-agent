# docker server security group
resource "aws_security_group" "docker_server_sg" {

    name = "${var.server_name}-docker-Server"
    description = "Rules for the docker server instance."
    vpc_id = "${var.vpc_id}"

    tags {
        Name = "${var.server_name}"
        ManagedBy = "terraform"
    }

    lifecycle {
        create_before_destroy = true
    }

}


# Outgoing & Incomming SSH
resource "aws_security_group_rule" "ssh_egress" {

    security_group_id = "${aws_security_group.docker_server_sg.id}"
    type = "egress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_security_group_rule" "ssh_ingress" {

    security_group_id = "${aws_security_group.docker_server_sg.id}"
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    lifecycle {
        create_before_destroy = true
    }
}


# Rancher agents need ports 500 & 4500 open
resource "aws_security_group_rule" "500_ingress" {

    security_group_id = "${aws_security_group.docker_server_sg.id}"
    type = "ingress"
    from_port = 500
    to_port = 500
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]

    lifecycle {
        create_before_destroy = true
    }

}
resource "aws_security_group_rule" "500_egress" {

    security_group_id = "${aws_security_group.docker_server_sg.id}"
    type = "egress"
    from_port = 500
    to_port = 500
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]

    lifecycle {
        create_before_destroy = true
    }

  }

resource "aws_security_group_rule" "4500_ingress" {

    security_group_id = "${aws_security_group.docker_server_sg.id}"
    type = "ingress"
    from_port = 4500
    to_port = 4500
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]

    lifecycle {
        create_before_destroy = true
    }

}

resource "aws_security_group_rule" "4500_egress" {

    security_group_id = "${aws_security_group.docker_server_sg.id}"
    type = "egress"
    from_port = 4500
    to_port = 4500
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]

    lifecycle {
        create_before_destroy = true
    }

  }

## HTTP & HTTPS for healthcheck/schedulars
resource "aws_security_group_rule" "80_egress" {

    security_group_id = "${aws_security_group.docker_server_sg.id}"
    type = "egress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    lifecycle {
        create_before_destroy = true
    }

}

resource "aws_security_group_rule" "443_egress" {

    security_group_id = "${aws_security_group.docker_server_sg.id}"
    type = "egress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    lifecycle {
        create_before_destroy = true
    }

}





output "server_security_group_id" {
    value = "${aws_security_group.docker_server_sg.id}"
}
