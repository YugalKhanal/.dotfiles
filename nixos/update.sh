#!/usr/bin/env bash

nix-channel update
nix flake update
sudo nixos-rebuild switch --flake .
