#!/bin/bash

sudo -v || echo "This script needs sudo privileges..." \
echo "-> sudo ./install.sh" \
exit \
\

SYSTEMD_DIR="/usr/lib/systemd/system"

SCRIPT_DIR="$PWD/scripts"

START_SCRIPT_NAME="start-linux-task-helper.py"
STOP_SCRIPT_NAME="stop-linux-task-helper.sh"
SERVICE_FILE_NAME="linux-task-helper.service"

python3 -m pip install -r requirements.txt

[ -f "$START_SCRIPT_NAME" ] && chmod u+x "$START_SCRIPT_NAME"
[ -f "$SCRIPT_DIR/$STOP_SCRIPT_NAME" ] && chmod u+x "$SCRIPT_DIR/$STOP_SCRIPT_NAME"

( sudo cp -f "$SCRIPT_DIR/$SERVICE_FILE_NAME" "$SYSTEMD_DIR/$SERVICE_FILE_NAME" && \
sudo cp -f "$START_SCRIPT_NAME" "$SYSTEMD_DIR/$START_SCRIPT_NAME" && \
sudo cp -f "$SCRIPT_DIR/$STOP_SCRIPT_NAME" "$SYSTEMD_DIR/$STOP_SCRIPT_NAME" ) \
\

systemctl daemon-reload

echo "Successfully installed service!"
echo "Enable using 'sudo systemctl enable $SERVICE_FILE_NAME'"
echo "Start using 'sudo systemctl start $SERVICE_FILE_NAME'"
