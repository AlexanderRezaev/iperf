#!/bin/bash
while [ 1 -eq 1 ]
do
  iperf_out=$(iperf3 -c $1 -i 1 -t $2 -P 4 --json | jq '.end.sum_sent.bits_per_second,.end.sum_received.bits_per_second' | tr "\n" " " | ts "$(hostname) $1");
#  tmp=$(echo -n -e "null\x0Anull");
  tmp=$(echo -n -e "$(hostname) $1 null null ");
  if [[ "${iperf_out}" = "${tmp}" ]]; then
    sleep $2;
  else
    # $3 = iperf_interface_speed
    echo -n -e "${iperf_out}";
    exit 0;
  fi
done
