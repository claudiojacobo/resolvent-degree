from math import gcd

class GroupCharactersPSU3:
    q = 1
    d = 0
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

    def __init__(self, prime, exp):

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
        self.group_order = q**3*r**2*s*tp


        ### conjugacy classes, class orders, and centralizer orders
        self.classes = [ "C_1", "C_2" ]
        self.class_order["C_1"] = 1
        self.centralizer_order["C_1"] = q**3*rp*r*s*t
        self.class_order["C_2"] = p
        self.centralizer_order["C_2"] = q**3*rp

        for l in range(d):
            c = f"C_3^{l}"
            self.classes.append(c)
            ### WHAT IS THE ORDER OF EACH CLASS REPRESENTATIVE?
            self.centralizer_order[c] = q**3*rp

        for k in range(1,rp):
            c = f"C_4^{k}"
            self.classes.append(c)
            self.class_order[c] = rp//gcd(rp,k)
            self.centralizer_order[c] = q**2

        for k in range(1,rp):
            c = f"C_5^{k}"
            self.classes.append(c)
            self.class_order[c] = rp*p//gcd(rp*p,k)
            self.centralizer_order[c] = q*rp*r*s

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

        for k in range(1,rp*s):
            if k*s == 0:
                continue
            c = f"C_7^{k}"
            self.classes.append(c)
            ### WHAT IS THE ORDER OF EACH CLASS REPRESENTATIVE?
            self.centralizer_order[c] = rp*s

        for k in range(1,tp):
            if k*s == 0:
                continue
            c = f"C_8^{k}"
            self.classes.append(c)
            ### WHAT IS THE ORDER OF EACH CLASS REPRESENTATIVE?
            self.centralizer_order[c] = tp


        ### compute relevant primes
        # there MUST be a better way to do this
        self.primes = primes_up_to(max(self.class_order.values()))


        ### compute power maps
        # this is NOT a good way to do it, but it'll do (for known powers) for now
        for g in self.classes:
            if int(g[2]) not in [3,7,8]: # we need to figure these cases out!
                self.power_map[g] = {}
                for p in self.primes:
                    self.power_map[g][p] = self.power_of(g,p)


        ### implement characters of interest
        UCF = UniversalCyclotomicField() 
        eps = UCF.gen(r)
        self.characters = [{} for i in range(rp)]
        for g in self.classes:

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
                UCF = UniversalCyclotomicField() 
                eps = UCF.gen(r) # epsilon as an rth root of unity
                for u in range(1,rp):
                    if i == 1: 
                        self.characters[u][g] = t 
                    elif i == 2: 
                        self.characters[u][g] = -s 
                    elif i == 3: 
                        self.characters[u][g] = 1
                    elif i == 4: 
                        self.characters[u][g] = -s * eps^(3*u*k) + eps^(-6*u*k)  
                    elif i == 5: 
                        self.characters[u][g] = eps^(3*u*k) + eps^(-6*u*k)
                    elif i == 6 : 
                        if g[-1] == "'": 
                            self.characters[u][g] = 3
                        else: 
                            self.characters[u][g] = eps^(3*u*k) + eps^(3*u*l) + eps^(3*u*m) 
                    elif i == 7: 
                        self.characters[u][g] = eps^(3*u*k) 
                    elif i == 8: 
                        self.characters[u][g] = 0 


        ### WHAT IS THE MINIMAL PERM REP? Pablo, didn't you find a paper on this?
        # self.minimal_perm = ?

    def power_of(self, g, n):
        """
        computes the conjugacy class of g^n
        """

        q = self.q
        d = self.d
        p = self.characteristic
        i = int(g[2])

        # string handling to recover indices from string
        # we'll use this when computing characters, but annoying to package as a function
        k,l,m = 0,0,0 
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
            return "WHAT IS HAPPENING, PABLO??"
        elif i == 4:
            e = (n*k) % ((q+1)//d)
            if e == 0:
                return "C_1"
            else:
                return f"C_4^{e}"
        elif i == 5:
            if k*n % ((q+1)*p//d) == 0:
                return "C_1"
            elif k*n % ((q+1)//d) == 0:
                return "C_2"
            return f"C_5^{k*n % ((q+1)//d)}"
        elif i == 6:
            if g[-1] == "'":
                if n%3 == 0:
                    return "C_1"
                return "C_6'"
            diag = [(n*x)%((q+1)//d) for x in (k,l,m)]
            k,l,m = sorted([ (q+1)//d if x == 0 else x for x in diag])
            if k == l or l == m: # broke the rules!
                return self.power_of(f"C_4^1", l)
            return f"C_6^{{{k},{l},{m}}}"
        elif i == 7:
            return "CARMEN, WHAT DO WE DO???"
        elif i == 8:
            return "ELLA, DO YOU HAVE THOUGHTS?"

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
