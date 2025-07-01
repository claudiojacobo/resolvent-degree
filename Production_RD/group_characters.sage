import math
from sage.all import libgap
from Resolvent_Degree_Polynomial import RD

class GroupCharacters:
    classes = None
    class_order = None
    centralizer_order = None
    group_order = None
    primes = None
    power_maps = None
    characters = None
    minimal_perm = None
    
    def __init__(self, group_name):
        # invoke GAP via libgap
        G = eval(f"libgap.{group_name}")
        ct = G.CharacterTable()
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
        self.power_maps = { g:{} for g in self.classes }
        for p in self.primes:
            for i in range(len(self.classes)):
                self.power_maps[self.classes[i]][p] = self.classes[ct.PowerMap(p).sage()[i]-1]

        # sort characters by degree
        ct = sorted(ct.Irr().sage(), key=lambda x:x[0])
        self.characters = [ { self.classes[i]:chi[i] for i in range(r) } for chi in ct]

        # this is likely a bottleneck
        self.minimal_perm = G.MinimalFaithfulPermutationDegree()

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
            curr_class = self.power_maps[curr_class][num]

        return chi[curr_class]

    def sym_power(self, chi, k):
        """
        Computes the character of the kth symmetric power of an action. 

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
        for i in range(0,k+1): # check for off by 1 errors abd what sym^0 is
            sym_pows.append(self.sym_power(chi,i))
        molien_coefs = []
        for i in range(0,k+1): 
            molien_coefs.append(self.inner_product(G.characters[0], sym_pows[i])) 
            #maybe we call ct, not sure about naming
        return molien_coefs 

    def power_class(self, g, k):
        """
        Recursively computes the conjugacy class of g^k using power map data
        """
        k = k % self.class_order[g]
        if k == 0:
            return self.classes[0]
        elif k == 1:
            return g
        for p in self.primes:
            if k%p == 0:
                return self.power_class(self.power_maps[g][p],k//p)

    def molien_coeff(self, chi, k): 
        """
        Returns the first k coefficients of the Molien series for chi
        """
        sym = [{ g:1 for g in self.classes }, chi]
        for i in range(2,k):
            sym.append({})
            for g in self.classes:
                sym[i][g] = sum([ sym[i-1-j][g] * chi[self.power_class(g,j+1)] for j in range(i)])/i
        return [ G.invariant_dimension(char) for char in sym ]

    def print_chars(self):
        for character in self.characters:
            print(character)
            print("")

    def print_char(self, k):
        print(self.characters[k])
    
    def the_game(self, chi):
        """
        Calculates a bound on G using chi and thereoms about nice G-varieties 
        returns triple (bound, ran_out_of_molien, limited_by_subgroup) where the first entry is an integer
        and the second and there are booleans indicating (2) wether or not we had enough molien series terms 
        to finish our calculations and (3) wether we were limited by the size of our maximal subgroup or by
        the product of the degrees of invariant polynomials.
        
        """
        bound = chi[self.classes[0]] - 1 # CHECK IF THIS IS THE RIGHT WAY AROUND | Sets initial bound to dimension of the associated projective rep
        degree_product = 1 
        irr_poly = self.irr_poly(chi) # place holder while irr_poly function is being developed
        ran_out_of_molien = True
        limited_by_action = None
        
        i = 1
        # start at the first non zero entry in irr_poly
        while irr_poly[i] == 0 and i < len(irr_poly):
            i += 1

        while i < len(irr_poly):
            if degree_product * i >= self.minimal_perm:
                limited_by_action = True
                break 
            
            # Stop when product of degrees is larger than bound
            if RD(degree_product * i) > bound-1:
                ran_out_of_molien = False
                limited_by_action = False
                break

            else:
                bound -= 1
                degree_product *= i     
                irr_poly[i] -= 1
                while irr_poly[i] == 0 and i < len(irr_poly):
                    i += 1
        return bound, ran_out_of_molien, limited_by_action 
    
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


def partitions(n, k=1):
    """
    returns all partitions of n into pieces at least k big
    """
    result = []
    if k <= n: # changed smallest <= n to k <= n -- not sure if that's right
        result = [(n,)]
    for i in range(n//2,k-1,-1):
        result += [ p + (i,) for p in partitions(n-i,i)]
    return result

def partition_tuple(n):
    """
    returns all partitions of n, where each partition p is encoded as a dictionary:
    p[k] is the multiplicity of k in the partition. For example, if p stands for the 
    partition 4+3+3+2 of 12, we have p[4]=1, p[3]=2, p[2]=1, and p[i]=0 otherwise.
    """
    tuples = []
    for partition in partitions(n):
        counts = { i+1:0 for i in range(n) }
        for i in partition:
            counts[i] += 1
        tuples.append(counts)
    return tuples

G = GroupCharacters("PSU(3,4)")
print(G.molien_coeff(G.characters[1],11))
