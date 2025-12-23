from math import comb, factorial, log2

'''
# best bounds from [HS2023] and [Sut2022]
H_bound = {
    1:2, 2: 3, 3: 4, 4: 5, 5: 9, 6: 21, 7: 109, 8: 325,
    13: 5250198, 22: 381918437071508900,
    34: 2475934708812781843231486891102123,
    44: 8559276927975810009082900078329761155025671771554
}
for r in range(9, 56):
    d = 4
    if 14 <= r <= 21: d = 5
    elif 23 <= r <= 33: d = 6
    elif 35 <= r <= 43: d = 7
    elif 45 <= r: d = 8
    H_bound[r] = factorial(r-1)//factorial(d) + 1
'''

# best bounds following [GG2025]
H_bound = {
    1: 2, 2: 3, 3: 4, 4: 5, 5: 9, 6: 21, 7: 75, 11: 59050,
    20: 227214539745187, 34: 2475934708812781843231486891102123,
    44: 8559276927975810009082900078329761155025671771554
}
for r in range (8, 56) :
    d = 4
    if 12 <= r <= 19: d = 5
    elif 21 <= r <= 33: d = 6
    elif 35 <= r <= 43: d = 7
    elif 45 <= r : d = 8
    H_bound[r] = factorial(r-1)//factorial(d) + 1

r_max = max(H_bound.keys())
def RD_bound(n):
    '''Uses H_bound to compute a bound on RD(n)'''
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

def fiber_max(r):
    '''Returns the largest n for which RD_bound(n) ≤ r'''
    # First, find an upper bound 'high' where R(high) > n
    low = r
    high = r
    while RD_bound(high) <= r:
        high *= 2
    # Now, binary search between low and high
    while low <= high:
        mid = (low + high) // 2
        if RD_bound(mid) <= r:
            low = mid + 1
        else:
            high = mid - 1
    return high

def endo(m,j):
    if j == 0:
        return m
    n = len(m)
    return tuple([ sum([comb(j+i-l-1,i-l)*m[i] for i in range(l,n)]) for l in range(n)])

def clear_rightmost_zeroes(m):
    mm = list(m)
    for i in range(len(mm)-1,-1,-1):
        if mm[i] > 0:
            mm = mm[:i+1]
            break
    return tuple(mm)

def f(l,j,m):
    '''
    Compute the best possible bound on f^\ell_j(m) as in GG2025

    Uses polar cones to inductively compute the smallest N for which any intersection of
    hypersurfaces of type m = (m2,...,mn) has dense j-planes at level l, i.e., when the
    fano variety F(j,X) has dense k^{(l)} points. Expects a globally defined `bailout` value
    that determines when to abandon a calculation.

    Args:
        l (int): The level of RD^{≤l} versality. Must have l≥0.
        j (int): The dimension of j-planes (j=0 is points). Must have j≥0.
        m (tuple of int): The intersection type, where m[i] is the number of degree i+2 forms.

    Returns:
        int: The best bound on f^\ell_j(m), or -1 if the computation was abandoned
    '''

    n = len(m)+1
    if RD_bound(n) > l:
        raise ValueError("We need more RD!")
    m = tuple(m)
    if m[-1] == 0:
        m = clear_rightmost_zeroes(m)
    N = 0

    steps = 0
    max_product = 1
    max_j = 0
    while sum(m) > 0:
        steps = steps+1
        if steps > bailout:
            print(f"Bailing out! >{bailout} steps, f^{l}_{j}({m})+{N}")
            return -1
        n = len(m)+1

        if j == 0: # apply Lemma 3.5

            if n == 2: # if we reduce to intersection of quadrics
                return N + f_quadratic(l,m[0])
            m = list(m)
            i = n-2
            product = 1
            while RD_bound(product) <= l and i >= 0:
                if m[i] == 0:
                    i -= 1
                    continue
                if RD_bound(product * (i+2)) <= l:
                    j += 1
                    product *= i+2
                    m[i] -= 1
                else:
                    break
            if max_product < product:
                max_product, max_j = product, j
            m = clear_rightmost_zeroes(m)

        else: # apply Lemma 3.4
            N += j + sum([comb(j+i,i+1)*m[i] for i in range(n-1)])
            m = endo(m,j)
            j = 0

    return j+N

def f_quadratic(l,m):
    '''Closed form of f^l_j(m) when j=0 for an intersection of m quadrics'''
    b = int(log2(fiber_max(l)))
    q, r = m//b, m%b
    return comb(q,2)*b**2+q*b*(r+1)+r
