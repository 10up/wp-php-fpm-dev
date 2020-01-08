#!/bin/bash

export EXEC_BASH=true
export COMMAND=$@
exec /entrypoint-dev.sh
