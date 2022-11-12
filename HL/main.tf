



module "mongodb" {
  source                = "../modules/mongodb"
    providers = {
    aws.region1 = aws.region1
    aws.region2 = aws.region2
    aws.region3 = aws.region3
  }
  name                  = "mongo"
  instance_type         = "t2.large"
  instance_name         = "MongoDB-Server"
  associate_public_ip_address = false

}
