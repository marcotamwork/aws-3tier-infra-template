variable "region" {
  default     = "ap-northeast-1"
  description = "AWS region"
}

variable "cluster_name" {
  default     = "fwd-terraform-eks-dev"
  description = "EKS Cluster name"
}

variable "cluster_version" {
  default     = "1.22"
  description = "Kubernetes version"
}

variable "instance_type" {
  default     = "t3.small"
  description = "EKS node instance type"
}

variable "instance_count" {
  default     = 2
  description = "EKS node count"
}

variable "node_group" {
  default     = "dev_node_group_1"
  description = "Name of the Node Group"
}

variable "availability_zones" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1b"]
}

variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  description = "EKS node count"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.1.3.0/24", "10.1.4.0/24"]
}

variable "env" {
  default     = "Development"
  description = "Environments"
}

