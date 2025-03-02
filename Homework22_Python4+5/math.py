import math

class Circle:
    def __init__(self, radius: float):
        if radius <= 0:
            raise ValueError("Радиус должен быть положительным")
        self.radius = radius

    def area(self) -> float:
        return math.pi * self.radius ** 2

class Rectangle:
    def __init__(self, length: float, width: float):
        if length <= 0 or width <= 0:
            raise ValueError("Стороны должны быть положительными")
        self.length = length
        self.width = width

    def area(self) -> float:
        return self.length * self.width
