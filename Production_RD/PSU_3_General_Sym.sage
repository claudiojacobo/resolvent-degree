from sympy import sympify

from sympy import sympify
"""
q = var('q')
d = gcd(3, q) # have to redefine that cases etc etc. 
d = 1
r = q+1
s = q-1 
t = q^2 - q + 1
rp = r/d
sp = s/d
tp = t/d
dp = (3-d)/2
rpp = 0 
tpp = (tp - 1)/6 
families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
num_classes = {'1': 1, '2': 1, '3^l': d, '4^k': rp - 1, '5^k': rp - 1, "6'": 1 - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": 2*tpp}
centralizers = {'1': q^3 * rp * r * s * t, '2': q^3 * rp, '3^l': q^2, '4^k': q*rp*r*s, '5^k': q*rp, "6'": r^2, "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
class_sizes = {key: (q^3 * rp * r * s * t) / val for key, val in centralizers.items()}
character_val = {'1': q*s, '2': -1 * q, '3^l': 0, '4^k': -1 * s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
# q = 1, 9 mod 12 
square_maps1 = {'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '2': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            '3^l': {'1': 0, '2': 0, '3^l': d, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '4^k': {'1': 1, '2': 0, '3^l': 0, '4^k': rp - 2, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0} , 
            '5^k': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': rp - 2, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 1 - dp, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6^klm": {'1': 0, '2': 0, '3^l': 0, '4^k': -1 * ceil(r/4) + floor(r/6) + r/2 + ceil(floor(r/6)/2), '5^k': 0, "6'": 0, "6^klm": tpp - rpp - (-1 * ceil(r/4) + floor(r/6) + r/2 + ceil(floor(r/6)/2)), "7^k": 0, "8^k": 0},
            "7^k": {'1': 0, '2': 0, '3^l': 0, '4^k': rp/2, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": tpp - rpp - dp - rp/2, "8^k": 0},  
            "8^k": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 2 * tpp}}
total = 0
for family in families:
    total += class_sizes[family]*num_classes[family]*(character_val[family] ** 2)
    for fam2 in families: # iterate through the square maps 
        total += class_sizes[family]*character_val[fam2]* square_maps1[family][fam2]
total = (total/2)/(q^3 * rp * r * s * t)
# print(total) 
print("q = 1,9 mod 12 case:")
print(total.full_simplify())
print(total.subs(q=25))

# q = 2, 8 mod 12 (p = 2, d = 3)
d = 3 
q = var('q')
r = q+1
s = q-1 
t = q^2 - q + 1
rp = r/d
sp = s/d
tp = t/d
dp = (3-d)/2
rpp = 0 
tpp = (tp - 1)/6 
families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
num_classes = {'1': 1, '2': 1, '3^l': d, '4^k': rp - 1, '5^k': rp - 1, "6'": 1 - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": 2*tpp}
centralizers = {'1': q^3 * rp * r * s * t, '2': q^3 * rp, '3^l': q^2, '4^k': q*rp*r*s, '5^k': q*rp, "6'": r^2, "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
class_sizes = {key: (q^3 * rp * r * s * t) / val for key, val in centralizers.items()}
character_val = {'1': q*s, '2': -1 * q, '3^l': 0, '4^k': -1 * s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
square_maps2 = {'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '2': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            '3^l': {'1': 0, '2': d, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '4^k': {'1': 0, '2': 0, '3^l': 0, '4^k': rp - 1, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0} , 
            '5^k': {'1': 0, '2': 1, '3^l': 0, '4^k': rp-1, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 1 - dp, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6^klm": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": tpp - rpp, "7^k": 0, "8^k": 0},
            "7^k": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": tpp - rpp - dp, "8^k": 0}, 
            "8^k": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 2 * tpp}}

total = 0
for family in families:
    total += class_sizes[family]*num_classes[family]*(character_val[family] ** 2)
    for fam2 in families: # iterate through the square maps 
        total += class_sizes[family]*character_val[fam2]* square_maps2[family][fam2]
total = (total/2)/(q^3 * rp * r * s * t)
# print(total) 
print("q = 2,8 mod 12 case:")
print(total.full_simplify())
print(total.subs(q=32))

# q = 4,10 mod 12 (p = 2, d = 1)
d = 1
q = var('q')
r = q+1
s = q-1 
t = q^2 - q + 1
rp = r/d
sp = s/d
tp = t/d
dp = (3-d)/2
rpp = 0 
tpp = (tp - 1)/6 
families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
num_classes = {'1': 1, '2': 1, '3^l': d, '4^k': rp - 1, '5^k': rp - 1, "6'": 1 - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": 2*tpp}
centralizers = {'1': q^3 * rp * r * s * t, '2': q^3 * rp, '3^l': q^2, '4^k': q*rp*r*s, '5^k': q*rp, "6'": r^2, "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
class_sizes = {key: (q^3 * rp * r * s * t) / val for key, val in centralizers.items()}
character_val = {'1': q*s, '2': -1 * q, '3^l': 0, '4^k': -1 * s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
square_maps3 = {'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '2': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            '3^l': {'1': 0, '2': d, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '4^k': {'1': 0, '2': 0, '3^l': 0, '4^k': rp - 1, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0} , 
            '5^k': {'1': 0, '2': 1, '3^l': 0, '4^k': rp-1, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 1 - dp, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6^klm": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": tpp - rpp, "7^k": 0, "8^k": 0},
            "7^k": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": tpp - rpp - dp, "8^k": 0}, 
            "8^k": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 2 * tpp}}

total = 0
for family in families:
    total += class_sizes[family]*num_classes[family]*(character_val[family] ** 2)
    for fam2 in families: # iterate through the square maps 
        total += class_sizes[family]*character_val[fam2]* square_maps3[family][fam2]
total = (total/2)/(q^3 * rp * r * s * t)
# print(total) 
print("q = 4,10 mod 12 case:")
print(total.full_simplify())
print(total.subs(q=16))

# q = 3, 7 mod 12 (d = 1)
q = var('q')
d = gcd(3, q) # have to redefine that cases etc etc. 
d = 1
r = q+1
s = q-1 
t = q^2 - q + 1
rp = r/d
sp = s/d
tp = t/d
dp = (3-d)/2
rpp = 0 
tpp = (tp - 1)/6 
families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
num_classes = {'1': 1, '2': 1, '3^l': d, '4^k': rp - 1, '5^k': rp - 1, "6'": 1 - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": 2*tpp}
centralizers = {'1': q^3 * rp * r * s * t, '2': q^3 * rp, '3^l': q^2, '4^k': q*rp*r*s, '5^k': q*rp, "6'": r^2, "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
class_sizes = {key: (q^3 * rp * r * s * t) / val for key, val in centralizers.items()}
character_val = {'1': q*s, '2': -1 * q, '3^l': 0, '4^k': -1 * s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
square_maps4 = {'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '2': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            '3^l': {'1': 0, '2': 0, '3^l': d, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '4^k': {'1': 1, '2': 0, '3^l': 0, '4^k': rp - 2, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0} , 
            '5^k': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': rp - 2, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 1 - dp, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6^klm": {'1': 0, '2': 0, '3^l': 0, '4^k': -1 * ceil(r/4) + floor(r/6) + r/2 + floor((ceil(r/6) - 1)/2), '5^k': 0, "6'": 0, "6^klm": tpp - rpp - (-1 * ceil(r/4) + floor(r/6) + r/2 + floor((ceil(r/6) - 1)/2)), "7^k": 0, "8^k": 0},
            "7^k": {'1': 0, '2': 0, '3^l': 0, '4^k': rp/2, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": tpp - rpp - dp - rp/2, "8^k": 0}, 
            "8^k": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 2 * tpp}}
total = 0
for family in families:
    total += class_sizes[family]*num_classes[family]*(character_val[family] ** 2)
    for fam2 in families: # iterate through the square maps 
        total += class_sizes[family]*character_val[fam2]* square_maps4[family][fam2]
total = (total/2)/(q^3 * rp * r * s * t)
# print(total) 
print("q = 3,7 mod 12 case:")
print(total.full_simplify())
print(total.subs(q=27))

# q = 5 mod 12
q = var('q')
d = gcd(3, q) # have to redefine that cases etc etc. 
d = 3
r = q+1
s = q-1 
t = q^2 - q + 1
rp = r/d
sp = s/d
tp = t/d
dp = (3-d)/2
rpp = 0 
tpp = (tp - 1)/6 
families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
num_classes = {'1': 1, '2': 1, '3^l': d, '4^k': rp - 1, '5^k': rp - 1, "6'": 1 - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": 2*tpp}
centralizers = {'1': q^3 * rp * r * s * t, '2': q^3 * rp, '3^l': q^2, '4^k': q*rp*r*s, '5^k': q*rp, "6'": r^2, "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
class_sizes = {key: (q^3 * rp * r * s * t) / val for key, val in centralizers.items()}
character_val = {'1': q*s, '2': -1 * q, '3^l': 0, '4^k': -1 * s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
square_maps5 = {'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '2': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            '3^l': {'1': 0, '2': 0, '3^l': d, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0},
            '4^k': {'1': 1, '2': 0, '3^l': 0, '4^k': rp - 2, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0} , 
            '5^k': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': rp - 2, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 1 - dp, "6^klm": 0, "7^k": 0, "8^k": 0}, 
            "6^klm": {'1': 0, '2': 0, '3^l': 0, '4^k': r/6 - 1, '5^k': 0, "6'": 0, "6^klm": tpp - rpp - (r/6 - 1), "7^k": 0, "8^k": 0},
            "7^k": {'1': 0, '2': 0, '3^l': 0, '4^k': rp/2, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": tpp - rpp - dp - rp/2, "8^k": 0}, 
            "8^k": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, "6^klm": 0, "7^k": 0, "8^k": 2 * tpp}}
total = 0
for family in families:
    total += class_sizes[family]*num_classes[family]*(character_val[family] ** 2)
    for fam2 in families: # iterate through the square maps 
        total += class_sizes[family]*character_val[fam2]* square_maps5[family][fam2]
total = (total/2)/(q^3 * rp * r * s * t)
# print(total) 
print("q = 5 mod 12 case:")
print(total.full_simplify())
print(total.subs(q=17))
"""
def create_latex_table(list_of_dicts):
    """
    Generates a LaTeX table from a list of nested dictionaries, with outer keys
    as rows and inner keys as columns.

    Args:
        list_of_dicts (list): A list of dictionaries, where each dictionary
                              corresponds to a complete table.

    Returns:
        str: A string containing the LaTeX code for the generated table.
    """
    if not list_of_dicts:
        return "No data provided to create a table."

    # Use the keys of the first inner dictionary for the column headers
    # and the keys of the outer dictionary for the row headers.
    outer_keys = list(list_of_dicts[0].keys())
    inner_keys = list(list_of_dicts[0][outer_keys[0]].keys())

    # Build the header row for the LaTeX table
    header = ' & ' + ' & '.join([f'${key}$' for key in inner_keys]) + ' \\\\'
    
    # Build the table body
    body = ''
    # The outer keys now represent the rows of the table
    for row_key in outer_keys:
        row_dict = list_of_dicts[0][row_key]
        row_content = f'${row_key}$'
        
        # Iterate through inner keys to get cell values for the row
        for col_key in inner_keys:
            cell_value = row_dict[col_key]
            
            # Check if the value is a number or an expression involving 'q'
            try:
                # Try to evaluate it as a symbolic expression for a cleaner output
                sympy_expr = sympify(str(cell_value))
                cell_value_str = f'${sympy_expr}$'
            except:
                # If it can't be parsed, treat it as a string
                cell_value_str = f'${cell_value}$'

            row_content += f' & {cell_value_str}'
        
        row_content += ' \\\\'
        body += row_content + '\n'

    # Construct the complete LaTeX document
    latex_code = f"""
\\begin{{table}}[h!]
\\centering
\\begin{{tabular}}{{{'c' * (len(inner_keys) + 1)}}}
\\toprule
{header}
\\midrule
{body}
\\bottomrule
\\end{{tabular}}
\\caption{{Generated Table}}
\\label{{tab:generated}}
\\end{{table}}
"""
    return latex_code



