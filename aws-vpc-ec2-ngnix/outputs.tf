output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ngnixserver.public_ip
}

output "instance_url" {
  description = "URL to access the EC2 instance"
  value       = "http://${aws_instance.ngnixserver.public_ip}"
}
