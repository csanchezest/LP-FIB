def absValue(x):
    return abs(x)


def power(x, p):
    if p == 0:
        return 1
    a = power(x, p // 2)
    a = a * a
    if p % 2 == 1:
        a = a * x
    return a


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


def slowFib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    return slowFib(n - 1) + slowFib(n - 2)


def quickFib(n):
    m = [0, 1]
    for i in range(2, n + 1):
        m.append(m[i - 1] + m[i - 2])
    return m[n]
