resource "aws_security_group" "mysg" {
    name = "web-sg"
    vpc_id = aws_vpc.myautomatedvpc.id

    ingress {
        from_port = 80
        to_port = 80
        description = "HTTP PORT"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {
        from_port = 22
        to_port = 22
        description = "ssh PORT"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name= "web-sg"
    }

  
}
