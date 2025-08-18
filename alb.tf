

# Create application load balancer
resource "aws_lb" "loab-balancer" {
    name = "application-load-balancer"
    internal = false 
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb_sg.id]
    subnets = [ aws_subnet.public_subnet_azla.id, aws_subnet.public_subnet_azlb.id]
    
    tags = {
    Name = "application-load-balancer"
  }

}


# create load balancer target group
resource "aws_lb_target_group" "target_group" {
    name = "target-group"
    port = 80
    target_type = "instance"
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc.id 

    health_check {
      healthy_threshold = 5
      interval = 30
      matcher = "200,301,302"
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5 
      unhealthy_threshold = 2

    }

    tags = {
    Name = "target-group" 
  }
  
}

# create load balancer listener on port 80 with a redirect action
resource "aws_lb_listener" "alb_http_listener" {
    load_balancer_arn = aws_lb.loab-balancer.arn 
    port = "80"
    protocol = "HTTP"


    default_action {
      type = "redirect"
      
      redirect {
        host = "#{host}"
        path = "/#{path}"
        port = 443
        protocol = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  
}
  

# create a listener on port 443 with forward action
resource "aws_lb_listener" "alb_https_listeners" {
    load_balancer_arn = aws_lb.loab-balancer.arn
    port = 443
    protocol = "HTTPS"
    certificate_arn = var.ssl_certificate_arn

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
  
}