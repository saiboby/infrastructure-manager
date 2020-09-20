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

variable "mytags"{
type = "map"
default = {
"fname" = "krishna"
"lname" = "maram"
}
}
