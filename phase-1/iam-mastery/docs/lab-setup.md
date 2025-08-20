# IAM Lab - Learning best practices

Showing complete and full steps and things I am learning alot the way,
for a full documentated journey 

---

## Table Of Contents

- [Lesson 1: Setting up Root user and Admin user](#lesson-1-setting-up-root-user-and-admin-user)
- [Lesson 2: Groups, Users, Profiles for least priveleged access](#lesson-2-groups-users-profiles-for-least-priveleged-access)
- [Full CLI Command reference for IAM](#full-cli-command-referenece-for-iam)


---

## Lesson 1: Setting up Root user and Admin user
1. Created non-root user and enabled MFA for best security practices.
2. Created IAM admin user and user group with admin priveleges
3. Created a Secure Password Policy 
4. Learned about organized by Lab vs through Production and why that is important 

### CLI commands used 
2. Creating an IAM admin user and group usin the CLI
```bash
## Creating admin Group and attaching policy 
aws iam create-group --group-name AdminGroup

aws iam attach-group-policy \
  --group-name AdminGroup \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

## Creating admin user, login profile, and adding user to a group 
aws iam create-user --user-name AdminUser

aws iam create-login-profile --user-name AdminUser --password '******' --password-reset-required

aws iam add-user-to-group --user-name AdminUser --group-name AdminGroup
```
3. Used CLI commands to create a secure password policy
```bash 
## Best practice
aws iam update-account-password-policy \
  --minimum-password-length 14 \
  --require-symbols \
  --require-numbers \
  --require-uppercase-characters \
  --require-lowercase-characters \
  --max-password-age 90 \
  --password-reuse-prevention 24 \
  --hard-expiry

## for my lab enviornment 
aws iam update-account-password-policy \
  --minimum-password-length 8 \
  --require-symbols \
  --require-numbers \
  --require-uppercase-characters \
  --require-lowercase-characters 
```

### Proof of Work:
1. Created non-root user and enabled MFA for best security practices.
![Root User MFA Screenshot](images/MFA_root_user_proof.png)
2. Created IAM admin user and user group with admin priveleges
 ![Admin user with admin group piveleges](images/admin-user.png)
3.  Created a Secure Password Policy 
![Password-Policy](images/password-policy.png)

### Notes

4. **Learning Production vs Lab Enviorments**

Lab Account:
- Safe space to experiment.
- Has budget alarms so we don’t overspend.
- Good for testing IAM policies, CLI commands, CloudFormation templates, etc.
- All practice projects go here.

Prod Account:
- Mistakes here mean outaes, security risks and money lost
- Stricter permissions on profiles
- Used only when we are sure the code is tested

Best way to seperate lab vs prod is with different AWS accounts

Different profiles are used for developer and read-only access

### Wrap up 
In this first lesson, I learned how to properly secure the AWS account creating a admin user and making sure not to touch the root user. I created a non-root IAM admin user and enabled MFA on both the root and admin accounts to follow best security practices. I then set up an IAM admin group with administrator privileges and added my new admin user to it. 

I implemented a secure password policy that enforces strong length and complexity requirements. 

I then learned the importance of separating a Lab environment from Production through profiles and tagging, so that experiments never risk impacting production resources.

---




## Lesson 2: Groups, Users, Profiles for least priveleged access

**Overview** 
In this lesson I will be going over how users should be created and used in a real world worl enviorment. 
The goal of IAM is to have users have the least amount of access to make things more secure.
I am make 3 users and groups to simualate that. 

- Created admin, develeoper, readonly users and groups and attached policies and assigned them to their respective groups.
- Created access keys for each user
- Configured the profiles
- Verified profiles
- Default to readonly for safer day-to-day operation to simulate a real world work environment



### Proof of Work:

```bash
# Create groups
aws iam create-group --group-name Admin
aws iam create-group --group-name Developer
aws iam create-group --group-name ReadOnly

# Attach managed policies
aws iam attach-group-policy --group-name Admin     --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam attach-group-policy --group-name Developer --policy-arn arn:aws:iam::aws:policy/PowerUserAccess
aws iam attach-group-policy --group-name ReadOnly  --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess

# Users
aws iam create-user --user-name admin-user
aws iam create-user --user-name dev-user
aws iam create-user --user-name readonly-user

# Add to groups
aws iam add-user-to-group --user-name admin-user     --group-name Admin
aws iam add-user-to-group --user-name dev-user       --group-name Developer
aws iam add-user-to-group --user-name readonly-user  --group-name ReadOnly

# Create access keys
aws iam create-access-key --user-name admin-user
aws iam create-access-key --user-name dev-user
aws iam create-access-key --user-name readonly-user

# Configured profiles
aws configure --profile admin
aws configure --profile developer
aws configure --profile readonly

# Verified profiles
aws sts get-caller-identity --profile admin
aws sts get-caller-identity --profile developer
aws sts get-caller-identity --profile readonly

# Default to readonly
export AWS_PROFILE=readonly 

```

### Notes:

This is an important lesson, I have setup my account to enforce least privelege access. 

I created groups, users, and profiles. 

Admin - with full control
Developer - with alot of permissions but not IAM
Read-Only - for view only access

I learned aboout profiles and storing the credentials for each to be able to run commands direclty under a chosen profile.

I learned about make read-only the default profile to safely view things and only switch to a user with more access if needed. 

Later down the line I will introduce more security by making the Admin profile keyless and accessed via roles with MFA. 
Developer will get mroe scoped down policies and I will touch on that later as well when I make my own custom policies.
Later I will also make sure to manage the credentials using a tool like aws-vault. 


## Full CLI Command referenece for IAM 
```bash
## Creating admin Group and attaching policy 
aws iam create-group --group-name AdminGroup

aws iam attach-group-policy \
  --group-name AdminGroup \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

## Creating admin user, login profile, and adding user to a group 
aws iam create-user --user-name AdminUser

aws iam create-login-profile --user-name AdminUser --password '******' --password-reset-required

aws iam add-user-to-group --user-name AdminUser --group-name AdminGroup

## Creating the password policy 
## Best practice
aws iam update-account-password-policy \
  --minimum-password-length 14 \
  --require-symbols \
  --require-numbers \
  --require-uppercase-characters \
  --require-lowercase-characters \
  --max-password-age 90 \
  --password-reuse-prevention 24 \
  --hard-expiry

## for my lab enviornment 
aws iam update-account-password-policy \
  --minimum-password-length 8 \
  --require-symbols \
  --require-numbers \
  --require-uppercase-characters \
  --require-lowercase-characters 

# Create groups
aws iam create-group --group-name Admin
aws iam create-group --group-name Developer
aws iam create-group --group-name ReadOnly

# Attach managed policies
aws iam attach-group-policy --group-name Admin     --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam attach-group-policy --group-name Developer --policy-arn arn:aws:iam::aws:policy/PowerUserAccess
aws iam attach-group-policy --group-name ReadOnly  --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess

# Users
aws iam create-user --user-name admin-user
aws iam create-user --user-name dev-user
aws iam create-user --user-name readonly-user

# Add to groups
aws iam add-user-to-group --user-name admin-user     --group-name Admin
aws iam add-user-to-group --user-name dev-user       --group-name Developer
aws iam add-user-to-group --user-name readonly-user  --group-name ReadOnly

# Create access keys
aws iam create-access-key --user-name admin-user
aws iam create-access-key --user-name dev-user
aws iam create-access-key --user-name readonly-user

# Configured profiles
aws configure --profile admin
aws configure --profile developer
aws configure --profile readonly

# Verified profiles
aws sts get-caller-identity --profile admin
aws sts get-caller-identity --profile developer
aws sts get-caller-identity --profile readonly

# Default to readonly
export AWS_PROFILE=readonly 
```



