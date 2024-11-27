resource "aws_cloudwatch_metric_alarm" "cpu_low_alarm" {
  alarm_name          = "cpu-usage-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "Trigger scale-down when CPU usage is below 50%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ec2_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
}
