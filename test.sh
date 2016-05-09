#!/bin/bash
set -e

if curl -s http://hello.127.0.0.1.xip.io | grep -q "<h1>Hello world!</h1>"; then
  exit 0;
else
  exit 1;
fi
