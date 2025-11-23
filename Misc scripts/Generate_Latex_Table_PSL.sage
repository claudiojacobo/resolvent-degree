#!/usr/bin/env python3

import re

# The input dictionary provided
data = {
    '1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0},
    '2': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0},
    '3^l': {'1': 0, '2': 0, '3^l': 1, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0},
    '4^k': {'1': 1, '2': 0, '3^l': 0, '4^k': 'q - 3', '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0},
    '5^k': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 'q - 3', "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0},
    "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0},
    '6^klm': {'1': 0, '2': 0, '3^l': 0, '4^k': '1/2*q - 3/2', '5^k': 0, "6'": 0, '6^klm': '1/6*q^2 - 4/3*q + 5/2', '7^k': 0, '8^k': 0},
    '7^k': {'1': 0, '2': 0, '3^l': 0, '4^k': '1/2*q - 1/2', '5^k': 0, "6'": 0, '6^klm': 0, '7^k': '1/2*q^2 - q + 1/2', '8^k': 0},
    '8^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': '1/3*q^2 + 1/3*q'}
}

# 1. Define the order of keys as they appear in the target table
# --- MODIFIED: Added "6'" to the list ---
key_order = ['1', '2', '3^l', '4^k', '5^k', "6'", '6^klm', '7^k', '8^k']

# 2. Map keys to their desired LaTeX C_... labels
# --- MODIFIED: Added entry for "6'" ---
label_map = {
    '1': 'C_1',
    '2': 'C_2',
    '3^l': 'C_3^{\ell}',
    '4^k': 'C_4^k',
    '5^k': 'C_5^k',
    "6'": "C_6'",
    '6^klm': 'C_6^{k,\ell,m}',
    '7^k': 'C_7^k',
    '8^k': 'C_8^k'
}

def format_term(term):
    """
    Formats a single string term into LaTeX.
    e.g., "1/2*q^2" -> "\\frac{q^2}{2}"
          "4/3*q"   -> "\\frac{4q}{3}"
          "3/2"     -> "\\frac{3}{2}"
          "q"       -> "q"
    """
    term = str(term)
    # Pattern 1: 1/B*C  (e.g., "1/2*q^2") -> \frac{C}{B}
    match = re.fullmatch(r'1/([\d\.]+)\*([\w\^]+)', term)
    if match:
        return f"\\frac{{{match.group(2)}}}{{{match.group(1)}}}"
        
    # Pattern 2: A/B*C  (e.g., "4/3*q") -> \frac{AC}{B}
    match = re.fullmatch(r'([\d\.]+)/([\d\.]+)\*([\w\^]+)', term)
    if match:
        return f"\\frac{{{match.group(1)}{match.group(3)}}}{{{match.group(2)}}}"
        
    # Pattern 3: A/B    (e.g., "3/2") -> \frac{A}{B}
    match = re.fullmatch(r'([\d\.]+)/([\d\.]+)', term)
    if match:
        return f"\\frac{{{match.group(1)}}}{{{match.group(2)}}}"
    
    # No fraction match, return the term as is (e.g., "q", "3")
    return term

def format_value(val):
    """
    Formats a full cell value (which could be an int or string).
    e.g., "1/6*q^2 - 4/3*q + 5/2" -> "\\frac{q^2}{6} - \\frac{4q}{3} + \\frac{5}{2}"
    """
    if isinstance(val, (int, float)):
        return str(val)
    
    s_val = str(val)
    
    # Split the string by ' + ' or ' - ', processing each part
    parts = re.split(r' ([\+\-]) ', s_val) # Split, keeping delimiters
    
    processed_parts = []
    for part in parts:
        if part == '+' or part == '-':
            processed_parts.append(f" {part} ") # Add spaces back
        else:
            # This is a term (like "1/6*q^2" or "q"), format it
            processed_parts.append(format_term(part))
    
    return "".join(processed_parts)

def create_latex_table(data_dict, key_order, label_map):
    """
    Generates the LaTeX table string.
    """
    output_lines = []
    num_cols = len(key_order)
    
    # --- \begin{tabular} ---
    col_format = "r|" + "c|" * num_cols
    col_format = col_format[:-1]
    output_lines.append(f"\\begin{{tabular}}{{{col_format}}}")
    
    # --- First Header Row (# of Classes) ---
    # As requested, this row's values are left blank
    header1_cells = ["\\# of Classes"] + [""] * num_cols
    output_lines.append(" & ".join(header1_cells) + " \\\\ \\hline")
    
    # --- Second Header Row (Type) ---
    header2_cells = ["Type"]
    for key in key_order:
        label = label_map.get(key, f"C_{{{key}}}") # Use map, fallback
        header2_cells.append(f"${label}$")
    output_lines.append(" & ".join(header2_cells) + " \\\\ \\hline \\hline")
    
    # --- Data Rows ---
    for row_key in key_order:
        row_label = label_map.get(row_key)
        cells = [f"${row_label}$"] # First cell is the row header
        
        for col_key in key_order:
            # === IMPORTANT LOGIC ===
            # The example table maps Table[row][col] to data[col_key][row_key]
            # This is a transpose of the dictionary.
            # We get the dictionary for the *column*
            col_data = data_dict.get(col_key, {})
            # Then we get the value for the *row* from that inner dict
            val = col_data.get(row_key, 0) # Default to 0 if key is missing
            
            # Format the value and wrap in $...$
            formatted_val = format_value(val)
            cells.append(f"${formatted_val}$")
            
        # Join all cells for the row
        output_lines.append(" & ".join(cells) + " \\\\ \\hline")
        
    # --- \end{tabular} ---
    output_lines.append("\\end{tabular}")
    
    return "\n".join(output_lines)

