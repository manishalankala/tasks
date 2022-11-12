


module "mongodb" {
  source                = "../modules/mongodb"
  domain                = local.main_domain
  location              = " "
  name                  = "mongo"
  instance_name    = "MongoDB-Server"
  associate_public_ip_address = false

}
