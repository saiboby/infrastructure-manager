#########################################  Importing  modules #################################
module "computing"{
source = "./modules/computing"
websg = "${module.security.websg}"
publicsubnet = "${module.networking.publicsubnet}"
#myregion = "${var.myregion}"
#myaccesskey = "${var.myaccesskey}"
#mysecretkey = "${var.mysecretkey}"
 myamiid = "${var.myamiid}"
}
module "networking"{
source = "./modules/networking"
}
module "security"{
source = "./modules/security"
myvpc = "${module.networking.myvpc}"
}

module "storage"{
source = "./modules/storage"
webserver = "${module.computing.webserver[0]}"
}
