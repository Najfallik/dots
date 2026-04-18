#/usr/bin/bash

RED='\e[0;31m'
NC='\e[0m'

errprint() {
    printf "${RED}[ERROR]${NC} $1"
}

if command -v git > /dev/null; then
    errprint()
    exit(1)
fi