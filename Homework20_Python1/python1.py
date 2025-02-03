# Обязательные задания

while True:
    print("\nМеню задач:")
    print("1. Вывод \"Привет, мир!\"")
    print("2. Вычисление суммы 2 + 2")
    print("3. Программа приветствия")
    print("4. Вывод чисел от 1 до 10")
    print("5. Определение возраста")
    print("6. Произведение чисел")
    print("7. Первая буква слова")
    print("8. Квадрат числа")
    print("9. Таблица умножения на 5")
    print("10. Среднее арифметическое двух чисел")
    print("0. Выход")
    
    choice = input("Выберите номер задачи: ")
    
    if choice == "1":
        print("Привет, мир!")
    elif choice == "2":
        print("Сумма 2 + 2:", 2 + 2)
    elif choice == "3":
        name = input("Введите ваше имя: ")
        print(f"Привет, {name}!")
    elif choice == "4":
        for i in range(1, 11):
            print(i)
    elif choice == "5":
        age = input("Введите ваш возраст: ")
        print(f"Ваш возраст — {age} лет")
    elif choice == "6":
        num1 = float(input("Введите первое число: "))
        num2 = float(input("Введите второе число: "))
        print(f"Произведение чисел: {num1 * num2}")
    elif choice == "7":
        word = input("Введите слово: ")
        print(f"Первая буква слова: {word[0]}")
    elif choice == "8":
        number = int(input("Введите целое число: "))
        print(f"Квадрат числа: {number ** 2}")
    elif choice == "9":
        for i in range(1, 11):
            print(f"5 x {i} = {5 * i}")
    elif choice == "10":
        num1 = float(input("Введите первое число: "))
        num2 = float(input("Введите второе число: "))
        print(f"Среднее арифметическое: {(num1 + num2) / 2}")
    elif choice == "0":
        print("Выход из программы.")
        break
    else:
        print("Некорректный ввод. Попробуйте снова.")
