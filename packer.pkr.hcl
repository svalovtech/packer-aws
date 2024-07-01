packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "kaizen" {
  ami_name      = "golden image {{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami = "ami-033fabdd332044f06"
  ssh_username = "ec2-user"
  ssh_keypair_name = "packer"
  ssh_private_key_file = "~/.ssh/id_rsa"

  ami_regions = [
    "us-east-1",
    "us-east-2"
  ]
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.kaizen"
  ]

  provisioner "shell" {
    script = "script.sh"
  }
}
