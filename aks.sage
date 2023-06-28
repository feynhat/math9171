def nbits(n):
    out = 0
    while n > 0:
        out += 1
        n //= 2
    return out

def floor_root(n, e):
    l = nbits(n)
    k = (l-1)//e
    m = 2^k
    for i in range(k-1, -1, -1):
        if (m + 2^i)^e <= n:
            m += 2^i
    return m

def perfect_power(n):
    # checks if n = a^b, a > 1, b > 1
    l = nbits(n)
    for i in range(2, l):
        r = floor_root(n, i)
        if r^i == n:
            return True
    return False

def mod_exp(a, n, m):
    res = 1
    p = a
    while n > 0:
        if n%2 == 1:
            res = (res * p)%m
        p = (p * p)%m
        n //= 2
    return res

def find_appr_r(n):
    l = nbits(n)
    cont = True
    for r in range(3, l^5+2):
        if cont:
            cont = False
            for i in range(1, l^2):
                if mod_exp(n, i, r) == 1 or mod_exp(n, i, r) == 0:
                    cont = True
        else:
            return r-1

def aks(n):
    if perfect_power(n):
        return False
    r = find_appr_r(n)
    for a in range(1, r+1):
        if gcd(a, n) > 1 and gcd(a, n) < n:
            return False

    P.<x> = Zmod(n)[]
    cy = P(x^r - 1)
    R = P.quotient(cy)
    l = nbits(n)
    for a in range(1, 2*floor_root(r,2)*l + 2):
        p = R((x + a)^n)
        q = R(x^n + a)
        if p != q:
            return False

    return True

def main():
    test_cases = [
            2,          # Prime
            3,          # Prime
            31,         # Prime
            561,        # Carmichael psuedoprime
            1729,       # Ramanujan-Carmichael number
            2465,       # Carmichael psuedoprime
            2821,       # Carmichael psuedoprime
            6061,       # Carmichael psuedoprime
            93131,      # Prime (takes ~20s on my machine)
            857*2089,   # Product of 'big' primes
            #86711 * 20809 # product of 'very big' primes, runs out of memory
    ]

    print(find_appr_r(31))

    for n in test_cases:
        if aks(n):
            print(n, 'Prime')
        else:
            print(n, 'Composite')

if __name__ == '__main__':
    #main()
    pass
