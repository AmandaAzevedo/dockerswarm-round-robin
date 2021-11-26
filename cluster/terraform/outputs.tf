output "managers" {
    value = ["${aws_instance.manager.*.public_ip}"]
}

output "workers" {
    value = ["${aws_instance.worker.*.public_ip}"]
}
