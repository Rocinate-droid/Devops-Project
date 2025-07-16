resource "aws_instance" "resume-master" {
  ami                         = var.ami
  instance_type               = var.instance-type
  key_name                    = var.key
  iam_instance_profile = var.profile-name

  user_data = <<-EOF
                        #!/bin/bash
                        apt update
                        apt install docker.io -y
                        apt install openjdk-17-jdk -y
                        wget -O /etc/apt/keyrings/jenkins-keyring.asc \
                        https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
                        echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
                        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                        /etc/apt/sources.list.d/jenkins.list > /dev/null
                        apt update
                        apt install jenkins -y
                        apt install ansible -y
                        apt install unzip -y
                        cd /tmp
                        wget https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_amd64.zip
                        unzip terraform_1.8.4_linux_amd64.zip
                        mv terraform /usr/local/bin/
                        chmod +x /usr/local/bin/terraform
                        mkdir -p /etc/ansible
                        echo "[webservers]" > /etc/ansible/hosts
                        echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
                        echo "10.0.2.50 ansible_user=ubuntu" >> /etc/ansible/hosts
                EOF

network_interface {
    network_interface_id = aws_network_interface.niw-master.id
    device_index = 0
}

  tags = {
    Name = "master-server"
  }
}

resource "aws_network_interface" "niw-master" {
  subnet_id       = var.subnet_id
  private_ips     = [var.master-private-ip]
  security_groups = [var.sg-id]
}

resource "aws_eip" "eip-master" {
    domain = "vpc"
    associate_with_private_ip = var.master-private-ip
}

resource "aws_eip_association" "eip-assoc-master" {
    allocation_id = aws_eip.eip-master.id
    network_interface_id = aws_network_interface.niw-master.id
    private_ip_address = var.master-private-ip
}
