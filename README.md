# hng-devops_stage_1

## Task

Your company has employed many new developers. As a SysOps engineer, write a bash script called `create_users.sh` that reads a text file containing the employee’s usernames and group names, where each line is formatted as user;groups.

The script should create users and groups as specified, set up home directories with appropriate permissions and ownership, generate random passwords for the users, and log all actions to `/var/log/user_management.log`. Additionally, store the generated passwords securely in `/var/secure/user_passwords.txt`.

Ensure error handling for scenarios like existing users and provide clear documentation and comments within the script.
Also write a technical article explaining your script, linking back to HNG

## Requirements

Each User must have a personal group with the same group name as the username, this group name will not be written in the text file.
A user can have multiple groups, each group delimited by comma ","
Usernames and user groups are separated by semicolon `";"` - Ignore whitespace

e.g.

- light; sudo,dev,www-data
- idimma; sudo
- mayowa; dev,www-data

For the first line, light is username and groups are sudo, dev, www-data

Technical Article: The article should be well-structured.
It MUST include at least two links to the HNG Internship websites; choose from any of <https://hng.tech/internship>, <https://hng.tech/hire>, or <https://hng.tech/premium> so others can learn more about the program.
The report should be concise.
The article should be public and accessible by anyone on the internet.

## User and Group Management Script

This repository contains a Bash script create_users.sh designed to automate the creation of users and groups on a Linux system. The script reads a text file containing usernames and group names, creates the users and groups as specified, sets up home directories with appropriate permissions, generates random passwords for the users, and logs all actions.

## Features

- Reads a text file with the format username;group1,group2,...
- Creates users and personal groups
- Assigns users to specified groups
- Generates random passwords for users
-Sets up home directories with appropriate permissions and ownership
- Logs all actions to `/var/log/user_management.log`
- Stores generated passwords securely in `/var/secure/user_passwords.txt`

## Dependencies

Ensure the script is run with root or sudo privileges.

## Usage

- **Clone the Repository:**

```bash
git clone 'https://github.com/BjornOnGit/hng-devops_stage_1.git'
cd `hng-devops_stage_1`
```

- **Generate the Sample Users File:**

You can use the provided Python script to generate a sample users file for testing purposes.

```python
import random

usernames = ["user1", "user2", "user3", "user4", "user5"]
groups = ["sudo", "dev", "www-data", "staff", "admin"]

with open("users.txt", "w") as file:
    for username in usernames:
        user_groups = random.sample(groups, k=random.randint(1, len(groups)))
        file.write(f"{username}; {','.join(user_groups)}\n")
```

- **Save the script as generate_users.py and run it:**

```bash
python3 generate_users.py
```

- **Make the Bash Script Executable:**

```bash
chmod +x create_users.sh
```

- **Run the Bash Script with the Generated Users File:**

```bash
sudo ./create_users.sh users.txt
```

## Logging

- **Log File:** All actions performed by the script are logged to `/var/log/user_management.log`. You can view this log file using:

```bash
sudo cat /var/log/user_management.log
```

- **Password File:** The generated passwords are securely stored in `/var/secure/user_passwords.txt`. You can view this file using:

```bash
sudo cat /var/secure/user_passwords.txt
```

## Error Handling

- The script checks if it is run with root or sudo privileges.
- It verifies if the input file exists and is readable.
- It checks if users already exist before attempting to create them.
- It logs all errors and actions to help with troubleshooting.

## Technical article

For a detailed explanation of the script, its functionality, and the reasoning behind each step, please refer to the [technical article](https://bjorndev.hashnode.dev/efficient-user-management-with-bash-a-script-for-user-creation-group-assignment-and-secure-passwords).

<!-- ## Sample Logs Overview

[Sample Logs Screenshot](https://drive.google.com/file/d/1QuybzllynKxRh8joVsd6KASYDcfZCOCi/view?usp=drive_link) -->
