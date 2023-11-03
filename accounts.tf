# Copyright 2023 Chris Farris <chris@primeharbor.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Import with the following command:
#
#  terraform import 'module.organization.module.["Account Key in tfvars"].aws_organizations_account.account' AWSACCOUNTID
#

module "accounts" {
  for_each = var.accounts
  source   = "./modules/account"

  account_name             = each.value["account_name"]
  account_email            = each.value["account_email"]
  parent_ou_id             = lookup(each.value, "parent_ou_id", aws_organizations_organizational_unit.workloads_ou.id)
  admin_permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn
  admin_group_id           = aws_identitystore_group.admin_group.group_id
  billing_contact          = var.global_billing_contact
  security_contact         = var.global_security_contact
}