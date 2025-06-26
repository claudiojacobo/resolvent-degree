
'''character_table: a list of dictionaries, one for each row of the character table, whose
keys are conjugacy class labels and whose values are the value of the character at that class (integers for now) '''

char_table_strings = [['X.1', '1', '-1', '1'], ['X.2', '2', '.', '-1'], ['X.3', '1', '1', '1']] 
power_map_strings = [['1a', '2a', '3a'], ['2P', '1a', '1a', '3a'], ['3P', '1a', '2a', '1a']] 

def char_table(power_map_strings,char_table_strings): 
    unnamed_list = []
    conj = power_map_strings[0]
    # print(char_table_strings[row])
    for i, row in enumerate(char_table_strings): 
        unnamed_dict = {}
        for j, data in enumerate(row): 
            if j != 0:
                unnamed_dict[conj[j-1]] = char_table_strings[i][j]
            # print(char_table_strings[row][column])
        unnamed_list.append(unnamed_dict)
    print(unnamed_list)
    return unnamed_list

char_table(power_map_strings,char_table_strings)

