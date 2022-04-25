#!/bin/bash

counter=5
success_counter=0
while [ $counter -gt 0 ]; do
    status="$(kubectl get pods -A -l app=postgui -o jsonpath='{.items[0].status.phase}')"
   if [ "$status" == "Running" ] ; then ((success_counter=success_counter+1)); fi
   sleep 5
   ((counter=counter-1))
 done
if [ $success_counter -eq 5 ]; then 
    echo "Successfully started"
    exit 0
else 
    echo "Failed to start"
    exit 1
fi
