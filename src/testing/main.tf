
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


variable "myregion"{
type = "string"
default = "us-east-1"
}

#variable "myaccesskey"{
#type = string
#}

#variable "mysecretkey"{
#type = "string"
#}

variable "myamiid"{
type = "string"
#default = "ami-0affd4508a5d2481b"
}


#output "webserverpublic_ip"{
#value = "${module.instances.webserver_publicip}"
#}



resource "aws_security_group" "websg" {
  name        = "websg"
  description = "Allow all traffic"
  vpc_id ="${var.myvpc}"
  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "websg"
  }
}


############################################ Networking modules ###############################3
resource "aws_eip" "webeip"{
instance = "${var.webserver}"
}
resource "aws_eip" "dbeip"{
instance = "${var.dbserver}"
}
resource "aws_vpc" "myvpc"{
cidr_block = "192.168.0.0/16"
tags ={
Name = "myvpc"
}
}

resource "aws_internet_gateway" "myigw"{
vpc_id = "${aws_vpc.myvpc.id}"
tags={
Name = "myigw"
}
}


resource "aws_subnet" "publicsubnet"{
availability_zone = "us-east-1c"
vpc_id = "${aws_vpc.myvpc.id}"
cidr_block = "192.168.1.0/24"
tags={
Name = "publicsubnet"
}
}

resource "aws_route_table" "publicrtb"{
vpc_id = "${aws_vpc.myvpc.id}"
tags = {
Name = "publicrtb"
}
}

resource "aws_route" "publicrt"{
route_table_id = "${aws_route_table.publicrtb.id}"
destination_cidr_block = "0.0.0.0/0"
gateway_id = "${aws_internet_gateway.myigw.id}"
}

resource "aws_route_table_association" "publicrtba"{
route_table_id = "${aws_route_table.publicrtb.id}"
subnet_id = "${aws_subnet.publicsubnet.id}"
}





provider "aws"{
region = "${var.myregion}"
shared_credentials_file = "/home/centos/.aws/credentials"
#profile                 = "customprofile"
#access_key = "${var.myaccesskey}"
#secret_key = "${var.mysecretkey}"
}
provider "template"{

}
data "template_file" "webserver-userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars = {
   vm_role = "web"
  }
}


