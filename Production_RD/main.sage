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

for q in [3, 4, 5]:
    G = GroupCharacters(f"PSU(3, {q})")
    result = G.the_game(G.characters[1],10)
    save_output(result)

"""
#G = GroupCharacters("PSU(3, 5)")
# print(G.the_game(G.characters[1]))
for j in [4, 5, 7, 8, 9, 11, 13]:
    G = PSU_Characters(2, j)
    print(2, j)
    for h in range(len(G.characters)):
        print(h)
        print(generators_from_molien(G.molien_coeff(G.characters[h], 8)))
        print(G.minimal_perm)

for j in [3,4,5,7]:
    G = PSU_Characters(3, j)
    print(3, j)
    print(generators_from_molien(G.molien_coeff(G.characters[0], 8)))
    print(generators_from_molien(G.molien_coeff(G.characters[1], 8)))
    print(generators_from_molien(G.molien_coeff(G.characters[2], 8)))
    print(generators_from_molien(G.molien_coeff(G.characters[3], 8)))
    #print(G.the_game(G.characters[1]))
    #print(G.the_game(G.characters[2]))
    #print(G.the_game(G.characters[3]))
    print(G.minimal_perm)
for j in [3,4,5]:
    for i in range(4, 7):
        print(i, j)
        G = PSU_Characters(i, j)
        print(G.the_game(G.characters[1]))
        print(G.the_game(G.characters[2]))
        print(G.the_game(G.characters[3]))
        print(G.minimal_perm)
# G = PSU_Characters(2, 8)
# print(G.characters)
# print(G.the_game(G.characters[1]))
# print(G.the_game(G.characters[2]))
"""
"""
for j in [9, 13, 19, 25, 27, 31]:
    G = PSU_Characters(3, j)
    print(3, j)
    print(G.the_game(G.characters[1]))
    print(G.the_game(G.characters[2]))
    print(G.the_game(G.characters[3]))
    print(G.minimal_perm)
"""
