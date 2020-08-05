
provider "aws" {
    version = "~> 3.0"
    region  = "us-east-1"
}


resource "aws_instance" "dev" {
    count = 3
    ami = "ami-0ac80df6eff0e70b5"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["sg-fcd9d6d4"]
}

resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    description = "acesso-ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["189.62.148.186"]
  }

  tags = {
    Name = "ssh"
  }
}