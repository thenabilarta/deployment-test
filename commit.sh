#!/bin/bash

# Get current date in "5 March 2025" format
CURRENT_DATE=$(date +"%d %B %Y")

# Count how many commits have been made today
COMMIT_COUNT=$(git log --since="00:00" --oneline | wc -l)
VERSION=$((COMMIT_COUNT + 1))  # Next version number

COMMIT_MESSAGE="update on $CURRENT_DATE v$VERSION"

# Check if inside a Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: This is not a Git repository."
  exit 1
fi

# Get the current branch name
BRANCH=$(git rev-parse --abbrev-ref HEAD)

git add .
if git commit -m "$COMMIT_MESSAGE"; then
  echo "Commit successful: $COMMIT_MESSAGE"
  if git push origin "$BRANCH"; then
    echo "Push successful to branch '$BRANCH'."
  else
    echo "Error: Push failed."
    exit 1
  fi
else
  echo "Error: Commit failed."
  exit 1
fi
