import string


class Group:
    centralizer_strings = None
    power_map_strings = None
    char_table_strings = None

    centralizers = None
    group_order = None
    conjugacy_sizes = None
    primes = None
    power_map = None
    char_table = None

    def __init__(self, input_strings):
        self.input_strings = input_strings
        self.string_parser()
        self.centralizer_to_float()
        self.initialize_group_order()
        self.initialize_conjugacy_size()
        self.initialize_primes()
        self.initialize_power_map()
        self.initialize_char_table()

    def string_parser(self):
        content = []  # a list of lists, one for each block in the input

        for line in input_strings[1:]:  # skip the first line
            line = line.strip()
            if line:  # if there is content in the line, add it our active list
                content[-1].append(line.split())
            else:  # otherwise, append a new list for the next block of data
                content.append([])
        self.centralizer_strings, self.power_map_strings, self.char_table_strings = content

    def centralizer_to_float(self):
        self.centralizers = list(self.centralizer_strings)
        for line in self.centralizers:
            for i, char in enumerate(line):
                if char == '.':
                    line[i] = 0.0
                else:
                    line[i] = float(char)  # replace 'float' with whatever mathematical object we end up using

    def initialize_group_order(self):
        self.group_order = 1
        for line in self.centralizers:
            self.group_order *= (line[0] ** line[1])

    def initialize_conjugacy_size(self):
        """
        :return:
        """
        self.conjugacy_sizes = {}
        for i in range(len(self.centralizers[0])):
            if i != 0:
                cl = 1
                # take a prime factorization and recover the relevant integer
                for line in self.centralizers:
                    cl = cl * (line[0] ** line[i])
                self.conjugacy_sizes[self.power_map_strings[0][i - 1]] = cl

    def initialize_primes(self):
        """
        Gets list of all primes smaller than the size of the largest conjugacy class.
        :return:
        """
        self.primes = []
        for j, row in enumerate(self.power_map_strings):
            if j != 0:
                self.primes.append(int(row[0].strip('P')))

    def initialize_power_map(self):
        """

        :return: dictionary of dictionaries associating conjugacy classes with their prime powers.
        """
        self.power_map = {}  # the dict of dicts
        for i, conj_class in enumerate(self.power_map_strings[0]):
            conj_power_dict = {}  # the dict associated with each conjugacy class
            for j, prime in enumerate(self.primes):
                conj_power_dict[prime] = self.power_map_strings[j + 1][i + 1]  # +1 so we avoid the "labels" section of the table
            self.power_map[conj_class] = conj_power_dict
        return self.power_map

    def evaluate_char(self, char, conj, n):
        """

        :param char: character dict
        :param conj:
        :param n:
        :return:
        """
        m = n % get_conj_order(conj)
        prime_factorization = []
        i = 0
        if m == 0:
            return char[self.power_map_strings[0][0]]
        while i < len(self.primes):
            if m % self.primes[i] == 0:
                print(m)
                m = m / self.primes[i]
                prime_factorization.append(self.primes[i])
            else:
                i += 1
        curr_class = conj
        for num in prime_factorization:
            curr_class = self.power_map[curr_class][num]

        return char[curr_class]  # update once we have character class

    def initialize_char_table(self):
        self.char_table = []
        conj = self.power_map_strings[0]
        # print(char_table_strings[row])
        for i, row in enumerate(self.char_table_strings):
            char_dict = {}
            for j, data in enumerate(row):
                if j != 0:
                    char_dict[conj[j - 1]] = self.char_table_strings[i][j]
                # print(char_table_strings[row][column])
            self.char_table.append(char_dict)





input_strings = ['CT2',
 '',
 '     2  3  2  3  1  1  2  .',
 '     3  1  1  .  1  1  .  .',
 '     5  1  .  .  .  .  .  1',
 '',
 '       1a 2a 2b 3a 6a 4a 5a',
 '    2P 1a 1a 1a 3a 3a 2b 5a',
 '    3P 1a 2a 2b 1a 2a 4a 5a',
 '    5P 1a 2a 2b 3a 6a 4a 1a',
 '',
 'X.1     1 -1  1  1 -1 -1  1',
 'X.2     4 -2  .  1  1  . -1',
 'X.3     5 -1  1 -1 -1  1  .',
 'X.4     6  . -2  .  .  .  1',
 'X.5     5  1  1 -1  1 -1  .',
 'X.6     4  2  .  1 -1  . -1',
 'X.7     1  1  1  1  1  1  1']


def get_conj_order(conj_class):
    """
    returns order of a conjugacy class given its name. NB: this only works when we have 26 conjugacy classes of the same order. (!!!)
    :return: Integer order of conjugacy class.
    """
    return int(conj_class.strip(str(string.ascii_lowercase)))


CT2 = Group(input_strings)
print(CT2.evaluate_char(CT2.char_table[0], '2a', 9))




# print(get_power_map())
# print(get_conj_order("6a"))
# print(string.ascii_lowercase)
# print(get_conjugacy_size())





# print(centralizer_strings)
