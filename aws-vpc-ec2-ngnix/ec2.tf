resource "aws_instance" "ngnixserver" {
  ami           = "ami-0ac7b260cf76d8865"
  instance_type = "t3.micro"

  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.ngnix-sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install nginx -y
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "NgnixServer"
  }
}
