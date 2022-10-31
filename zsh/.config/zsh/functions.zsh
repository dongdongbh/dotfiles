#!/bin/sh
#Set Proxy
function setproxy() {
        export {http,https,ftp}_proxy="http://127.0.0.1:8118"
        export {HTTP,HTTPS,FTP}_PROXY="http://127.0.0.1:8118"
}
   
# Unset Proxy
function unsetproxy() {
        unset {http,https,ftp}_proxy
        unset {HTTP,HTTPS,FTP}_PROXY
}


batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}
