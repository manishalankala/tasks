 
data "template_file" "user_data_db" {
  template = "${file("${path.module}/modules/db-data.sh")}"

  vars {
    dbAdminUser        = "${var.dbUser}"
    dbAdminUserPass    = "${var.dbUserPass}"
    dbReplicaAdmin     = "${var.dbReplicaAdmin}"
    dbReplicaAdminPass = "${var.dbReplicaAdminPass}"
    dbReplSetName      = "${var.dbReplSetName}"
#    access_key         = "${var.access_key}"
#    secret_key         = "${var.secret_key}"
#    region             = "${var.region}"
  }
}
