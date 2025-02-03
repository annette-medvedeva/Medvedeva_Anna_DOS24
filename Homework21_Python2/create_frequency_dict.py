def create_frequency_dict(input_string):
    frequency_dict = {}
    for char in input_string:
        if char in frequency_dict:
            frequency_dict[char] += 1
        else:
            frequency_dict[char] = 1

    return frequency_dict

input_string = input("Введите строку: ")

result = create_frequency_dict(input_string)

print("Символ : Количество")
for key, value in result.items():
    print(f"{key} : {value}")