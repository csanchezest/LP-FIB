def my_map(f, L):
    ls = [f(x) for x in L]
    return ls


def my_filter(f, L):
    ls = [x for x in L if f(x)]
    return ls


def factors(n):
    ls = [x for x in range(1, n + 1) if n % x == 0]
    return ls


def triplets(n):
    ls = [(a, b, c) for a in range(1, n + 1) for b in range(1, n + 1) for c in range(1, n + 1) if c ** 2 == a ** 2 + b ** 2]
    return ls
