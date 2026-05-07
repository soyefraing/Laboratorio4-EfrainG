resource "aws_sns_topic" "dlq_alarm_topic" {
  name = "dlq_alarm-${local.env}-topic"
}

#------------------------------------------------------------------------------#
resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn            = aws_sns_topic.dlq_alarm_topic.arn
  protocol             = "email"
  endpoint             = "matthewtandaypan007@gmail.com"
}

#------------------------------------------------------------------------------#

resource "aws_cloudwatch_metric_alarm" "dql_messages_alarm" {
  alarm_name                = "dql_messages_alarm-${local.env}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = 60
  statistic                 = "Sum"
  threshold                 = 0
  alarm_description         = "Esta alarma se dispara si hay mensajes estancados en la DLQ"

  dimensions = {
    QueueName = aws_sqs_queue.image_dlq.name
  }

  alarm_actions = [aws_sns_topic.dlq_alarm_topic.arn]
  
}
