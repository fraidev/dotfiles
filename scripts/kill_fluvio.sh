#!/bin/bash

# Find the process IDs related to fluvio
PIDS=$(ps -ef | grep fluvio | grep -v grep | awk '{print $2}')

# Check if any PIDs were found
if [ -z "$PIDS" ]; then
    echo "No fluvio processes found."
else
    echo "Killing the following fluvio processes: $PIDS"
    # Loop through each PID and kill it
    for PID in $PIDS; do
        kill -9 $PID
        if [ $? -eq 0 ]; then
            echo "Successfully killed process $PID"
        else
            echo "Failed to kill process $PID"
        fi
    done
fi
