#!/bin/bash

if gem list --installed rubocop > /dev/null; then
    rubocop "$@"
elif bundle exec gem list --installed rubocop &> /dev/null; then
    bundle exec rubocop "$@"
fi
