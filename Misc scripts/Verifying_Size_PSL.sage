

# case 1, d = 1 
q = var('q')
r = q - 1
s = q + 1 
t = q^2 + q + 1
tpp = (t-1)/6
rpp = r
centralizers = [q^3 * r^2 * s * t, q^3 * r, q^2, q * r^2 * s, q * r, r^2, r^2, r*s, t]
num_classes = [1,1,1,r - 1, r - 1, 0, tpp - rpp, 3 * tpp - rpp - 1, 2 * tpp]

total_elements = 0
for i in range(len(centralizers)):
    total_elements += num_classes[i] * centralizers[0] / centralizers[i]
print(total_elements.full_simplify())
print(centralizers[0].full_simplify())

# case 2, d = 3 
q = var('q')
r = q - 1
s = q + 1 
t = q^2 + q + 1
rp = r/3 
tp = t/3
sp = t/3
rpp = rp 
tpp = (tp - 1)/6


centralizers = [q^3 * rp * r * s * t, q^3 * rp, q^2, q * rp * r * s, q * rp, r^2, rp * r, rp * s, tp]
num_classes = [1,1,3,rp - 1, rp - 1, 1, tpp - rpp, 3 * tpp - rpp, 2 * tpp]
total_elements = 0
for i in range(len(centralizers)):
    total_elements += num_classes[i] * centralizers[0] / centralizers[i]
print(total_elements.full_simplify())
print(centralizers[0].full_simplify())

# Figuring out what the 

wikipedia_order_d_is_1 = q^((1/2)*3*2)/1 * (q^2 - 1) * (q^3 - 1) 

wikipedia_order_d_is_3 = q^((1/2)*3*2)/3 * (q^2 - 1) * (q^3 - 1) 
print(wikipedia_order_d_is_1.full_simplify())
print(wikipedia_order_d_is_3.full_simplify())