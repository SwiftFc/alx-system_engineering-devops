# 0x19. Postmortem

Any software system will eventually fail, and that failure can come stem from a wide range of possible factors: bugs, traffic spikes, security issues, hardware failures, natural disasters, human error… Failing is normal and failing is actually a great opportunity to learn and improve. Any great Software Engineer must learn from his/her mistakes to make sure that they won’t happen again. Failing is fine, but failing twice because of the same issue is not.

A postmortem is a tool widely used in the tech industry. After any outage, the team(s) in charge of the system will write a summary that has 2 main goals:

To provide the rest of the company’s employees easy access to information detailing the cause of the outage. Often outages can have a huge impact on a company, so managers and executives have to understand what happened and how it will impact their work.
And to ensure that the root cause(s) of the outage has been discovered and that measures are taken to make sure it will be fixed

Using one of the web stack debugging project issue or an outage you have personally face, write a postmortem. Most of you will never have faced an outage, so just get creative and invent your own

## “From Locked Out to Logged In: Solving SSH Connection Woes”
### Postmortem: SSH Login Failure Incident

### Issue Summary
Duration: June 26, 2024, 9:00 AM — 12:00 PM (UTC)
Impact: Inability to log in to the remote server, resulting in a delay in completing subsequent tasks. This affected 100% of the users (myself) trying to access the server.
Root Cause: Misconfigured SSH key and incorrect SSH configuration settings on the server.

### Timeline
- 9:00 AM: Issue detected when unable to log in to the remote server using SSH.
- 9:05 AM: Initial troubleshooting began, suspecting issues with the SSH key.
- 9:20 AM: Verified the presence of the SSH key on the local machine and the server.
- 9:30 AM: Attempted to log in multiple times, receiving a “Permission denied (publickey)” error.
- 9:40 AM: Investigated server-side SSH configuration, specifically the sshd_config file.
- 9:50 AM: Assumed that the SSH key was corrupted. Generated a new SSH key pair and added the new public key to the server’s ~/.ssh/authorized_keys file.
- 10:00 AM: Escalated the issue to a peer for additional troubleshooting support.
- 10:15 AM: I first generated a new SSH key using the ssh-keygencommand. Also, my peer review identified that PasswordAuthentication was set to "no" and AuthorizedKeysFile was incorrectly configured.
- 10:25 AM: Updated sshd_config to allow password authentication temporarily and corrected the AuthorizedKeysFile path.
- 10:30 AM: Then I navigated through my files to the location of the newly generated SSH key. I used the command cat ~/.ssh/id_rsa.pubto display it.
- 10:35 AM: I copied the public key and uploaded it to my intranet profile page, which ALX would use for subsequent tasks. The following task involved using the key to launch a server. Upon starting the server, it generated an “IP address for me.”
- 10:40 AM: I then used the newly generated IP address and the server username, which was ssh ubuntu@ip_address, to log in to my server using their terminal. I was then asked to authenticate a passphrase to securely manage my server
- 10:50 AM: Successfully logged into the server. Restored PasswordAuthentication to “yes” for security reasons and confirmed.

### Root Cause and Resolution
- Root Cause: The root cause was a combination of misconfigured SSH settings and an incorrect path for AuthorizedKeysFile in the server's sshd_config file. Additionally, PasswordAuthentication was set to "no", preventing fallback to password-based authentication.
- Resolution: The issue was resolved by:
- Reviewing and updating the sshd_config file on the server.
- Setting PasswordAuthentication to "yes" temporarily to allow troubleshooting.
- Correcting the AuthorizedKeysFile path to ensure the server could locate the correct public keys.
- Restarting the SSH service to apply the configuration changes.
- Successfully logging into the server and reverting PasswordAuthentication to "yes" for security purposes.

### Corrective and Preventative Measures
- Improvements/Fixes:
- Implement a checklist for verifying SSH configurations before deploying a new server.
- Enhance logging and monitoring to detect and diagnose SSH-related issues more effectively.
- Automate configuration validation to prevent misconfigurations.
- Task List:
- Update documentation: Include detailed steps for SSH configuration and troubleshooting.
- Add monitoring: Implement monitoring tools to detect SSH login failures and configuration errors.
- Configuration review: Establish a protocol for reviewing and approving changes to SSH configuration files.
- Automate configuration checks: Use scripts/tools to validate SSH configurations against best practices before applying changes.
- Training: Provide training for the engineering team on SSH key management and server configuration best practices.

By following these steps and implementing the corrective measures, similar issues can be prevented in the future, ensuring a more robust and reliable process for accessing remote servers

BELOW IS LINK TO MY BLOG POST ON MEDIUM
(https://medium.com/@swiftpuss/from-locked-out-to-logged-in-solving-ssh-connection-woes-9c09b59371ce)


