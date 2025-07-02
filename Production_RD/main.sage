"""
File used for testing and running our production code 
"""
load("group_characters.sage")
load("suzuki_characters.sage")

G = Suzuki_Characters(32)
print(G.the_game(G.characters[1]))