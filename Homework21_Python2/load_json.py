import json

def load_json(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        return json.load(file)

def print_top_level_keys_and_values(data):
    for key, value in data.items():
        print(f"Ключ: {key}, Значение: {value}")

def save_json_with_indent(data, file_path, indent=4):
    with open(file_path, 'w', encoding='utf-8') as file:
        json.dump(data, file, ensure_ascii=False, indent=indent)

if __name__ == "__main__":
    input_file = 'input.json'
    output_file = 'output.json'
    json_data = load_json(input_file)
    print_top_level_keys_and_values(json_data)
    
    # Сохранение JSON-файла с отступами
    save_json_with_indent(json_data, output_file)
    
    print(f"JSON-файл сохранен в {output_file} с отступами.")