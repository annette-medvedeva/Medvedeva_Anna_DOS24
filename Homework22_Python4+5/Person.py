class Person:
    def __init__(self, name: str, age: int):
        if not isinstance(name, str):
            raise TypeError("Имя должно быть строкой")
        if age < 0:
            raise ValueError("Возраст не может быть отрицательным")
        self.name = name
        self.age = age

    def introduce(self) -> str:
        print(f"Меня зовут {self.name}, мне {self.age} лет.")
try:
    name = input("Введите ваше имя: ")
    age = int(input("Введите ваш возраст: "))
    person = Person(name, age)
    print(person.introduce())

except ValueError as e:
    if "invalid literal" in str(e):
        print("Ошибка: Возраст должен быть целым числом")
    else:
        print(f"Ошибка: {e}")
except TypeError as e:
    print(f"Ошибка: {e}")
