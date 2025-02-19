#!/bin/bash

# Prompt for user's name
read -p "Enter your name: " userName

# Define main directory
app_dir="submission_reminder_${userName}"

# Create directory structure
mkdir -p "$app_dir/app"
mkdir -p "$app_dir/modules"
mkdir -p "$app_dir/assets"
mkdir -p "$app_dir/config"

# Create necessary files
touch "$app_dir/app/reminder.sh"
touch "$app_dir/modules/functions.sh"
touch "$app_dir/assets/submissions.txt"
touch "$app_dir/config/config.env"
touch "$app_dir/startup.sh"
touch "$app_dir/README.md"

# Work on config.env
cat << EOF > "$app_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Work on submissions.txt with sample student records
cat << EOF > "$app_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOF

# Work on functions.sh
cat << 'EOF' > "$app_dir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# Work on reminder.sh
cat << 'EOF' > "$app_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# Works on startup.sh
cat << 'EOF' > "$app_dir/startup.sh"
#!/bin/bash

# Load environment variables and functions
source ./config/config.env
source ./modules/functions.sh

# Path to submission file
submissions_file="./assets/submissions.txt"

# Check if submissions file exists
if [ ! -f "$submissions_file" ]; then
    echo "Error: Submissions file ($submissions_file) is missing!"
    exit 1
fi

# Display assignment details from the environment variables
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"

echo "----------------------------------------------"

# Call the function to check submissions
check_submissions "$submissions_file"

# Reminder executable messagee
echo "Reminder script executed successfully!"
EOF

# Create a README.md file
cat << EOF > "$app_dir/README.md"
# Submission Reminder App

This application is developed to help remind students about upcoming submissions. It checks the submission statuses and sends reminders notification based on the data provided.

## Setup Instructions to follow:
1. Run the setup script:
   \`\`\`
   chmod +x setup_all.sh
   ./setup_all.sh
   \`\`\`
2. Navigate to the created directory and start the app:
   \`\`\`
   cd submission_reminder_${userName}/scripts
   chmod +x startup.sh
   ./startup.sh
   \`\`\`

## Project Structure:
- \`reminder.sh\` → Runs the actual reminder logic.
- \`functions.sh\` → Contains core utility functions that applications uses.
- \`submissions.txt\` → Contains data about the students submissions that the app is monitoring.
- \`config.env\` → Hold configuration settings of the application.
- \`startup.sh\` → Initializes and starts the application.

## Author:
Developed by **${userName}**
EOF

# Make scripts executable
chmod 755 "$app_dir/modules/functions.sh"
chmod 755 "$app_dir/startup.sh"
chmod 755 "$app_dir/app/reminder.sh"

echo "Environment setup completed! Run the application..."
cd "$app_dir"
./startup.sh

