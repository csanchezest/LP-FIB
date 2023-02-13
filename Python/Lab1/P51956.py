def myLength(L):
    l = 0
    for i in L:
        l = l + 1
    return l


def myMaximum(L):
    mx = L[0]
    for i in L:
        if i > mx:
            mx = i
    return mx


def average(L):
    avg = 0
    n = 0
    for i in L:
        avg = avg + i
        n = n + 1
    return avg / n


def buildPalindrome(L):
    nL = []
    for i in range(-1, - myLength(L) - 1, -1):
        nL.append(L[i])
    return nL + L


def remove(L1, L2):
    res = []
    for i in L1:
        if i not in L2:
            res.append(i)
    return res


def flatten(L):
    ls = []
    for i in L:
        if isinstance(i, list):
            ls = ls + flatten(i)
        else:
            ls.append(i)
    return ls


def oddsNevens(L):
    odds = []
    evens = []
    for i in L:
        if i % 2 == 0:
            evens.append(i)
        else:
            odds.append(i)
    return odds, evens


def primes(x):
    if x == 2:
        return True
    if x < 2 or x % 2 == 0:
        return False
    for i in range(3, int(x ** 0.5) + 1, 2):
        if x % i == 0:
            return False
    return True
    


def primeDivisors(n):
    divs = []
    for i in range(2, n // 2 + 1):
        if n % i == 0:
            divs.append(i)
    divs.append(n)
    res = []
    for i in divs:
        if primes(i):
            res.append(i)
    return res
    
