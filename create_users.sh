#!/bin/bash

# Create the log directory and file if it does not exist
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"
mkdir -p /var/log
mkdir -p /var/secure
touch $LOG_FILE
touch $PASSWORD_FILE
chmod 600 $PASSWORD_FILE

log_action() {
  echo "$(date): $1" | tee -a $LOG_FILE
}

if [ $# -ne 1 ]; then
  echo "Usage: $0 <name-of-text-file>"
  exit 1
fi

INPUT_FILE=$1

if [ ! -f "$INPUT_FILE" ]; then
  echo "File $INPUT_FILE does not exist."
  exit 1
fi

while IFS=';' read -r username groups; do
  username=$(echo "$username" | xargs)
  groups=$(echo "$groups" | xargs)

  if id "$username" &>/dev/null; then
    log_action "User $username already exists."
  else
    useradd -m -s /bin/bash "$username"
    log_action "User $username created."

    if [ $? -eq 0 ]; then
      user_group="$username"
      groupadd "$user_group"
      usermod -aG "$user_group" "$username"
      log_action "Group $user_group created and user $username added to group $user_group."

      IFS=',' read -ra ADDR <<< "$groups"
      for group in "${ADDR[@]}"; do
        group=$(echo "$group" | xargs)
        if ! getent group "$group" > /dev/null; then
          groupadd "$group"
          log_action "Group $group created."
        fi
        usermod -aG "$group" "$username"
        log_action "User $username added to group $group."
      done

      PASSWORD=$(openssl rand -base64 12)
      echo "$username:$PASSWORD" | chpasswd
      echo "$username,$PASSWORD" >> $PASSWORD_FILE
      log_action "Password set for user $username."

      chmod 700 /home/$username
      chown $username:$user_group /home/$username
      log_action "Home directory for user $username set with appropriate permissions and ownership."
    else
      log_action "Failed to create user $username."
    fi
  fi
done < "$INPUT_FILE"

log_action "User creation process completed."

exit 0
