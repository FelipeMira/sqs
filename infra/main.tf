# Terraform configuration for AWS SQS FIFO queue and Dead Letter Queue

resource "aws_sqs_queue" "inspections_dlq" {
  name                      = "inspections-dlq.fifo"
  fifo_queue                = true
  content_based_deduplication = true
}

resource "aws_sqs_queue" "inspections" {
  name                      = "inspections.fifo"
  fifo_queue                = true
  content_based_deduplication = true
  visibility_timeout_seconds = 30
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.inspections_dlq.arn
    maxReceiveCount     = 3
  })
}
