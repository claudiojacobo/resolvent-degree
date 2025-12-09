def primitive_root_of_unity(field, k):
    """
    Takes in a finite field and a positive integer k, then returns a primitive
        nth root of unity in the field or an error if none exists.
    """
    q = field.order()
    if (q - 1) % k != 0:
        raise ValueError(f"No primitive {k}-th root of unity exists in {field}.")
    
    gen = field.primitive_element()
    return gen**((q-1)//k)

def is_scalar(A, B):
    """
    Takes in two non-zero matrices with the same dimensions and ground field and
        returns True if one is a scaled version of the other; False otherwise.
    """
    field = A.base_ring()
    n = A.nrows()

    i,j = 0,0
    for i in range(n):
        for j in range(n):
            if A[i][j] != field(0):
                break

    scalar = B[i][j] / A[i][j]
    if B == scalar * A:
        return True
    return False

q = 7
t = q^2-q+1
tp = t/gcd(3,q+1)
tpp = (tp-1)/6
tau = primitive_root_of_unity(GF(q^(2*euler_phi(t))),t)
A = matrix([[tau,0,0],[0,tau^(-q),0],[0,0,tau^(q^2)]])A = matrix([[tau,0,0],[0,tau^(-q),0],[0,0,tau^(q^2)]])

# let's look at what conjugacy classes we pass through
classes = {1:1}
B = A
for i in range(2,tp):
    B *= A
    flag = False
    for j in classes.keys():
        # this is (apparently) a (very expensive) way to check conjugacy, at least for this case
        if is_scalar(B.jordan_form(),(A**j).jordan_form()):
            classes[j] += 1
            flag = True
            break
    if flag == False:
        classes[i] = 1

print(classes)