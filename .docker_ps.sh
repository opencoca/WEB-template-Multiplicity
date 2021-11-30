#!/bin/bash

# This is handy when using Docker with screen.
# Now that we're moving to yarn it's less needed.


clear
docker ps
while sleep 5; do clear; docker ps; done
