# Outputs
output "security_system_id" {
  description = "ID of the created security system"
  value       = saviynt_security_system_resource.this.id
}

output "connection_id" {
  description = "ID of the created AD connection"
  value       = saviynt_ad_connection_resource.this.id
}

output "endpoint_id" {
  description = "ID of the created endpoint"
  value       = saviynt_endpoint_resource.this.id
}
