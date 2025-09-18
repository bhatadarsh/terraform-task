output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.flask_express_instance.public_ip
}

output "flask_url" {
  description = "The URL for the Flask backend."
  value       = "http://${aws_instance.flask_express_instance.public_ip}:5000"
}

output "express_url" {
  description = "The URL for the Express frontend."
  value       = "http://${aws_instance.flask_express_instance.public_ip}:3000"
}