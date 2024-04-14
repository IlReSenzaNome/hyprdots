#!/bin/bash
#!/bin/bash

if mpc | grep -q playing; then
    state="playing"
elif mpc | grep -q paused; then
    state="paused"
else
    mpd --kill
    state="false"
fi

