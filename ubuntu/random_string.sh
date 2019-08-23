#!/bin/bash

# Generate a random string (len=28, max len=28) containing only numbers and alphabets

openssl rand -base64 20 | tr -cd '[[:alnum:]]._-' | head -c28
