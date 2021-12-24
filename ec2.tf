#Grabbing latest Linux 2 AMI
data "aws_ami" "linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# EC2 Deploy
resource "aws_instance" "bastion-host" {
  ami                    = data.aws_ami.linux2.id
  instance_type          = var.instance_type["type1"]
  subnet_id              = var.public-subnet-id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_host.id]

  # Install fail2band
  user_data = <<EOF
  #!/bin/bash
  yum update -y
  amazon-linux-extras install epel -y
  yum-config-manager --enable epel
  yum install fail2ban -y
  systemctl enable fail2ban
  systemctl start fail2ban
  EOF

  tags = merge(var.project-tags, { Name = "${var.resource-name-tag}-EC2" }, )

  root_block_device {
    volume_size           = 120
    volume_type           = "gp2"
    delete_on_termination = true
    tags                  = merge(var.project-tags, { Name = "${var.resource-name-tag}-EBS" }, )
  }
}

output "ssh_command" {
  value = "sudo ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.bastion-host.public_ip}"
}