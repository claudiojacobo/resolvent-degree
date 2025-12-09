def transpose_table(table):
    table_in_array = []
    table_out_array = []
    table = table.replace("\n", "")
    table = table.split("\\ \hline")
    for row in table:
        table_in_array.append(row.split("&"))
    i = 0
    while i < len(table_in_array[0]):
        table_out_array.append([])
        i += 1
    i = 0
    while i < len(table_in_array):
        for row in table_in_array:
            table_out_array[i].append(row[i])
        i += 1
    str_out = ""
    for row in table_out_array:
        for text in row:
            str_out += text
            str_out += " & "
        str_out = str_out[:-2]
        str_out += r"""\\ \hline"""
    return str_out
table = r"""
 $g^4$& $C_1$ & $C_2$ & $C_3^{\ell}$ & $C_4^k$ & $C_5^k$ & $C_6'$ & $C_6^{k,\ell,m}$ & $C_7^k$ & $C_8^k$ \\ \hline

$C_1$ & $1$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ \\ \hline
$C_2$ & $0$ & $1$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ \\ \hline
$C_3^{\ell}$ & $0$ & $0$ & $3$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ \\ \hline
$C_4^k$ & $3$ & $0$ & $0$ & $\frac{q}{3} - \frac{11}{3}$ & $0$ & $0$ & $0$ & $0$ & $0$ \\ \hline
$C_5^k$ & $0$ & $3$ & $0$ & $0$ & $\frac{q}{3} - \frac{11}{3}$ & $0$ & $0$ & $0$ & $0$ \\ \hline
$C_6'$ & $0$ & $0$ & $0$ & $0$ & $0$ & $1$ & $0$ & $0$ & $0$ \\ \hline
$C_6^{k,\ell,m}$ & $1$ & $0$ & $0$ & $\frac{q}{2} - \frac{11}{2}$ & $0$ & $0$ & $\frac{q^2}{18} - \frac{5q}{9} + \frac{79}{18}$ & $0$ & $0$ \\ \hline
$C_7^k$ & $0$ & $0$ & $0$ & $\frac{q}{6} + \frac{1}{6}$ & $0$ & $0$ & $0$ & $\frac{q^2}{6} - \frac{q}{3} - \frac{1}{2}$ & $0$ \\ \hline
$C_8^k$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ & $0$ & $\frac{q^2}{9} - 
\frac{q}{9} - \frac{2}{9}$
"""
print(transpose_table(table))
