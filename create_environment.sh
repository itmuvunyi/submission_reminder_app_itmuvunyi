#!/bin/bash

# Prompt the user for their name
echo "Enter your name:"
read user_name

# Define the main directory
APP_DIR="submission_reminder_${user_name}"

# Create the main application directory
mkdir -p "$APP_DIR"

# Create subdirectories
mkdir -p "$APP_DIR/scripts"
mkdir -p "$APP_DIR/config"
mkdir -p "$APP_DIR/data"

# Move provided files to appropriate directories
echo "Downloading necessary files..."
mv config.env "$APP_DIR/config/"
mv reminder.sh "$APP_DIR/scripts/"
mv functions.sh "$APP_DIR/scripts/"
mv submissions.txt "$APP_DIR/data/"

# Ensure scripts are executable
chmod +x "$APP_DIR/scripts/reminder.sh"
chmod +x "$APP_DIR/scripts/functions.sh"

# Create startup.sh script
echo -e "#!/bin/bash\n# Startup script for the submission reminder app\n\nsource ./scripts/functions.sh\nsource ./config/config.env\n\nbash ./scripts/reminder.sh\nsend_reminder" > "$APP_DIR/startup.sh"
chmod +x "$APP_DIR/startup.sh"

# Create README.md
echo -e "# Submission Reminder App\n\n## How to Run\n1. Navigate to the application directory:\n   \n   \`cd $APP_DIR\`\n\n2. Run the startup script:\n   \n   \`./startup.sh\`\n\nThis will check submissions and send reminders where necessary." > "$APP_DIR/README.md"

echo "Environment setup complete! Navigate to $APP_DIR and run ./startup.sh to start the application."

