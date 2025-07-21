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

    
    


def main(): 
    file_name = "Carmen-data-dump.json"
    print(get_data(file_name))



if __name__ == "__main__":
        main() 