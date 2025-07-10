"""
File used for testing and running our production code 
"""
load("group_characters.sage")
load("suzuki_characters.sage")
load("psu_characters.sage")
load("helper_functions.sage")

import json
import os
import time
from datetime import datetime

def save_output(data):
    with open("RD-bounds.json", "a") as f:
        f.write(json.dumps(data) + "\n")

'''
previous in case we don't like new version
for q in [2]:
    G = GroupCharacters(f"PSU(3, {q})")
    result = G.the_game(G.characters[1],10)
    save_output(result)
'''

def check_previous_runs(): 
    # retrieve a list of the q's we have in .json by checking string
    seen = set()
    if not os.path.exists("RD-bounds.json"):
        return seen 
    with open("RD-bounds.json","r") as f: 
        for line in f: 
            try: 
                if f"PSU(3, " in line:
                    q = line.split("PSU(3, ")[1].split(")")[0].strip()
                    q = int(q)
                    seen.add(q)
            except (IndexError, ValueError): 
                pass
    return seen

"""
this doesnt work yet mb
"""

def run_with_time(q): 
    g_name = f"PSU(3, {q})" 
    results = {"group": g_name} 

    try: 
        start_time = time.time()
        G = GroupCharacters(group_name)
        output = G.the_game(G.characters[1], 10) 
        result.update(output) 
        result["Status"] = "Success!" 
    except MemoryError: 
        result["status"] = "Ran out of memory"
    except Exception as e: 
        result["status"] = "Failed" 
        result["notes"] = f"{e}" 
    end_time = time.time()
    result["approx_run_length"] = round (end_time - start_time, 2) 
    result["time"] = datetime.now().isoformat()

    with open("RD-bounds.json", "a") as f: 
        f.write(json.dumps(result) + "\n")


for q in [3]: 
    seen = check_previous_runs()
    if q in seen: 
        print(f"We already ran q = {q} silly") 
    else: 
        print(f"Now running q = {q}, hold please!")
        G = GroupCharacters(f"PSU(3, {q})")
        result = G.the_game(G.characters[1],10)
        #run_with_time(q) 
        save_output(result)


        