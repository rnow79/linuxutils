#!/bin/bash
if [ "$1" == "s" ] ; then
 for dev in `cat /proc/net/dev | cut -d ":" -f1  | grep 'vlan\|eth'` ; do
  echo "--- dev $dev ---"
  tc -s qdisc ls dev $dev
 done
 exit 0
fi
function rule() {
   tc filter add dev $1 protocol all parent 1: prio $3 u32 match ip src $2 flowid 1:$3
   tc filter add dev $1 protocol all parent 1: prio $3 u32 match ip dst $2 flowid 1:$3
}

for dev in `cat /proc/net/dev | cut -d ":" -f1  | grep 'vlan\|eth'` ; do
 echo dev $dev
 tc qdisc del dev $dev root handle 1:
 tc qdisc add dev $dev root handle 1: prio bands 3 priomap 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 tc qdisc add dev $dev parent 1:1 handle 10: sfq perturb 10
 tc qdisc add dev $dev parent 1:2 handle 20: sfq perturb 10
 tc qdisc add dev $dev parent 1:3 handle 30: sfq perturb 10
 rule $dev 10.52.0.0/16 1
 rule $dev 10.50.0.0/16 2
 rule $dev 10.58.0.0/24 2
 rule $dev 10.58.1.0/24 2
 rule $dev 10.58.3.0/24 2
 rule $dev 0.0.0.0/0 3
done

