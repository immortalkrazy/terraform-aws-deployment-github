# Input variable definitions

variable "bucket_name" {
    description = "name of s3 bucker. Must be unique"
    type = string  
}

variable "tags" {
    description = "Tags to set on the bucket"
    type = map(string)
    default = {}
}
