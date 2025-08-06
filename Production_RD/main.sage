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
'''
G = GroupCharactersPSU3(3, 997)
result = G.the_game(G.characters[0], 5)
print(result)
save_output(result)
'''

'''
for q in [2,3,4,5,7,8,9,11,13,16,17,19,23]:
    G = GroupCharacters(f"PSU(2,{q})")
    result = G.the_game(G.characters[1], 5)
    print(q)
    print(result,end="\n\n")
'''
G = GroupCharacters("SL(2, 11)")
print(G.the_game(G.characters[1],7))
# we want to compare the miminum perm rep of PSU(2, q), instead of SL(2, q)
'''
file = "ElderlyOwl-data-dump.json"
for a,b in get_unicorn(150):
    G = GroupCharacters(f"PSU(2,{a})")
    for j, char in enumerate(G.characters):
        result = G.the_game(G.characters[1], 10)
        print(result)
        result["character_index"] = f"{j}"
        save_output(result, file)
'''
'''
file = "Acorn-data-dump.json"
for a,b in get_unicorn(150):
    G = GroupCharacters(f"SL(2,{a})")
    for j, char in enumerate(G.characters):
        result = G.the_game(G.characters[1], 10)
        print(result)
        result["character_index"] = f"{j}"
        save_output(result, file)
'''
'''
file = "Condensed-Acorn.json"
with open("Acorn-data-dump.json", "r") as f:
    for line in f:
        entry = json.loads(line)
        if entry.get("character_index") == "0":
            save_output(entry, file)
'''

'''
file = "Carmen-data-dump.json"
for a,b in get_unicorn(126):
    c, d = b.split(',')
    c = int(c)
    d = int(d)
    print(c,d)
    G = GroupCharactersPSU3(c,d)
    for j, char in enumerate(G.characters):
        result = G.the_game(char, 7)
        print(result)
        result["character_index"] = f"{j}"
        save_output(result, file)


G = GroupCharactersPSU3(3, 6)
result = G.the_game(G.characters[0], 7)
print(result)
save_output(result)
'''


# 31, 37, 41, 43, 47
"""
G = GroupCharactersPSU3(5, 2)
result = G.the_game(G.characters[0], 10)
print(result)
"""
# save_output(result)
