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


# This file was *autogenerated* from the file PSU_3_General_Sym.sage
from sage.all_cmdline import *   # import sage library

_sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_2 = Integer(2); _sage_const_3 = Integer(3); _sage_const_9 = Integer(9); _sage_const_4 = Integer(4); _sage_const_12 = Integer(12); _sage_const_5 = Integer(5); _sage_const_7 = Integer(7); _sage_const_11 = Integer(11); _sage_const_10 = Integer(10); _sage_const_6 = Integer(6); _sage_const_8 = Integer(8); _sage_const_24 = Integer(24); _sage_const_72 = Integer(72); _sage_const_19 = Integer(19)



def C_1_squared(modulus):
        C1Counter = _sage_const_1 
        C2Counter = _sage_const_0 
        C3Counter = _sage_const_0 
        C4Counter = _sage_const_0 
        C5Counter = _sage_const_0 
        C6pCounter = _sage_const_0 
        C6klmCounter = _sage_const_0 
        C7Counter = _sage_const_0 
        C8Counter = _sage_const_0 
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
    
def C_1_cubed(modulus):
    C1Counter = _sage_const_1 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_1_fourth(modulus):
    C1Counter = _sage_const_1 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_2_squared(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_1 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if modulus % _sage_const_2  == _sage_const_0 :
        C1Counter += _sage_const_1 
        C2Counter -= _sage_const_1 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_2_cubed(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_1 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if modulus % _sage_const_3  == _sage_const_0 :
        C1Counter += _sage_const_1 
        C2Counter -= _sage_const_1 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_2_fourth(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_1 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if modulus % _sage_const_2  == _sage_const_0 :
        C1Counter += _sage_const_1 
        C2Counter -= _sage_const_1 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_3_squared(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = d
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if modulus % _sage_const_2  == _sage_const_0 :
        C2Counter += d
        C3Counter -= d
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)


def C_3_cubed(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = d
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if modulus % _sage_const_3  == _sage_const_0 :
        C1Counter += d
        C3Counter -= d
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)


def C_3_fourth(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = d
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if modulus % _sage_const_2  == _sage_const_0 :
        C1Counter += d
        C3Counter -= d
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_4_squared(modulus):
    C1Counter = _sage_const_0 
    C4Counter = (q+_sage_const_1 )/d-_sage_const_1 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if modulus % _sage_const_2  == _sage_const_1 :
        C1Counter += _sage_const_1 
        C4Counter -= _sage_const_1 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_4_cubed(modulus):
    C1Counter = _sage_const_0 
    C4Counter = (q+_sage_const_1 )/d-_sage_const_1 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if (modulus + _sage_const_1 ) % _sage_const_9  == _sage_const_0 : # going to need the mod we're dealing with to be divisible by 9
        C1Counter += _sage_const_2 
        C4Counter -= _sage_const_2 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_4_fourth(modulus):
    C1Counter = _sage_const_0 
    C4Counter = (q+_sage_const_1 )/d-_sage_const_1 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if (modulus + _sage_const_1 ) % _sage_const_4  == _sage_const_0 : 
        C1Counter += _sage_const_3 
        C4Counter -= _sage_const_3 
    elif (modulus + _sage_const_1 ) % _sage_const_2  == _sage_const_0 :
        C1Counter += _sage_const_1 
        C4Counter -= _sage_const_1 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_5_squared(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = (q+_sage_const_1 )/d-_sage_const_1 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if modulus % _sage_const_2  == _sage_const_1 :
        C2Counter +=_sage_const_1 
        C5Counter -= _sage_const_1 
    if modulus % _sage_const_2  == _sage_const_0 :
        C4Counter += (q+_sage_const_1 )/d-_sage_const_1 
        C5Counter -= (q+_sage_const_1 )/d-_sage_const_1 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_5_cubed(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = (q+_sage_const_1 )/d-_sage_const_1 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if (modulus+_sage_const_1 ) % _sage_const_9  == _sage_const_0 : # need modulus divisible by 9
        C2Counter += _sage_const_2 
        C5Counter -= _sage_const_2 
    if modulus % _sage_const_3  == _sage_const_0 :
        C4Counter += (q+_sage_const_1 )/d-_sage_const_1 
        C5Counter-= (q+_sage_const_1 )/d-_sage_const_1  
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_5_fourth(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = (q+_sage_const_1 )/d-_sage_const_1 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    if (modulus+_sage_const_1 ) % _sage_const_2  == _sage_const_0 :
        C2Counter += _sage_const_1 
        C5Counter -= _sage_const_1 
    if (modulus+_sage_const_1 ) % _sage_const_4  == _sage_const_0 :
        C2Counter += _sage_const_2 
        C5Counter -= _sage_const_2 
    if modulus % _sage_const_2  == _sage_const_0 :
        C4Counter += (q+_sage_const_1 )/d-_sage_const_1 
        C5Counter-= (q+_sage_const_1 )/d-_sage_const_1  
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_6_p_squared(modulus):
    C6pCounter = _sage_const_1 -(_sage_const_3 -d)/_sage_const_2 
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_6_p_cubed(modulus):
    C6pCounter = _sage_const_0 
    C1Counter = _sage_const_1 -(_sage_const_3 -d)/_sage_const_2 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_6_p_fourth(modulus):
    C6pCounter = _sage_const_1 -(_sage_const_3 -d)/_sage_const_2 
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = _sage_const_0 

    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
def C_6_klm_sym_squared_explicit(modulus):
    if (modulus+_sage_const_1 ) % _sage_const_12  in [_sage_const_1 ,_sage_const_3 ,_sage_const_5 ,_sage_const_7 ,_sage_const_9 ,_sage_const_11 ]:
        C4Counter = _sage_const_0  
    if (modulus+_sage_const_1 ) % _sage_const_12  in [_sage_const_2 , _sage_const_10 ]:
        total = _sage_const_0  - ceil(r/_sage_const_4 ) + floor(r/_sage_const_6 ) + r/_sage_const_2   + ceil(floor(r/_sage_const_6 )/_sage_const_2 )
        C4Counter = total
    if (modulus+_sage_const_1 ) % _sage_const_12  in [_sage_const_4 , _sage_const_8 ]:
        total = -_sage_const_1  * floor(r/_sage_const_4 ) + floor(r/_sage_const_6 ) + r/_sage_const_2  + floor((ceil(r/_sage_const_6 ) - _sage_const_1 )/_sage_const_2 )
        C4Counter = total
    if (modulus+_sage_const_1 ) % _sage_const_12  == _sage_const_6 :
        C4Counter = r/_sage_const_6  - _sage_const_1 
    if (modulus+_sage_const_1 ) % _sage_const_12  == _sage_const_0 :
        C4Counter = r/_sage_const_6  - _sage_const_1  
    return (_sage_const_0 , _sage_const_0 , _sage_const_0 , C4Counter, _sage_const_0 , _sage_const_0 , tpp - rpp - C4Counter, _sage_const_0 , _sage_const_0 )

def C_6_klm_sym_cubed():
    C4Counter = _sage_const_0  
    if r % _sage_const_3  != _sage_const_0 :
        pass
    else: 
        # Case 2a
        k = ceil(r/_sage_const_6 )
        while k < _sage_const_2 *r/_sage_const_9 :
            C4Counter += _sage_const_1 
            k += _sage_const_1  
        # Case 3a 
        k = _sage_const_1 
        while k < _sage_const_2 *r/_sage_const_9 :
            if k % _sage_const_2  == _sage_const_0 :
                C4Counter += _sage_const_1 
            k += _sage_const_1 
        # Case 2a, 3a difference = 2r/3 
        k = _sage_const_1 
        while k < r/_sage_const_9 :
            C4Counter += _sage_const_1 
            if r % _sage_const_6  == _sage_const_0  and k % _sage_const_2  == _sage_const_0 :
                C4Counter += _sage_const_1 
            elif r % _sage_const_6  == _sage_const_3  and k % _sage_const_2  == _sage_const_1 :
                C4Counter += _sage_const_1 
            k += _sage_const_1 

    return C4Counter

def C_7_squared(modulus):
    totalnum = (_sage_const_3 *tpp - rpp - dp)# totalnum = (q*q-q+1-d)/(2*d) - (3-d)/2
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = totalnum
    C8Counter = _sage_const_0 
    if modulus % _sage_const_2  != _sage_const_0 :
        C4Counter += (q+_sage_const_1 )/(_sage_const_2 *d)
        C7Counter = C7Counter - (q+_sage_const_1 )/(_sage_const_2 *d)
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_7_cubed(modulus):
    totalnum = (_sage_const_3 *tpp - rpp - dp) # maybe this and fourth need fixing too?
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = totalnum
    C8Counter = _sage_const_0 
    if modulus % _sage_const_3  == _sage_const_1 :
        C1Counter += _sage_const_1 
        C7Counter -= _sage_const_1 
        C4Counter += q
        C7Counter -= q
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_7_fourth(modulus):
    totalnum = (q*q-q+_sage_const_1 -d)/(_sage_const_2 *d) - (_sage_const_3 -d)/_sage_const_2 
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = totalnum
    C8Counter = _sage_const_0 
    if modulus % _sage_const_2  == _sage_const_1 :
        C4Counter += (q+_sage_const_1 )/(_sage_const_2 *d)
        C7Counter -= (q+_sage_const_1 )/(_sage_const_2 *d)
    if (modulus+_sage_const_1 )%_sage_const_2  == _sage_const_0  and (modulus+_sage_const_1 )%_sage_const_4  != _sage_const_0 :
        C1Counter += _sage_const_1 
        C4Counter -= _sage_const_1 
    if modulus % _sage_const_4  == _sage_const_1 :
        C4Counter += _sage_const_2 *(q+_sage_const_1 )/(_sage_const_2 *d)
        C7Counter -= _sage_const_2 *(q+_sage_const_1 )/(_sage_const_2 *d)
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_8_squared(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = ((q*q-q+_sage_const_1 )/d-_sage_const_1 )/_sage_const_3 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_8_cubed(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = ((q*q-q+_sage_const_1 )/d-_sage_const_1 )/_sage_const_3 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_8_fourth(modulus):
    C1Counter = _sage_const_0 
    C2Counter = _sage_const_0 
    C3Counter = _sage_const_0 
    C4Counter = _sage_const_0 
    C5Counter = _sage_const_0 
    C6pCounter = _sage_const_0 
    C6klmCounter = _sage_const_0 
    C7Counter = _sage_const_0 
    C8Counter = ((q*q-q+_sage_const_1 )/d-_sage_const_1 )/_sage_const_3 
    return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

def C_6_klm_sym_fourth(modulus):
    C4Counter = _sage_const_0  
    C1Counter = _sage_const_0 
    r = r
    C4Counter += C_6_klm_sym_squared()
    if r % _sage_const_4  != _sage_const_0 :
        return C4Counter, C1Counter
    elif r % _sage_const_3  != _sage_const_0 :
        # We start by dealing with cases concerning a difference of r/4 
        # Case 1a 
        k = _sage_const_1  
        while k < r/_sage_const_6 : 
            C4Counter += _sage_const_1  
            k += _sage_const_1 
        # Case 1b
        k = ceil(_sage_const_3 *r/_sage_const_8 )
        while k < r/_sage_const_2 :
            C4Counter += _sage_const_1 
            k += _sage_const_1  
        # Case 2a 
        k = ceil(r/_sage_const_6 )
        while k < r/_sage_const_4 :
            k += _sage_const_1 
            C4Counter += _sage_const_1 
        # Case 2b 
        k = int(r/_sage_const_2 ) + _sage_const_1  
        while k < _sage_const_7  * r/_sage_const_12 :
            k += _sage_const_1  
            C4Counter += _sage_const_1  
        # Case 3a
        k = _sage_const_1  
        while k < r/_sage_const_4 :
            if r % _sage_const_8  == _sage_const_0  and k%_sage_const_2  == _sage_const_0 : 
                C4Counter += _sage_const_1 
            elif r%_sage_const_8  == _sage_const_4  and k%_sage_const_2  == _sage_const_1 :
                C4Counter += _sage_const_1 
            k += _sage_const_1 
        # Case 3b
        k = ceil(r/_sage_const_4 )
        while k < _sage_const_7 /_sage_const_12  * r:
            if r % _sage_const_8  == _sage_const_0  and k % _sage_const_2  == _sage_const_0 :
                C4Counter += _sage_const_1  
            if r % _sage_const_8  == _sage_const_4  and k % _sage_const_2  == _sage_const_1 :
                C4Counter += _sage_const_1 
            k += _sage_const_1  
        # Now we move onto cases concerning a difference of 3r/4
        # Case 1b
        k = ceil(r/_sage_const_8 )
        while k < r/_sage_const_6 :
            k += _sage_const_1  
            C4Counter += _sage_const_1 
        # Case 2a
        k = _sage_const_1 
        while k < r/_sage_const_12 :
            k += _sage_const_1  
            C4Counter += _sage_const_1 
        # Case 2b
        k = ceil(r/_sage_const_6 )
        while k <= r/_sage_const_4 : # note the '<=' weird huh?
            k += _sage_const_1 
            C4Counter += _sage_const_1 
        # Case 3a
        k = _sage_const_1  
        while k <= r/_sage_const_12 :
            if r%_sage_const_8  == _sage_const_0  and k % _sage_const_2  == _sage_const_0 :
                C4Counter += _sage_const_1 
            elif r%_sage_const_8  == _sage_const_4  and k % _sage_const_2  == _sage_const_1 :
                C4Counter += _sage_const_1 
            k += _sage_const_1  
        # When 4 | r we get exactly 1 C1
        C4Counter -= _sage_const_3  
        C1Counter += _sage_const_1 
    else:
        # We start by dealing with cases concerning a difference of r/4 
        # Case 1a 
        k = _sage_const_1  
        while k <= r/_sage_const_12 : 
            C4Counter += _sage_const_1  
            k += _sage_const_1 
        # Case 2a 
        k = ceil(_sage_const_5 *r/_sage_const_24 ) # this is weird no?
        while k < r/_sage_const_4 :
            k += _sage_const_1 
            C4Counter += _sage_const_1 
        # Case 3a
        k = ceil(r/_sage_const_12 )
        while k < r/_sage_const_4 :
            if r % _sage_const_8  == _sage_const_0  and k%_sage_const_2  == _sage_const_0 : 
                C4Counter += _sage_const_1 
            elif r%_sage_const_8  == _sage_const_4  and k%_sage_const_2  == _sage_const_1 :
                C4Counter += _sage_const_1 
            k += _sage_const_1 
        # Now we move onto cases concerning a difference of 3r/4
        # Case 2a
        k = _sage_const_1 
        while k < r/_sage_const_12 :
            k += _sage_const_1  
            C4Counter += _sage_const_1 
        # Case 3a
        k = _sage_const_1  
        while k <= r/_sage_const_12 :
            if r%_sage_const_8  == _sage_const_0  and k % _sage_const_2  == _sage_const_0 :
                C4Counter += _sage_const_1 
            elif r%_sage_const_8  == _sage_const_4  and k % _sage_const_2  == _sage_const_1 :
                C4Counter += _sage_const_1 
            k += _sage_const_1  
        # When 4 | r we get exactly 1 C1
        C4Counter -= _sage_const_3  
        C1Counter += _sage_const_1 
        # We over counted the C1 case because there was a differnece of r/2 between k and m and so it was flagged by the squared function
        C4Counter -= _sage_const_1 
    return C4Counter, C1Counter
    return C4Counter, C1Counter

def C_6_klm_sym_cubed_explicit(modulus):
        C4Counter = _sage_const_0 
        a = (modulus + _sage_const_1 ) % _sage_const_12 
        if a%_sage_const_3  != _sage_const_0 :
            pass
        if a%_sage_const_6  == _sage_const_0 :
            # Case 2a
            C4Counter +=  (ceil(_sage_const_2 *r/_sage_const_9 ) - _sage_const_1 ) - ceil(r/_sage_const_6 ) + _sage_const_1 
            # Case 3a
            C4Counter += floor((ceil(_sage_const_2 *r/_sage_const_9 ) - _sage_const_1 )/_sage_const_2 )
            # Case 2a, 3a diff of 2r/3
            C4Counter += ceil(r/_sage_const_9 ) - _sage_const_1  
            C4Counter += floor((ceil(r/_sage_const_9 ) - _sage_const_1 )/_sage_const_2 )

        if a%_sage_const_6  == _sage_const_3 :
            # Case 2a
            C4Counter += (ceil(_sage_const_2 *r/_sage_const_9 ) - _sage_const_1 ) - ceil(r/_sage_const_6 ) + _sage_const_1 
            # Case 3a
            C4Counter += floor((ceil(_sage_const_2 *r/_sage_const_9 ) - _sage_const_1 )/_sage_const_2 )
            # Case 2a, 3a diff of 2r/3
            C4Counter += ceil(r/_sage_const_9 ) - _sage_const_1    
            C4Counter += ceil((ceil(r/_sage_const_9 ) - _sage_const_1 )/_sage_const_2 )
        return (_sage_const_0 , _sage_const_0 , _sage_const_0 , C4Counter, _sage_const_0 , _sage_const_0 , tpp - rpp - C4Counter, _sage_const_0 , _sage_const_0 )

def C_6_klm_sym_fourth_explicit(modulus):
    C4Counter = _sage_const_0 
    C1Counter = _sage_const_0 
    a = (modulus + _sage_const_1 ) % _sage_const_24  
    C4Counter += C_6_klm_sym_squared_explicit(modulus)[_sage_const_3 ]
    if a % _sage_const_4  != _sage_const_0 :
        pass
    elif a % _sage_const_3  != _sage_const_0 :
        # Case 1a
        C4Counter += ceil(r/_sage_const_6 ) - _sage_const_1 
        # Case 1b
        C4Counter += ceil(r/_sage_const_2 ) - _sage_const_1  - ceil(_sage_const_3 *r/_sage_const_8 ) + _sage_const_1 
        # Case 2a
        C4Counter += ceil(r/_sage_const_4 ) - _sage_const_1  - ceil(r/_sage_const_6 ) + _sage_const_1 
        # Case 2b
        C4Counter += ceil(_sage_const_7 *r/_sage_const_12 ) - _sage_const_1  - (floor(r/_sage_const_2 ) + _sage_const_1 ) + _sage_const_1  # changed int(r/2) to floor(r/2)
        # Case 3a 
        if a % _sage_const_8  == _sage_const_0 :
            C4Counter += floor((ceil(r/_sage_const_4 ) - _sage_const_1 )/_sage_const_2 )
        if a % _sage_const_8  == _sage_const_4 :
            C4Counter += ceil((ceil(r/_sage_const_4 ) - _sage_const_1 )/_sage_const_2 )
        # Case 3b
        if a % _sage_const_8  == _sage_const_0 :
            C4Counter += ceil((ceil(r*_sage_const_7 /_sage_const_12 ) - _sage_const_1  - ceil(r/_sage_const_4 ) + _sage_const_1 )/_sage_const_2 )
        if a % _sage_const_8  == _sage_const_4 :
            C4Counter += ceil((ceil(r*_sage_const_7 /_sage_const_12 ) - _sage_const_1  - ceil(r/_sage_const_4 ) + _sage_const_1 )/_sage_const_2 )
        # diff of 3r/4
        # Case 1b
        C4Counter += ceil(r/_sage_const_6 ) - _sage_const_1  - ceil(r/_sage_const_8 ) + _sage_const_1  
        # Case 2a
        C4Counter += ceil(r/_sage_const_12 ) - _sage_const_1 
        # Case 2b
        C4Counter += ceil(r/_sage_const_4 ) - ceil(r/_sage_const_6 ) + _sage_const_1  
        # Case 3a
        if a % _sage_const_8  == _sage_const_0 :
            C4Counter += floor(floor(r/_sage_const_12 )/_sage_const_2 )
        elif a % _sage_const_8  == _sage_const_4 :
            C4Counter += ceil(floor(r/_sage_const_12 )/_sage_const_2 )
        C4Counter -= _sage_const_3 
        C1Counter += _sage_const_1 
    elif a % _sage_const_3  == _sage_const_0 :
        # Case 1a 
        C4Counter += ceil(r/_sage_const_12 )
        # Case 2a
        C4Counter += ceil(r/_sage_const_4 ) - _sage_const_1  - ceil(_sage_const_5 *r/_sage_const_24 ) + _sage_const_1 
        # Case 3a
        if a % _sage_const_8  == _sage_const_0 :
            C4Counter += floor((ceil(r/_sage_const_4 ) - _sage_const_1  - ceil(r/_sage_const_12 ) + _sage_const_1 )/_sage_const_2 )
        elif a % _sage_const_8  == _sage_const_4 :
            C4Counter += ceil((ceil(r/_sage_const_4 ) - _sage_const_1  - ceil(r/_sage_const_12 ) + _sage_const_1 )/_sage_const_2 )
        # diff of 3r/4
        # Case 2a
        C4Counter += ceil(r/_sage_const_12 ) - _sage_const_1 
        # Case 3a 
        if a % _sage_const_8  == _sage_const_0 :
            C4Counter += floor(floor(r/_sage_const_12 )/_sage_const_2 )
        elif a % _sage_const_8  == _sage_const_4 :
            C4Counter += ceil(floor(r/_sage_const_12 )/_sage_const_2 )
        C4Counter -= _sage_const_4 
        C1Counter += _sage_const_1 
    return (C1Counter, _sage_const_0 , _sage_const_0 , C4Counter, _sage_const_0 , _sage_const_0 , tpp - rpp - C4Counter - C1Counter, _sage_const_0 , _sage_const_0 )
def get_power_map_counts(power, modulus):
    output = {}
    families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
    if power == _sage_const_2 :
        output['1'] = dict(zip(families, C_1_squared(modulus)))
        output['2'] = dict(zip(families, C_2_squared(modulus)))
        output['3^l'] = dict(zip(families, C_3_squared(modulus)))
        output['4^k'] = dict(zip(families, C_4_squared(modulus)))
        output['5^k'] = dict(zip(families, C_5_squared(modulus)))
        output["6'"] = dict(zip(families, C_6_p_squared(modulus)))
        output["6^klm"] = dict(zip(families, C_6_klm_sym_squared_explicit(modulus)))
        output["7^k"] = dict(zip(families, C_7_squared(modulus)))
        output["8^k"] = dict(zip(families, C_8_squared(modulus)))
    if power == _sage_const_3 :
        output['1'] = dict(zip(families, C_1_cubed(modulus)))
        output['2'] = dict(zip(families, C_2_cubed(modulus)))
        output['3^l'] = dict(zip(families, C_3_cubed(modulus)))
        output['4^k'] = dict(zip(families, C_4_cubed(modulus)))
        output['5^k'] = dict(zip(families, C_5_cubed(modulus)))
        output["6'"] = dict(zip(families, C_6_p_cubed(modulus)))
        output["6^klm"] = dict(zip(families, C_6_klm_sym_cubed_explicit(modulus)))
        output["7^k"] = dict(zip(families, C_7_cubed(modulus)))
        output["8^k"] = dict(zip(families, C_8_cubed(modulus)))
    if power == _sage_const_4 :
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
"""
for modulus in range(0, 12):
    break
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
equations = {}
equations_list = []
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
    print("==========================================")
print(equations)
print(equations_list)
"""
for modulus in range(_sage_const_0 , _sage_const_72 ):
    q = var('q')
    d = gcd(_sage_const_3 , modulus + _sage_const_1 )
    r = q+_sage_const_1 
    s = q-_sage_const_1  
    t = q**_sage_const_2  - q + _sage_const_1 
    rp = r/d
    sp = s/d
    tp = t/d
    dp = (_sage_const_3 -d)/_sage_const_2 
    rpp = _sage_const_0  
    tpp = (tp - _sage_const_1 )/_sage_const_6  

    square_maps = get_power_map_counts(_sage_const_2 , modulus)
    cube_maps = get_power_map_counts(_sage_const_3 , modulus)
    fourth_maps = get_power_map_counts(_sage_const_4 , modulus)
    families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
    num_classes = {'1': _sage_const_1 , '2': _sage_const_1 , '3^l': d, '4^k': rp - _sage_const_1 , '5^k': rp - _sage_const_1 , "6'": _sage_const_1  - dp, "6^klm": tpp - rpp, "7^k": tpp - rpp - dp, "8^k": _sage_const_2 *tpp}
    centralizers = {'1': q**_sage_const_3  * rp * r * s * t, '2': q**_sage_const_3  * rp, '3^l': q**_sage_const_2 , '4^k': q*rp*r*s, '5^k': q*rp, "6'": r**_sage_const_2 , "6^klm": rp*r, "7^k": rp*s, "8^k": tp}
    class_sizes = {key: (q**_sage_const_3  * rp * r * s * t) / val for key, val in centralizers.items()}
    character_val = {'1': q*s, '2': -_sage_const_1  * q, '3^l': _sage_const_0 , '4^k': -_sage_const_1  * s, '5^k': _sage_const_1 , "6'": _sage_const_2 , "6^klm": _sage_const_2 , "7^k": _sage_const_0 , "8^k": -_sage_const_1 }
    total = _sage_const_0 
    for family in families:
        total += class_sizes[family]*num_classes[family]*(character_val[family] ** _sage_const_4 )
        for fam2 in families: # iterate through the square maps 
            total += class_sizes[family]*character_val[fam2]* square_maps[family][fam2] * (character_val[family] ** _sage_const_2 ) * _sage_const_6 
            total += class_sizes[family]*(character_val[fam2]** _sage_const_2 ) * square_maps[family][fam2] * _sage_const_3  
            total += class_sizes[family]*character_val[fam2]* cube_maps[family][fam2] * character_val[family] * _sage_const_8 
            total += class_sizes[family]*character_val[fam2]*fourth_maps[family][fam2] * _sage_const_6 
    total = (total/_sage_const_24 )/(q**_sage_const_3  * rp * r * s * t)
    print("==========================================")
    print(f"for modulus: {modulus}")
    print(total.full_simplify()) 
    print(total.subs(q=(modulus + _sage_const_72 )))
    # equations[modulus] = str(total.full_simplify())
    # equations_list.append(str(total.full_simplify()))
    print("==========================================")
    if modulus == _sage_const_19 :
        fourth_maps_eval = {}
        for key in fourth_maps.keys():
            fourth_maps_eval[key] = {}
            for key2 in cube_maps:
                fourth_maps_eval[key][key2] = fourth_maps[key][key2].subs(q=modulus) 
        print(fourth_maps_eval)
#currently works for everything that's 2 mod 4

