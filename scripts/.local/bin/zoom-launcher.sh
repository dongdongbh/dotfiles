#!/bin/bash
xcompmgr -c -l0 -t0 -r5 -o0.05 &
XCOMPGR_PID=$!
/usr/bin/zoom "$@"
kill $XCOMPGR_PID

