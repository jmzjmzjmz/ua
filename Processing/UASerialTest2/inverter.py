# entire grid

# grid = [
#     [ -1 , -1 , 1  , 3  , 5  , 7  , 9  , 11 , 13 ,   15 , 17 , 19 , 21 , 23 , 25 , 27 , -1 , -1 ,    -1 , -1 , 33 , 35 , 37 , 39 , 41 , 43 , 45 ,    47 , 49 , 51 , 53 , 55 , 57 , 59 , 61 , -1 , -1,  -1 ],
#     [ -1 , -1 , 2  , 4  , 6  , 8  , 10 , 12 , 14 ,   16 , 18 , 20 , 22 , 24 , 26 , 28 , 29 , 30 ,    31 , 32 , 34 , 36 , 38 , 40 , 42 , 44 , 46 ,    48 , 50 , 52 , 54 , 56 , 58 , 60 , 62 , 63 , -1,  -1 ],
#     [ -1 , -1 , 130, 128, 126, 124, 122, 120, 118,   116, 114, 112, 110, 108, 106, 104, 102, 100,    98 , 96 , 94 , 92 , 90 , 88 , 86 , 84 , 82 ,    80 , 78 , 76 , 74 , 72 , 70 , 68 , 66 , 64 , -1,  -1 ],
#     [ -1 , -1 , 131, 129, 127, 125, 123, 121, 119,   117, 115, 113, 111, 109, 107, 105, 103, 101,    99 , 97 , 95 , 93 , 91 , 89 , 87 , 85 , 83 ,    81 , 79 , 77 , 75 , 73 , 71 , 69 , 67 , 65 , -1,  -1 ],
#     [ 132, 134, 136, 138, 140, 142, 144, 146, 148,   150, 152, 154, 156, 158, 160, 162, 164, 166,    168, 170, 171, 172, 174, 176, 178, 180, 182,    184, 186, 188, 190, 192, 194, 196, 198, 200, -1,  -1 ],
#     [ 133, 135, 137, 139, 141, 143, 145, 147, 149,   151, 153, 155, 157, 159, 161, 163, 165, 167,    169, -1 , -1 , 173, 175, 177, 179, 181, 183,    185, 187, 189, 191, 193, 195, 197, 199, 201, -1,  -1 ],
#     [ 270, 268, 266, 264, 262, 260, 258, 256, 254,   252, 250, 248, 246, 244, 242, 240, 238, 236,    234, -1 , -1 , 230, 228, 226, 224, 222, 220,    218, 216, 214, 212, 210, 208, 206, 204, 202, -1,  -1 ],
#     [ 271, 269, 267, 265, 263, 261, 259, 257, 255,   253, 251, 249, 247, 245, 243, 241, 239, 237,    235, 233, 232, 231, 229, 227, 225, 223, 221,    219, 217, 215, 213, 211, 209, 207, 205, 203, -1,  -1 ]
# ]

# wednesday demo

# grid = [
#     [ -1,  -1,  1 ,  3 ,  5 ,  7 ,  9 ,  11,  13,  15 ],
#     [ -1,  -1,  2 ,  4 ,  6 ,  8 ,  10,  12,  14,  16 ],
#     [ -1,  -1,  31,  29,  27,  25,  23,  21,  19,  17 ],
#     [ -1,  -1,  32,  30,  28,  26,  24,  22,  20,  18 ],
#     [ 33,  35,  37,  39,  41,  43,  45,  47,  49,  51 ],
#     [ 34,  36,  38,  40,  42,  44,  46,  48,  50,  52 ],
#     [ 71,  69,  67,  65,  63,  61,  59,  57,  55,  53 ],
#     [ 72,  70,  68,  66,  64,  62,  60,  58,  56,  54 ]
# ]

# analogue ins

# grid = [
# [ 1 ,  2 ,  3 ,  4 ,  5 ,  6 ,  7 ,  -1,  -1 ],
# [ 8 ,  9 ,  10,  11,  12,  13,  14,  15,  16 ],
# [ 17,  18,  19,  20,  21,  22,  23,  24,  25 ],
# [ 26,  27,  28,  29,  30,  31,  32,  33,  34 ]
# ]

grid = [
[1 ,  2 ,  3 ,  4 ,  5 ,  6 ,  7 ,  8 ,  9 ,  -1,  -1],
[10,  11,  12,  13,  14,  15,  16,  17,  18,  -1,  -1],
[19,  20,  21,  22,  23,  24,  25,  26,  27,  -1,  -1],
[28,  29,  30,  31,  32,  33,  34,  35,  36,  -1,  -1]
]

pixelOrder = []

for y, row in enumerate(grid):
    for x, pixelIndex in enumerate(row):
        if pixelIndex > 0:
            pixelOrder.append( (pixelIndex - 1, (x, y)) )

pixelOrder = sorted(pixelOrder, key=lambda p: p[0])

pairs = []

for p in pixelOrder:
    pairs.append('{ %s, %s }'%(p[1][0], p[1][1]))

print 'new int[][] { ' + ', '.join(pairs) + ' } '
