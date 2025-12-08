def create_latex_table(list_of_dicts):
    """
    Generates a LaTeX table from a list of nested dictionaries, with outer keys
    as rows and inner keys as columns.

    Args:
        list_of_dicts (list): A list of dictionaries, where each dictionary
                              corresponds to a complete table.

    Returns:
        str: A string containing the LaTeX code for the generated table.
    """
    if not list_of_dicts:
        return "No data provided to create a table."

    # Use the keys of the first inner dictionary for the column headers
    # and the keys of the outer dictionary for the row headers.
    outer_keys = list(list_of_dicts[0].keys())
    inner_keys = list(list_of_dicts[0][outer_keys[0]].keys())

    # Build the header row for the LaTeX table
    header = ' & ' + ' & '.join([f'${key}$' for key in inner_keys]) + ' \\\\'
    
    # Build the table body
    body = ''
    # The outer keys now represent the rows of the table
    for row_key in outer_keys:
        row_dict = list_of_dicts[0][row_key]
        row_content = f'${row_key}$'
        
        # Iterate through inner keys to get cell values for the row
        for col_key in inner_keys:
            cell_value = row_dict[col_key]
            
            # Check if the value is a number or an expression involving 'q'
            try:
                # Try to evaluate it as a symbolic expression for a cleaner output
                sympy_expr = sympify(str(cell_value))
                cell_value_str = f'${sympy_expr}$'
            except:
                # If it can't be parsed, treat it as a string
                cell_value_str = f'${cell_value}$'

            row_content += f' & {cell_value_str}'
        
        row_content += ' \\\\'
        body += row_content + '\n'

    # Construct the complete LaTeX document
    latex_code = f"""
\\begin{{table}}[h!]
\\centering
\\begin{{tabular}}{{{'c' * (len(inner_keys) + 1)}}}
\\toprule
{header}
\\midrule
{body}
\\bottomrule
\\end{{tabular}}
\\caption{{Generated Table}}
\\label{{tab:generated}}
\\end{{table}}
"""
    return latex_code