# grid = [
#     [ -1,  -1,  1 ,  3 ,  5 ,  7 ,  9 ,  11,  13 ],
#     [ -1,  -1,  2 ,  4 ,  6 ,  8 ,  10,  12,  14 ],
#     [ -1,  -1,  15,  17,  19,  21,  23,  25,  27 ],
#     [ -1,  -1,  16,  18,  20,  22,  24,  26,  28 ]
# ]

grid = [
    [1 ,  3 ,  5 ,  7 ,  9 ,  11,  13,  15,  17 ],
    [2 ,  4 ,  6 ,  8 ,  10,  12,  14,  16,  18 ],
    [19,  21,  23,  25,  27,  29,  31,  33,  35 ],
    [20,  22,  24,  26,  28,  30,  32,  34,  36 ]
]

pixelOrder = []

for y, row in enumerate(grid):
    for x, pixelIndex in enumerate(row):
        if pixelIndex > 0:
            pixelOrder.append( (pixelIndex - 1, (x, y)) )

pixelOrder = sorted(pixelOrder, key=lambda p: p[0])

for p in pixelOrder:
    print '{ %s, %s }'%(p[1][0], p[1][1])
