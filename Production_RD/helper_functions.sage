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

def generator_combinations(generators, degree, limit=None):
    """
    computes all ways to decompose degree into generators (specified as a list, where 
    generators[i] tells us the number of generators in degree i) and returns a list of tuples,
    where each tuple contains elements of the form (i,j) to describe the jth generator of
    degree i as part of the sum. Example usage: generator_combinations([1,3,1],3) returns a
    list of the 13 products of f0, f1, f2, and g (deg(fi) = 1 and deg(g) = 2) of degree 3.
    """

    # initial function call
    if limit == None: 
        limit = (len(generators),generators[-1]-1)

    # strategy is to inductively strip away i from the target degree
    combinations = []
    for i in range(1,len(generators)):
        if degree < i:
            break
        for j in range(int(generators[i])):
            # only allow weakly decreasing combinations to avoid duplicates
            if (i,j) > limit: break

            if degree == i: # base case
                combinations.append(((i,j),))
            else: # inductive step
                for c in generator_combinations(generators[:i+1],degree-i,(i,j),):
                    combinations.append(((i,j),) + c)

    return combinations

# [1,1,2,3,4,5,7,8]

def generators_from_molien(molien_terms):

    # initialize generators with first non-zero element in molien terms
    generators = [1]
    for e in molien_terms[1:]:
        generators.append(e)
        if e != 0:
            break
 
    # iteratively compute number of new generators from old
    for i in range(len(generators),len(molien_terms)):
        generators.append(molien_terms[i]-(len(generator_combinations(generators,i))))

    return generators

"""
best known bounds on RD from Heberle-Sutherland 2022
note: Claudio is currently in the process of beating
    some of these bounds, so we might update this
"""
def RD(n):
    G = {1:2, 2:3, 3:4, 4:5, 5:9, 6:21, 7:109, 8:325, 9:1681,
        10:15121, 11:151201, 12:1663201, 13:5250198, 14:51891840,
        15:726485761, 16:10897286401, 17:174356582401,
        18:2964061900801, 19:53353114214401,
        20:1013709170073601, 21:20274183401472001,
        22:381918437071508900}
    for m in range(len(G),0,-1):
        if n >= G[m]:
            return n-m
    return 1

def display(group_name, char_index, molien_deg): 
    print("----------RD info for", group_name,"----------\n")
    G = GroupCharacters(group_name)
    print("---Conjugacy classes of", group_name, "---\n", G.classes)
    print("----------Power maps---------- \n", G.power_maps)
    print("Power maps \n", G.classes)
    for c in range(char_index):
        chi = G.characters[c]
        print("----------Molien coef for character #", c, "up to", molien_deg, "th degree----------\n")
        mcoefs = G.get_coef(chi, molien_deg)
        print(mcoefs)

