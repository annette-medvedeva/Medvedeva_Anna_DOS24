def find_common_and_unique(list1, list2):
    set1, set2 = set(list1), set(list2)

    common_elements = list(set1 & set2)  # Общие элементы
    unique_elements = list(set1 ^ set2)  # Уникальные элементы (разность множеств)

    return common_elements, unique_elements

def main():
    list1 = input("Введите первый список элементов через пробел: ").split()
    list2 = input("Введите второй список элементов через пробел: ").split()

    common_elements, unique_elements = find_common_and_unique(list1, list2)

    print(f"Общие элементы: {common_elements}")
    print(f"Уникальные элементы: {unique_elements}")
    with open("list_analysis.txt", "w") as file:
        file.write(f"Первый список: {list1}\n")
        file.write(f"Второй список: {list2}\n")
        file.write(f"Общие элементы: {common_elements}\n")
        file.write(f"Уникальные элементы: {unique_elements}\n")

    print("Результаты сохранены в 'list_analysis.txt'.")

if __name__ == "__main__":
    main()
