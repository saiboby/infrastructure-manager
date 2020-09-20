#########################################  Importing  modules #################################
module "computing"{
source = "./modules/computing"
websg = "${module.security.websg}"
publicsubnet = "${module.networking.publicsubnet}"
userdata = "${module.cloudinit.userdata}"
#myregion = "${var.myregion}"
#myaccesskey = "${var.myaccesskey}"
#mysecretkey = "${var.mysecretkey}"
myamiid = "${var.myamiid}"
tags = "${module.tags.tags}"
}
module "networking"{
source = "./modules/networking"
webserver = "${module.computing.webserver}"
dbserver = "${module.computing.dbserver}"
}
module "security"{
source = "./modules/security"
myvpc = "${module.networking.myvpc}"
}

module "storage"{
source = "./modules/storage"
webserver = "${module.computing.webserver}"
}
module "cloudinit"{
source = "./modules/cloudinit"
}
module "tags"{
source = "./modules/tags"
fname = "${var.fname}"
lname = "${var.lname}"
}
