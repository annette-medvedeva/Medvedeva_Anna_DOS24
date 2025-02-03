def check_duplicates(user_input):
    elements = tuple(user_input.split())  # Преобразуем ввод в кортеж
    unique_elements = set()
    duplicates = set()

    for elem in elements:
        if elem in unique_elements:
            duplicates.add(elem)
        else:
            unique_elements.add(elem)

    return elements, duplicates

def save_results(elements, duplicates):
    with open("duplicates_result.txt", "w") as file:
        file.write(f"Вы ввели такие элементы: {', '.join(elements)}\n")
        if duplicates:
            file.write(f"Повторяющиеся элементы: {', '.join(duplicates)}\n")
        else:
            file.write("Все элементы уникальны.\n")

# Основной код
user_input = input("Введите элементы через пробел: ")
elements, duplicates = check_duplicates(user_input)
save_results(elements, duplicates)

print("Результаты проверки записаны в 'duplicates_result.txt'.")
