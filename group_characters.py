class GroupCharacters:
    classes = None
    class_order = None
    centralizer_order = None
    group_order = None
    primes = None
    power_maps = None
    characters = None

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
    if smallest <= n:
        result = [(n,)]
    for i in range(n//2,k-1,-1):
        result += [ p + (i,) for p in partitions(n-i,i)]
    return result

def partition_tuples(n):
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
