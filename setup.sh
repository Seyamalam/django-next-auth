set -e

echo_success() {
    echo -e "\033[0;32m$1\033[0m"
}

# Function to echo in yellow color for progress messages
echo_progress() {
    echo -e "\033[0;33m$1\033[0m"
}

echo_progress "Setting up backend..."
python3.11 -m venv venv || { echo "Failed to create virtual environment"; exit 1; }
source venv/bin/activate || { echo "Failed to activate virtual environment"; exit 1; }
pip install --upgrade pip || { echo "Failed to upgrade pip"; exit 1; }
pip install -r requirements.txt || { echo "Failed to install backend requirements"; exit 1; }
python manage.py migrate || { echo "Django migrate command failed"; exit 1; }
echo_success "Done setting up backend."
echo_progress "Setting up frontend..."
cd frontend || { echo "Failed to change directory to frontend"; exit 1; }
npm install || { echo "npm install failed"; exit 1; }
echo_success "Done setting up frontend."
cd ..
echo_success "Project is ready bitch"

