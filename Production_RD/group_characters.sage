import math
from sage.all import libgap # is this necessary? 
import time
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
        the inner product..outputs a list of the coef where posiiton of the list 
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

        i = 1
        # start at the first non zero entry in alg_indp_poly
        while i < len(alg_indp_poly) and alg_indp_poly[i] == 0:
            i += 1

        while i < len(alg_indp_poly):
            if degree_product * i >= self.minimal_perm:
                limited_by_action = True
                ran_out_of_molien = False
                if RD(degree_product * i) > bound-1:
                    limited_by_versality = True
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
            while alg_indp_poly[i] == 0 and i < len(alg_indp_poly):
                i += 1

        if RD(self.minimal_perm) <= bound:
            bound = RD(self.minimal_perm)
            beat_by_perm = True

        output = {
            "group":self.name, 
            "rep-degree":int(chi[self.classes[0]]), 
            "bound":int(bound), 
            "invariants":tuple(invariants), 
            "limitation":[], 
            "notes":"",
        }
        if limited_by_action:
            output["limitation"].append("generic-freeness")
        if limited_by_versality:
            output["limitation"].append("versality-degree")
        if beat_by_perm:
            output["limitation"].append("permutation-rep")
        if ran_out_of_molien:
            output["limitation"].append("insufficient-invariants")
            print("We ran out of Molien terms before the game ended!")

        return output
