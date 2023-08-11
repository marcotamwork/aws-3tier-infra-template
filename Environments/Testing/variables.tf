variable "region" {
  default     = "ap-northeast-1"
  description = "AWS region"
}

variable "cluster_name" {
  default     = "fwd-terraform-eks-test"
  description = "EKS Cluster name"
}

variable "cluster_version" {
  default     = "1.27"
  description = "Kubernetes version"
}

variable "eks_instance_type" {
  default     = "t3.small"
  description = "EKS node instance type"
}

variable "eks_instance_count" {
  default     = 3
  description = "EKS node count"
}

variable "eks_max_instance_count" {
  default     = 3
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
  default     = "Testing"
  description = "Environments"
}

variable "mongodbatlas_public_key" {
  default     = "jmepjyjf"
  description = "MongoDB Public Key"
}

variable "mongodbatlas_private_key" {
  default     = "ac17428e-ba35-4216-86d3-28b7568f2389"
  description = "MongoDB Private Key"
}

# Atlas Organization ID
variable "mongodbatlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
  default     = "Pamela's Org - 2023-02-16"
}

# Atlas Project Name
variable "mongodbatlas_project_name" {
  type        = string
  description = "Atlas Project Name"
  default     = "FWD_TEST"
}

variable "mongodbatlas_environment" {
  type        = string
  description = "The environment to be built"
  default = "sit"
}

# Cluster Instance Size Name
variable "mongodbatlas_cluster_instance_size_name" {
  type        = string
  description = "Cluster instance size name"
  default = "M0"
}

# Cloud Provider to Host Atlas Cluster
variable "mongodbatlas_cloud_provider" {
  type        = string
  description = "AWS or GCP or Azure"
  default = "AWS"
}

# Atlas Region
variable "mongodbatlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
  default = "ap_northeast_1"
}

# MongoDB Version
variable "mongodbatlas_mongodb_version" {
  type        = string
  description = "MongoDB Version"
  default = "6.0"
}

# IP Address Access
variable "mongodbatlas_ip_address" {
  type = string
  description = "IP address used to access Atlas cluster"
  default = "103.6.176.130"
}

variable "mongodbatlas_db_username" {
  type        = string
  description = "Atlas DB Username"
  default     = "fwd"
}

variable "mongodbatlas_db_password" {
  type        = string
  description = "Atlas DB password"
  default     = "fwd"
}

variable "mongodbatlas_db_name" {
  type        = string
  description = "Atlas DB name"
  default     = "fwd_testing"
}

variable "rds_sg_name" {
  default     = "fwd-terraform-sg"
  description = "FWD SG name"
}

