variable "ya_api_token" {
  description = "Api token for access ya cloud"
  type        = string
}
variable "ya_cloud_id" {
  description = "ID ya cloud"
  type        = string
}
variable "ya_folder_id" {
  description = "ID foldes with resourses"
  type        = string

}
variable "ya_available_zone" {
  description = "Zone available in ya cloud"
  default     = "ru-central1-a"
  type        = string
}
