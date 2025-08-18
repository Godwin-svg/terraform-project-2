# create a launch template
resource "aws_launch_template" "webserver_launch_template" {
    name = var.launch_template_name
    image_id = var.ami_id
    instance_type = "t3.micro"
    key_name = var.ec2_key_pair_name
    description = "launch template for asg"
    user_data = filebase64("scripts/apache.sh")
    vpc_security_group_ids = [ aws_security_group.web_sever_sg.id]

    monitoring {
      enabled = true
    }

    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "webserver_launch_template"
      }
    }

  
}




# create auto sclaing group
resource "aws_autoscaling_group" "asg" {
    name = "apache-asg"
    max_size =  3
    min_size = 1
    desired_capacity = 2
    vpc_zone_identifier = [aws_subnet.private_data_subnet_azla.id, aws_subnet.private_app_subnet_azlb.id]
    health_check_type = "ELB"
    termination_policies = [ "OldestInstance" ]
    launch_template {
      id = aws_launch_template.webserver_launch_template.id 
      version = "$Latest"
    }

    target_group_arns = [aws_lb_target_group.target_group.arn]

    tag {
      key = "Name"
      value = "asg-webserver"
      propagate_at_launch = true
    }


    lifecycle {
      ignore_changes = [ target_group_arns ]
    }
  
}

# attach auto scaling group to alb target group
resource "aws_autoscaling_attachment" "autoscaling-attcahment" {
    autoscaling_group_name = aws_autoscaling_group.asg.id 
    lb_target_group_arn = aws_lb_target_group.target_group.id 
  
}

resource "aws_autoscaling_notification" "webserver_asg_notofication" {
  group_names = [aws_autoscaling_group.asg.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.user_update.arn
}