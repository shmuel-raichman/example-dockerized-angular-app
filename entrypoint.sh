#!/bin/bash
# B"H

# This script search for string in this case REPLCAE_ENV_NAME
# And change it in file to the value of the env variable or hardcoded text in the second example.
sed -i "s|REPLCAE_ENV_NAME| ${ENV_NAME}|g" *
sed -i "s|REPLCAE_ENV_BACKEND_URL| SOMETEXTA|g" *

nginx -g "daemon off;"