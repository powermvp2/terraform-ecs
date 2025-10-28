# 기존 서브넷 참조
data "aws_subnet" "vec_prd_pub_subnet_2a" {
  filter {
    name   = "tag:Name"
    values = ["VEC-PRD-VPC-NGINX-PUB-2A"]
  }
}

# ECS Instance
resource "aws_instance" "vec_prd_ecs_pub_2a" {
  ami                         = "ami-056a29f2eddc40520"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.vec_prd_ecs_pub_2a_sg.id]
  subnet_id                   = data.aws_subnet.vec_prd_pub_subnet_2a.id  # data로 참조
  key_name                    = "powermvp"
  associate_public_ip_address = true
  private_ip                  = "10.250.1.240"  # 고정 IP (빠뜨리셨네요!)

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "VEC-PRD-ECS-PUB-2A"
    }
  }

  tags = {
    "Name" = "VEC-PRD-ECS-PUB-2A"
  }
}