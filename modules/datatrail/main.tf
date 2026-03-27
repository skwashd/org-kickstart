/**
 * # Org-Kickstart - DataTrail Module
 *
 * Copyright 2025 Chris Farris <chris@primeharbor.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 6.37.0, < 7.0.0"
      configuration_aliases = [aws.security-account]
    }
  }
}

variable "bucket_name" {
  description = "Name of the S3 Bucket to hold DataTrails"
  type        = string
}

variable "trail_name" {
  description = "Name of the DataTrails Trail"
  type        = string
  default     = null
}

variable "excluded_buckets" {
  description = "List of Bucket Arns to exclude"
  type        = list(string)
  default     = []
}

variable "enabled" {
  type        = bool
  description = "Boolean to indicate if the trail logging should be enabled"
}

variable "use_bucket_namespace" {
  description = "Whether to use bucket namespaced to account and region for the created S3 buckets. This is required to ensure unique bucket names across accounts and regions. If set to false, the bucket names will be exactly as specified in the variables which may cause conflicts if the same name is used in multiple accounts or regions."
  type        = bool
  default     = true
}

data "aws_caller_identity" "payer" {}

data "aws_partition" "payer" {}

data "aws_region" "payer" {}



