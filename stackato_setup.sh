#!/bin/bash

if [ $STACKATO_HOOK_ACTION == 'create' ] && [ ! -f config/site.yml ]; then
  echo "No config/site.yml found, creating..."
  cp config/site.yml.tmpl config/site.yml

  echo "Generating salt..."
  salt=$(ruby -e "require 'bcrypt'; puts BCrypt::Engine.generate_salt")
  sed -n "s|salt: \"change-me\"|salt: \"$salt\"|" config/site.yml

  echo "Generating secret token..."
  secret=$(rake secret)
  sed -n "s|secret_token: \"change-me\"|secret_token:\"$secret\"|" config/site.yml
else
  echo "config/site.yml exists"
fi
