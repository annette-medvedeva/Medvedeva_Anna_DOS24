class BankAccount:
    def __init__(self, initial_balance: float = 0):
        self._balance = initial_balance

    def deposit(self, amount: float):
        if amount <= 0:
            raise ValueError("Сумма должна быть положительной")
        self._balance += amount

    def withdraw(self, amount: float):
        if amount <= 0:
            raise ValueError("Сумма должна быть положительной")
        if self._balance < amount:
            raise ValueError("Недостаточно средств")
        self._balance -= amount

    def get_balance(self) -> float:
        return self._balance
account = BankAccount(1000)
account.deposit(500)
print(account.get_balance())  
account.withdraw(200)
print(account.get_balance()) 

try:
    account.withdraw(2000)
except ValueError as e:
    print(e) 