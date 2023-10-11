resource "aws_instance" "web" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "saida"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "saidareddy"
  }

  provisioner "file" {
    source = "./saida.pem"
    destination = "/home/ec2-user/saida.pem"
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("./saida.pem")}"
    }  
  }
}

resource "aws_instance" "db" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = "saida"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}
