#!/bin/bash
set -e

if curl -s http://hello.169.0.13.37.xip.io | grep -q "<h1>Hello world!</h1>"; then
  exit 0;
else
  exit 1;
fi
