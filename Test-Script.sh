#!/bin/bash

do
	echo "ACK SCAN"
    nmap -sA 172.16.12.131 &
    echo "XMAS SCAN"
    nmap -sX 172.16.12.131 &
    echo "FIN SCAN"
    nmap -sF 172.16.12.131 &
    echo "SYN SCAN"
    nmap -sS 172.16.12.131 &
    echo "NULL SCAN"
    nmap -sN 172.16.12.131 &
done

wait 
echo "All scans done"
