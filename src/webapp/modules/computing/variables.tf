#variable "myaccesskey"{
#type = string
#}
#variable "mysecretkey"{
#type = "string"
#}
#variable "myregion"{
#type = "string"
#default = "us-east-1"
#}
variable "myamiid"{
type = "string"
default = "ami-0affd4508a5d2481b"
}
variable "publicsubnet"{
type = string
}
variable "websg"{
type = "string"
}
variable "userdata"{
type = "string"
}
variable "tags"{
type = "map"
}
