################################################  Cloud init module  ####################################
provider "template"{

}
data "template_file" "webserver-userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars = {
   vm_role = "web"
  }
}
