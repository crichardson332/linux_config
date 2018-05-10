#!/bin/bash

# check OS
if [[ "OSTYPE" == "darwin"* ]] ; then
  source setup_darwin.bash
elif [[ "OSTYPE" == "linux-gnu" ]] ; then
  source setup_linux-gnu.bash
fi
