@classmethod
def change_company(cls, new_name: str):
        if not isinstance(new_name, str):
            raise TypeError("Название компании должно быть строкой")
        cls.company_name = new_name

@staticmethod
def is_adult(age: int) -> bool:
        return age >= 18