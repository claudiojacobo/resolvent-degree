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