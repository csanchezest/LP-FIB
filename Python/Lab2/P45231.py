def fibs():
    a = 0
    yield a
    b = 1
    while True:
        yield b
        a, b = b, a + b
        

def roots(x):
    f1 = x
    yield f1
    while True:
        f1 = 1/2 * (f1 + x / f1)
        yield f1


def isPrime(x):
    if x < 2:
        return False
    nums = [True] * (x + 1)
    m = 2
    while(m * m <= x):
        if nums[m]:
            for i in range(m * m, x + 1, m):
                nums[i] = False
        m += 1
    return nums[x]


def primes():
    x = 2
    yield x
    while True:
        x += 1
        if isPrime(x):
            yield x
            

def isHamming(x):
    if x == 1:
        return True
    elif x % 2 == 0:
        return isHamming(x / 2)
    elif x % 3 == 0:
        return isHamming(x / 3)
    elif x % 5 == 0:
        return isHamming(x / 5)
    return False


def hammings():
    x = 1
    yield x
    while True:
        x += 1
        if isHamming(x):
            yield x
