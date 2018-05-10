#!/bin/bash

# check OS
if [[ "$OSTYPE" == "darwin"* ]] ; then
  source darwin.bash
elif [[ "$OSTYPE" == "linux-gnu" ]] ; then
  source linux-gnu.bash
fi
