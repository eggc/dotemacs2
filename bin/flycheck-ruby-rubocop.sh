#!/bin/bash
if bundle exec gem list --installed rubocop &> /dev/null; then
    bundle exec rubocop "$@"
elif gem list --installed rubocop > /dev/null; then
    rubocop "$@"
fi
