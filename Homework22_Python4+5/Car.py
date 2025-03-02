class Car:
    def __init__(self, brand: str, model: str, year: int):
        if not (isinstance(brand, str) and isinstance(model, str)):
            raise TypeError("Марка и модель должны быть строками")
        if not (1900 <= year <= 2025):
            raise ValueError("Некорректный год выпуска")
        self.brand = brand
        self.model = model
        self.year = year

    def get_info(self) -> str:
        return f"{self.brand} {self.model} {self.year} года"
try:
    # Ввод данных
    brand = input("Введите марку автомобиля: ").strip()
    model = input("Введите модель автомобиля: ").strip()
    year = int(input("Введите год выпуска (1900-2023): "))
    
    # Создание объекта
    car = Car(brand, model, year)
    
    # Вывод результата
    print("\nИнформация об автомобиле:")
    print(car.get_info())

except ValueError as e:
    if "invalid literal" in str(e):
        print("Ошибка: Год должен быть целым числом")
    elif "Некорректный год выпуска" in str(e):
        print("Ошибка: Год должен быть в диапазоне 1900-2023")
    else:
        print(f"Неизвестная ошибка: {e}")
except TypeError as e:
    print(f"Ошибка типа данных: {e}")
except Exception as e:
    print(f"Неожиданная ошибка: {e}")   