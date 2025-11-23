"""
A collection of combinatorial power maps that allow for the general (i.e., in terms of q) calculation of the dimension of the 2nd, 3rd, and 
4th Symmetric powers of the smallest non-trivial irreducible representation of PSU(3,q).
"""
from sympy import sympify


class sym_object: 
    def __init__(self, modulus, power):
        self.power = power
        self.modulus = modulus
        self.q = var('q')
        self.d = gcd(3, self.modulus - 1)
        self.r = self.q-1
        self.s = self.q+1 
        self.t = self.q^2 + self.q + 1
        self.rp = self.r/self.d
        self.sp = self.s/self.d
        self.tp = self.t/self.d
        self.dp = (3-self.d)/2
        self.rpp = self.rp
        self.tpp = (self.tp - 1)/6 

        self.families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
        self.num_classes = {'1': 1, '2': 1, '3^l': self.d, '4^k': self.rp - 1, '5^k': self.rp - 1, "6'": 1 - self.dp, "6^klm": self.tpp - self.rpp, "7^k": self.tpp - self.rpp - self.dp, "8^k": 2*self.tpp}
        self.centralizers = {'1': self.q^3 * self.rp * self.r * self.s * self.t, '2': self.q^3 * self.rp, '3^l': self.q^2, '4^k': self.q*self.rp*self.r*self.s, '5^k': self.q*self.rp, "6'": self.r^2, "6^klm": self.rp*self.r, "7^k": self.rp*self.s, "8^k": self.tp}
        self.class_sizes = {key: (self.q^3 * self.rp * self.r * self.s * self.t) / val for key, val in self.centralizers.items()}
        self.character_val = {'1': self.q*self.s, '2': self.q, '3^l': 0, '4^k': self.s, '5^k': 1, "6'": 2, "6^klm": 2, "7^k": 0, "8^k": -1}
    
    def C_1_power(self):
        if self.power == 2:
            C1Counter = 1
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
        if self.power == 3:
            C1Counter = 1
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
        if self.power == 4:
            C1Counter = 1
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_2_power(self):
        if self.power == 2:
            C1Counter = 0
            C2Counter = 1
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if self.modulus % 2 == 0:
                C1Counter += 1
                C2Counter -= 1
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
        if self.power == 3:
            C1Counter = 0
            C2Counter = 1
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if self.modulus % 3 == 0:
                C1Counter += 1
                C2Counter -= 1
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
        if self.power == 4:
            C1Counter = 0
            C2Counter = 1
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if self.modulus % 2 == 0:
                C1Counter += 1
                C2Counter -= 1
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_3_power(self):
        if self.power == 2:
            C1Counter = 0
            C2Counter = 0
            C3Counter = self.d
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if self.modulus % 2 == 0:
                C2Counter += self.d
                C3Counter -= self.d
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
        if self.power == 3:
            C1Counter = 0
            C2Counter = 0
            C3Counter = self.d
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if self.modulus % 3 == 0:
                C1Counter += self.d
                C3Counter -= self.d
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
        if self.power == 4:
            C1Counter = 0
            C2Counter = 0
            C3Counter = self.d
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if self.modulus % 2 == 0:
                C1Counter += self.d
                C3Counter -= self.d
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_4_power(self):
        if self.power == 2:
            C1Counter = 0
            C4Counter = (self.r)/self.d-1
            C2Counter = 0
            C3Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if self.modulus % 2 == 1:
                C1Counter += 1
                C4Counter -= 1
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

        if self.power == 3:
            C1Counter = 0
            C4Counter = (self.r)/self.d-1
            C2Counter = 0
            C3Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if (self.modulus - 1) % 9 == 0: # going to need the mod we're dealing with to be divisible by 9
                C1Counter += 2
                C4Counter -= 2
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

        if self.power == 4:
            C1Counter = 0
            C4Counter = (self.r)/self.d-1
            C2Counter = 0
            C3Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if (self.modulus - 1) % 4 == 0: 
                C1Counter += 3
                C4Counter -= 3
            elif (self.modulus - 1) % 2 == 0:
                C1Counter += 1
                C4Counter -= 1
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_5_power(self):
        if self.power == 2:
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = (self.r)/self.d-1
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if self.modulus % 2 == 1:
                C2Counter +=1
                C5Counter -= 1
            if self.modulus % 2 == 0:
                C4Counter += (self.r)/self.d-1
                C5Counter -= (self.r)/self.d-1
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
            
        if self.power == 3:
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = (self.r)/self.d-1
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if (self.modulus-1) % 9 == 0: # need self.modulus divisible by 9
                C2Counter += 2
                C5Counter -= 2
            if self.modulus % 3 == 0:
                C4Counter += (self.r)/self.d-1
                C5Counter -= (self.r)/self.d-1 
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

        if self.power == 4:
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = (self.r)/self.d-1
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            if (self.modulus-1) % 2 == 0:
                C2Counter += 1
                C5Counter -= 1
            if (self.modulus-1) % 4 == 0:
                C2Counter += 2
                C5Counter -= 2
            if self.modulus % 2 == 0:
                C4Counter += (self.r)/self.d-1
                C5Counter-= (self.r)/self.d-1 
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_6_p_power(self):
        if self.power == 2:
            C6pCounter = 1-(3-self.d)/2
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
        if self.power == 3:
            C6pCounter = 0
            C1Counter = 1-(3-self.d)/2
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
        if self.power == 4:
            C6pCounter = 1-(3-self.d)/2
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 0
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_6_klm_power(self):
        if self.power == 2:
            if (self.modulus-1) % 12 in [1,3,5,7,9,11]:
                C4Counter = 0 
            if (self.modulus-1) % 12 in [2, 10]:
                total = 0 - ceil(self.r/4) + floor(self.r/6) + self.r/2  + ceil(floor(self.r/6)/2)
                C4Counter = total
            if (self.modulus-1) % 12 in [4, 8]:
                total = -1 * floor(self.r/4) + floor(self.r/6) + self.r/2 + floor((ceil(self.r/6) - 1)/2)
                C4Counter = total
            if (self.modulus-1) % 12 == 6:
                C4Counter = self.r/6 - 1
            if (self.modulus-1) % 12 == 0:
                C4Counter = self.r/6 - 1 
            return (0, 0, 0, C4Counter, 0, 0, self.tpp - self.rpp - C4Counter, 0, 0)

        if self.power == 3:
            C4Counter = 0
            a = (self.modulus - 1) % 12
            if a%3 != 0:
                pass
            if a%6 == 0:
                # Case 2a
                C4Counter +=  (ceil(2*self.r/9) - 1) - ceil(self.r/6) + 1
                # Case 3a
                C4Counter += floor((ceil(2*self.r/9) - 1)/2)
                # Case 2a, 3a diff of 2r/3
                C4Counter += ceil(self.r/9) - 1 
                C4Counter += floor((ceil(self.r/9) - 1)/2)

            if a%6 == 3:
                # Case 2a
                C4Counter += (ceil(2*self.r/9) - 1) - ceil(self.r/6) + 1
                # Case 3a
                C4Counter += floor((ceil(2*self.r/9) - 1)/2)
                # Case 2a, 3a diff of 2r/3
                C4Counter += ceil(self.r/9) - 1   
                C4Counter += ceil((ceil(self.r/9) - 1)/2)
                
            return (0, 0, 0, C4Counter, 0, 0, self.tpp - self.rpp - C4Counter, 0, 0)

        if self.power == 4:
            C4Counter = 0
            C1Counter = 0
            a = (self.modulus - 1) % 24 
            square_modulus = self.modulus % 12
            square_sym = sym_object(square_modulus, 2) 
            C4Counter += square_sym.C_6_klm_power()[3]
            if a % 4 != 0:
                pass
            elif a % 3 != 0:
                # Case 1a
                C4Counter += ceil(self.r/6) - 1
                # Case 1b
                C4Counter += ceil(self.r/2) - 1 - ceil(3*self.r/8) + 1
                # Case 2a
                C4Counter += ceil(self.r/4) - 1 - ceil(self.r/6) + 1
                # Case 2b
                C4Counter += ceil(7*self.r/12) - 1 - (floor(self.r/2) + 1) + 1 
                # Case 3a 
                if a % 8 == 0:
                    C4Counter += floor((ceil(self.r/4) - 1)/2)
                if a % 8 == 4:
                    C4Counter += ceil((ceil(self.r/4) - 1)/2)
                # Case 3b
                if a % 8 == 0:
                    C4Counter += ceil((ceil(self.r*7/12) - 1 - ceil(self.r/4) + 1)/2)
                if a % 8 == 4:
                    C4Counter += ceil((ceil(self.r*7/12) - 1 - ceil(self.r/4) + 1)/2)
                # diff of 3r/4
                # Case 1b
                C4Counter += ceil(self.r/6) - 1 - ceil(self.r/8) + 1 
                # Case 2a
                C4Counter += ceil(self.r/12) - 1
                # Case 2b
                C4Counter += ceil(self.r/4) - ceil(self.r/6) + 1 
                # Case 3a
                if a % 8 == 0:
                    C4Counter += floor(floor(self.r/12)/2)
                elif a % 8 == 4:
                    C4Counter += ceil(floor(self.r/12)/2)
                C4Counter -= 3
                C1Counter += 1
            elif a % 3 == 0:
                # Case 1a 
                C4Counter += ceil(self.r/12)
                # Case 2a
                C4Counter += ceil(self.r/4) - 1 - ceil(5*self.r/24) + 1
                # Case 3a
                if a % 8 == 0:
                    C4Counter += floor((ceil(self.r/4) - 1 - ceil(self.r/12) + 1)/2)
                elif a % 8 == 4:
                    C4Counter += ceil((ceil(self.r/4) - 1 - ceil(self.r/12) + 1)/2)
                # diff of 3r/4
                # Case 2a
                C4Counter += ceil(self.r/12) - 1
                # Case 3a 
                if a % 8 == 0:
                    C4Counter += floor(floor(self.r/12)/2)
                elif a % 8 == 4:
                    C4Counter += ceil(floor(self.r/12)/2)
                C4Counter -= 4
                C1Counter += 1
            return (C1Counter, 0, 0, C4Counter, 0, 0, self.tpp - self.rpp - C4Counter - C1Counter, 0, 0)

    def C_7_power(self):
        if self.power == 2:
            totalnum = (3*self.tpp - self.rpp - self.dp) 
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = totalnum
            C8Counter = 0
            if self.modulus % 2 != 0:
                C4Counter += (self.r)/(2*self.d)
                C7Counter = C7Counter - (self.r)/(2*self.d)
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

        if self.power == 3:
            totalnum = (3*self.tpp - self.rpp - self.dp)
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = totalnum
            C8Counter = 0
            if self.modulus % 3 == 2: # THIS MIGHT BE AN ISSUE??? Changed == 1 to == 2 here
                C1Counter += 1
                C7Counter -= 1
                C4Counter += (self.q - 2) # added a -2 here to ensure r total problem cases.
                C7Counter -= (self.q - 2) # added a -2 here to ensure r total problem cases.
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

        if self.power == 4:
            totalnum = (3 * self.tpp) - self.rpp - (3-self.d)/2
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = totalnum
            C8Counter = 0
            if self.modulus % 2 == 1:
                C4Counter += (self.r)/(2*self.d)
                C7Counter -= (self.r)/(2*self.d)
            if (self.modulus-1)%2 == 0 and (self.modulus-1)%4 != 0:
                C1Counter += 1
                C4Counter -= 1
            if self.modulus % 4 == 3: # changed 1 to 3 because I believe it's about r being 2 mod 4? Idk though, probably revert this. 
                C4Counter += 2*(self.r)/(2*self.d) # why do we have a 2 in the numerator and denominator?
                C7Counter -= 2*(self.r)/(2*self.d)
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

    def C_8_power(self):
        if self.power == 2:
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 2 * self.tpp
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

        if self.power == 3:
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 2 * self.tpp
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)

        if self.power == 4:
            C1Counter = 0
            C2Counter = 0
            C3Counter = 0
            C4Counter = 0
            C5Counter = 0
            C6pCounter = 0
            C6klmCounter = 0
            C7Counter = 0
            C8Counter = 2 * self.tpp
            return (C1Counter, C2Counter, C3Counter, C4Counter, C5Counter, C6pCounter, C6klmCounter, C7Counter, C8Counter)
    
    def get_power_map_counts(self):
        maps = {}
        families = ['1', '2', '3^l', '4^k', '5^k', "6'", "6^klm", "7^k", "8^k"]
        maps['1'] = dict(zip(families, self.C_1_power()))
        maps['2'] = dict(zip(families, self.C_2_power()))
        maps['3^l'] = dict(zip(families, self.C_3_power()))
        maps['4^k'] = dict(zip(families, self.C_4_power()))
        maps['5^k'] = dict(zip(families, self.C_5_power()))
        maps["6'"] = dict(zip(families, self.C_6_p_power()))
        maps["6^klm"] = dict(zip(families, self.C_6_klm_power()))
        maps["7^k"] = dict(zip(families, self.C_7_power()))
        maps["8^k"] = dict(zip(families, self.C_8_power()))
        mod_needed = {2: 12, 3: 36, 4: 72}
        for key in maps.keys():
            for key2 in maps:
                k = var('k')
                assume(k, 'integer')
                assume(k >= 0)
                
                if str(type(maps[key][key2].subs(q=(self.modulus + mod_needed[self.power]*k)))) == "<class 'sage.symbolic.expression.Expression'>":
                    maps[key][key2] = maps[key][key2].subs(q=(self.modulus + mod_needed[self.power]*k)).full_simplify().subs(k=(q-self.modulus)/mod_needed[self.power]).full_simplify()
                # print(total.subs(q=(modulus + 72*k)).full_simplify().subs(k=(q-modulus)/72).full_simplify())

        return maps
    def calc_sym_power(self):
        power_map = {}
        total = 0
        if self.power == 2:
            square_maps = self.get_power_map_counts()
            power_map = square_maps
            for family in self.families:
                total += self.class_sizes[family]*self.num_classes[family]*(self.character_val[family] ** 2)
                for fam2 in self.families: # iterate through the maps 
                    total += self.class_sizes[family]*self.character_val[fam2]*square_maps[family][fam2]
            total = (total/2)/(self.q^3 * self.rp * self.r * self.s * self.t)
        if self.power == 3:
            self_sym_squared = sym_object(self.modulus % 12, 2)
            square_maps = self_sym_squared.get_power_map_counts()
            cube_maps = self.get_power_map_counts()
            power_map = cube_maps
            for family in self.families:
                total += self.class_sizes[family]*self.num_classes[family]*(self.character_val[family] ** 3)
                for fam2 in self.families: # iterate through the square maps 
                    total += self.class_sizes[family]*self.character_val[fam2]* square_maps[family][fam2] * 3 * self.character_val[family]
                    total += self.class_sizes[family]*self.character_val[fam2]* cube_maps[family][fam2] * 2 
            total = (total/6)/(self.q^3 * self.rp * self.r * self.s * self.t)
        if self.power == 4:
            self_sym_squared = sym_object(self.modulus % 12, 2)
            square_maps = self_sym_squared.get_power_map_counts()
            self_sym_cubed = sym_object(self.modulus % 36, 3)
            cube_maps = self_sym_cubed.get_power_map_counts()
            fourth_maps = self.get_power_map_counts()
            power_map = fourth_maps
            for family in self.families:
                total += self.class_sizes[family]*self.num_classes[family]*(self.character_val[family] ** 4)
                for fam2 in self.families: # iterate through the square maps 
                    total += self.class_sizes[family]*self.character_val[fam2]* square_maps[family][fam2] * (self.character_val[family] ** 2) * 6
                    total += self.class_sizes[family]*(self.character_val[fam2]** 2) * square_maps[family][fam2] * 3 
                    total += self.class_sizes[family]*self.character_val[fam2]* cube_maps[family][fam2] * self.character_val[family] * 8
                    total += self.class_sizes[family]*self.character_val[fam2]*fourth_maps[family][fam2] * 6
            total = (total/24)/((self.q)^3 * self.rp * self.r * self.s * self.t)
        return (total.full_simplify(), power_map)

