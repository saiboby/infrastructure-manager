################################################  Storage modules #####################################
resource "aws_ebs_volume" "ebs3" {
availability_zone = "us-east-1c"
size = "11"
}

resource "aws_volume_attachment" "vattach"{
device_name = "/dev/xvdf"
volume_id = "${aws_ebs_volume.ebs3.id}"
instance_id = "${var.webserver}"
}
