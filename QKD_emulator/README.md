#KQD (Quantum Key Distribution) HW software emulator.

Software emulator for KQD hardware. This utility generate of random key and sending of them to URLs by POST HTTP query.

## Building

make qkdemu

## Running

Arguments of utility -- URLs of agents which must receive quantum keys by REST API:
```
$ qkdemu URL1 [URL2 ... URLN]
```
For example:
```
$ qkdemu http://127.0.0.1:5000/qkey http://127.0.0.1:5001/qkey
```
