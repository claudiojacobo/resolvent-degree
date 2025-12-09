from sage.all import libgap, UniversalCyclotomicField
from helper_functions import *
from group_characters import *
from math import gcd

'''
main reference is
    J. Frame and W. Simpson,
    The Character Tables for SL(3,q), SU(3,q^2), PSL(3,q), PSU(3,q^2),
    Canadian Journal of Math 25.3: 487–494 (1973)
'''
class GroupCharactersPSU3(GroupCharacters):
    def __init__(self, prime, exp):

        self.q = prime**exp
        self.p = prime
        self.r = self.q + 1
        self.s = self.q - 1
        self.t = self.q**2 - self.q + 1
        self.d = gcd(3, self.r)
        self.rp = self.r // self.d
        self.tp = self.t // self.d

        self.group_order = self.q**3 * self.r * self.rp * self.s * self.t
        self.exp = exp

        self.name = f"PSU(3,{self.q})"
        self.class_initialization()
        self.characters_initalization()

    def class_initialization(self):
        # shorthand
        q = self.q
        p = self.p
        d = self.d
        r = self.r
        s = self.s
        t = self.t
        rp = self.rp
        tp = self.tp

        # conjugacy classes, class orders, and centralizer orders
        self.classes = [ "C_1", "C_2" ] # C1 & C2 initialization
        self.class_order = {}
        self.centralizer_order = {}
        self.class_order["C_1"] = 1
        self.centralizer_order["C_1"] = q**3*rp*r*s*t
        self.class_order["C_2"] = p
        self.centralizer_order["C_2"] = q**3*rp

        # C_3^l initialization
        for l in range(d):
            c = f"C_3^{l}"
            self.classes.append(c)
            ### These class_orders are conjectured but not certain
            if p == 2:
                self.class_order[c] = 4
            else:
                self.class_order[c] = p
            self.centralizer_order[c] = q**2

        # C_4^k initialization
        for k in range(1,rp):
            c = f"C_4^{k}"
            self.classes.append(c)
            self.class_order[c] = rp//gcd(rp,k)
            self.centralizer_order[c] = q*rp*r*s

        # C_5^k initialization
        for k in range(1,rp):
            c = f"C_5^{k}"
            self.classes.append(c)
            self.class_order[c] = 0
            self.centralizer_order[c] = q*rp
            n = 1
            while True:
                if k*n % ((q+1)//d) == 0 and n%p == 0:
                    self.class_order[c] = n
                    break
                n += 1

        # C_6' initialization
        if d == 3:
            self.classes.append("C_6'")
            self.class_order["C_6'"] = 3
            self.centralizer_order["C_6'"] = r**2

        # C_6^klm initialization
        for l in range(2,rp+1):
            for k in range(1,l):
                m = (-k-l)%r
                if m == 0:
                    m = r
                if l < m:

                    c = f"C_6^{{{k},{l},{m}}}"
                    self.classes.append(c)
                    self.centralizer_order[c] = rp*r
                    self.class_order[c] = int(r / gcd(k,l,m,r))

        # C_7^k initialization
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

        # C_8^k initialization
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

    def characters_initalization(self):
        q = self.q
        p = self.p
        d = self.d
        r = self.r
        s = self.s
        t = self.t
        rp = self.rp
        tp = self.tp

        # compute power maps
        self.power_map = {}
        self.primes = [2,3,5,7] # we don't need many primes for what we're doing
        for g in self.classes:
            self.power_map[g] = {}
            for p in self.primes:
                self.power_map[g][p] = self.power_of(g,p)

        ### implement characters of degree q*s and t
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

            # chi_{qs}
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

            # chi_t^u
            for u in range(1,rp):
                if i == 1:
                    self.characters[u][g] = t
                elif i == 2:
                    self.characters[u][g] = -s
                elif i == 3:
                    self.characters[u][g] = 1
                elif i == 4:
                    self.characters[u][g] = -s * eps**(3 * u * k) + eps**(-6 * u * k)
                elif i == 5:
                    self.characters[u][g] = eps**(3 * u * k) + eps**(-6 * u * k)
                elif i == 6 :
                    if g[-1] == "'":
                        self.characters[u][g] = 3
                    else:
                        self.characters[u][g] = eps**(3 * u * k) + eps**(3 * u * l) + eps**(3 * u * m)
                elif i == 7:
                    self.characters[u][g] = eps**(3 * u * k)
                elif i == 8:
                    self.characters[u][g] = 0

        if self.q == 5:
            self.minimal_perm = 50
        else:
            self.minimal_perm = self.q ** 3 + 1

    def power_of(self, g, n):
        """
        Computes the conjugacy class of g^n
        """
        q = self.q
        d = self.d
        s = q - 1
        r = (q + 1) // d
        tp = self.tp
        rp = self.rp
        p = self.p
        i = int(g[2])

        # initialize
        k,l,m = 0,0,0

        # string handling to recover indices from string
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
            if self.p == 2:
                if n%4 == 0:
                    return "C_1"
                elif n%2 == 0:
                    return "C_2"
                else:
                    return g
            else:
                if n%self.p == 0:
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
                return f"C_4^{n * k % rp}"
            return f"C_5^{k*n % ((q+1)//d)}"

        elif i == 6:
            # Logic for C_6'
            if g[-1] == "'":
                if n%3 == 0:
                    return "C_1"
                return "C_6'"
            # Logic for C_6^{k,l,m}
            diag = [(n*x)%((q+1)) for x in (k,l,m)]
            k,l,m = sorted([ (q+1) if x == 0 else x for x in diag])

            if (k,l,m) == ((q+1)//d, 2 * ((q+1)//d), (q+1)): # checks for C_6'
                return "C_6'"
            while l > (q+1)//d:
                diag  = [(x + (q+1)//d)%(q+1) for x in (k,l,m)]
                k,l,m = sorted([ (q+1) if x == 0 else x for x in diag])
            if k == l or l == m: # breaks the rules for C_6, thus jumps to C_4
                return self.power_of(f"C_4^1", l)
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
