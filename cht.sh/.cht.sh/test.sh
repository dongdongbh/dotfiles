c="tar"
c2="python/Advanced"
    for s in $(curl -s cheat.sh/:styles); do
      echo
      echo --------
      echo $s
      echo --------
      curl -s cheat.sh/$c?style=$s | head -5
      curl -s cheat.sh/$c2?style=$s | head -5
    done
