import math
def get_PSU_order(n,q):
    """
    :param n: integer
    :param q: prime
    :return: order of PSU(n+1, q)
    """
    n += -1 # correction to make the wikipedia formula work (as it's for the differently labeled )
    k = 1
    for i in range(1, n+1):
        k *= q ** (i + 1) - ((-1) ** (i + 1))
    return k * (q ** ((1/2) * n * (n+1))) * (1/(math.gcd(n+1, q+1)))


    