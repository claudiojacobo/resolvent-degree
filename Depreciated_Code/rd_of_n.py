"""
best known bounds on RD from Heberle-Sutherland 2022
note: Claudio is currently in the process of beating
    some of these bounds, so we might update this
"""


def RD(n):
    G = {1:2, 2:3, 3:4, 4:5, 5:9, 6:21, 7:109, 8:325, 9:1681,
        10:15121, 11:151201, 12:1663201, 13:5250198, 14:51891840,
        15:726485761, 16:10897286401, 17:174356582401,
        18:2964061900801, 19:53353114214401,
        20:1013709170073601, 21:20274183401472001,
        22:381918437071508900}
    for m in range(len(G),0,-1):
        if n >= G[m]:
            return n-m
    return 1
