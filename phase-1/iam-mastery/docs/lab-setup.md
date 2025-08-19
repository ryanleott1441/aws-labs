# IAM Lab - Learning best practices

Showing complete and full steps and things I am learning alot the way,
for a full documentated journey 

---

## Table Of Contents

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
1. ![Root User MFA Screenshot](images/MFA_root_user_proof.png)
2. ![Admin user with admin group piveleges](images/admin-user.png)
3. ![Password-Policy](images/password-policy.png)

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

## Full CLI Command referenece 
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
```

