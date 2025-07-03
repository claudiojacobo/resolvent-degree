"""
File used for testing and running our production code 
"""
load("group_characters.sage")
load("suzuki_characters.sage")
load("psu_characters.sage")
load("helper_functions.sage")


G = PSU_Characters(3,5)
G.display()