def C_1_squared(modulus):
        C1Counter = 1
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
    
def C_1_cubed(modulus):
    C1Counter = 1
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_1_fourth(modulus):
    C1Counter = 1
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_2_squared(modulus):
    C1Counter = 0
    C2Counter = 1
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if modulus % 2 == 0:
        C1Counter += 1
        C2Counter -= 1
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_2_cubed(modulus):
    C1Counter = 0
    C2Counter = 1
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if modulus % 3 == 0:
        C1Counter += 1
        C2Counter -= 1
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_2_fourth(modulus):
    C1Counter = 0
    C2Counter = 1
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if modulus % 2 == 0:
        C1Counter += 1
        C2Counter -= 1
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_3_squared(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = d
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if modulus % 2 == 0:
        C2Counter += d
        C3Counter -= d
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)


def C_3_cubed(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = d
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if modulus % 3 == 0:
        C1Counter += d
        C3Counter -= d
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)


def C_3_fourth(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = d
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if modulus % 2 == 0:
        C1Counter += d
        C3Counter -= d
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_4_squared(modulus):
    C1Counter = 0
    C4Counter = (q+1)/d-1
    C2Counter = 0
    C3Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if modulus % 2 == 1:
        C1Counter += 1
        C4Counter -= 1
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_4_cubed(modulus):
    C1Counter = 0
    C4Counter = (q+1)/d-1
    C2Counter = 0
    C3Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if (modulus + 1) % 9 == 0: # going to need the mod we're dealing with to be divisible by 9
        C1Counter += 2
        C4Counter -= 2
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_4_fourth(modulus):
    C1Counter = 0
    C4Counter = (q+1)/d-1
    C2Counter = 0
    C3Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if (modulus + 1) % 4 == 0: 
        C1Counter += 3
        C4Counter -= 3
    elif (modulus + 1) % 2 == 0:
        C1Counter += 1
        C4Counter -= 1
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_5_squared(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = (q+1)/d-1
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if modulus % 2 == 1:
        C2Counter +=1
        C5Counter -= 1
    if modulus % 2 == 0:
        C4Counter += (q+1)/d-1
        C5Counter -= (q+1)/d-1
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_5_cubed(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = (q+1)/d-1
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if (modulus+1) % 9 == 0: # need modulus divisible by 9
        C2Counter += 2
        C5Counter -= 2
    if modulus % 3 == 0:
        C4Counter += (q+1)/d-1
        C5Counter-= (q+1)/d-1 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_5_fourth(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = (q+1)/d-1
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    if (modulus+1) % 2 == 0:
        C2Counter += 1
        C5Counter -= 1
    if (modulus+1) % 4 == 0:
        C2Counter += 2
        C5Counter -= 2
    if modulus % 2 == 0:
        C4Counter += (q+1)/d-1
        C5Counter-= (q+1)/d-1 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_6_p_squared(modulus):
    C6pCounter = 1-(3-d)/2
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_6_p_cubed(modulus):
    C6pCounter = 0
    C1Counter = 1-(3-d)/2
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_6_p_fourth(modulus):
    C6pCounter = 1-(3-d)/2
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = 0

    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
def C_6_klm_sym_squared_explicit(modulus):
    if (modulus+1) % 12 in [1,3,5,7,9,11]:
        C4Counter = 0 
    if (modulus+1) % 12 in [2, 10]:
        total = 0 - ceil(r/4) + floor(r/6) + r/2  + ceil(floor(r/6)/2)
        C4Counter = total
    if (modulus+1) % 12 in [4, 8]:
        total = -1 * floor(r/4) + floor(r/6) + r/2 + floor((ceil(r/6) - 1)/2)
        C4Counter = total
    if (modulus+1) % 12 == 6:
        C4Counter = r/6 - 1
    if (modulus+1) % 12 == 0:
        C4Counter = r/6 - 1 
    return (0, 0, 0, C4Counter, 0, 0, tpp - rpp - C4Counter, 0, 0)

def C_6_klm_sym_cubed():
    C4Counter = 0 
    if r % 3 != 0:
        pass
    else: 
        # Case 2a
        k = ceil(r/6)
        while k < 2*r/9:
            C4Counter += 1
            k += 1 
        # Case 3a 
        k = 1
        while k < 2*r/9:
            if k % 2 == 0:
                C4Counter += 1
            k += 1
        # Case 2a, 3a difference = 2r/3 
        k = 1
        while k < r/9:
            C4Counter += 1
            if r % 6 == 0 and k % 2 == 0:
                C4Counter += 1
            elif r % 6 == 3 and k % 2 == 1:
                C4Counter += 1
            k += 1

    return C4Counter

def C_7_squared(modulus):
    totalnum = (3*tpp - rpp - dp)# totalnum = (q*q-q+1-d)/(2*d) - (3-d)/2
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = totalnum
    C8Counter = 0
    if modulus % 2 != 0:
        C4Counter += (q+1)/(2*d)
        C7Counter = C7Counter - (q+1)/(2*d)
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_7_cubed(modulus):
    totalnum = (3*tpp - rpp - dp) # maybe this and fourth need fixing too?
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = totalnum
    C8Counter = 0
    if modulus % 3 == 1:
        C1Counter += 1
        C7Counter -= 1
        C4Counter += q
        C7Counter -= q
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_7_fourth(modulus):
    totalnum = (q*q-q+1-d)/(2*d) - (3-d)/2
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = totalnum
    C8Counter = 0
    if modulus % 2 == 1:
        C4Counter += (q+1)/(2*d)
        C7Counter -= (q+1)/(2*d)
    if (modulus+1)%2 == 0 and (modulus+1)%4 != 0:
        C1Counter += 1
        C4Counter -= 1
    if modulus % 4 == 1:
        C4Counter += 2*(q+1)/(2*d)
        C7Counter -= 2*(q+1)/(2*d)
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_8_squared(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = ((q*q-q+1)/d-1)/3
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_8_cubed(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = ((q*q-q+1)/d-1)/3
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_8_fourth(modulus):
    C1Counter = 0
    C2Counter = 0
    C3Counter = 0
    C4Counter = 0
    C5Counter = 0
    C6pCounter = 0
    C6klmCounter = 0
    C7Counter = 0
    C8Counter = ((q*q-q+1)/d-1)/3
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_6_klm_sym_fourth(modulus):
    C4Counter = 0 
    C1Counter = 0
    r = r
    C4Counter += C_6_klm_sym_squared()
    if r % 4 != 0:
        return C4Counter, C1Counter
    elif r % 3 != 0:
        # We start by dealing with cases concerning a difference of r/4 
        # Case 1a 
        k = 1 
        while k < r/6: 
            C4Counter += 1 
            k += 1
        # Case 1b
        k = ceil(3*r/8)
        while k < r/2:
            C4Counter += 1
            k += 1 
        # Case 2a 
        k = ceil(r/6)
        while k < r/4:
            k += 1
            C4Counter += 1
        # Case 2b 
        k = int(r/2) + 1 
        while k < 7 * r/12:
            k += 1 
            C4Counter += 1 
        # Case 3a
        k = 1 
        while k < r/4:
            if r % 8 == 0 and k%2 == 0: 
                C4Counter += 1
            elif r%8 == 4 and k%2 == 1:
                C4Counter += 1
            k += 1
        # Case 3b
        k = ceil(r/4)
        while k < 7/12 * r:
            if r % 8 == 0 and k % 2 == 0:
                C4Counter += 1 
            if r % 8 == 4 and k % 2 == 1:
                C4Counter += 1
            k += 1 
        # Now we move onto cases concerning a difference of 3r/4
        # Case 1b
        k = ceil(r/8)
        while k < r/6:
            k += 1 
            C4Counter += 1
        # Case 2a
        k = 1
        while k < r/12:
            k += 1 
            C4Counter += 1
        # Case 2b
        k = ceil(r/6)
        while k <= r/4: # note the '<=' weird huh?
            k += 1
            C4Counter += 1
        # Case 3a
        k = 1 
        while k <= r/12:
            if r%8 == 0 and k % 2 == 0:
                C4Counter += 1
            elif r%8 == 4 and k % 2 == 1:
                C4Counter += 1
            k += 1 
        # When 4 | r we get exactly 1 C1
        C4Counter -= 3 
        C1Counter += 1
    else:
        # We start by dealing with cases concerning a difference of r/4 
        # Case 1a 
        k = 1 
        while k <= r/12: 
            C4Counter += 1 
            k += 1
        # Case 2a 
        k = ceil(5*r/24) # this is weird no?
        while k < r/4:
            k += 1
            C4Counter += 1
        # Case 3a
        k = ceil(r/12)
        while k < r/4:
            if r % 8 == 0 and k%2 == 0: 
                C4Counter += 1
            elif r%8 == 4 and k%2 == 1:
                C4Counter += 1
            k += 1
        # Now we move onto cases concerning a difference of 3r/4
        # Case 2a
        k = 1
        while k < r/12:
            k += 1 
            C4Counter += 1
        # Case 3a
        k = 1 
        while k <= r/12:
            if r%8 == 0 and k % 2 == 0:
                C4Counter += 1
            elif r%8 == 4 and k % 2 == 1:
                C4Counter += 1
            k += 1 
        # When 4 | r we get exactly 1 C1
        C4Counter -= 3 
        C1Counter += 1
        # We over counted the C1 case because there was a differnece of r/2 between k and m and so it was flagged by the squared function
        C4Counter -= 1
    return C4Counter, C1Counter
    return C4Counter, C1Counter

def C_6_klm_sym_cubed_explicit(modulus):
        C4Counter = 0
        a = (modulus + 1) % 12
        if a%3 != 0:
            pass
        if a%6 == 0:
            # Case 2a
            C4Counter +=  (ceil(2*r/9) - 1) - ceil(r/6) + 1
            # Case 3a
            C4Counter += floor((ceil(2*r/9) - 1)/2)
            # Case 2a, 3a diff of 2r/3
            C4Counter += ceil(r/9) - 1 
            C4Counter += floor((ceil(r/9) - 1)/2)

        if a%6 == 3:
            # Case 2a
            C4Counter += (ceil(2*r/9) - 1) - ceil(r/6) + 1
            # Case 3a
            C4Counter += floor((ceil(2*r/9) - 1)/2)
            # Case 2a, 3a diff of 2r/3
            C4Counter += ceil(r/9) - 1   
            C4Counter += ceil((ceil(r/9) - 1)/2)
        return (0, 0, 0, C4Counter, 0, 0, tpp - rpp - C4Counter, 0, 0)

def C_6_klm_sym_fourth_explicit(modulus):
    C4Counter = 0
    C1Counter = 0
    a = (modulus + 1) % 24 
    C4Counter += C_6_klm_sym_squared_explicit(modulus)[3]
    if a % 4 != 0:
        pass
    elif a % 3 != 0:
        # Case 1a
        C4Counter += ceil(r/6) - 1
        # Case 1b
        C4Counter += ceil(r/2) - 1 - ceil(3*r/8) + 1
        # Case 2a
        C4Counter += ceil(r/4) - 1 - ceil(r/6) + 1
        # Case 2b
        C4Counter += ceil(7*r/12) - 1 - (floor(r/2) + 1) + 1 # changed int(r/2) to floor(r/2)
        # Case 3a 
        if a % 8 == 0:
            C4Counter += floor((ceil(r/4) - 1)/2)
        if a % 8 == 4:
            C4Counter += ceil((ceil(r/4) - 1)/2)
        # Case 3b
        if a % 8 == 0:
            C4Counter += ceil((ceil(r*7/12) - 1 - ceil(r/4) + 1)/2)
        if a % 8 == 4:
            C4Counter += ceil((ceil(r*7/12) - 1 - ceil(r/4) + 1)/2)
        # diff of 3r/4
        # Case 1b
        C4Counter += ceil(r/6) - 1 - ceil(r/8) + 1 
        # Case 2a
        C4Counter += ceil(r/12) - 1
        # Case 2b
        C4Counter += ceil(r/4) - ceil(r/6) + 1 
        # Case 3a
        if a % 8 == 0:
            C4Counter += floor(floor(r/12)/2)
        elif a % 8 == 4:
            C4Counter += ceil(floor(r/12)/2)
        C4Counter -= 3
        C1Counter += 1
    elif a % 3 == 0:
        # Case 1a 
        C4Counter += ceil(r/12)
        # Case 2a
        C4Counter += ceil(r/4) - 1 - ceil(5*r/24) + 1
        # Case 3a
        if a % 8 == 0:
            C4Counter += floor((ceil(r/4) - 1 - ceil(r/12) + 1)/2)
        elif a % 8 == 4:
            C4Counter += ceil((ceil(r/4) - 1 - ceil(r/12) + 1)/2)
        # diff of 3r/4
        # Case 2a
        C4Counter += ceil(r/12) - 1
        # Case 3a 
        if a % 8 == 0:
            C4Counter += floor(floor(r/12)/2)
        elif a % 8 == 4:
            C4Counter += ceil(floor(r/12)/2)
        C4Counter -= 4
        C1Counter += 1
    return (C1Counter, 0, 0, C4Counter, 0, 0, tpp - rpp - C4Counter - C1Counter, 0, 0)
def get_power_map_counts(power, modulus):
    output = {}
    families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
    if power == 2:
        output['1'] = dict(zip(families, C_1_squared(modulus)))
        output['2'] = dict(zip(families, C_2_squared(modulus)))
        output['3^l'] = dict(zip(families, C_3_squared(modulus)))
        output['4^k'] = dict(zip(families, C_4_squared(modulus)))
        output['5^k'] = dict(zip(families, C_5_squared(modulus)))
        output["6'"] = dict(zip(families, C_6_p_squared(modulus)))
        output["6^klm"] = dict(zip(families, C_6_klm_sym_squared_explicit(modulus)))
        output["7^k"] = dict(zip(families, C_7_squared(modulus)))
        output["8^k"] = dict(zip(families, C_8_squared(modulus)))
    if power == 3:
        output['1'] = dict(zip(families, C_1_cubed(modulus)))
        output['2'] = dict(zip(families, C_2_cubed(modulus)))
        output['3^l'] = dict(zip(families, C_3_cubed(modulus)))
        output['4^k'] = dict(zip(families, C_4_cubed(modulus)))
        output['5^k'] = dict(zip(families, C_5_cubed(modulus)))
        output["6'"] = dict(zip(families, C_6_p_cubed(modulus)))
        output["6^klm"] = dict(zip(families, C_6_klm_sym_cubed_explicit(modulus)))
        output["7^k"] = dict(zip(families, C_7_cubed(modulus)))
        output["8^k"] = dict(zip(families, C_8_cubed(modulus)))
    if power == 4:
        output['1'] = dict(zip(families, C_1_fourth(modulus)))
        output['2'] = dict(zip(families, C_2_fourth(modulus)))
        output['3^l'] = dict(zip(families, C_3_fourth(modulus)))
        output['4^k'] = dict(zip(families, C_4_fourth(modulus)))
        output['5^k'] = dict(zip(families, C_5_fourth(modulus)))
        output["6'"] = dict(zip(families, C_6_p_fourth(modulus)))
        output["6^klm"] = dict(zip(families, C_6_klm_sym_fourth_explicit(modulus)))
        output["7^k"] = dict(zip(families, C_7_fourth(modulus)))
        output["8^k"] = dict(zip(families, C_8_fourth(modulus)))
    return output
dict_list = []
for modulus in range(0, 12):
    q = var('q')
    d = gcd(3, modulus + 1)
    r = q+1
    s = q-1 
    t = q^2 - q + 1
    rp = r/d
    sp = s/d
    tp = t/d
    dp = (3-d)/2
    rpp = 0 
    tpp = (tp - 1)/6 


    square_maps = get_power_map_counts(2, modulus)
    families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
    num_classes = {'1': 1, '2': 1, '3^l': d, '4^k': rp - 1, '5^k': rp - 1, "6'": 1 - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": 2*tpp}
    centralizers = {'1': q^3 * rp * r * s * t, '2': q^3 * rp, '3^l': q^2, '4^k': q*rp*r*s, '5^k': q*rp, "6'": r^2, "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
    class_sizes = {key: (q^3 * rp * r * s * t) / val for key, val in centralizers.items()}
    character_val = {'1': q*s, '2': -1 * q, '3^l': 0, '4^k': -1 * s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
    total = 0
    for family in families:
        total += class_sizes[family]*num_classes[family]*(character_val[family] ** 2)
        for fam2 in families: # iterate through the square maps 
            total += class_sizes[family]*character_val[fam2]* square_maps[family][fam2]
    total = (total/2)/(q^3 * rp * r * s * t)
    print("==========================================")
    print(f"for modulus: {modulus}")
    print(total.full_simplify()) 
    print(square_maps)
    print("==========================================")

    for key in square_maps.keys():
            for key2 in square_maps:
                k = var('k')
                assume(k, 'integer')
                assume(k >= 0)
                if str(type(square_maps[key][key2].subs(q=(modulus + 36*k)))) == "<class 'sage.symbolic.expression.Expression'>":
                    square_maps[key][key2] = square_maps[key][key2].subs(q=(modulus + 36*k)).full_simplify().subs(k=(q-modulus)/36).full_simplify()
                # print(total.subs(q=(modulus + 72*k)).full_simplify().subs(k=(q-modulus)/72).full_simplify())
    dict_list.append(square_maps)
                # fourth_maps_eval[key][key2] = fourth_maps[key][key2].subs(q=modulus) 

unique_elements = []
for d in dict_list:
    if d not in unique_elements:
        unique_elements.append(d)
print(len(dict_list))
print(len(unique_elements))

dict_assignment = []
for dict1 in unique_elements:
    dict_assignment.append([])
    for i, dict2 in enumerate(dict_list):
        if dict2 == dict1:
            dict_assignment[-1].append(i)
print(dict_assignment)
print(unique_elements)
raise SystemExit

# print(equations)
# print(equations_list)


# Prepare the data for SymPy
for table_data in unique_elements:
    for row_dict in table_data.values():
        for key, value in row_dict.items():
            if value == 'q':
                row_dict[key] = 'q'
            elif isinstance(value, str):
                row_dict[key] = value.replace('^', '**')

    latex_table = create_latex_table([table_data])
    print(latex_table)


dict_list = []
for modulus in range(0,36):
    q = var('q')
    d = gcd(3, modulus + 1)
    r = q+1
    s = q-1 
    t = q^2 - q + 1
    rp = r/d
    sp = s/d
    tp = t/d
    dp = (3-d)/2
    rpp = 0 
    tpp = (tp - 1)/6 

    square_maps = get_power_map_counts(2, modulus)
    cube_maps = get_power_map_counts(3, modulus)
    families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
    num_classes = {'1': 1, '2': 1, '3^l': d, '4^k': rp - 1, '5^k': rp - 1, "6'": 1 - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": 2*tpp}
    centralizers = {'1': q^3 * rp * r * s * t, '2': q^3 * rp, '3^l': q^2, '4^k': q*rp*r*s, '5^k': q*rp, "6'": r^2, "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
    class_sizes = {key: (q^3 * rp * r * s * t) / val for key, val in centralizers.items()}
    character_val = {'1': q*s, '2': -1 * q, '3^l': 0, '4^k': -1 * s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
    total = 0
    for family in families:
        total += class_sizes[family]*num_classes[family]*(character_val[family] ** 3)
        for fam2 in families: # iterate through the square maps 
            total += class_sizes[family]*character_val[fam2]* square_maps[family][fam2] * 3 * character_val[family]
            total += class_sizes[family]*character_val[fam2]* cube_maps[family][fam2] * 2 
    total = (total/6)/(q^3 * rp * r * s * t)
    print("==========================================")
    print(f"for modulus: {modulus}")
    print(total.full_simplify()) 
    """
    if modulus != 0 and modulus != 1:
        print(total.subs(q=(modulus)))
    equations[modulus] = str(total.full_simplify())
    equations_list.append(str(total.full_simplify()))
    if modulus % 9 == 8:
        cube_maps_eval = {}
        for key in cube_maps.keys():
            cube_maps_eval[key] = {}
            for key2 in cube_maps:
                cube_maps_eval[key][key2] = cube_maps[key][key2].subs(q=modulus) 
        print(cube_maps_eval)
    """
    for key in cube_maps.keys():
        for key2 in cube_maps:
            k = var('k')
            assume(k, 'integer')
            assume(k >= 0)
            if str(type(cube_maps[key][key2].subs(q=(modulus + 36*k)))) == "<class 'sage.symbolic.expression.Expression'>":
                cube_maps[key][key2] = cube_maps[key][key2].subs(q=(modulus + 36*k)).full_simplify().subs(k=(q-modulus)/36).full_simplify()
            # print(total.subs(q=(modulus + 72*k)).full_simplify().subs(k=(q-modulus)/72).full_simplify())
    dict_list.append(cube_maps)
            # fourth_maps_eval[key][key2] = fourth_maps[key][key2].subs(q=modulus) 
    print(cube_maps)
    print("==========================================")

unique_elements = []
for d in dict_list:
    if d not in unique_elements:
        unique_elements.append(d)
print(len(dict_list))
print(len(unique_elements))

dict_assignment = []
for dict1 in unique_elements:
    dict_assignment.append([])
    for i, dict2 in enumerate(dict_list):
        if dict2 == dict1:
            dict_assignment[-1].append(i)
print(dict_assignment)
print(unique_elements)

# print(equations)
# print(equations_list)


# Prepare the data for SymPy
for table_data in unique_elements:
    for row_dict in table_data.values():
        for key, value in row_dict.items():
            if value == 'q':
                row_dict[key] = 'q'
            elif isinstance(value, str):
                row_dict[key] = value.replace('^', '**')

    latex_table = create_latex_table([table_data])
    print(latex_table)
dict_list = []
for modulus in range(0, 72):
    q = var('q')
    d = gcd(3, modulus + 1)
    r = q+1
    s = q-1 
    t = q^2 - q + 1
    rp = r/d
    sp = s/d
    tp = t/d
    dp = (3-d)/2
    rpp = 0 
    tpp = (tp - 1)/6 

    square_maps = get_power_map_counts(2, modulus)
    cube_maps = get_power_map_counts(3, modulus)
    fourth_maps = get_power_map_counts(4, modulus)
    families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
    num_classes = {'1': 1, '2': 1, '3^l': d, '4^k': rp - 1, '5^k': rp - 1, "6'": 1 - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": 2*tpp}
    centralizers = {'1': q^3 * rp * r * s * t, '2': q^3 * rp, '3^l': q^2, '4^k': q*rp*r*s, '5^k': q*rp, "6'": r^2, "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
    class_sizes = {key: (q^3 * rp * r * s * t) / val for key, val in centralizers.items()}
    character_val = {'1': q*s, '2': -1 * q, '3^l': 0, '4^k': -1 * s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
    total = 0
    for family in families:
        total += class_sizes[family]*num_classes[family]*(character_val[family] ** 4)
        for fam2 in families: # iterate through the square maps 
            total += class_sizes[family]*character_val[fam2]* square_maps[family][fam2] * (character_val[family] ** 2) * 6
            total += class_sizes[family]*(character_val[fam2]** 2) * square_maps[family][fam2] * 3 
            total += class_sizes[family]*character_val[fam2]* cube_maps[family][fam2] * character_val[family] * 8
            total += class_sizes[family]*character_val[fam2]*fourth_maps[family][fam2] * 6
    total = (total/24)/(q^3 * rp * r * s * t)
    print("==========================================")
    print(f"for modulus: {modulus}")
    print(total.full_simplify()) 
    print(total.subs(q=(modulus + 72)))
    print(fourth_maps)
    k = var('k')
    assume(k, 'integer')
    assume(k >= 0)
    print(total.subs(q=(modulus + 72*k)).full_simplify().subs(k=(q-modulus)/72).full_simplify())
    # equations[modulus] = str(total.full_simplify())
    # equations_list.append(str(total.full_simplify()))
    print("==========================================")
    for key in fourth_maps.keys():
        for key2 in fourth_maps:
            k = var('k')
            assume(k, 'integer')
            assume(k >= 0)
            if str(type(fourth_maps[key][key2].subs(q=(modulus + 72*k)))) == "<class 'sage.symbolic.expression.Expression'>":
                fourth_maps[key][key2] = fourth_maps[key][key2].subs(q=(modulus + 72*k)).full_simplify().subs(k=(q-modulus)/72).full_simplify()
            # print(total.subs(q=(modulus + 72*k)).full_simplify().subs(k=(q-modulus)/72).full_simplify())
    dict_list.append(fourth_maps)
            # fourth_maps_eval[key][key2] = fourth_maps[key][key2].subs(q=modulus) 
    # print(fourth_maps)
    print("==========================================")

unique_elements = []
for d in dict_list:
    if d not in unique_elements:
        unique_elements.append(d)
print(len(dict_list))
print(len(unique_elements))

dict_assignment = []
for dict1 in unique_elements:
    dict_assignment.append([])
    for i, dict2 in enumerate(dict_list):
        if dict2 == dict1:
            dict_assignment[-1].append(i)
print(dict_assignment)
print(unique_elements)
for table_data in unique_elements:
    for row_dict in table_data.values():
        for key, value in row_dict.items():
            if value == 'q':
                row_dict[key] = 'q'
            elif isinstance(value, str):
                row_dict[key] = value.replace('^', '**')

    latex_table = create_latex_table([table_data])
    print(latex_table)

"""
    if modulus == 19:
        fourth_maps_eval = {}
        for key in fourth_maps.keys():
            fourth_maps_eval[key] = {}
            for key2 in cube_maps:
                fourth_maps_eval[key][key2] = fourth_maps[key][key2].subs(q=modulus) 
        print(fourth_maps_eval)
"""
