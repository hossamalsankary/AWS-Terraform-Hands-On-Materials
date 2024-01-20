resource "aws_launch_template" "launch_template" {
  name_prefix   = "launch_template"
  image_id      = "ami-0ce2cb35386fc22e9"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "autoscaling" {
  
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  vpc_zone_identifier = [  var.privet_subnets[0] , var.privet_subnets[1]  ]
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}

