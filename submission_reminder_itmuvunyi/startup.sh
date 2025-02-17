#!/bin/bash
# Startup script for the submission reminder app

source ./scripts/functions.sh
source ./config/config.env

bash ./scripts/reminder.sh
send_reminder
