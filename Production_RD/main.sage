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


file = "PC-data-dump.json"
q_to_200 = get_unicorn(200)
q_to_100 = get_unicorn(100)
q_vals = [item for item in q_to_200 if item not in q_to_100]
for a,b in q_vals:
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

"""
G = GroupCharactersPSU3(3, 6)
result = G.the_game(G.characters[0], 7)
print(result)
save_output(result)
"""

# 31, 37, 41, 43, 47
"""
G = GroupCharactersPSU3(5, 2)
result = G.the_game(G.characters[0], 10)
print(result)
"""
# save_output(result)
"""
def get_char_sym(self, k, chi, a): 
    unicorn = get_unicorn(a) 
    for primes in range(len(get_unicorn(a)): 
        for item in primes
            if len(
        q =  unicorn[primes][0]
        G = GroupCharactersPSU3(
    #print out characters for several symmetric powers for many PSU(3,q) 
    # to go through and run all of the different groups, we just need to look thorugh e
    for i in range(2, k+1): 
        sym_power(self, chi, k) 

"""
def get_groups(a, k, chi): 
    G = GroupCharactersPSU3(3, a)
    pps = G.get_unicorn(a)
    for group in pps: 
        pair = pps[group][1]
        prime = pair[0]
        power = pair[1]
        q = prime ** power 
        symmetric = 



