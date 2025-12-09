from helper_functions import *
from group_characters import *

# first try bounding naively
PSL = GroupCharacters('PSL(2,13)')

# bound RD with smallest non-trivial irreducible representation
# computing out to 8 terms in the Molien series
analysis = PSL.the_game(PSL.characters[1], 8)
for key in analysis:
    print(f"{key}: {analysis[key]}")
print('')

# now try passing to Schur cover
SL = GroupCharacters('PSL(2,13)', schur_cover = 'SL(2,13)')

# print results
analysis = SL.the_game(SL.characters[1], 8)
for key in analysis:
    print(f"{key}: {analysis[key]}")

'''
% sage -python demo.py
group: PSL(2,13)
bound: 4
rep_degree: 7
inv_used: {2: 1, 4: 1}
inv_computed: {0: 1, 2: 1, 4: 1, 6: 2, 7: 1, 8: 2}
limitation: ['generic freeness', 'versality']
notes:

group: PSL(2,13)
bound: 4
rep_degree: 6
inv_used: {4: 1}
inv_computed: {0: 1, 4: 1, 8: 1}
limitation: ['generic freeness', 'versality']
notes:
'''
