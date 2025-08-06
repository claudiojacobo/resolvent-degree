load("helper_functions.sage")
load("group_characters.sage")
class PSU_Characters(GroupCharacters): 
        def __init__(self, n, q):
            # Get schur cover
            if gcd(n,q+1) != 1:
                tup = self.get_schur_cover(n,q)
                G = eval(f"libgap.PerfectGroup({tup[0]}, {tup[1]})")
            else:
                G = eval(f"libgap.PSU({n}, {q})")
            self.name = f"PSU({n},      {q})"
            ct = G.CharacterTable() # We can add a custom generic character table from our lit. rev. if neccessary
            self.classes = libgap.ClassNames(ct).sage()
            r = len(self.classes)

            # parse orders of each conjugacy class representative
            orders = ct.OrdersClassRepresentatives().sage()
            self.class_order = { self.classes[i]:orders[i] for i in range(r)}

            # parse centralizer orders
            centralizers = ct.SizesCentralizers().sage()
            self.centralizer_order = { self.classes[i]:centralizers[i] for i in range(r) }
            self.group_order = centralizers[0]
 
            # load necessary power maps
            largest_order = max(orders)
            self.primes = primes_up_to(largest_order)
            self.power_map = { g:{} for g in self.classes }
            for p in self.primes:
                for i in range(len(self.classes)):
                    self.power_map[self.classes[i]][p] = self.classes[ct.PowerMap(p).sage()[i]-1]

            # sort characters by degree
            ct = sorted(ct.Irr().sage(), key=lambda x:x[0])
            self.characters = [ { self.classes[i]:chi[i] for i in range(r) } for chi in ct]

            # Calculate minimal perm group
            if n == 3: 
                if q == 5:
                    self.minimal_perm = 50
                else:
                    self.minimal_perm = q^3 + 1
            if n == 4:
                self.minimal_perm = (q+1)(q^3 + 1)
            elif q != 2: # Let's just avoid the q = 2 case for now
                self.minimal_perm = (q^n -(-1)^n) * (q^(n-1) - (-1)^(n-1))/(q^2 - 1) # from https://arxiv.org/pdf/1301.5166
                
        def get_schur_cover(self, n, q):
            # Initialize GAP through Sage
            gap = Gap()

            # Load packages
            gap.eval('LoadPackage("atlasrep");')
            gap.eval('LoadPackage("perfectgroups");')

            # Define target group - use local variable assignment
            gap.eval(f"G := PSU({n}, {q});")
            gap.eval('target := G;')

            # Set parameters
            size = get_PSU_order(n,q)
            gap.eval(f"size := {size};")
            gap.eval(f'SchurM := {gcd(n, q + 1)} ;')
            gap.eval('N := size * SchurM ;')
            gap.eval('num := NumberPerfectGroups(N);')
            gap.eval('found := false;')
            if gap.eval('num') == "fail":
                raise Exception("size of Schur cover was too large")
            # Search through groups
            for i in range(1, int(gap.eval('num')) + 1):
                gap.eval(f'G := PerfectGroup(N, {i});')
                gap.eval('H := Center(G);')
                gap.eval('Q := G/H;')
                if gap.eval('IsomorphismGroups(Q, target) <> fail;') == 'true':
                    return (int(gap.eval("N")), i)
                else:
                    raise Exception("No suitable group found.")


G = PSU_Characters (2, 37)
print("2, 37")
for character in G. characters:
    print(G. the_game (character, 7))
H = GroupCharacters ("PSU(2, 37)")
print(" normal 2, 37")
for character in H. characters:
    print(H. the_game (character, 7))
G. display()
H. display()