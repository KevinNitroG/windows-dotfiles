#!/usr/bin/env bash

if [[ "$0" =~ .*zsh$ ]]; then
  exit 0
fi

chsh -s "$(which zsh)"
