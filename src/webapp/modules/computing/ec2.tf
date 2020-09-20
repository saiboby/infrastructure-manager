################################################  Computing modules #####################################
resource "aws_instance" "webserver" {
count = 1
availability_zone = "us-east-1c"
ami = "${var.myamiid}"
instance_type = "t2.medium"
subnet_id = "${var.publicsubnet}"
private_ip= "192.168.1.6"
vpc_security_group_ids = ["${var.websg}"]
key_name = "virginia"
user_data = "${var.userdata}"
tags = "${merge(var.tags, map("Name", format("web-server-%d", count.index + 1)))}"
root_block_device {
  volume_type = "standard"
  volume_size = "9"
  delete_on_termination = "true"
  }
ebs_block_device {
  device_name = "/dev/xvde"
  volume_type = "gp2"
  volume_size = "10"
  }
}

resource "aws_instance" "dbserver" {
count = 1
availability_zone = "us-east-1c"
ami = "${var.myamiid}"
instance_type = "t2.medium"
subnet_id = "${var.publicsubnet}"
private_ip= "192.168.1.7"
vpc_security_group_ids = ["${var.websg}"]
key_name = "virginia"
user_data = "${var.userdata}"
tags = "${merge(var.tags, map("Name", format("db-server-%d", count.index + 1)))}"
}
