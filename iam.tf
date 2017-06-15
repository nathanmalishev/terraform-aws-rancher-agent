##########################################
## Docker server instance profile/role ##
##########################################

# Docker server instance profile
resource "aws_iam_instance_profile" "docker_server_instance_profile" {

    name = "${var.server_name}-instance-profile"
    roles = [
        "${aws_iam_role.docker_server_role.name}"
    ]

    lifecycle {
        create_before_destroy = true
    }

}


# Docker server role
resource "aws_iam_role" "docker_server_role" {

    name = "${var.server_name}-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

    lifecycle {
        create_before_destroy = true
    }

}