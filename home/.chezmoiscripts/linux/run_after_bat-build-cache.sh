#!/usr/bin/env bash

if ! command -v bat &>/dev/null; then
  exit
fi

echo "BUILDING BAT CACHE..."
bat cache --build
