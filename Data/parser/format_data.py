import yaml
import os

def extract_bracketed_content(text):
    '''Attempt to extract bracketed reference from string'''
    start = text.find('[')
    end = text.find(']')
    if start == -1 or end == -1 or start >= end:
        return text
    return text[start+1:end]

def parse_yaml_files_with_pyyaml(directory):
    '''Process all YAML files using PyYAML.'''
    master_dict = {}

    for filename in os.listdir(directory):
        if filename.endswith('.yml') or filename.endswith('.yaml'):
            filepath = os.path.join(directory, filename)
            print(f"Processing {filename}...")

            try:
                with open(filepath, 'r') as f:
                    data = yaml.safe_load(f)

                method = ''
                reference = ''
                if 'method' in data:
                    method = extract_bracketed_content(data.get('method', ''))
                if 'reference' in data:
                    reference = data['reference']

                if 'groups' in data:
                    for entry in data['groups']:
                        group_name = entry['group']

                        formatted_entry = {
                            'bound': entry.get('bound', 0),
                            'method': method,
                            'reference': reference,
                            'notes': entry.get('notes', ''),
                        }

                        if group_name not in master_dict:
                            master_dict[group_name] = []
                        master_dict[group_name].append(formatted_entry)

            except Exception as e:
                print(f"Error parsing {filename}: {e}")

    for G in master_dict:
        master_dict[G].sort(key=lambda entry: entry['bound'])

    return master_dict

def generate_markdown_table(master_dict, sort_by = 'alpha'):
    '''Generate a Markdown table from the parsed data.'''

    groups_data = []
    for G, entries in master_dict.items():
        groups_data.append((G, entries))

    if sort_by == 'alpha':
        groups_data.sort(key=lambda x: x[0])
    elif sort_by == 'bound':
        groups_data.sort(key=lambda x: x[1][0]['bound'])

    markdown = []
    markdown.append("| Group | Bound | Method | Reference |")
    markdown.append("|-------|-------|--------|-----------|")

    for G, entries in groups_data:
        best_entry = entries[0]
        markdown.append(f"| {G} | {best_entry['bound']} | {best_entry['method']} | {best_entry['reference']} |")

        if len(entries) > 1:
            for entry in entries[1:]:
                markdown.append(f"| | {entry['bound']} | {entry['method']} | {entry['reference']} |")

    return '\n'.join(markdown)

script_dir = os.path.dirname(os.path.abspath(__file__))
master_data = parse_yaml_files_with_pyyaml(script_dir)
print(generate_markdown_table(master_data, sort_by='bound'))
