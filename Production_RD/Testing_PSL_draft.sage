import math
from sage.all import libgap # is this necessary? 
import time
from math import gcd
load("helper_functions.sage")

class GroupCharacters:
    name = None # string
    classes = None # list of strings
    class_order = None # dictionary string->int
    centralizer_order = None # dictionary string->int
    group_order = None # int
    primes = None # list of ints
    power_map = None # dictionary string->dictionary (int->string)
    characters = None # list of dictionaries string->algebraic number
    minimal_perm = None # int
    
    def __init__(self, group_name):
        # invoke GAP via libgap
        self.name = group_name
        group = eval(f"libgap.{group_name}")
        ct = group.CharacterTable()
        self.classes = libgap.ClassNames(ct).sage()
        r = len(self.classes)

        # parse orders of each conjugacy class representative
        orders = ct.OrdersClassRepresentatives().sage()
        self.class_order = { self.classes[i]:orders[i] for i in range(r) }

        # parse centralizer orders
        centralizers = ct.SizesCentralizers().sage()
        self.centralizer_order = { self.classes[i]:centralizers[i] for i in range(r) }
        self.group_order = centralizers[0]
 
        # load necessary power maps
        largest_order = max(orders)
        self.primes = primes_up_to(largest_order)
        self.power_map = { g:{} for g in self.classes }
        for p in self.primes:
            for i in range(len(self.classes)):
                self.power_map[self.classes[i]][p] = self.classes[ct.PowerMap(p).sage()[i]-1]

        # sort characters by degree
        ct = sorted(ct.Irr().sage(), key=lambda x:x[0])
        self.characters = [ { self.classes[i]:chi[i] for i in range(r) } for chi in ct]

        # this is likely a bottleneck
        self.minimal_perm = group.MinimalFaithfulPermutationDegree()

    def display(self, decimal=False):
        print(f"----------- Character data for {self.name} ------------")
        
        print("\nConjugacy classes:\n\n", end="\t")
        for g in self.classes:
            print(g,end = "\t")

        print("\n\nCentralizers:\n\n", end="\t")
        for g in self.classes:
            print(self.centralizer_order[g],end = "\t")

        print("\n\nPower maps:")
        for p in self.primes:
            print(f"\n{p}", end="\t")
            for g in self.classes:
                print(self.power_map[g][p],end = "\t")

        print("\n\nCharacters:")
        for i, chi in enumerate(self.characters):
            print(f"\nχ{i}:", end="\t")
            for g in self.classes:
                if decimal:
                    print(f"{complex(chi[g]):.3f}",end = "\t")
                else:
                    print(chi[g],end = "\t")
        print("\n")

    def inner_product(self, f1, f2):
        """
        compute the inner product of two class functions (encoded as dictionaries with keys = classes)
        """
        return sum([ f1[g].conjugate()*f2[g]/self.centralizer_order[g] for g in self.classes ])
 
    def invariant_dimension(self, chi):
        """
        computes the dimension of G-invariants for the representation corresponding to chi
        """
        return sum([ chi[g]/self.centralizer_order[g] for g in self.classes ])

    def eval_char(self, chi, conj, n):
        """
        Evaluates a specific character at a conjugacy class raised to the nth power.
        :param chi: Relevant character dictionary
        :param conj: conjugacy class of interest
        :param n: Power we raise conj to
        :return: 
        """
        m = n % self.class_order[conj]
        prime_factorization = []
        i = 0
        if m == 0:
            return chi[self.classes[0]]
        while i < len(self.primes):
            if m % self.primes[i] == 0:
                m = m / self.primes[i]
                prime_factorization.append(self.primes[i])
            else:
                i += 1
        curr_class = conj
        for num in prime_factorization:
            curr_class = self.power_map[curr_class][num]

        return chi[curr_class]

    def sym_power(self, chi, k):
        """
        Computes the character of the kth symmetric power of an action. 
        :k: an integer greater than 0 representing the dimension of the symmetric power
        :return: a dictionary whose keys are conjugacy classes and whose values are (sage?) numbers
        """
        sym_power = {}
        for g in self.classes:
            sum = 0
            for partition in partition_tuple(k):
                product = 1
                for i in range(1, k+1):
                    product *= (((self.eval_char(chi, g, i)) ** partition[i]) *
                                (1 / ((math.factorial(partition[i])) * (i ** partition[i]))))
                sum += product
            sym_power[g] = sum
        return(sym_power)
        
    def get_coef(self, chi, k): 
        '''
        first makes a list of dictionaries from symmetric power function and calculates
        the inner product..outputs a list of the coef where position of the list 
        corresponds to kth power'''
        sym_pows = []
        for i in range(0,k): # check for off by 1 errors abd what sym^0 is
            sym_pows.append(self.sym_power(chi,i))
        molien_coefs = [1]
        for i in range(1,k): 
            molien_coefs.append(self.invariant_dimension(sym_pows[i])) 
            #maybe we call ct, not sure about naming
        return molien_coefs 

    def power_class(self, g, k):
        """
        Recursively computes the conjugacy class of g^k using power map data
        """
        k = k % self.class_order[g]
        if k == 0:
            return self.classes[0] # Assumes 0th class is the identity
        elif k == 1:
            return g
        for p in self.primes:
            if k%p == 0:
                return self.power_class(self.power_map[g][p],k//p)

    def molien_coeff(self, chi, k): 
        """
        Returns the first k coefficients of the Molien series for chi
        """
        sym = [{ g:1 for g in self.classes }, chi]
        for i in range(2,k):
            sym.append({})
            for g in self.classes:
                sym[i][g] = sum([ sym[i-1-j][g] * chi[self.power_class(g,j+1)] for j in range(i)])/i
        return [ self.invariant_dimension(char) for char in sym ]

    def print_chars(self):
        for character in self.characters:
            print(character)
            print("")

    def print_char(self, k):
        print(self.characters[k])
    
    def the_game(self, chi, n):
        """
        Calculates a bound on G using chi and theorems about nice G-varieties 
        returns triple (bound, ran_out_of_molien, limited_by_subgroup) where the first entry is an integer
        and the second and there are booleans indicating (2) wether or not we had enough molien series terms 
        to finish our calculations and (3) wether we were limited by the size of our maximal subgroup or by
        the product of the degrees of invariant polynomials.
        """
        bound = chi[self.classes[0]] - 1 # sets initial bound to dimension of the associated projective rep
        degree_product = 1 
        alg_indp_poly = generators_from_molien(self.molien_coeff(chi, n))
        ran_out_of_molien = True
        limited_by_action = False
        limited_by_versality = False
        beat_by_perm = False
        invariants = []

        alg_indp_poly_copy = tuple(alg_indp_poly)
        alg_indp_poly_copy = list(alg_indp_poly_copy)
        for i, val in enumerate(alg_indp_poly_copy):
            alg_indp_poly_copy[i] = str(val)
        i = 1
        # start at the first non zero entry in alg_indp_poly
        while i < len(alg_indp_poly) and alg_indp_poly[i] == 0:
            i += 1
        while i < len(alg_indp_poly):
            if degree_product * i >= self.minimal_perm: # failed b/c irreducibility
                limited_by_action = True
                ran_out_of_molien = False
                if RD(degree_product * i) > bound-1: # also failed b/c versality
                    limited_by_versality = True
                else: # truly failed b/c irreducibility
                    invariants.append(int(i))
                break 
            
            # Stop when product of degrees is larger than bound
            if RD(degree_product * i) > bound-1:
                ran_out_of_molien = False
                limited_by_versality = True
                break

            bound -= 1
            degree_product *= i
            invariants.append(int(i))
            alg_indp_poly[i] -= 1
            while i < len(alg_indp_poly) and alg_indp_poly[i] == 0:
                i += 1

        if RD(self.minimal_perm) <= bound:
            beat_by_perm = True 
            if RD(self.minimal_perm) < bound:
                limited_by_action = False
                limited_by_versality = False
                bound = RD(self.minimal_perm)


        output = {
            "group":self.name, 
            "rep-degree":int(chi[self.classes[0]]), 
            "bound":int(bound), 
            "invariants":tuple(invariants),
            "total polynomials":alg_indp_poly_copy,
            "limitation":[], 
            "notes":"",
        }
        if limited_by_action:
            output["limitation"].append("generic-freeness")
        if limited_by_versality:
            output["limitation"].append("versality-degree")
        if beat_by_perm:
            output["limitation"].append("permutation-rep")
        if ran_out_of_molien and RD(degree_product * (n-1)) < bound:
            output["limitation"].append("insufficient-invariants")
            print(f"{self.name} We ran out of Molien terms before the game ended!")

        return output

class GroupCharactersPSL3(GroupCharacters):
    q = 1 # q as seen in PSL(3, q)
    p = 0 # the characteristic of the field
    d = 0
    r = 0
    s = 0
    t = 0
    tp = 0
    rp = 0 
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
    class_initialization_time = 0 
    character_table_time = 0


    def __init__(self, prime, exp):
        self.start_pm_time = time.time()
        ### useful constants
        q = prime**exp
        p = prime
        d = gcd(3,q-1)
        r = q-1
        s = q+1
        t = q**2+q+1
        rp = r//d
        tp = t//d
        
        self.q = q
        self.p = p 
        self.dc = d
        self.tp = tp
        self.rp = rp
        self.s = s
        self.r = r
        self.t = t
        self.d = d 

        self.group_order = q**3*r*rp*s*t
        self.exp = exp

        self.name = f"PSL({prime},{exp}) (prime, exp)"
        self.class_initialization()
        self.characters_initalization()


    def class_initialization(self):
        q = self.q
        p = self.p
        d = self.d
        r = self.r 
        s = self.s  
        t = self.t 
        rp = self.rp  
        tp = self.tp  

        ### conjugacy classes, class orders, and centralizer orders
        self.classes = [ "C_1", "C_2" ] # C1 & C2 initialization
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
            while True: # this sucks, we should find a better way to do this
                if k*n % ((r)//d) == 0 and n%p == 0:
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
            k = min(k, ((q*k) % (rp * s)))
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
            k = min(k, (k * q) % tp, ((q ** 2) * k) % tp )
            if k in klist:
                continue 
            else: 
                klist.append(k)
            c = f"C_8^{k}"
            self.classes.append(c)
            self.class_order[c] = tp
            self.centralizer_order[c] = tp

        self.class_initialization_time = time.time() - self.start_pm_time


    def characters_initalization(self):
        q = self.q
        p = self.p
        d = self.d
        r = self.r 
        s = self.s  
        t = self.t 
        rp = self.rp  
        tp = self.tp  

        ### compute relevant primes 
        # not necessary with our current approach
        self.primes = primes_up_to(max(self.class_order.values()))

        ### compute power maps
        # this is NOT a good way to do it, but it'll do (for known powers) for now
        for g in self.classes:
            self.power_map[g] = {}
            #for p in self.primes:
            for p in [2,3,5,7]: # we only need primes up to the # of molien coefficients we're asking for.
                self.power_map[g][p] = self.power_of(g,p)

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
            
            # Chi_qs
            if i == 1: 
                self.characters[0][g] = q * s 
            elif i == 2: 
                self.characters[0][g] = q
            elif i == 3: 
                self.characters[0][g] = 0 
            elif i == 4: 
                self.characters[0][g] = s
            elif i == 5: 
                self.characters[0][g] = 1 
            elif i == 6: 
                self.characters[0][g] = 2
            elif i == 7: 
                self.characters[0][g] = 0
            elif i == 8: 
                self.characters[0][g] = -1

            # Chi_t^u
            for u in range(1,rp):
                if i == 1: 
                    self.characters[u][g] = t 
                elif i == 2: 
                    self.characters[u][g] = s 
                elif i == 3: 
                    self.characters[u][g] = 1
                elif i == 4: 
                    self.characters[u][g] = s * eps^(3 * u * k) + eps^(-6 * u * k)  
                elif i == 5: 
                    self.characters[u][g] = eps^(3 * u * k) + eps^(-6 * u * k) 
                elif i == 6 : 
                    if g[-1] == "'": 
                        self.characters[u][g] = 3
                    else: 
                        self.characters[u][g] = eps^(3 * u * k) + eps^(3 * u * l) + eps^(3 * u * m) 
                elif i == 7: 
                    self.characters[u][g] = -1 * eps^(3 * u * k) 
                elif i == 8: 
                    self.characters[u][g] = 0 
        self.character_table_time = time.time() - start_char_time
            # return self.characters #end of check for our 2 chars 

        # determine minimal faithful perm representation
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
        s = self.s
        r = self.r
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
            e = (n*k) % ((r)//d)
            if e == 0:
                return "C_1"
            else:
                return f"C_4^{e}"

        elif i == 5:
            if k*n % (rp) == 0 and n%p == 0 :
                return "C_1"
            elif k*n % (rp) == 0:
                return "C_2"
            elif n % p == 0:
                return f"C_4^{n * k % rp}" # added 7/15--might not  work
            return f"C_5^{k*n % (rp)}"

        elif i == 6:
            # Logic for C_6'
            if g[-1] == "'":
                if n%3 == 0:
                    return "C_1"
                return "C_6'"
            # Logic for C_6^{k,l,m}
            diag = [(n*x)%((r)) for x in (k,l,m)] # ((q+1)//d) ?
            k,l,m = sorted([ (r) if x == 0 else x for x in diag])  # ((q+1)//d) ?

            if (k,l,m) == (rp, 2 * (rp),  (r)): # checks for C_6'
                return "C_6'" 
            while l > rp:
                diag  = [(x + rp)%(r) for x in (k,l,m)]
                k,l,m = sorted([ (r) if x == 0 else x for x in diag])
            if k == l or l == m: # broke the rules!
                return self.power_of(f"C_4^1", l) # what's up with this?
            return f"C_6^{{{k},{l},{m}}}"

        elif i == 7:
            if k*n % (s*rp) == 0:
                return "C_1"
            elif k*n % s == 0:
                return f"C_4^{sorted([s*k*n % (s*rp), k*n % (s*rp), (q*k*n) % (s*rp)])[1] // s}"
            y = k*n % (s*rp)
            y = min(y, (q*y) % (s*rp))
            return f"C_7^{y}"

        elif i == 8:
            if k*n % tp == 0:
                return "C_1"
            w = k*n % tp
            w = min(w, w*(q) % tp, w*q*q % tp) #changed this, it might break itself
            return f"C_8^{w}"
    
    def C_1_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_1 gets mapped to when it's squared.  
        """
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
    
    def C_1_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_1 gets mapped to when it's cubed.  
        """
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

    def C_1_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_1 gets mapped to when it's raised to the fourth power.  
        """
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
    
    def C_2_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_2 gets mapped to when it's squared.  
        """
        C1Counter = 0
        C2Counter = 1
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        p = self.p
        if p == 2:
            C1Counter += 1
            C2Counter -= 1
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_2_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_2 gets mapped to when it's cubed.  
        """
        C1Counter = 0
        C2Counter = 1
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        p = self.p
        if p == 3:
            C1Counter += 1
            C2Counter -= 1
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_2_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_2 gets mapped to when it's raised to the fourth power.  
        """
        C1Counter = 0
        C2Counter = 1
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        p = self.p
        if p == 2:
            C1Counter += 1
            C2Counter -= 1
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_3_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_3 gets mapped to when it's squared.  
        """
        d = self.d
        p = self.p
        C1Counter = 0
        C2Counter = 0
        C3Counter = d
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if p == 2:
            C2Counter += d
            C3Counter -= d
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    
    def C_3_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_3 gets mapped to when it's cubed.  
        """
        d = self.d
        p = self.p
        C1Counter = 0
        C2Counter = 0
        C3Counter = d
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if p == 3:
            C1Counter += d
            C3Counter -= d
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    
    def C_3_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_3 gets mapped to when it's raised to the fourth power.  
        """
        d = self.d
        p = self.p
        C1Counter = 0
        C2Counter = 0
        C3Counter = d
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if p == 2:
            C1Counter += d
            C3Counter -= d
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_4_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_4 gets mapped to when it's squared.  
        """
        q = self.q
        d = self.d
        C1Counter = 0
        C4Counter = (q+1)//d-1
        C2Counter = 0
        C3Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if q % 2 == 1:
            C1Counter += 1
            C4Counter -= 1
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_4_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_4 gets mapped to when it's cubed.  
        """
        q = self.q
        d = self.d
        C1Counter = 0
        C4Counter = (q+1)//d-1
        C2Counter = 0
        C3Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if (q+1) % 9 == 0:
            C1Counter += 2
            C4Counter -= 2
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_4_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_4 gets mapped to when it's raised to the fourth power.  
        """
        q = self.q
        d = self.d
        C1Counter = 0
        C4Counter = (q+1)//d-1
        C2Counter = 0
        C3Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if (q+1) % 4 == 0: 
            C1Counter += 3
            C4Counter -= 3
        elif (q+1) % 2 == 0:
            C1Counter += 1
            C4Counter -= 1
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_5_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_5 gets mapped to when it's squared.  
        """
        q = self.q
        d = self.d
        p = self.p
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = (q+1)//d-1
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if q % 2 == 1:
            C2Counter +=1
            C5Counter -= 1
        if p == 2:
            C4Counter += (q+1)//d-1
            C5Counter -= (q+1)//d-1
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_5_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_5 gets mapped to when it's cubed.  
        """
        q = self.q
        d = self.d
        p = self.p
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = (q+1)//d-1
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if (q+1) % 9 == 0:
            C2Counter += 2
            C5Counter -= 2
        if p == 3:
            C4Counter += (q+1)//d-1
            C5Counter-= (q+1)//d-1 
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_5_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_5 gets mapped to when it's raised to the fourth power.  
        """
        q = self.q
        d = self.d
        p = self.p
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = (q+1)//d-1
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        if (q+1) % 2 == 0:
            C2Counter += 1
            C5Counter -= 1
        if (q+1) % 4 == 0:
            C2Counter += 2
            C5Counter -= 2
        if p == 2:
            C4Counter += (q+1)//d-1
            C5Counter-= (q+1)//d-1
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_6_p_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_p gets mapped to when it's squared.  
        """
        d = self.d
        C6pCounter = 1-(3-d)//2
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_6_p_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_p gets mapped to when it's cubed.  
        """
        d = self.d
        C6pCounter = 0
        C1Counter = 1-(3-d)//2
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_6_p_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_p gets mapped to when it's raised to the fourth power.  
        """
        d = self.d
        C6pCounter = 1-(3-d)//2
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = 0

        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)


    def C_6_klm_sym_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_klm gets mapped to when it's squared.  
        """
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

        return C4Counter # edit this so it matches the other functions' formats 

    def C_6_klm_sym_squared_explicit(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_klm gets mapped to when it's squared. 
        does not iterate through each conjugacy class
        """
        a = self.r % 12
        r = self.r
        if a in [1,3,5,7,9,11]:
            return (0,0)
        if a in [2, 10]:
            total = 0 - math.ceil(r/4) + math.floor(r/6) + r/2  + math.ceil(math.floor(r/6)/2)
            return total
        if a in [4, 8]:
            total = -1 * math.floor(r/4) + math.floor(r/6) + r/2 + math.floor((math.ceil(r/6) - 1)/2)
            return total
        if a == 6:
            return r/6 - 1
        if a == 0:
            return r/6 - 1 
        # edit this so the return statement matches the other functions' formats 

    def C_6_klm_sym_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_klm gets mapped to when it's cubed.  
        """
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
        return C4Counter # edit this so it matches the other functions' formats 

    def C_6_klm_sym_cubed_explicit(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_klm gets mapped to when it's cubed. 
        does not iterate through each conjugacy class 
        """
        C4Counter = 0
        r = self.r
        a = r % 12
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
        return C4Counter # edit this so it matches the other functions' formats 

    def C_6_klm_sym_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_klm gets mapped to when it's raised to the fourth power.  
        """
        C4Counter = 0 
        C1Counter = 0
        r = self.r
        C4Counter += self.C_6_klm_sym_squared()
        if r % 4 != 0:
            return C4Counter, C1Counter
        elif r % 3 != 0:
            # We start by dealing with cases concerning a difference of r/4 
            # Case 1a
            print(C4Counter) 
            k = 1 
            while k < r/6: 
                C4Counter += 1 
                k += 1
            print(C4Counter)
            # Case 1b
            k = math.ceil(3*r/8)
            while k < r/2:
                C4Counter += 1
                k += 1 
            print(C4Counter)
            # Case 2a 
            k = math.ceil(r/6)
            while k < r/4:
                k += 1
                C4Counter += 1
            print(C4Counter)
            # Case 2b 
            k = int(r/2) + 1 
            while k < 7 * r/12:
                k += 1 
                C4Counter += 1 
            print(C4Counter)
            # Case 3a
            k = 1 
            while k < r/4:
                if r % 8 == 0 and k%2 == 0: 
                    C4Counter += 1
                elif r%8 == 4 and k%2 == 1:
                    C4Counter += 1
                k += 1
            print(C4Counter)
            # Case 3b
            k = math.ceil(r/4)
            while k < 7/12 * r:
                if r % 8 == 0 and k % 2 == 0:
                    C4Counter += 1 
                if r % 8 == 4 and k % 2 == 1:
                    C4Counter += 1
                k += 1 
            print(C4Counter)
            # Now we move onto cases concerning a difference of 3r/4
            # Case 1b
            k = math.ceil(r/8)
            while k < r/6:
                k += 1 
                C4Counter += 1
            print(C4Counter)
            # Case 2a
            k = 1
            while k < r/12:
                k += 1 
                C4Counter += 1
            print(C4Counter)
            # Case 2b
            k = math.ceil(r/6)
            while k <= r/4: # note the '<=' weird huh?
                k += 1
                C4Counter += 1
            print(C4Counter)
            # Case 3a
            k = 1 
            while k <= r/12:
                if r%8 == 0 and k % 2 == 0:
                    C4Counter += 1
                elif r%8 == 4 and k % 2 == 1:
                    C4Counter += 1
                k += 1 
            print(C4Counter)
            # When 4 | r we get exactly 1 C1
            C4Counter -= 3 
            C1Counter += 1
            print("======================")
        else:
            # We start by dealing with cases concerning a difference of r/4 
            print(C4Counter)
            # Case 1a 
            k = 1 
            while k <= r/12: 
                C4Counter += 1 
                k += 1
            print(C4Counter)
            # Case 2a 
            k = math.ceil(5*r/24) # this is weird no?
            while k < r/4:
                k += 1
                C4Counter += 1
            print(C4Counter)
            # Case 3a
            k = math.ceil(r/12)
            while k < r/4:
                if r % 8 == 0 and k%2 == 0: 
                    C4Counter += 1
                elif r%8 == 4 and k%2 == 1:
                    C4Counter += 1
                k += 1
            print(C4Counter)
            # Now we move onto cases concerning a difference of 3r/4
            # Case 2a
            k = 1
            while k < r/12:
                k += 1 
                C4Counter += 1
            print(C4Counter)
            # Case 3a
            k = 1 
            while k <= r/12:
                if r%8 == 0 and k % 2 == 0:
                    C4Counter += 1
                elif r%8 == 4 and k % 2 == 1:
                    C4Counter += 1
                k += 1 
            print(C4Counter)
            # When 4 | r we get exactly 1 C1
            C4Counter -= 3 
            C1Counter += 1
            # We over counted the C1 case because there was a differnece of r/2 between k and m and so it was flagged by the squared function
            C4Counter -= 1
            print("============")
        return C4Counter, C1Counter # edit this so it matches the other functions' formats 

    def C_6_klm_sym_fourth_explicit(self):
        """
        Returns a summary of the families that each conjugacy class in C_6_klm gets mapped to when it's raised to the fourth power.
        does not iterate through each conjugacy class  
        """
        C4Counter = 0
        C1Counter = 0
        r = self.r
        a = r%24 
        C4Counter += self.C_6_klm_sym_squared_explicit()
        if a % 4 != 0:
            pass
        elif a % 3 != 0:
            print(C4Counter)
            # Case 1a
            C4Counter += ceil(r/6) - 1
            print(C4Counter)
            # Case 1b
            C4Counter += ceil(r/2) - 1 - ceil(3*r/8) + 1
            print(C4Counter)
            # Case 2a
            C4Counter += ceil(r/4) - 1 - ceil(r/6) + 1
            print(C4Counter)
            # Case 2b
            C4Counter += ceil(7*r/12) - 1 - (int(r/2) + 1) + 1
            print(C4Counter)
            # Case 3a 
            if a % 8 == 0:
                C4Counter += floor((ceil(r/4) - 1)/2)
            if a % 8 == 4:
                C4Counter += ceil((ceil(r/4) - 1)/2)
            print(C4Counter)
            # Case 3b
            if a % 8 == 0:
                C4Counter += ceil((ceil(r*7/12) - 1 - ceil(r/4) + 1)/2)
            if a % 8 == 4:
                C4Counter += ceil((ceil(r*7/12) - 1 - ceil(r/4) + 1)/2)
            print(C4Counter)
            # diff of 3r/4
            # Case 1b
            C4Counter += ceil(r/6) - 1 - ceil(r/8) + 1 
            print(C4Counter)
            # Case 2a
            C4Counter += ceil(r/12) - 1
            print(C4Counter)
            # Case 2b
            C4Counter += ceil(r/4) - ceil(r/6) + 1 
            print(C4Counter)
            # Case 3a
            if a % 8 == 0:
                C4Counter += floor(floor(r/12)/2)
            elif a % 8 == 4:
                C4Counter += ceil(floor(r/12)/2)
            print(C4Counter)
            C4Counter -= 3
            C1Counter += 1
            print("===========================")
        elif a % 3 == 0:
            print(C4Counter)
            # Case 1a 
            C4Counter += ceil(r/12)
            print(C4Counter)
            # Case 2a
            C4Counter += ceil(r/4) - 1 - ceil(5*r/24) + 1
            print(C4Counter)
            # Case 3a
            if a % 8 == 0:
                C4Counter += floor((ceil(r/4) - 1 - ceil(r/12) + 1)/2)
            elif r % 8 == 4:
                C4Counter += ceil((ceil(r/4) - 1 - ceil(r/12) + 1)/2)
            print(C4Counter)
            # diff of 3r/4
            # Case 2a
            C4Counter += ceil(r/12) - 1
            print(C4Counter)
            # Case 3a 
            if a % 8 == 0:
                C4Counter += floor(floor(r/12)/2)
            elif a % 8 == 4:
                C4Counter += ceil(floor(r/12)/2)
            print(C4Counter)

            C4Counter -= 4
            C1Counter += 1
            print("===========")

        return C4Counter, C1Counter # edit this so it matches the other functions' formats 
        
    
    def C_7_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_7 gets mapped to when it's squared.  
        """
        p = self.p
        q = self.q
        d = self.d
        totalnum = (q*q-q+1-d)//(2*self.d) - (3-d)//2
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = totalnum
        C8Counter = 0
        if q % 2 != 0:
            C4Counter += (q+1)//(2*self.d)
            C7Counter = C7Counter - (q+1)//(2*self.d)
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_7_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_7 gets mapped to when it's cubed.  
        """
        p = self.p
        q = self.q
        d = self.d
        totalnum = (q*q-q+1-d)//(2*self.d) - (3-d)//2
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = totalnum
        C8Counter = 0
        if q % 3 == 1:
            C1Counter += 1
            C7Counter -= 1
            C4Counter += q
            C7Counter -= q
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_7_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_7 gets mapped to when it's raised to the fourth power.  
        """
        p = self.p
        q = self.q
        d = self.d
        totalnum = (q*q-q+1-d)//(2*self.d) - (3-d)//2
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = totalnum
        C8Counter = 0
        if q % 2 == 1:
            C4Counter += (q+1)//(2*self.d)
            C7Counter -= (q+1)//(2*self.d)
        if q % 4 == 1: 
            C4Counter += 2*(q+1)//(2*self.d)
            C7Counter -= 2*(q+1)//(2*self.d)
        if (q+1) % 2 == 0 and (q+1)%4 != 0:
            C1Counter += 1
            C4Counter -= 1
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
    
    def C_8_squared(self):
        """
        Returns a summary of the families that each conjugacy class in C_8 gets mapped to when it's squared.  
        """
        q = self.q
        d = self.d
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = ((q*q-q+1)//d-1)//3
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
    
    def C_8_cubed(self):
        """
        Returns a summary of the families that each conjugacy class in C_8 gets mapped to when it's cubed.  
        """
        q = self.q
        d = self.d
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = ((q*q-q+1)//d-1)//3
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
    
    def C_8_fourth(self):
        """
        Returns a summary of the families that each conjugacy class in C_8 gets mapped to when it's raised to the fourth power.  
        """
        q = self.q
        d = self.d
        C1Counter = 0
        C2Counter = 0
        C3Counter = 0
        C4Counter = 0
        C5Counter = 0
        C6pCounter = 0
        C6klmCounter = 0
        C7Counter = 0
        C8Counter = ((q*q-q+1)//d-1)//3
        return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)


        



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
for (a,b) in [(2, 2), (2, 3), (3, 2), (2, 4), (5, 2), (3, 3), (2, 5), (7, 2), (2, 6), (3, 4)]:
    G = GroupCharactersPSL3(a, b)
    print(G.the_game(G.characters[0], 5))
"""
H = GroupCharacters("PSL(3, 5)")
H.display()
G = GroupCharactersPSL3(5, 1)
G.display()
print(G.characters[0])
print(G.the_game(G.characters[0], 4))
"""