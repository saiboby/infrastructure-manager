#########################################  Importing  modules #################################
module "computing"{
source = "./modules/computing"
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
}

