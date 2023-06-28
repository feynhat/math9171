import random

def nbits(n):
    out = 0
    while n > 0:
        out += 1
        n //= 2
    return out

def mod_exp(a, n, m):
    res = 1
    p = a
    while n > 0:
        if n%2 == 1:
            res = (res * p)%m
        p = (p * p)%m
        n //= 2
    return res

def fermat_witness(a, n):
    if mod_exp(a, n-1, n) != 1:
        return True
    return False

def fermat_test(n):
    num_checked = 0
    while num_checked <= 20:
        i = random.choice(range(2, n))
        if gcd(i, n) == 1:
            if fermat_witness(i, n):
                return False
            num_checked += 1
    return True
