output "webserver" {
value = "${aws_instance.webserver[0].id}"
}
output "dbserver" {
value = "${aws_instance.dbserver[0].id}"
}
#output "appserver_publicip" {
#value = "${aws_instance.appserver.public_ip}"
#}
#output "dbserver_publicip" {
#value = "${aws_instance.dbserver.public_ip}"
#}
