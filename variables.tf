variable "gcpprojectid" {
    default = "lucky-altar-287406"
}
variable "username" {
  default = "admin"
}
variable "password" {
    default = "@akhileshjain9221@"
}
variable "rdspasswd" {
  type = string
  default = "podpasswd"
  description = "Password for AWS-RDS MySQL Database"
}
variable "rdsusername" {
  type = string
  default = "admin"
  description = "Username for database"
}
