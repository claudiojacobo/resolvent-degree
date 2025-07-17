"""
File used for testing and running our production code 
"""
# load("group_characters.sage")
# load("suzuki_characters.sage")
# load("psu_characters.sage")
load("helper_functions.sage")
load("PSU_3_P.sage")

import json
import os
import time
from datetime import datetime


def save_output(data, file):
    with open(file, "a") as f:
        f.write(json.dumps(data) + "\n")


file = "Carmen-data-dump.json"
for a,b in get_unicorn(100):
    c, d = b.split(',')
    c = int(c)
    d = int(d)
    print(c,d)
    G = GroupCharactersPSU3(c,d)
    for j, char in enumerate(G.characters):
        result = G.the_game(char, 7)
        print(result)
        result["character_index"] = f"{j}"
        save_output(result)

G = GroupCharactersPSU3(3, 6)
result = G.the_game(G.characters[0], 7)
print(result)
save_output(result)




# 31, 37, 41, 43, 47

# G = GroupCharactersPSU3(5, 2)
# result = G.the_game(G.characters[0], 10)
# save_output(result)
