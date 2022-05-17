output "hello" {
    value = data.aws_subnets.this.ids
}
