"""
File used for testing and running our production code 
"""
load("group_characters.sage")
load("suzuki_characters.sage")
load("psu_characters.sage")
load("helper_functions.sage")
load("PSU_3_P.sage")

import json
import os
import time
from datetime import datetime

def save_output(data):
    with open("RD-bounds.json", "a") as f:
        f.write(json.dumps(data) + "\n")



# G = GroupCharacters(f"PSU(3, {q})")
# result = G.the_game(G.characters[1],10)
    
G = GroupCharactersPSU3(2, 4)
result = G.the_game(G.characters[0], 10)
print(result)
result["notes"] = "this info may be incorrect as our model is not yet finished"
save_output(result)

G = GroupCharactersPSU3(2, 5)
result = G.the_game(G.characters[0], 10)
print(result)
result["notes"] = "this info may be incorrect as our model is not yet finished"
save_output(result)

G = GroupCharactersPSU3(5, 2)
result = G.the_game(G.characters[0], 10)
print(result)
result["notes"] = "this info may be incorrect as our model is not yet finished"
save_output(result)

G = GroupCharactersPSU3(7, 2)
result = G.the_game(G.characters[0], 10)
print(result)
result["notes"] = "this info may be incorrect as our model is not yet finished"
save_output(result)
# Works for: q = 2, 5, 25, 16, 32, 49, 11, 13, 17, 19, 23, 29

# 31, 37, 41, 43, 47

# G = GroupCharactersPSU3(5, 2)
# result = G.the_game(G.characters[0], 10)
# save_output(result)
