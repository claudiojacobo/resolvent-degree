"""
File used for testing and running our production code 
"""
# load("group_characters.sage")
# load("suzuki_characters.sage")
# load("psu_characters.sage")
# load("helper_functions.sage")
load("PSU_3_P.sage")

import json
import os
import time
from datetime import datetime

def save_output(data):
    with open("PC-data-dump.json", "a") as f:
        f.write(json.dumps(data) + "\n")



# G = GroupCharacters(f"PSU(3, {q})")
# result = G.the_game(G.characters[1],10)
"""
for j in range(10):
    for a,b in [(3,3), (3,4), (5, 3), (11, 2), (2, 6), (2,7)]:
        try:
            print(a,b)
            G = GroupCharactersPSU3(a, b)
            result = G.the_game(G.characters[j], 7)
            print(result)
            result["character_index"] = f"{j}"
            save_output(result)
        except: 
            print(f"PSU({i},1 does not have a index {j} character")

"""
G = GroupCharactersPSU3(3, 6)
result = G.the_game(G.characters[0], 7)
print(result)
save_output(result)




# 31, 37, 41, 43, 47

# G = GroupCharactersPSU3(5, 2)
# result = G.the_game(G.characters[0], 10)
# save_output(result)
