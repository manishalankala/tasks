


module "mongodb" {
  source                = "../modules/mongodb"
    providers = {
    aws.region1 = aws.region1
    aws.region2 = aws.region2
    aws.region3 = aws.region3
  }
  domain                = local.main_domain
  location              = " "
  name                  = "mongo"
  instance_name    = "MongoDB-Server"
  associate_public_ip_address = false

}
