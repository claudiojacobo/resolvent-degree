### Enumerating partitions

def partitions(n, k=1):
    '''
    Generate all integer partitions of n with parts no smaller than k.

    A partition of an integer n is a way of writing n as a sum of positive integers,
    where the order of terms does not matter. This function generates all such
    partitions where each part is at least k.

    Args:
        n (int): The positive integer to partition. Must be ≥ 0.
        k (int): The minimum value for each part in the partition. Must be ≥ 1.
                Defaults to 1, which generates all partitions of n.

    Returns:
        list[tuple[int, ...]]: A list of tuples, where each tuple represents a
            partition of n as a sequence of integers in non-increasing order.
            Each integer in the tuple is ≥ k.
    '''
    result = []
    if k <= n:
        result = [(n,)]
    for i in range(n//2,k-1,-1):
        result += [ p + (i,) for p in partitions(n-i,i)]
    return result

def partitions_as_dicts(n):
    '''
    Returns all integer partitions of `n` as dictionaries.

    Each partition is represented as a dictionary where keys are integers from 1 to n,
    and the value for each key is the multiplicity (count) of that number in the partition.
    For example, the partition 4 + 3 + 3 + 2 = 12 is represented as:
        {1: 0, 2: 1, 3: 2, 4: 1, 5: 0, ..., 12: 0}

    Args:
        n (int): The integer to partition. Must be ≥ 1.

    Returns:
        list[dict[int, int]]: A list of dictionaries encoding the partitions of `n`.
    '''
    tuples = []
    for partition in partitions(n):
        counts = { i+1:0 for i in range(n) }
        for i in partition:
            counts[i] += 1
        tuples.append(counts)
    return tuples

### Computing algebraically independent generators from molien series

def generator_combinations(generators, degree, limit=None):
    '''
    Computes all ways to decompose a given degree into the provided generators.

    Returns all decompositions of a `degree` in terms of a given list `generators`
    (where generators[i] is the number of generators in degree i), using all generators
    up to some specified `limit`. Each decomposition is a tuple of tuples (i,j), used
    to describe the jth generator of degree i as part of the decomposition.

    Args:
        generators (list[int]): A list where generators[i] is the number of generators
            in degree i. Must be non-negative integers and expects generators[0] = 1.
        degree (int): The target degree to decompose. Must be non-negative.
        limit (tuple[int, int], optional): A tuple (max_degree, max_index) that
            constrains the search space to avoid duplicate decompositions. If None,
            as is expected when used normally, defaults to largest possible.

    Returns:
        list[tuple[tuple[int, int], ...]]: A list of decompositions, where each
            decomposition is a tuple of (degree, index) pairs indicating which
            generators were used. Each decomposition sums to the target degree.

    Example:
        >>> generator_combinations([1,2,1], 3)
        [((1, 0), (1, 0), (1, 0)),
        ((1, 1), (1, 0), (1, 0)),
        ((1, 1), (1, 1), (1, 0)),
        ((1, 1), (1, 1), (1, 1)),
        ((2, 0), (1, 0)),
        ((2, 0), (1, 1))]
    '''
    # initial function call, establish limit
    if limit == None:
        limit = (len(generators), generators[-1]-1)

    # generators are often computed using character theory and may, a priori, be
    # number field elements (they are actually non-negative integers)
    generators = [int(g) for g in generators]

    # strategy is to inductively strip away i from the target degree
    combinations = []
    for i in range(1,len(generators)):
        if degree < i:
            break
        for j in range(generators[i]):
            # only allow weakly decreasing combinations to avoid duplicates
            if (i,j) > limit: break

            if degree == i: # base case
                combinations.append(((i,j),))
            else: # inductive step
                for c in generator_combinations(generators[:i+1],degree-i,(i,j),):
                    combinations.append(((i,j),) + c)

    return combinations

def generators_from_molien(molien_terms):
    '''
    Counts algebraically independent G-invariant polynomials from a molien series

    Determines a set of G-invariant polynomials f1,...,fn, with weakly increasing degrees,
    where each fi is algebraically independent from the lower order terms.

    Args:
        molien_terms (list[int]): A list where molien_terms[i] is understood to denote the
        dimension of G-invariant polynomials of degree i on some representation

    Returns:
        list[int]: A list whose ith entry denotes the number of algebraically independent
        polynomials identified in degree i

    Example:
        >>> generators_from_molien([1,0,2,0,4])
        [1, 0, 2, 0, 1]
    '''
    # initialize generators with first non-zero element in molien terms
    generators = [1]
    for e in molien_terms[1:]:
        generators.append(e)
        if e != 0:
            break

    # iteratively compute number of new generators from old
    for i in range(len(generators), len(molien_terms)):
        generators.append(molien_terms[i]-(len(generator_combinations(generators,i))))

    return generators

def degrees_to_dict(degrees, include_last = False):
    '''
    Converts a list encoding degrees to a dictionary encoding degrees

    Args:
        degrees (list[int]): A list where degrees[i] is the number of forms of degree i
        include_last (bool): A flag on wether to include the highest degree k

    Returns:
        dict[int, int]: A dictionary where the value at key=i is the number of degree i forms.

    Example:
        >>> degrees_to_dict([1,0,2,0,1,0])
        {0:1, 2:2, 4:1, 5:0}
    '''
    result = {}
    d = len(degrees)
    for i in range(d):
        if degrees[i] != 0:
            result[i] = degrees[i]
    if include_last:
        result[d-1] = degrees[d-1]
    return result

### Enumerating prime powers

def primes_up_to(k):
    '''
    returns an ascending list of all primes up through k
    '''
    primes = [2]
    for i in range(3,k):
        for p in primes:
            if i%p == 0: break
        else:
            primes.append(i)
    return primes

def prime_powers_up_to(k, as_pairs=False):
    '''
    returns an ascending list of all prime powers up through k
    '''
    prime_powers = []
    for p in primes_up_to(k):
        e = 1
        q = p**e
        while q <= k:
            if as_pairs:
                prime_powers.append((p, e))
            else:
                prime_powers.append(q)
            e += 1
            q *= p
    if as_pairs:
        return sorted(prime_powers, key=lambda x: x[0]**x[1])
    return sorted(prime_powers)

### Computing bounds on RD(n)

from math import factorial

# best bounds from [HS2023] and [Sut2022]
H_bound = {
    1: 2, 2: 3, 3: 4, 4: 5, 5: 9, 6: 21, 7: 75,
    20: 227214539745187, 34: 2475934708812781843231486891102123,
    44: 8559276927975810009082900078329761155025671771554
}

for r in range(8,44):
    if 8 <= r <= 11: d = 4
    elif 12 <= r <= 19: d = 5
    elif 21 <= r <= 33: d = 6
    elif 35 <= r: d = 7
    else: continue
    H_bound[r] = factorial(r-1)//factorial(d) + 1

r_max = max(H_bound.keys())

def RD_bound(n):
    '''Uses H_bound to compute a bound on RD(n)'''
    n = int(n) # protect against SageMath Integers!
    if n < H_bound[1]:
        return n
    if n >= H_bound[r_max]:
        return n-r_max
    low, high = 1, r_max
    while low <= high: # use a binary search to find r with H[r] <= n < H[r+1]
        r = (low + high) // 2
        if H_bound[r] <= n and H_bound[r+1] > n:
            return n-r
        elif H_bound[r] <= n:
            low = r + 1
        else:
            high = r - 1
