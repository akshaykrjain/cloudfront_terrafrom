variable "spa-app-bkt" {
  type        = string
  description = "Name of the bucket for holding SPA scripts"
  default     = "spa-app-x67672a"
}

variable "static-data-bkt" {
  type        = string
  description = "Name of the bucket for holding static files"
  default     = "spa-static-files-x67672a"
}

variable "route53_domain" {
  type        = string
  description = "Your domain nome (naked) (e.g. example.com)"
  default     = "mywebsite.com"
}

variable "acm_arn" {
  type        = string
  description = "ACM Arn (Global)"
  default     = "arn:aws:acm:us-east-1:111122223333:certificate/12345678-1234-1234-1234-123456789012"
}


variable "allowed_IP" {
  type        = string
  description = "IP CIDR for whitelisting"
  default     = "34.251.32.94/32"
}


variable "s3_force_destroy" {
  type        = string
  description = "Destroy the s3 bucket inspite of contents in it."
  default     = true
}

variable "index_document" {
  type        = string
  description = "Index page to be used for website. Defaults to index.html"
  default     = "index.html"
}

variable "error_document" {
  type        = string
  description = "Error page to be used for website. Defaults to error.html"
  default     = "error.html"
}
