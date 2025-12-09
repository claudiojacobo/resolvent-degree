'''

Running the following, e.g. by entering 'sage compute_molien.sage' while
    in the proper directory, lets you pick a sporadic group G and then either:

1. Invokes GAP to compute the Molien series as a rational function, 
    prints the numerator p_G(z) and the denominator q_G(z), and stores 
    these in the file output/G_output.txt.
2. Loads the data for G from the GAP character table library, saved in
    the file data/G_data.txt, computes the first 20 coefficients of the
    molien series, and stores them in the file output/G_output.txt.

Outcome 1 happens when G = M11, M12, M22, M23, M24, Co3, Co2, Co1, J1,
    J2, J3, Suz, HS, McL, Ru, or He; outcome 2 happens when G = J4, Fi22, 
    Fi23, Fi24', HN, Th, O'N, Ly, B, and M.

Note: The data files for Fi24' and O'N are the character tables of the
    schur covers a.G; for the remaining groups – J4, Fi22, Fi23, HN, Th,
    Ly, B, and M — the data files are just the character tables of G.

'''


# recursively compute g^n using the power map data as far as we can
#	returns (g^b,a) where ab=n and gcd(a,|G|)=1
def power(g,n):

	# find i so that |g| = int(g[:i]), then reduce n modulo |g|
	for i in range(len(g)):
		if g[i].isalpha():
			break
	n = n%int(g[:i])

	# trivial cases
	if n == 0:
		return (class_name[0],1)
	elif n == 1:
		return (g,1)

	# check primes we have power map data for
	for p in primes:
		if n%p == 0:
			return power(maps[g][p],n//p)

	# if we get here, n must be coprime to |G|
	return (g,n)

# evaluate chi on g^n
def eval_chi(g,n):

	# make sure n is coprime to |G|
	(g,n) = power(g,n)

	# use the algebraic conjugacy operator to compute chi(g^n)
	return eval(chi[g].replace('z','(z**{})'.format(n)))

# compute the invariant dimension of sym^n chi, returned as an int
def invariant_dim(n):

	sum = 0
	for g in class_name:
		A = []
		for i in range(n):
			A.append([ (-1)**(j-1)*eval_chi(g,j) for j in range(i+1,0,-1) ])
			if i+1<n:
				A[i] += [i+1] + [0]*(n-i-2)
		sum += det(matrix(A))*cc[g]
	sum /= group_size*factorial(n)

	return sum

# for debugging, computes <V⊗...⊗V,V⊗...⊗V> where ... is k times
def norm(k):

	sum = 0
	for g in class_name:
		sum += eval_chi(g,k)*eval_chi(g,k).conjugate()*cc[g]
	sum /= group_size

	return sum 

# multi-argument least common multiple
def lcmm(*args):
    return reduce(lcm, args)

# extract smallest prime factor of n, or 1 if a unit
def smallest_factor(n):
	if abs(n) < 2:
		return 1
	return factor(n)[0][0]

# print the main menu!
print('Indicate the desired group: ')
print('a) Mathieu11 (M11)')
print('b) Mathieu12 (M12)')
print('c) Mathieu22 (M22)')
print('d) Mathieu23 (M23)')
print('e) Mathieu24 (M24)')
print('f) Janko1 (J1)')
print('g) Janko2 (J2)')
print('h) Janko3 (J3)')
print('i) Janko4 (J4)')
print('j) Conway3 (Co3)')
print('k) Conway2 (Co2)')
print('l) Conway1 (Co1)')
print('m) Fischer22 (Fi22)')
print('n) Fischer23 (Fi23)')
print('o) Fischer24 (Fi24\')')
print('p) Suzuki (Suz)')
print('q) Higman—Sims (HS)')
print('r) McLaughlin (McL)')
print('s) Rudvalis (Ru)')
print('t) Held (He)')
print('u) Harada-Norton (HN)')
print('v) Thompson (Th)')
print('w) O\'Nan (O\'N)')
print('x) Lyon (Ly)')
print('y) Baby (B)')
print('z) Monster (M)')
G = input('>> ').lower()

if G[0].isalpha():

	if G[0] in 'imnouvwxyz': # compute coefficients manually

		chi_num = 2
		if G[0] == 'i':
			G = 'J4'
		elif G[0] == 'm':
			G = 'Fi22'
		elif G[0] == 'n':
			G = 'Fi23'
		elif G[0] == 'o':
			G = 'Fi24\''
			chi_num = 109
		elif G[0] == 'u':
			G = 'HN'
		elif G[0] == 'v':
			G = 'Th'
		elif G[0] == 'w':
			G = 'O\'N'
			chi_num = 31
		elif G[0] == 'x':
			G = 'Ly'
		elif G[0] == 'y':
			G = 'B'
		elif G[0] == 'z':
			G = 'M'

		# open and skip few lines of file
		f = open('data/' + G + '_data.txt','r')
		f.readline()
		f.readline()

		# first chunk of data teaches us prime divisors of G and centralizer sizes
		primes = []
		centralizer = []
		flag = True
		while True:
			l = f.readline().split()
			if flag: # after reading the first line, we know how many classes there are
				N = len(l)-1
				centralizer = [1]*N
				flag = False
			if len(l) == 0: # finished reading the first chunk
				break
			p = int(l[0])
			for i in range(N):
				if l[i+1] != '.': # gap has a funny way of writing zero
					centralizer[i] *= p**int(l[i+1])
			primes.append(p)

		# next chunk of data names conjugacy classes and gives power map data
		class_name = f.readline().split()
		maps = { s:{} for s in class_name } # dictionary of dictionaries!
		for p in primes:
			l = f.readline().split()[1:]
			for i in range(N):
				maps[class_name[i]][p] = l[i]

		# record the group and conjugacy class sizes before proceeding
		group_size = centralizer[0]
		cc = { class_name[i]:group_size//centralizer[i] for i in range(N) }

		# scan ahead to desired row in character table
		f.readline()
		chi_num = 'X.' + str(chi_num-1)
		while True:
			if f.readline().split()[0] == chi_num:
				break
		chi_row = f.readline().split()[1:]

		# scan through remainder of characters
		while True:
			if len(f.readline().split()) == 0:
				break

		# scan through chi_row and see what algebraic symbols we need
		keys = set([])
		for s in chi_row:
			s = ''.join(c for c in s if c.isalpha())
			if len(s)>0:
				keys.add(s)

		# if we saw symbols to replace, do it; otherwise, character is Z-valued
		if len(keys)>0:
			
			# scan symbol codes, store relevant ones in a dictionary
			symbols = {}
			while True:
				l = f.readline()
				if not l:
					break

				# key is symbol (like 'A') and value is a string (like '342*E(3)')
				#	remember that E(n) denotes e^(2pi*i/n)
				l = l.split('=')
				k = l[0][:-1]
				if k in keys:
					symbols[k] = l[1][1:-1].replace('^','**')

			keys = list(keys)
			keys.sort(key=len, reverse=True) # do this to avoid replacing 'A' before 'AB'

			# walk through symbols to replace, first to determine ambient field
			cyclo = set([]) # keep track of all the E(n) we need
			for k in keys: 
				I = [i for (i,c) in enumerate(symbols[k]) if c == '(']
				J = [j for (j,c) in enumerate(symbols[k]) if c == ')']	
				for (i,j) in list(zip(I,J)):
					cyclo.add(int(symbols[k][i+1:j])) # extract the n from 'E(n)'

			# define the field we will work in
			d = lcmm(*cyclo)
			K.<z> = CyclotomicField(d)

			# walk through symbols and actually replace this time
			for k in keys:
				i = 0
				while 'E' in symbols[k]:
					i = symbols[k].index('E')
					j = i+symbols[k][i:].index(')')
					n = int(symbols[k][i+2:j]) # again, extract the n from 'E(n)'

					# replace E(n) with z^(d/n), where z = E(d)
					symbols[k] = symbols[k][:i] + '(z**' + str(d//n) + ')' + symbols[k][j+1:]

				# tidy up; python doesn't like ^
				symbols[k] = ('(' + str(eval(symbols[k])) + ')').replace('^','**')

		f.close()

		# now we can actually record the character as a dictionary; store values as strings
		chi = {}
		for i in range(N):
			if chi_row[i][0] == '.':
				chi[class_name[i]] = '0'
			else:
				chi[class_name[i]] = chi_row[i].replace('*','&') # * denotes a Galois conjugate; flag with & instead
				for k in keys: # if there are keys, replace them with expressions in z
					chi[class_name[i]] = chi[class_name[i]].replace(k,symbols[k])

			# gap denotes complex conjugations with '/'
			if '/' in chi[class_name[i]]:
				chi[class_name[i]] = 'conjugate('+chi[class_name[i]].replace('/','')+')'

			# don't forget the galois conjugates!
			if '&' in chi[class_name[i]]:
				gc = eval('('+chi[class_name[i]].replace('&','')+').galois_conjugates(K)')
				if gc[0] == eval(chi[class_name[i]].replace('&','')):
					chi[class_name[i]] = '('+str(gc[1]).replace('^','**')+')'
				else:
					chi[class_name[i]] = '('+str(gc[0]).replace('^','**')+')'

			# tidy up again
			chi[class_name[i]] = str(eval(chi[class_name[i]])).replace('^','**')

		# useful global variables after data has been loaded:
		# class_name is a list of the conjugacy class names (strings)
		# chi is a dictionary taking class_names to the character value (integers)
		# maps is a dictionary of dictionaries
		#	if g is a string from class_name and p is a prime dividing |G|, maps[g][p] is
		#   the string encoding the glass of g^p
		# cc is a dictionary taking class_names to the size of the conjugacy class

		# compute invariant dimension of sym^n chi for n=1,...,20
		f = open('output/' + G + '_output.txt','w')
		f.write('d\tm_d(ρ_{})\n'.format(G))
		for d in range(1,21):
			print('m_{}(ρ_{}): '.format(d,G),end='')
			m = invariant_dim(d)
			print(m)
			f.write('{}\t{}\n'.format(d,m))
		f.close()

	else: # use gap to compute series as a rational function

		a = 1
		degree = 1
		if G[0] == 'a':
			G = 'M11'
			degree = 10
		elif G[0] == 'b':
			G = 'M12'
			degree = 11
		elif G[0] == 'c':
			G = 'M22'
			a = 12
			degree = 10
		elif G[0] == 'd':
			G = 'M23'
			degree = 22
		elif G[0] == 'e':
			G = 'M24'
			degree = 23
		elif G[0] == 'f':
			G = 'J1'
			degree = 56
		elif G[0] == 'g':
			G = 'J2'
			degree = 6
			a = 2
		elif G[0] == 'h':
			G = 'J3'
			degree = 18
			a = 3
		elif G[0] == 'j':
			G = 'Co3'
			degree = 23
		elif G[0] == 'k':
			G = 'Co2'
			degree = 23
		elif G[0] == 'l':
			G = 'Co1'
			degree = 24
			a = 2
		elif G[0] == 'p':
			G = 'Suz'
			degree = 12
			a = 6
		elif G[0] == 'q':
			G = 'HS'
			degree = 22
		elif G[0] == 'r':
			G = 'McL'
			degree = 22
		elif G[0] == 's':
			G = 'Ru'
			degree = 28
			a = 2
		elif G[0] == 't':
			G = 'He'
			degree = 51

		# pass to the appropriate extension if necessary
		s = ''
		if a>1:
			s += str(a) + '.'

		# compute the molien series in GAP
		R.<z> = QQ[]
		gap.eval('t:=CharacterTable("' + s + G + '")')
		gap.eval('chi:=First(Irr(t),x->Degree(x)=' + str(degree) + ')')
		M = eval(gap.eval('MolienSeries(chi)').replace('^','**'))

		# extract numerator and denominator
		p = M.numerator()
		q = M.denominator()

		# output and save to file
		print('p_' + G + '(z) = ' + str(p))
		print('\nq_' + G + '(z) = ' + str(q))
		f = open('output/' + G + '_output.txt','w')
		f.write('p_' + G + '(z) = ' + str(p))
		f.write('\n\nq_' + G + '(z) = ' + str(q))
		f.close()

else:
	print('Error parsing user input!')