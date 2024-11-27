resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name          = "cpu-usage-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "Trigger scale-up when CPU usage is above 50%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ec2_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
}
