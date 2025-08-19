# IAM Lab – Quick Overview

This repo documents my AWS IAM learning journey.  
The `setup.md` contains the detailed steps, CLI commands, and proof of work.  
This README gives a quick summary.

---

## Lesson 1: Root & Admin User Setup
- Created a non-root admin user and enabled MFA for both root and admin.
- Built an AdminGroup with administrator privileges.
- Added admin user to the group.
- Configured a secure password policy (strong complexity + rotation).
- Learned why separating Lab vs Production environments is critical.