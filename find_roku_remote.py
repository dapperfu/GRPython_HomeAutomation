#!virtual_env/bin/python

import roku
import time

print("🚦", end="")

cfg = {
    "host": "192.168.1.128",
    "port": 8060,
    "timeout": 10, # E   
}
# Autofind roku.
r = next(r for r in roku.Roku.discover() if r.port == 8060)
print(".", end="")
r.find_remote()
print(". Go")
