#!/bin/bash

sudo -v || echo "This script needs sudo privileges..." \
echo "-> sudo ./install.sh" \
exit \
\

SYSTEMD_DIR="/usr/lib/systemd/system"

START_SCRIPT_NAME="start-linux-task-helper.py"
STOP_SCRIPT_NAME="stop-linux-task-helper.sh"
SERVICE_FILE_NAME="linux-task-helper.service"

[ -f "$SYSTEMD_DIR/$SERVICE_FILE_NAME" ] && echo "Stopping old scheduler..." ; \
sudo systemctl stop "$SERVICE_FILE_NAME" && \
sudo systemctl disable "$SERVICE_FILE_NAME" && \
sudo rm -f "$SYSTEMD_DIR/$SERVICE_FILE_NAME" \
\

[ -f "$SYSTEMD_DIR/$START_SCRIPT_NAME" ] && sudo rm -f "$SYSTEMD_DIR/$START_SCRIPT_NAME"
[ -f "$SYSTEMD_DIR/$STOP_SCRIPT_NAME" ] && sudo rm -f "$SYSTEMD_DIR/$STOP_SCRIPT_NAME"
[ -f "$SYSTEMD_DIR/$SERVICE_FILE_NAME" ] && sudo rm -f "$SYSTEMD_DIR/$SERVICE_FILE_NAME"

echo "Reloading systemd daemon..."

sudo systemctl daemon-reload

echo "Successfully uninstalled!"