# --- Main execution ---
q = var('q')
dict_list = [[{'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '2': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '3^l': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '4^k': {'1': 0, '2': 0, '3^l': 0, '4^k': q - 2, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '5^k': {'1': 0, '2': 0, '3^l': 0, '4^k': q - 2, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '6^klm': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 1/6*q^2 - 5/6*q + 1, '7^k': 0, '8^k': 0}, '7^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 1/2*q^2 - 1/2*q, '8^k': 0}, '8^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 1/3*q^2 + 1/3*q}}, [0, 2, 6, 8, 12, 14, 18, 20, 24, 26, 30, 32, 36, 38, 42, 44, 48, 50, 54, 56, 60, 62, 66, 68]], [{'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '2': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '3^l': {'1': 0, '2': 0, '3^l': 3, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '4^k': {'1': 3, '2': 0, '3^l': 0, '4^k': 1/3*q - 13/3, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '5^k': {'1': 0, '2': 3, '3^l': 0, '4^k': 0, '5^k': 1/3*q - 13/3, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 1, '6^klm': 0, '7^k': 0, '8^k': 0}, '6^klm': {'1': 1, '2': 0, '3^l': 0, '4^k': 1/2*q - 13/2, '5^k': 0, "6'": 0, '6^klm': 1/18*q^2 - 7/9*q + 103/18, '7^k': 0, '8^k': 0}, '7^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 1/6*q - 1/6, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 1/6*q^2 - 1/3*q + 1/6, '8^k': 0}, '8^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 1/9*q^2 + 1/9*q - 2/9}}, [1, 13, 25, 37, 49, 61]], [{'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '2': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '3^l': {'1': 0, '2': 0, '3^l': 1, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '4^k': {'1': 1, '2': 0, '3^l': 0, '4^k': q - 3, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '5^k': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': q - 3, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '6^klm': {'1': 0, '2': 0, '3^l': 0, '4^k': 1/2*q - 3/2, '5^k': 0, "6'": 0, '6^klm': 1/6*q^2 - 4/3*q + 5/2, '7^k': 0, '8^k': 0}, '7^k': {'1': 1, '2': 0, '3^l': 0, '4^k': 3/2*q - 5/2, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 1/2*q^2 - 2*q + 3/2, '8^k': 0}, '8^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 1/3*q^2 + 1/3*q}}, [3, 11, 15, 23, 27, 35, 39, 47, 51, 59, 63, 71]], [{'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '2': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '3^l': {'1': 3, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '4^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 1/3*q - 4/3, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '5^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 1/3*q - 4/3, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 1, '6^klm': 0, '7^k': 0, '8^k': 0}, '6^klm': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 1/18*q^2 - 5/18*q + 2/9, '7^k': 0, '8^k': 0}, '7^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 1/6*q^2 - 1/6*q, '8^k': 0}, '8^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 1/9*q^2 + 1/9*q - 2/9}}, [4, 10, 16, 22, 28, 34, 40, 46, 52, 58, 64, 70]], [{'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '2': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '3^l': {'1': 0, '2': 0, '3^l': 1, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '4^k': {'1': 3, '2': 0, '3^l': 0, '4^k': q - 5, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '5^k': {'1': 0, '2': 3, '3^l': 0, '4^k': 0, '5^k': q - 5, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '6^klm': {'1': 1, '2': 0, '3^l': 0, '4^k': 3/2*q - 15/2, '5^k': 0, "6'": 0, '6^klm': 1/6*q^2 - 7/3*q + 15/2, '7^k': 0, '8^k': 0}, '7^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 1/2*q - 1/2, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 1/2*q^2 - q + 1/2, '8^k': 0}, '8^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 1/3*q^2 + 1/3*q}}, [5, 9, 17, 21, 29, 33, 41, 45, 53, 57, 65, 69]], [{'1': {'1': 1, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '2': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '3^l': {'1': 0, '2': 0, '3^l': 3, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '4^k': {'1': 1, '2': 0, '3^l': 0, '4^k': 1/3*q - 7/3, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, '5^k': {'1': 0, '2': 1, '3^l': 0, '4^k': 0, '5^k': 1/3*q - 7/3, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 0}, "6'": {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 1, '6^klm': 0, '7^k': 0, '8^k': 0}, '6^klm': {'1': 0, '2': 0, '3^l': 0, '4^k': 1/6*q - 7/6, '5^k': 0, "6'": 0, '6^klm': 1/18*q^2 - 4/9*q + 25/18, '7^k': 0, '8^k': 0}, '7^k': {'1': 1, '2': 0, '3^l': 0, '4^k': 1/2*q - 3/2, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 1/6*q^2 - 2/3*q + 1/2, '8^k': 0}, '8^k': {'1': 0, '2': 0, '3^l': 0, '4^k': 0, '5^k': 0, "6'": 0, '6^klm': 0, '7^k': 0, '8^k': 1/9*q^2 + 1/9*q - 2/9}}, [7, 19, 31, 43, 55, 67]]]
for pair in dict_list:
    print(f"for moduli {pair[1]} we have " + r"\\")
    latex_table = create_latex_table(pair[0], key_order, label_map)
    print(latex_table)