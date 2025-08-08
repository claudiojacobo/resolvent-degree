from math import gcd
import time

load("group_characters.sage")
class GroupCharactersPSU3(GroupCharacters):
    q = 1
    d = 0
    r = 0
    s = 0
    t = 0
    tp = 0
    rp = 0 
    characteristic = 1
    name = ""
    classes = []
    class_order = {}
    centralizer_order = {}
    group_order = 0
    primes = []
    power_map = {}
    characters = []
    minimal_perm = 0
    name = ""

    def __init__(self, prime, exp):
        start_pm_time = time.time()
        ### useful constants
        self.q = prime**exp
        self.characteristic = prime
        q = self.q
        p = prime
        self.d = gcd(3,q+1)
        d = self.d
        r = q+1
        s = q-1
        t = q**2-q+1
        rp = r//d
        tp = t//d
        self.tp = tp
        self.rp = rp
        self.s = s
        self.r = r
        self.t = t
        self.group_order = q**3*r**2*s*tp
        self.exp = exp

        self.name = f"PSU({prime},{exp}) (prime, exp)"

        ### conjugacy classes, class orders, and centralizer orders
        self.classes = [ "C_1", "C_2" ]
        self.class_order["C_1"] = 1
        self.centralizer_order["C_1"] = q**3*rp*r*s*t
        self.class_order["C_2"] = p
        self.centralizer_order["C_2"] = q**3*rp

        for l in range(d):
            c = f"C_3^{l}"
            self.classes.append(c)
            ### These class_orders are conjectured but not certain 
            if prime == 2:
                self.class_order[c] = 4
            else:
                self.class_order[c] = prime
            self.centralizer_order[c] = q**2

        for k in range(1,rp):
            c = f"C_4^{k}"
            self.classes.append(c)
            self.class_order[c] = rp//gcd(rp,k)
            self.centralizer_order[c] = q*rp*r*s

        for k in range(1,rp):
            c = f"C_5^{k}"
            self.classes.append(c)
            self.class_order[c] = 0
            self.centralizer_order[c] = q*rp
            n = 1
            while True: # this sucks, we should find a better way to do this
                if k*n % ((q+1)//d) == 0 and n%p == 0:
                    self.class_order[c] = n
                    break
                n += 1
        if d == 3:
            self.classes.append("C_6'")
            self.class_order["C_6'"] = 3
            self.centralizer_order["C_6'"] = r**2

        for l in range(2,rp+1):
            for k in range(1,l):
                m = (-k-l)%r
                if m == 0:
                    m = r
                if l < m:
                    
                    c = f"C_6^{{{k},{l},{m}}}"
                    self.classes.append(c)
                    self.centralizer_order[c] = rp*r
                    """
                    # there is definitely a better way to do this (Pablo's formula?)
                    # (and we need to know it) but this works for now
                    n = 1
                    while True: # heheheh
                        n += 1
                        cn = self.power_of(c,n)
                        if cn[2] == "4":
                            self.class_order[c] = n*self.class_order[cn]
                            break
                        if cn[2] == "1":
                            self.class_order[c] = n
                            break
                    """
                    # This was taking a while so I've replaced it with a maybe incorrect formula
                    self.class_order[c] = int(r / gcd(k,l,m,r))
                    
        klist = []
        for k in range(1,rp*s):
            if k%s == 0:
                continue
            k = min(k, ((-q*k) % (rp * s)))
            if k in klist:
                continue
            else: 
                klist.append(k)
            c = f"C_7^{k}" 
            self.classes.append(c)
            self.class_order[c] = rp*s // gcd(k, rp*s)
            self.centralizer_order[c] = rp*s

        klist = []
        for k in range(1,tp):
            k = min(k, (-k * q) % tp, ((q ** 2) * k) % tp )
            if k in klist:
                continue 
            else: 
                klist.append(k)
            c = f"C_8^{k}"
            self.classes.append(c)
            self.class_order[c] = tp
            self.centralizer_order[c] = tp


        ### compute relevant primes
        # there MUST be a better way to do this
        self.primes = primes_up_to(max(self.class_order.values()))


        ### compute power maps
        # this is NOT a good way to do it, but it'll do (for known powers) for now
        for g in self.classes:
            self.power_map[g] = {}
            #for p in self.primes:
            for p in [2,3,5,7]: # we only need primes up to the # of molien coefficients we're asking for.
                self.power_map[g][p] = self.power_of(g,p)
        print(f"Power Map and Class Initialization took {time.time() - start_pm_time}")
        ### implement characters of degree qs and t
        # Generates character table data for Chi_qs and Chi_t^(u)
        start_char_time = time.time()
        UCF = UniversalCyclotomicField() 
        eps = UCF.gen(r) # epsilon as an rth root of unity
        self.characters = [{} for u in range(rp)] 
        for g in self.classes:
            i = int(g[2]) 
            k,l,m = 0,0,0 
            if i in [3,4,5,7,8]:
                k = int(g[4:])
            elif i == 6 and g[-1] != "'":
                k,l,m = map(int,g[5:-1].split(','))
            if i == 1: 
                self.characters[0][g] = q * s 
            elif i == 2: 
                self.characters[0][g] = -q
            elif i == 3: 
                self.characters[0][g] = 0 
            elif i == 4: 
                self.characters[0][g] = -s
            elif i == 5: 
                self.characters[0][g] = 1 
            elif i == 6: 
                self.characters[0][g] = 2
            elif i == 7: 
                self.characters[0][g] = 0
            elif i == 8: 
                self.characters[0][g] = -1
            for u in range(1,rp):
                if i == 1: 
                    self.characters[u][g] = t 
                elif i == 2: 
                    self.characters[u][g] = -s 
                elif i == 3: 
                    self.characters[u][g] = 1
                elif i == 4: 
                    self.characters[u][g] = -s * eps^(3 * u * k) + eps^(-6 * u * k)  
                elif i == 5: 
                    self.characters[u][g] = eps^(3 * u * k) + eps^(-6 * u * k) 
                elif i == 6 : 
                    if g[-1] == "'": 
                        self.characters[u][g] = 3
                    else: 
                        self.characters[u][g] = eps^(3 * u * k) + eps^(3 * u * l) + eps^(3 * u * m) 
                elif i == 7: 
                    self.characters[u][g] = eps^(3 * u * k) 
                elif i == 8: 
                    self.characters[u][g] = 0 
        print(f"Character Table took {time.time() - start_char_time}")
            # return self.characters #end of check for our 2 chars 


        if self.q == 5:
            self.minimal_perm = 50
        else:
            self.minimal_perm = self.q ** 3 + 1  

    def power_of(self, g, n):
        """
        computes the conjugacy class of g^n
        """
        q = self.q
        d = self.d
        s = q - 1
        r = (q + 1) // d
        tp = self.tp
        rp = self.rp
        p = self.characteristic
        i = int(g[2])

        # initialize
        k,l,m = 0,0,0 

        # string handling to recover indices from string
        # we'll use this when computing characters, but annoying to package as a function
        if i in [3,4,5,7,8]:
            k = int(g[4:])
        elif i == 6 and g[-1] != "'":
            k,l,m = map(int,g[5:-1].split(','))

        # power map logic
        if i == 1:
            return "C_1"
        elif i == 2:
            if n%p == 0:
                return "C_1"
            return "C_2"
        elif i == 3:
            if self.characteristic == 2:
                if n%4 == 0:
                    return "C_1"
                elif n%2 == 0:
                    return "C_2"
                else:
                    return g 
            else:
                if n%self.characteristic == 0:
                    return "C_1"
                else:
                    return g 
        elif i == 4:
            e = (n*k) % ((q+1)//d)
            if e == 0:
                return "C_1"
            else:
                return f"C_4^{e}"
        elif i == 5:
            if k*n % ((q+1)//d) == 0 and n%p == 0 :
                return "C_1"
            elif k*n % ((q+1)//d) == 0:
                return "C_2"
            elif n % p == 0:
                return f"C_4^{n * k % rp}" # added 7/15--might not  work
            return f"C_5^{k*n % ((q+1)//d)}"
        elif i == 6:
            # Logic for C_6'
            if g[-1] == "'":
                if n%3 == 0:
                    return "C_1"
                return "C_6'"
            # Logic for C_6^{k,l,m}
            diag = [(n*x)%((q+1)) for x in (k,l,m)] # ((q+1)//d) ?
            k,l,m = sorted([ (q+1) if x == 0 else x for x in diag])  # ((q+1)//d) ?

            if (k,l,m) == ((q+1)//d, 2 * ((q+1)//d),  (q+1)): # checks for C_6'
                return "C_6'" 
            while l > (q+1)//d:
                diag  = [(x + (q+1)//d)%(q+1) for x in (k,l,m)]
                k,l,m = sorted([ (q+1) if x == 0 else x for x in diag])
                

            if k == l or l == m: # broke the rules!
                return self.power_of(f"C_4^1", l) # what's up with this?
            return f"C_6^{{{k},{l},{m}}}"
        elif i == 7:
            if k*n % (s*rp) == 0:
                return "C_1"
            elif k*n % s == 0:
                return f"C_4^{sorted([s*k*n % (s*rp), k*n % (s*rp), (-q*k*n) % (s*rp)])[1] // s}"
            y = k*n % (s*rp)
            y = min(y, (-q*y) % (s*rp))
            return f"C_7^{y}"
        elif i == 8:
            if k*n % tp == 0:
                return "C_1"
            w = k*n % tp
            w = min(w, w*(-q) % tp, w*q*q % tp)
            return f"C_8^{w}"
    
    def C_6_klm_sym_squared(self):
        C4Counter = 0
        C1Counter = 0
        r = self.r
        if self.r % 3 != 0:
            if self.r % 2 == 1:
                pass
            else:
                # Case 1b
                k = math.ceil(r/4)
                while k < r/3:
                    k += 1
                    C4Counter += 1
                # Case 3a
                k = 1
                while k < r/6:
                    k += 1
                    C4Counter += 1
                # Case 3b
                k = math.ceil(r/3)
                while k < r/2:
                    k += 1
                    C4Counter += 1
                # Case 2a 
                if self.r % 4 == 0:
                    k = 1
                    while k < r/6:
                        if k % 2 == 0:
                            C4Counter += 1
                        k += 1
                else: 
                    k = 1
                    while k < r/6:
                        if k % 2 == 1:
                            C4Counter += 1
                        k += 1
        # d = 3 case
        else: 
            if self.r % 2 == 1:
                pass
            else:
                # Case 3a
                k = math.ceil(r/12)
                while k < r/6:
                    k += 1
                    C4Counter += 1
                # Case 2a 
                if self.r % 4 == 0:
                    k = 1
                    while k < r/6:
                        if k % 2 == 0:
                            C4Counter += 1
                        k += 1
                else: 
                    k = 1
                    while k < r/6:
                        if k % 2 == 1:
                            C4Counter += 1
                        k += 1

        return C4Counter
    def C_6_klm_sym_squared_explicit(self):
        a = self.r % 12
        r = self.r
        if a in [1,3,5,7,9,11]:
            return (0,0)
        if a in [2, 10]:
            total = 0 - math.ceil(r/4) + math.floor(r/6) + r/2  + math.ceil(math.floor(r/6)/2)
            return total
        if a in [4, 8]:
            total = -1 * math.floor(r/4) + 1 + math.floor(r/6) + r/2 + math.floor((math.ceil(r/6) - 1)/2) - 1
            return total
        if a == 6:
            return r/6 - 1
        if a == 0:
            return r/6 - 1 

    def C_6_klm_sym_cubed(self):
        C4Counter = 0 
        r = self.r 
        if r % 3 != 0:
            pass
        else: 
            # Case 2a
            k = math.ceil(r/6)
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
    
    def C_6_klm_sym_fourth(self):
        C4Counter = 0 
        C1Counter = 0
        r = self.r
        C4Counter += self.C_6_klm_sym_squared()
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
            k = math.ceil(3*r/8)
            while k < r/2:
                C4Counter += 1
                k += 1 
            # Case 2a 
            k = math.ceil(r/6)
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
            k = math.ceil(r/4)
            while k < 7/12 * r:
                if r % 8 == 0 and k % 2 == 0:
                    C4Counter += 1 
                if r % 8 == 4 and k % 2 == 1:
                    C4Counter += 1
                k += 1 
            # Now we move onto cases concerning a difference of 3r/4
            # Case 1b
            k = math.ceil(r/8)
            while k < r/6:
                k += 1 
                C4Counter += 1
            # Case 2a
            k = 1
            while k < r/12:
                k += 1 
                C4Counter += 1
            # Case 2b
            k = math.ceil(r/6)
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
            k = math.ceil(5*r/24) # this is weird no?
            while k < r/4:
                k += 1
                C4Counter += 1
            # Case 3a
            k = math.ceil(r/12)
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
        



def primes_up_to(k):
    """
    returns an ascending list of all primes up through k
    """
    primes = [2]
    for i in range(3,k):
        for p in primes:
            if i%p == 0: break
        else:
            primes.append(i)
    return(primes)

start = time.time()






# G = GroupCharactersPSU3(3,6)
# print(G.class_order)
# G.display()
# print(G.the_game(G.characters[0], 10))
# H = GroupCharacters("PSU(3, 3)")
# print(H.the_game(H.characters[1], 10))
# print(H.the_game(H.characters[1], 10))
# H.display()

# currently fails for q = 125, 4, 8, 3, 7, 27 -- struggling with third powers, small primes, and a couple other things?
# Works for: q = 2, 5, 25, 16, 32, 49, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47

end = time.time()
print(f"Elapsed time: {end - start:.4f} seconds")   
i = 0
G = GroupCharactersPSU3(31, 1)
for g in G.classes:
    if g[2] == "6":
        if G.power_of(g, 2)[2] != "6":
            print(g)
            print(f"g squared is {G.power_of(g, 2)}")
            i += 1
print(i)
print(G.C_6_klm_sym_squared())
print(G.C_6_klm_sym_squared_explicit())

i = 0
for g in G.classes:
    if g[2] == "6" and g[3] != "'":
        if G.power_of(g, 3)[2] != "6":
            print(g)
            print(f"g cubed is {G.power_of(g, 3)}")
            i += 1
print(f"empirical problem cases (cube): {i}")
print(f"predicted problem cases (cube): {G.C_6_klm_sym_cubed()}")


i = 0
for g in G.classes:
    if g[2] == "6" and g[3] != "'":
        if G.power_of(g, 4)[2] != "6":
            print(g)
            print(f"g to the fourth is {G.power_of(g, 4)}")
            i += 1
print(f"empirical problem cases (4th): {i}")
print(f"predicted problem cases (4th): {G.C_6_klm_sym_fourth()}")
# so, this doesn't quite work. I don't know what's going on here but it looks like we're undercounting by 1 or 2 sometimes but asymptotically we're overcounting? 
