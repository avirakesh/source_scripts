#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
ORANGE='\033[38;5;208m' # ANSI 256-color for orange
BOLD='\033[1m'
RESET='\033[0m'

# Helpers
info() { echo -e "${WHITE}🔹 $*${RESET}"; }
success() { echo -e "${GREEN}✔ $*${RESET}"; }
warn() { echo -e "${YELLOW}⚠️  $*${RESET}"; }
error() { echo -e "${RED}❌ $*${RESET}"; }
attention() { echo -e "${ORANGE}🔔 ${BOLD}$*${RESET}"; }
header() { echo -e "\n${BOLD}${PURPLE}➜ $*${RESET}"; }
