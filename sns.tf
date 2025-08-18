#  create an sns topic
resource "aws_sns_topic" "user_update" {
    name = "dev-sns-topic"
  
}

# create an sns topic subsription
resource "aws_sns_topic_subscription" "notification_topic" {
    topic_arn = aws_sns_topic.user_update.arn
    protocol = "email"
    endpoint = var.opearator_email
  
}