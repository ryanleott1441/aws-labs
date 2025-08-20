# IAM Lab – Quick Overview

This repo documents my AWS IAM learning journey.  
The setup.md contains the detailed steps, CLI commands, and proof of work.  
This README gives a quick summary.

---

## Lesson 1: Root & Admin User Setup
- Created a non-root admin user and enabled MFA for both root and admin.
- Built an AdminGroup with administrator privileges.
- Added admin user to the group.
- Configured a secure password policy (strong complexity + rotation).
- Learned why separating Lab vs Production environments is critical.

## Lesson 2: Groups, Users, Profiles for least priveleged access
- Created three IAM groups and users: Admin (full access), Developer (broad permissions, no IAM), and ReadOnly (view-only).
- Configured separate CLI profiles for each user so I can run commands directly under the right identity.
- Learned how to make ReadOnly my default profile for safety, only switching to Developer or Admin when needed.
- Verified profiles using sts get-caller-identity and tested permissions to confirm least privilege works.
- Learned about guardrails used in real environments, like making Admin keyless with MFA roles, scoping Developer with custom   policies, and managing credentials with tools such as aws-vault (to be implemented later).