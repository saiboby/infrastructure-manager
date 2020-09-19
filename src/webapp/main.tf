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
}
module "networking"{
source = "./modules/networking"
webserver = "${module.computing.webserver}"
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
