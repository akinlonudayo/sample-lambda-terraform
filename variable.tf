variable "region" {
  type        = string
  description = "Enter Your AWS Region"
  default     = "ca-central-1"
}
variable "lambda_role_name" {
  type        = string
  description = "Enter Your lambda execution role name"
  default     = "sample-TF-Lambda_execution_role"
}

variable "lambda_function_name" {
  type        = string
  description = "Enter Your lambda function role name"
  default     = "sample-TF-Lambda_function_role"
}

variable "lambda_function_handler" {
  type        = string
  description = "Enter Your lambda function handler name"
  default     = "sample-TF-Lambda_function_handler"
}

variable "lambda_function_runtime" {
  type        = string
  description = "Enter Your lambda function runtime"
  default     = "nodejs20.x"
}