def group_dict_indices(dict_list):
    """
    Groups indices of unique dictionaries from a list.

    Iterates through a list of dictionaries and returns a new list.
    Each item in the returned list is a sub-list containing:
    [unique_dictionary, [list_of_indices]]

    This function correctly handles dictionaries with unhashable items (like lists)
    by using direct comparison (==) instead of attempting to hash them.

    Args:
        dict_list (list): A list of dictionaries.

    Returns:
        list: A list of lists, where each inner list contains a
              unique dictionary and a list of its indices.
    """
    # This list will hold our final [dict, [indices]] pairs
    grouped_list = []

    # We need a way to quickly find if we've already seen a dictionary.
    # `grouped_list` itself will store the unique dictionaries found so far.
    # We'll search it to see if a dictionary is already logged.

    for index, current_dict in enumerate(dict_list):
        found = False
        
        # Check if we have already seen this exact dictionary
        for item in grouped_list:
            unique_dict = item[0]
            indices_list = item[1]
            
            if current_dict == unique_dict:
                # We found it! Add the current index to its list
                indices_list.append(index)
                found = True
                break  # Stop searching for this dictionary
        
        if not found:
            # This is a new, unique dictionary.
            # Add it to our grouped_list with its first index.
            grouped_list.append([current_dict, [index]])

    return grouped_list

power_maps = []
for i in range(12):
    group = sym_object(i, 2)
    data = group.calc_sym_power()
    power_maps.append(data[1])
    print(f"2nd sym power for q = {i} mod 12: {data[0]}")

print(f"for 2nd power the power maps are {group_dict_indices(power_maps)}")
print(len(group_dict_indices(power_maps)))

power_maps = []
for i in range(36):
    group = sym_object(i, 3)
    data = group.calc_sym_power()
    power_maps.append(data[1])
    print(f"3rd sym power for q = {i} mod 36: {data[0]}")
    
print(f"for 3rd power the power maps are {group_dict_indices(power_maps)}")
print(len(group_dict_indices(power_maps)))

power_maps = []
for i in range(72):
    group = sym_object(i, 4)
    data = group.calc_sym_power()
    power_maps.append(data[1])
    print(f"4th sym power for q = {i} mod 72: {data[0]}")

print(f"for 4th power the power maps are {group_dict_indices(power_maps)}")
print(len(group_dict_indices(power_maps)))

