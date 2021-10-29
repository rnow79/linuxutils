#!/bin/bash

NUM1="126 127"
NUM2="`seq 1 254`"
echo "config firewall ippool"
for n1 in $NUM1 ; do
 for n2 in $NUM2; do
  cat << END
 edit "Private Net $n1.$n2"
 set startip 10.18.$n1.$n2
 set endip 10.18.$n1.$n2
 next
END
 done
done

echo end

