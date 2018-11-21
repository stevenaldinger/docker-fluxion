#!/bin/sh

# set -ex

# ----------------------------- [START] main logic --------------------------- #

if [ -f "/usr/bin/custom_entrypoint" ]; then
  chmod a+x "/usr/bin/custom_entrypoint" && \
  "/usr/bin/custom_entrypoint" "$@"
else
  if [ -f "/usr/bin/startup_script" ]; then
    chmod u+x "/usr/bin/startup_script"
    "/usr/bin/startup_script"
  else
    # echo "Mount a file at /usr/bin/startup_script to run a script with GCloud credentials."
    echo "Creating x11vnc password file at /home/user/.x11vnc/passwd..."
    mkdir -p /home/user/.x11vnc
    x11vnc -storepasswd ${VNC_PASSWORD:-secretp4ss} /home/user/.x11vnc/passwd
    chown -R user:user /home/user/
    echo "Running supervisord..."
    /usr/bin/supervisord -c /etc/supervisord.conf
  fi
fi
# ------------------------------ [END] main logic ---------------------------- #

# set +ex
