group_name = "AlternatingGroup(9)"
G_gap = eval(f"libgap.{group_name}")

tbl = libgap.CharacterTable(G_gap)
irreps = libgap.Irr(tbl)

degrees = [int(chi.Degree()) for chi in irreps]
sorted_degrees = sorted(set(degrees))
target_degree = sorted_degrees[1]

target_char = next(chi for chi in irreps if int(chi.Degree()) == target_degree)

molien_series = libgap.MolienSeries(tbl, target_char)
print("Target degree:", target_degree) 
print("Molien series:", molien_series)
s_py = str(molien_series).replace('^', '**')
# declare variable and parse
var('z')
f = SR(s_py)   # symbolic expression

# get series up to z^N (N is the order you want)
N = 10
ser = f.series(z, N)   # gives series up to z^(N-1) plus big-O
print(ser)