load("group_characters.sage")
class Suzuki_Characters(GroupCharacters): 
        def __init__(self, q):
            self.name = f"Suzuki({q})"
            ct = libgap.CharacterTable("Suzuki", q)
            self.classes = libgap.ClassNames(ct).sage()
            r = len(self.classes)

            # parse orders of each conjugacy class representative
            orders = ct.OrdersClassRepresentatives().sage()
            self.class_order = { self.classes[i]:orders[i] for i in range(r) }

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

            # this is likely a bottleneck
            self.minimal_perm = q ** 2 + 1 # from https://arxiv.org/pdf/1301.5166