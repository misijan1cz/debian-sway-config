#!/bin/bash

username=$(id -u -n 1000)


# Download eduroam config script
curl 'https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=1070&device=linux&generatedfor=user&openroaming=0' > /home/$username/eduroam-cuni.py
