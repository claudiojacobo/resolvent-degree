"""
Given a character table and a representation, we find the representation's decomposition into a product of irreducible
representations.
"""
import math


class Character:
    def __init__(self, class_size, ch_table):
        self.class_size = class_size
        self.ch_table = ch_table
        self.order = 0
        for cl in class_size:
            self.order += cl

    def herm_product(self, row, ch_input):
        """
        Takes the hermitian product of the input representation by a row in the character table.
        :param row: An integer indicating the relevant row of the character table.
        :param ch_input: The character of the relevant representation.
        :return: A complex number indicating
        """
        prod = complex(0,0)
        for i in range(len(ch_input)):
            prod += self.class_size[i] * ch_input[i] * complex(self.ch_table[row][i].real,
                                                               -1 * self.ch_table[row][i].imag) # hermitian
        return prod

    def decompose_rep(self, ch):
        """
        decomposes a representation into a direct sum of irreducible representations
        :param ch: character of the rep being decomposed
        :return: list of multiplicities of irreducible reps, in the same order as the character table.
        """
        output = []
        for row in range(len(self.ch_table)):
            product = self.herm_product(row, ch)
            output.append(int(product.real / self.order))
        return output

    
"""
class_size = [1, 3, 2]
ch_table = [[complex(1, 0), complex(1, 0), complex(1, 0)],
                [complex(1, 0), complex(-1, 0), complex(1, 0)],
                [complex(2, 0), complex(0, 0), complex(-1, 0)]]
ch = [complex(2, 0), complex(0, 0), complex(-1, 0)]
"""

class_size = [1, 4, 4, 3]
ch_table = [[complex(1, 0), complex(1, 0), complex(1, 0), 1],
                [1, complex(-1/2, math.sqrt(3)/2), complex(-1/2, -1 * math.sqrt(3)/2), 1],
                [1,complex(-1/2, -1 * math.sqrt(3)/2),complex(-1/2, math.sqrt(3)/2), 1],
                [3, 0, 0, -1]]
# ch = [1,complex(-1/2, -1 * math.sqrt(3)/2),complex(-1/2, math.sqrt(3)/2)]
# ch = [2, -1, -1]
ch_one = [3, 0, 0, -1]
ch_two = [3, 0, 0, -1]
ch_three = [2, -1, -1, 2]

my_character = Character(class_size, ch_table)
print(my_character.decompose_rep(ch_one))
print(my_character.decompose_rep(ch_two))
print(my_character.decompose_rep(ch_three))
