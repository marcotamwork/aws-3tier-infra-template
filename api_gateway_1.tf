############################
#strapi + lambda authorize
resource "aws_apigatewayv2_api" "strapi" {
name = "${var.env}-${var.application}-strapi"
protocol_type = "HTTP"

}
#https://docs.aws.amazon.com/apigateway/latest/developerguide/permissions.html

resource "aws_apigatewayv2_authorizer" "lambda_authorizer_strapi"{
name = "${var.env}-${var.application}-api-authorizer-strapi"
api_id = aws_apigatewayv2_api.strapi.id
authorizer_type = "REQUEST"
authorizer_uri = data.aws_lambda_function.authorizer.invoke_arn
identity_sources = ["$request.header.x-origin-verify"]
authorizer_payload_format_version = "2.0"
authorizer_result_ttl_in_seconds = 0
enable_simple_responses = true

}



resource "aws_apigatewayv2_integration" "green_strapi_integration" {
api_id = aws_apigatewayv2_api.strapi.id
integration_type = "HTTP_PROXY"
integration_uri = data.aws_lb_listener.green.arn

integration_method = "ANY"
connection_type = "VPC_LINK"
connection_id = aws_apigatewayv2_vpc_link.vpc_link.id
}

resource "aws_apigatewayv2_integration" "blue_strapi_integration" {
api_id = aws_apigatewayv2_api.strapi.id
integration_type = "HTTP_PROXY"
integration_uri = data.aws_lb_listener.blue.arn

integration_method = "ANY"
connection_type = "VPC_LINK"
connection_id = aws_apigatewayv2_vpc_link.vpc_link.id
}

resource "aws_apigatewayv2_route" "strapi_default_route" {
api_id = aws_apigatewayv2_api.strapi.id
route_key = "$default"
target = "integrations/${aws_apigatewayv2_integration.green_strapi_integration.id}"
authorization_type = "CUSTOM"
authorizer_id = aws_apigatewayv2_authorizer.lambda_authorizer_strapi.id
}

resource "aws_apigatewayv2_stage" "strapi_default_stage" {
api_id = aws_apigatewayv2_api.strapi.id
auto_deploy = true
name = "$default"
tags = {
"Name" = "${var.env}-${var.application}-strapi-default-stage"
application = "${var.application}"
env = "${var.env}"
bu = "${var.bu}"
}
access_log_settings {

destination_arn = "arn:aws:logs:ap-east-1:${data.aws_caller_identity.current.account_id}:log-group:${var.env}-${var.application}-api-gateway-logs"
format = "{ \"requestId\":\"$context.requestId\", \"ip\": \"$context.identity.sourceIp\", \"requestTime\":\"$context.requestTime\", \"httpMethod\":\"$context.httpMethod\",\"routeKey\":\"$context.routeKey\", \"status\":\"$context.status\",\"protocol\":\"$context.protocol\", \"responseLength\":\"$context.responseLength\", \"errorMessage\":\"$context.error.message\", \"errorMessageString\":\"$context.error.messageString\",\"errorResponseType\":\"$context.error.responseType\" }"
}
# default_route_settings {
# #logging level only available for websocket api
# throttling_burst_limit = 10000
# throttling_rate_limit = 10000
# }

depends_on = [
aws_cloudwatch_log_group.api_gateway_cloudwatch
]
}

resource "aws_apigatewayv2_deployment" "strapi_deployment" {
api_id = aws_apigatewayv2_api.strapi.id
description = "Deployment"
depends_on = [
aws_apigatewayv2_route.strapi_default_route
]
}