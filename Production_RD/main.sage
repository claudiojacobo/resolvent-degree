"""
File used for testing and running our production code 
"""
load("group_characters.sage")
load("suzuki_characters.sage")
load("psu_characters.sage")
display("PSU(2,13)", 6, 6) 
#G = GroupCharacters("PSU(3, 5)")
G = PSU_Characters(3, 5)
# print(G.the_game(G.characters[1]))
display("PSU(3,5)", 2, 10)