resource "aws_lb" "alb_green" {
name = "${var.env}-${var.application}-alb-green"
internal = true
load_balancer_type = "application"
security_groups = [aws_security_group.alb_green_sg.id]
subnets = data.aws_subnets.private.ids

#enable_deletion_protection = true
enable_deletion_protection = false
access_logs {
bucket = "${var.env}-${var.application}-s3-lb-log"
prefix = "${var.env}-${var.application}-green-lb"
enabled = true
}


tags = {
Name = "${var.env}-${var.application}-alb-green"
application = "${var.application}"
env = "${var.env}"
bu = "${var.bu}"
}

}

resource "aws_lb_listener" "http_listener" {
load_balancer_arn = aws_lb.alb_green.arn
port = "80"
protocol = "HTTP"

default_action {
type = "fixed-response"
fixed_response {
content_type = "text/html"
status_code = 200
message_body = "Load balancer recevied your request"
}

}

tags = {
Name = "${var.env}-${var.application}-http-listener"
application = "${var.application}"
env = "${var.env}"
bu = "${var.bu}"
}
}

resource "aws_lb_target_group" "green_target_groups" {

for_each = toset(["30200", "30300","30400"]) //port
name = "${var.env}-${var.application}-port-${each.value}-g"
port = each.value
protocol = "HTTP"
vpc_id = var.vpc.id
health_check {
port = each.value
protocol = "HTTP"
interval = 30
unhealthy_threshold = 3
healthy_threshold = 3
path = each.value=="30200"? "/graphiql?path=/v1/graphql": each.value=="30300"? "/api/health": each.value=="30400"? "/index.html":"/"
}

tags = {
Name = "${var.env}-${var.application}-green-target-gp"
application = "${var.application}"
env = "${var.env}"
bu = "${var.bu}"
}
}



# resource "aws_lb_target_group_attachment" "attachment" {
# for_each = {
# for pair in setproduct(keys(aws_lb_target_group.green_target_groups), data.aws_instances.nodes_green.ids) :
# "${pair[0]}:${pair[1]}" => {
# target_group = aws_lb_target_group.green_target_groups[pair[0]]
# instance_id = pair[1]
# }
# }
# target_group_arn = each.value.target_group.arn
# target_id = each.value.instance_id
# port = each.value.target_group.port #30000 to 32768
# }




resource "aws_lb_listener_rule" "green_lb_rules_gql" {

listener_arn = data.aws_lb_listener.green.arn

action {
type = "forward"
target_group_arn = data.aws_lb_target_group.gql.arn #port 30200
}
condition {
host_header {
#values = [trim("${aws_apigatewayv2_api.graphql_api.api_endpoint}", "https://")]
values = var.gql_api_domain
}
}
tags = {
Name = "${var.env}-${var.application}-listener-rules-gql"
application = "${var.application}"
env = "${var.env}"
bu = "${var.bu}"
}
}