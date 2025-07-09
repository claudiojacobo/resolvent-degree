"""
File used for testing and running our production code 
"""
load("group_characters.sage")
load("suzuki_characters.sage")
load("psu_characters.sage")
load("helper_functions.sage")

import json
from datetime import datetime

def save_output(data):
    with open("RD-bounds.json", "a") as f:
        f.write(json.dumps(data) + "\n")

for q in [2]:
    G = GroupCharacters(f"PSU(3, {q})")
    result = G.the_game(G.characters[1],10)
    save_output(result)
