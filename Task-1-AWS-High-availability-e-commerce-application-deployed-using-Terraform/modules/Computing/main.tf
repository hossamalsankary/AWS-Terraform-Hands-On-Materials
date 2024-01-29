
resource "aws_launch_template" "launch_template" {
  name_prefix   = "launch_template"
  image_id      = "ami-0ce2cb35386fc22e9"
  instance_type = "t3.micro"

  user_data              = filebase64("${path.module}/app.sh")
  vpc_security_group_ids = [var.web_security_group]
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_elb" "web_elb" {
  name            = "Loadbalancer"
  security_groups = [var.web_security_group]
  subnets         = var.public_subnets

  cross_zone_load_balancing = true


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 4
    timeout             = 10
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }


  lifecycle {
    create_before_destroy = true
  }


  tags = {
    Name = "elb"
  }
}


resource "aws_autoscaling_group" "asg" {
  name              = "awsautoscalinggroup"
  desired_capacity  = 3
  max_size          = 4
  min_size          = 1
  health_check_type = "ELB"

  load_balancers      = [aws_elb.web_elb.id]
  vpc_zone_identifier = var.privet_subnets
  depends_on          = [aws_launch_template.launch_template]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

}






