"""
File used for testing and running our production code 
"""
load("group_characters.sage")
load("suzuki_characters.sage")
load("psu_characters.sage")
# display("PSU(2,13)", 6, 6) 
#G = GroupCharacters("PSU(3, 5)")
G = PSU_Characters(3, 4)
print(G.the_game(G.characters[1])) 
print(G.molien_coeff(G.characters[1], 11))
# G = Suzuki_Characters(128)
# print(G.the_game(G.characters[1]))