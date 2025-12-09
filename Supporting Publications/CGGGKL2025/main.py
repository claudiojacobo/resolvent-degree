# run by executing `sage -python main.py`

from helper_functions import *
from group_characters import *
from psu3_characters import *

def print_report_as_yml(result):
    content = [f'  - group: "{result['group']}"']
    content.append(f'    bound: {result['bound']}')
    content.append(f'    representation degree: {result['rep_degree']}')

    if result['inv_used']:
        content.append('    invariants used:')
        for deg, num in result['inv_used'].items():
            content.append(f'      {deg} : {num}')
    else:
        content.append('    invariants used: {}')

    content.append('    invariants computed:')
    for deg, num in result['inv_computed'].items():
        if deg != 0:
            content.append(f'      {deg} : {num}')

    content.append('    limitation:')
    for limit in result['limitation']:
        content.append(f'      - {limit}')

    content.append(f'    notes: "{result['notes']}"')
    content.append('')

    print('\n'.join(content))

# PSL(2,q)
for q in prime_powers_up_to(125):
    if q <= 4:
        continue # not simple
    elif q == 4 or q == 9:
        continue # exceptional cases; PSL(2,4) ≅ A_5 and PSL(2,9) ≅ A_6 (already known)

    G = GroupCharacters(f'PSL(2,{q})', schur_cover = f'SL(2,{q})')
    report = G.the_game(G.characters[1], 8) # smallest non-trivial irreducible representation
    print_report_as_yml(report)

# PSU(3,q)
for p,e in prime_powers_up_to(125, as_pairs=True):
    G = GroupCharactersPSU3(p,e)
    report = G.the_game(G.characters[0], 8) # smallest non-trivial irreducible representation
    print_report_as_yml(report)
