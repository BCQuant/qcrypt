#!/bin/sh

qcrypt/qcrypt qcrypt/coder0.cfg > /tmp/coder.log 2>&1 &
qcrypt/qcrypt qcrypt/decoder0.cfg > /tmp/decoder.log 2>&1 &

QKD_emulator/qkdemu 127.0.0.1:78 127.0.0.1:77 > /tmp/qkdemu.log 2>&1

#. /opt/rh/rh-python36/enable

#pipenv run python /tmp/blockchain.py -p 5000 2>&1 | tee /tmp/blockchain_5000.log &
#pipenv run python /tmp/blockchain.py -p 5001 2>&1 | tee /tmp/blockchain_5001.log &

tcpdump -A -i lo port 5001 > /tmp/tcpdump.raw.log 2>&1 &
tcpdump -A -i lo port 2222 > /tmp/tcpdump.qkd.log 2>&1 &

echo Press ENTER
read
echo Connection without coding

curl -X POST -H "Content-Type: application/json" -d '{
 "nodes": ["http://localhost:5001"]
}' "http://localhost:5000/nodes/register"

curl http://localhost:5000/nodes/resolve

echo Press ENTER
read
echo Connection with coding
curl http://localhost:5000/nodes/remove
curl -X POST -H "Content-Type: application/json" -d '{
 "nodes": ["http://localhost:7777"]
}' "http://localhost:5000/nodes/register"

curl http://localhost:5000/nodes/resolve

killall qcrypt/qcrypt > /dev/null 2>&1
killall tcpdump > /dev/null 2>&1

