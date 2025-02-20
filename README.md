# Submission Reminder App

This application is developed to help remind students about upcoming submissions. It checks the submission statuses and sends reminders notification based on the data provided.

## Setup Instructions to follow:
1. Clone a Repository:
   ```
   git clone https://github.com/itmuvunyi/submission_reminder_app_itmuvunyi.git
   ```
2. Run the environment script:
   ```
   cd submission_reminder_app_itmuvunyi
   ./create_environment.sh
   ```
3. Navigate to the created directory and start the app:
   ```
   cd submission_reminder_{userName}/scripts
   chmod 755 startup.sh
   ./startup.sh
   ```
## Structure of Directory
    ```
   submission_reminder_{YourName}/
│── app/
│   └── reminder.sh
│── config/
│   └── config.env
│── modules/
│   └── functions.sh
│── assets/
│   └── submissions.txt
│── startup.sh

    ```

## Project Structure:
- `reminder.sh` → Runs the actual reminder logic.
- `functions.sh` → Contains core utility functions that applications uses.
- `submissions.txt` → Contains data about the students submissions that the app is monitoring.
- `config.env` → Hold configuration settings of the application.
- `startup.sh` → Initializes and starts the application.

## Author:
Developed by **itmuvunyi**

