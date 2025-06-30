
resource "aws_alb" "webalb" {
  name = "WebALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.mysg.id]
  subnets = [aws_subnet.automated_subnet1.id,aws_subnet.automated_subnet2.id]
  tags = {
    Name="weblb"
  }
}

resource "aws_lb_target_group" "tg" {
  name = "myTG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.myautomatedvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
  
}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.web_instance1.id
  
}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.web_instance2.id
  
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.webalb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type = "forward"
  }
}