import numpy as np

class ComplexNumber:
    real = 0
    imaginary = 0
    val = [0,0]

    def __init__(self, real, imaginary=0):
        self.real = real
        self.imaginary = imaginary
        self.val = [self.real, self.imaginary]
        # self.conjugate = [self.real, -1 * self.imaginary]

    def conjugate(self):
        return ComplexNumber(self.real, self.imaginary)

    def mult(self, comp2):
        #print(self.real, self.imaginary)
        #print(comp2.real, comp2.imaginary)
        #print(ComplexNumber(self.real * comp2.real - self.imaginary * comp2.imaginary, self.real * comp2.imaginary + self.imaginary * comp2.real).real, ComplexNumber(self.real * comp2.real - self.imaginary * comp2.imaginary, self.real * comp2.imaginary + self.imaginary * comp2.real).imaginary)
        #print("-")
        return ComplexNumber(self.real * comp2.real - self.imaginary * comp2.imaginary, self.real * comp2.imaginary + self.imaginary * comp2.real)

    def add(self, comp2):
        #print(self.real, self.imaginary)
        # print(comp2.real, comp2.imaginary)
        return ComplexNumber(self.real + comp2.real, self.imaginary + comp2.imaginary)

class Character:
    def __init__(self, class_size, ch_table, ch):
        self.class_size = class_size
        self.ch_table = ch_table
        self.ch = ch
"""
    def decompose_rep(class_size, ch_table, ch):
        for i in ch_table:
            for j in ch_table[i - 1]:
                ch_table[i] * ch[i - 1] *
"""



class Character:
    def __init__(self, class_size, ch_table, ch):
        self.class_size = class_size
        self.ch_table = ch_table
        self.ch = ch
        self.order = 0
        for l in class_size:
            self.order += l
    def herm_product(self, row, ch_input):
        prod = ComplexNumber(0,0)
        for i in range(len(ch_input)):
            prod = prod.add(ComplexNumber(self.class_size[i], 0).mult(ch_input[i].mult(self.ch_table[row][i].conjugate())))
        return prod
    def decompose_rep(self):
        lst = []
        for row in range(len(self.ch_table)):
            # for j in range(len(self.class_size)):
            product = self.herm_product(row, self.ch)
            print(product.real, product.imaginary)
            lst.append(int(product.real / self.order))
        return lst


class_size = [1, 3, 2]
ch_table = [[ComplexNumber(1, 0), ComplexNumber(1, 0), ComplexNumber(1, 0)], [ComplexNumber(1, 0), ComplexNumber(-1, 0), ComplexNumber(1, 0)], [ComplexNumber(2, 0), ComplexNumber(0, 0), ComplexNumber(-1, 0)]]
ch = [ComplexNumber(2, 0), ComplexNumber(0, 0), ComplexNumber(-1, 0)]

my_character = Character(class_size, ch_table, ch)

list_of_multiplicities = my_character.decompose_rep()

print(list_of_multiplicities)