output "myvpc" {
value = "${aws_vpc.myvpc.id}"
}
output "publicsubnet" {
value = "${aws_subnet.publicsubnet.id}"
}
#output "dbserver_publicip" {
#value = "${aws_instance.dbserver.public_ip}"
#}
