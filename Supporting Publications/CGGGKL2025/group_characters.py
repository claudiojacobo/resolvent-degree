from sage.all import libgap, Integer
from helper_functions import *

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

    def __init__(self, group_name, schur_cover=None):

        self.name = group_name

        # invoke GAP via libgap
        group = eval(f'libgap.{group_name}')
        self.minimal_perm = group.MinimalFaithfulPermutationDegree()

        if schur_cover:
            group = eval(f'libgap.{schur_cover}')

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

    def display(self, decimal=False):
        '''
        Display the data currently stored in the class
        '''

        print(f'----------- Character data for {self.name} ------------')

        print('\nConjugacy classes:\n\n', end='\t')
        for g in self.classes:
            print(g,end = '\t')

        print('\n\nCentralizers:\n\n', end='\t')
        for g in self.classes:
            print(self.centralizer_order[g],end = '\t')

        print('\n\nPower maps:')
        for p in self.primes:
            if p in self.power_map[self.classes[0]]:
                print(f'\n{p}', end='\t')
                for g in self.classes:
                    print(self.power_map[g][p],end = '\t')
            else:
                print(f'\nPower Map was not calculated for primes greater than or equal to {p}')
                break

        print('\n\nCharacters:')
        for i, chi in enumerate(self.characters):
            print(f'\nχ{i}:', end='\t')
            for g in self.classes:
                if decimal:
                    print(f'{complex(chi[g]):.3f}',end = '\t')
                else:
                    print(chi[g],end = '\t')
        print('\n')

    def inner_product(self, f1, f2):
        '''
        Compute the inner product of two class functions

        Calculates the L^2 inner product of two class functions, encoded as dictionaries with keys
        denoting classes and values in some appropriate ring. Inner product is normalized so that
        irreducible representations are orthonormal and first argument is anti-linear.

        Args:
            f1 (dict[str, ring element]): A class function on G (keys are conjugacy classes)
            f2 (dict[str, ring element]): A class function on G
        '''
        return sum([ f1[g].conjugate()*f2[g]/self.centralizer_order[g] for g in self.classes ])

    def invariant_dimension(self, chi):
        '''
        Computes the dimension of G-invariants for the representation whose character is chi

        Args:
            chi (dict[str, ring element]): A character of G (keys are conjugacy classes)
        '''
        return sum([ chi[g] / Integer(self.centralizer_order[g]) for g in self.classes ])

    def power_class(self, g, k):
        '''
        Computes the conjugacy class of g^k using power map data

        Args:
            g (str): A conjugacy class of G
            k (int): The power to apply to g

        Returns:
            str: The conjugacy class of g^k
        '''
        k = k % self.class_order[g]
        if k == 0:
            return self.classes[0]
        elif k == 1:
            return g
        for p in self.primes:
            if k%p == 0:
                return self.power_class(self.power_map[g][p], k//p)

    def molien_coeff(self, chi, k):
        '''
        Computes first k coefficients of the Molien series for chi

        Args:
            chi (dict[str, ring element]): A character of G (keys are conjugacy classes)
            k (int): The number of terms to compute in the Molien series. Must be ≥ 1.

        Returns:
            list[int]: A list of coefficients, where result[i] is the ith coefficient
        '''
        sym = [{ g:1 for g in self.classes }, chi]
        for i in range(2,k):
            sym.append({})
            for g in self.classes:
                sym[i][g] = sum([ sym[i-1-j][g] * chi[self.power_class(g,j+1)] for j in range(i)]) / Integer(i)
        return [ self.invariant_dimension(char) for char in sym ]

    def the_game(self, chi, n):
        '''
        Calculates a bound on RD(G) using Theorem 2.2 of [CGGGKL2025]

        Returns a dictionary describing the result of "the game", where we compute invariants of the provided
        irreducible representation of G (or its Schur cover) and use these to establish the existence of a
        suitably versal G-variety whose dimension is a bound on RD(G).

        Args:
            chi (dict[str, ring element]): A character of G (keys are conjugacy classes)
            n (int): The number of terms to compute in the Molien series. Must be ≥ 1.

        Returns:
            dict[str, data]: Result of playing the game with chi
        '''
        bound = chi[self.classes[0]] - 1 # sets initial bound to dimension of the associated projective rep
        computed_invariants = generators_from_molien(self.molien_coeff(chi, n+1))
        available_invariants = computed_invariants[:]
        used_invariants = [0]*len(computed_invariants)

        degree = 1

        # start at the first non-zero invariant polynomial
        while degree < len(computed_invariants) and computed_invariants[degree] == 0:
            degree += 1

        degree = min(degree, n)
        total_degree = 1
        exhausted_invariants = True
        while degree < len(available_invariants):
            if total_degree * degree >= self.minimal_perm or RD_bound(total_degree * degree) > bound - 1:
                exhausted_invariants = False
                break

            bound -= 1
            total_degree *= degree
            used_invariants[degree] += 1
            available_invariants[degree] -= 1
            while degree < len(available_invariants) and available_invariants[degree] == 0:
                degree += 1

        if exhausted_invariants:
            raise ValueError('Invariants are exhausted, cannot complete analysis')

        while degree < len(available_invariants) and available_invariants[degree] == 0:
            degree += 1

        output = {
            'group': self.name,
            'bound': int(bound),
            'rep_degree': int(chi[self.classes[0]]),
            'inv_used': degrees_to_dict(used_invariants),
            'inv_computed': degrees_to_dict(computed_invariants, include_last = True),
            'limitation': [],
            'notes': '',
        }

        if total_degree * degree >= self.minimal_perm:
            output['limitation'].append('generic freeness')
        if RD_bound(total_degree * degree) > bound - 1:
            output['limitation'].append('versality')

        if RD_bound(self.minimal_perm) == bound:
            output['notes'] = "Tied with minimal permutation bound [FW19, Lemma 3.13]"
        elif RD_bound(self.minimal_perm) < bound:
            bound = RD_bound(self.minimal_perm)
            output['notes'] = "Beat by minimal permutation bound [FW19, Lemma 3.13]"

        return output
