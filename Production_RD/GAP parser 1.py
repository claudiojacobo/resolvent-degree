import string

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

def string_parser(input_strings):
    content = [] # a list of lists, one for each block in the input
    for line in input_strings[1:]: # skip the first line
        line = line.strip()
        if line: # if there is content in the line, add it our active list
            content[-1].append(line.split())
        else: # otherwise, append a new list for the next block of data
            content.append([])
    return content
    # centralizer_strings, power_map_strings, char_table_strings = content

def centralizer_str_to_float(centralizer_str):
    """
    Reformats the centralizer_strings so that it contains arrays of floats instead of strings
    :return:
    """
    centralizer_float = list(centralizer_str)
    for line in centralizer_float:
        for i, char in enumerate(line):
            if char == '.':
                line[i] = 0.0
            else:
                line[i] = float(char)  # replace 'float' with whatever mathematical object we end up using
    return centralizer_float

def get_group_order(centralizers):
    """

    :return:
    """
    group_order = 1
    for line in centralizers:
        group_order = group_order * (line[0]**line[1])
    return group_order


def get_conjugacy_size(power_map_str, centralizer):
    """

    :param power_map_str:
    :param centralizer:
    :return:
    """
    conjugacy_sizes = {}
    for i in range(len(centralizer[0])):
        if i != 0:
            cl = 1
            # take a prime factorization and recover the relevant integer
            for line in centralizer:
                cl = cl * (line[0] ** line[i])
            conjugacy_sizes[power_map_str[0][i-1]] = cl
    return conjugacy_sizes


def get_conj_order(conj_class):
    """
    returns order of a conjugacy class given its name. NB: this only works when we have 26 conjugacy classes of the same order. (!!!)
    :return: Integer order of conjugacy class.
    """
    return int(conj_class.strip(str(string.ascii_lowercase)))
def get_primes(power_map_str):
    """
    Gets list of all primes smaller than the size of the largest conjugacy class.
    :return:
    """
    primes = []
    for j, row in enumerate(power_map_str):
        if j != 0:
            primes.append(int(row[0].strip('P')))
    return primes


primes = get_primes()
print(primes)


def get_power_map(power_map_str):
    """

    :return: dictionary of dictionaries associating conjugacy classes with their prime powers.
    """
    power_map = {} # the dict of dicts
    for i, conj_class in enumerate(power_map_str[0]):
        conj_power_dict = {} # the dict associated with each conjugacy class
        for j, prime in enumerate(primes):
            conj_power_dict[prime] = power_map_str[j+1][i+1] # +1 so we avoid the "labels" section of the table
        power_map[conj_class] = conj_power_dict
    return power_map



def evaluate_char(char, conj, n, power_map, power_map_str):
    m = n % get_conj_order(conj)
    prime_factorization = []
    i = 0
    if m == 0:
        return power_map_str[0][0]
    while i < len(primes):
        if m % primes[i] == 0:
            print(m)
            m = m/primes[i]
            prime_factorization.append(primes[i])
        else:
            i += 1
    curr_class = conj
    for num in prime_factorization:
        curr_class = power_map[curr_class][num]
    return curr_class # update once we have character class


print(evaluate_char(None, '6a', 531))





# print(get_power_map())
# print(get_conj_order("6a"))
# print(string.ascii_lowercase)
# print(get_conjugacy_size())





# print(centralizer_strings)
