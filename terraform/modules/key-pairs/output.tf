
output "key_pair_id" {
  value = aws_key_pair.key_pair.id
  description = "The key pair ID"
}

output "key_name" {
  value = aws_key_pair.key_pair.key_name
  description = "The key pair name"
}

output "fingerprint" {
  value = aws_key_pair.key_pair.fingerprint
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716"
}