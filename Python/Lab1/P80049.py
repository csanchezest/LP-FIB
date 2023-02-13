def count_unique(L):
    ans = list(dict.fromkeys(L))
    return len(ans)


def remove_duplicates(L):
    ans = list(dict.fromkeys(L))
    return ans


def flatten(L):
    ans = []
    for i in L:
        for j in i:
            ans.append(j)
    return ans


def flatten_rec(L):
    ls = []
    for i in L:
        if isinstance(i, list):
            ls = ls + flatten_rec(i)
        else:
            ls.append(i)
    return ls
