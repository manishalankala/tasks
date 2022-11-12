


resource "aws_instance" "mongo" {
  count                  = "3"
  ami                    = "ami-0e34af9d3686f9ace"
  instance_type          = "t2.large"
  key_name               = " "
  subnet_id              = " "
  user_data              = "${data.template_file.user_data_db.rendered}"
  vpc_security_group_ids = ["${aws_security_group.mongo_sg.id}"]
#  iam_instance_profile   = " "
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }

  tags = {
    Name = "mongo_${count.index + 1}"
  }
  
 
 
data "template_file" "user_data_db" {
  template = "${file("${path.module}/modules/db-data.sh")}"

  vars {
    dbAdminUser        = "${var.dbUser}"
    dbAdminUserPass    = "${var.dbUserPass}"
    dbReplicaAdmin     = "${var.dbReplicaAdmin}"
    dbReplicaAdminPass = "${var.dbReplicaAdminPass}"
    dbReplSetName      = "${var.dbReplSetName}"
    access_key         = "${var.access_key}"
    secret_key         = "${var.secret_key}"
    region             = "${var.region}"
  }
}
