#!/bin/bash
# deploy.sh

# Ensure working directory is the app folder
cd /home/$USER/app || { echo "App directory not found. Ensure initial setup is complete."; exit 1; }

# Pull latest code from private GitHub repo
git pull origin main || { echo "Git pull failed. Check SSH key and repo access."; exit 1; }

# Install dependencies (in case new ones were added)
npm install

# Reload the app with PM2 for zero-downtime deployment
pm2 reload ecosystem.config.js || { echo "PM2 reload failed."; exit 1; }

# Save PM2 process list to ensure persistence across reboots
pm2 save

# Verify the app is running
pm2 list

echo "Deployment completed successfully with zero downtime."