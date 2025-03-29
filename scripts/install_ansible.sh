if ! command -v python3 &> /dev/null
then
    echo "Python3 is not installed. Installing Python 3.9..."
    sudo yum install -y python39
else
    echo "Python3 is already installed."
fi

echo "Installing pipx..."
python3 -m pip install --user pipx
python3 -m pipx ensurepath

echo "Installing Ansible..."
pipx install --include-deps ansible



