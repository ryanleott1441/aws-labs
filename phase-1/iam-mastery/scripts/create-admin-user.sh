#!/bin/bash
# createing a one time script to setup a admin group and user 

set -e

# Create Group
aws iam create-group --group-name AdminGroup || echo "Group already exists"
aws iam attach-group-policy \
  --group-name AdminGroup \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# Create User
aws iam create-user --user-name AdminUser || echo "User already exists"
aws iam add-user-to-group --user-name AdminUser --group-name AdminGroup

# Create console login profile
aws iam create-login-profile \
  --user-name AdminUser \
  --password '*****' \
  --password-reset-required || echo "Login profile already exists"