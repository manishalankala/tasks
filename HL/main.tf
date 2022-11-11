


module "mongodb" {
  source                = "../modules/mongodb"
  domain                = local.main_domain
  location              = " "
  name                  = "mongo"

}
