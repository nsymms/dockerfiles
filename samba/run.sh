#!/bin/sh

CONFIG_FILE="/etc/samba/smb.conf"

initialized=`getent passwd |grep -c '^smbuser:'`
set -e
if [ $initialized = "0" ]; then
  adduser smbuser -H -D

  cat >"$CONFIG_FILE" <<EOT
[global]
workgroup = WORKGROUP
security = user
guest ok = yes
guest account = nobody
create mask = 0664
directory mask = 0775
force create mode = 0664
force directory mode = 0775
#force user = smbuser
#force group = smbuser
obey pam restrictions = yes
map to guest = bad user
server role = standalone server
load printers = no
printing = bsd
printcap name = /dev/null
disable spoolss = yes
EOT

  while getopts ":u:s:h" opt; do
    case $opt in
      h)
        cat <<EOH
Samba server container

Container will be configured as samba sharing server and it just needs:
 * host directories to be mounted,
 * users (one or more username:password tuples) provided,
 * shares defined (name, path, users).

 -u username:password         add user account (named 'username'), which is
                              protected by 'password'

 -s name:path:rw:user1[,user2[,userN]]
                              add share, that is visible as 'name', exposing
                              contents of 'path' directory for read+write (rw)
                              or read-only (ro) access for specified logins
                              user1, user2, .., userN. Note that user '-public'
                              will allow anonymous guest access to that share.

Example:
docker run -d -p 445:445 \\
  -v /mnt/data:/share/data \\
  -v /mnt/backups:/share/backups \\
  --name <container name> nsymms/docker-samba \\
  -u "alice:abc123" \\
  -u "bob:secret" \\
  -u "guest:guest" \\
  -s "Backup directory:/share/backups:rw:alice,bob" \\
  -s "Alice (private):/share/data/alice:rw:alice" \\
  -s "Bob (private):/share/data/bob:rw:bob" \\
  -s "Documents (readonly):/share/data/documents:ro:-public"

EOH
        exit 1
        ;;
      u)
        echo -n "Add user "
        #IFS=: read username password <<<"$OPTARG"
	IFS=: read username password <<EOF
$OPTARG
EOF
        echo -n "'$username' "
        adduser "$username" -H -D
        echo -n "with password '$password' "
        echo "$password" |tee - |smbpasswd -s -a "$username"
        echo "DONE"
        ;;
      s)
        echo -n "Add share "
        #IFS=: read sharename sharepath readwrite users <<<"$OPTARG"
        IFS=: read sharename sharepath readwrite users <<EOF
$OPTARG
EOF
        echo -n "'$sharename' "
        echo "[$sharename]" >>"$CONFIG_FILE"
        chown smbuser "$sharepath"
        echo -n "path '$sharepath' "
        echo "path = \"$sharepath\"" >>"$CONFIG_FILE"
        echo "browseable = yes" >> "$CONFIG_FILE"
        echo -n "read"
        if [[ "rw" = "$readwrite" ]] ; then
          echo -n "+write "
          echo "read only = no" >>"$CONFIG_FILE"
        else
          echo -n "-only "
          echo "read only = yes" >>"$CONFIG_FILE"
        fi
	if [[ "-public" = "$users" ]] ; then
	  echo -n "(public) "
	  echo "guest ok = yes" >> "$CONFIG_FILE"
	  echo "public = yes" >> "$CONFIG_FILE"
	  echo "force user = smbuser" >> "$CONFIG_FILE"
	  #echo "force group = smbgroup" >> "$CONFIG_FILE"
	else
          echo -n "for users: "
          users=$(echo "$users" |tr "," " ")
          echo -n "$users "
          echo "valid users = $users" >>"$CONFIG_FILE"
	fi
        echo "DONE"
        ;;
      \?)
        echo "Invalid option: -$OPTARG"
        exit 1
        ;;
      :)
        echo "Option -$OPTARG requires an argument."
        exit 1
        ;;
    esac
  done

fi

exec ionice -c 3 smbd -FS --configfile="$CONFIG_FILE"
