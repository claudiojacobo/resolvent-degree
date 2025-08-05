import json

def get_data(file_name): 
    data = []
    # Turn the json file into a list of dictionaries
    with open(file_name) as f: #i think this also closes file...check. 
        for line in f:
            data.append(json.loads(line))
    min_bounds = {}
    for entry in data: 
        group = entry["group"]
        bound = entry["bound"]
        ch_index = entry["character_index"]
        invariants = entry["invariants"]
        if group not in min_bounds or bound < min_bounds[group]["bound"]:
                min_bounds[group] = {"bound": bound, "character_index": ch_index, "invariants": invariants}

    for group in min_bounds: 
        print(
            f"Group: {group} \n"
            f" Min bound: {min_bounds[group]['bound']} \n"
            f" Character index: {min_bounds[group]['character_index']} \n"
            f" Invariants: {min_bounds[group]['invariants']} \n\n"
        )
    return data 

# want to make a graph where x is q...we want to track how many invariants of size 4 on the y axis and have powers of each other be the same color. 
# want to have the y axis be the invariants and the size of the data to be the number of occurences and then have the color be the prime 
# how to color code it so that the primes of different powers have the same color...want to decide if color is based on how many different primes we go to, or if the primes are always the same color 

def get_prime(group_name): 
    section = group_name.split('(')[1]
    str_prime = section.split(',')[0]
    prime = int(str_prime)
    return prime
def get_degree(group_name): 
    section = group_name.split(',')[1]
    str_degree = gropup_name.split(')')[0]
    degree = int(str_degree)
    return degree 
def get_points(data): 
    points = []
    for entry in data: 
        if invariant == 4: 
            num_deg4 += 1
    return points 
"""       
def plot(points): #want x to be prime_power and y to be degree 
    prime_powers = [] #need to identify btw distinct primes and their powers 
    colors = {}
    color_spec = plt.cm.tab20.colors 
    x_axis = []
    y_axis = []
    pt_size = []
    prime_color = []
    for p in #not sure 
        if p not in prime_powers: 
            prime_powers.appemd(p) 
        else: 
            pass 
        #plt.com gets the colors from matplot, tab20 gets 20 colors, update . colors gives tuples w values btw o and 1 
    for i in prime_powers: # some other list? 
        colors[prime] = color_spec[i % len(color_spec)]

def get_char_sym(a): 
    load("group_characters.sage")
    unicorn = get_unicorn(a) 
    load("psu_characters.sage")
    for primes in get_unicorn(a):
        power = int(primes[-1][-1])
        print(power) 
        prime = int(primes[-1][0])
        print(prime) 
        q = int(prime ** power)
        print("this is q", q) 
        G = GroupCharacters(3,q)
        print(f'Symmetric powers for PSU(3, {q} G.sym_power(chi,k) \n')  
print(get_char_sym(7)) 
"""

def get_tex(file_name, latex_file):  
    data = []
    # Turn the json file into a list of dictionaries
    with open(file_name) as f: 
       for line in f: 
        entry = json.loads(line)
        if entry.get("character_index") == "0": 
            data.append(entry) 
    with open(latex_file, "w") as f:
        for entry in data:
            group = entry["group"]
            pair = group.split('(')[1].split(')')[0] # 'a,b'
            primes_str = pair.split(',') # ['a','b']
            prime = int(primes_str[0]) 
            exp = int(primes_str[1])
            q = prime ** exp
            dim_v = entry["rep-degree"]
            bound = entry["bound"]
            invariants_dict = str(entry["invariants"])
            invariants = invariants_dict[1:-1]
            # invariants = invariants.replace(' ', '')
            limitation = entry["limitation"]
            miu = 50 if q == 5 else q ** 3 + 1
            rd_miu = " "
            molien = " " 
            if dim_v >= miu: 
                f.write(f"\\hline\n \rowcolor{c1} {q} & {dim_v} & {bound} & {molien} & {invariants} & {miu} & {rd_miu} \\\\\n")
                return True 
            if limitation == "versality-degree":  
                f.write(f"\\hline\n \rowcolor{c6} {q} & {dim_v} & {bound} & {molien} & {invariants} & {miu} & {rd_miu} \\\\\n")
                retrun True 
            if dim_v >= miu and limitation == "versality-degree"  == True: 
                

            
% c1 = stopped by deg >= mu(G) % does this ever happen?
% c6 = stopped by RD(deg)  
% c5 = both of the above
% c4 = smallest permutation rep beats the bound from the Game

            f.write(f"\\hline\n{q} & {dim_v} & {bound} & {molien} & {invariants} & {miu} & {rd_miu} \\\\\n")
def get_color_tex(file_name, latex_file): 
    data = []
    # Turn the json file into a list of dictionaries
    with open(file_name) as f: 
       for line in f: 
        entry = json.loads(line)
        if entry.get("character_index") == "0": 
            data.append(entry) 
    with open(latex_file, "w") as f:
        for entry in data: 
            group = entry["group"]
            pair = group.split('(')[1].split(')')[0] # 'a,b'
            primes_str = pair.split(',') # ['a','b']
            prime = int(primes_str[0]) 
            exp = int(primes_str[1])
            q = prime ** exp
            dim_v = entry["rep-degree"]
            bound = entry["bound"]
            invariants_dict = str(entry["invariants"])
            invariants = invariants_dict[1:-1]
            # invariants = invariants.replace(' ', '')
            miu = 50 if q == 5 else q ** 3 + 1
            rd_miu = " "
            molien = " " 
            f.write(f"\\hline\n{q} & {dim_v} & {bound} & {molien} & {invariants} & {miu} & {rd_miu} \\\\\n")

def main(): 
    file_name = "Carmen-data-dump.json"
    latex_file = "latex_2.txt"
    get_tex(file_name, latex_file) 
    print(get_tex(file_name, latex_file))



if __name__ == "__main__":
        main() 