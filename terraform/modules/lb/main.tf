resource "aws_lb" "k8_cp_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "network" # para TCP
  subnets            = var.subnet_ids

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "k8_cp_tg" {
  name        = "${var.lb_name}-tg"
  port        = 6443
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "TCP"
    port                = 22
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 3
    interval            = 10
  } 

}

resource "aws_lb_listener" "k8_cp_listener" {
  load_balancer_arn = aws_lb.k8_cp_lb.arn
  port              = 6443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.k8_cp_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "k8_cp_attachment" {
  for_each = { for idx, instance_id in var.instance_ids : idx => instance_id }

  target_group_arn = aws_lb_target_group.k8_cp_tg.arn
  target_id        = each.value
  port             = 6443
}
