class InsufficientAmount(Exception):
    pass


class Wallet(object):

    def __init__(self, initial_amount=0):
        self.balance = initial_amount

    def spend_cash(self, amount):
        if self.balance < amount:
            raise InsufficientAmount("Not enough available to spend {}".format(amount))
        self.balance -= amount

    def add_cash(self, amount):
        self.balance += amount


def main():
    wallet = Wallet(100)
    wallet.add_cash(90)
    wallet.spend_cash(10)
    print(f"{wallet.balance}")


if __name__ == "__main__":
    main()
