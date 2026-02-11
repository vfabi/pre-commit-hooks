#!/usr/bin/env bash


function cecho {
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    NC="\033[0m"
    printf "${!1}${2} ${NC}\n"
}
