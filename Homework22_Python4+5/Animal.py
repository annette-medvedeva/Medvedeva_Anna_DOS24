class Animal:
    def make_sound(self) -> str:
        raise NotImplementedError("Метод должен быть переопределен")

class Dog(Animal):
    def make_sound(self) -> str:
        return "Гав!"

class Cat(Animal):
    def make_sound(self) -> str:
        return "Мяу!"
animals = [Dog(), Cat()]
for animal in animals:
    print(animal.make_sound()) 