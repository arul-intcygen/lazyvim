# Kasus nyata dalam perbankan

class BankAccount:
    def __init__(self, saldo_awal):
        self.__saldo_awal = saldo_awal          # private / disembunyikan


    # public method -> interface yang aman 
    def deposit(self, jumlah):
        if jumlah > 0:
            self.__saldo_awal += jumlah
        else:
            print("Jumlah harus positif")

            
    def tarik(self, jumlah):
        if jumlah <= self.__saldo_awal:
            self.__saldo_awal -= jumlah
        else:
            print("Saldo tidak cukup!!")


    def lihat_saldo(self):
        return self.__saldo_awal

class UserInfo:
    def __init__(self, username, emailddress):
        self.username = username
        self.email    = emailddress

    def check_username(self, username_to_check):
        if username_to_check == self.username:
            message = (f"Username {self.username} ditemukan")
            return message
        else:
            return False

# Penggunaan
akunku = BankAccount(10000)
user1  = UserInfo("incygenius", "sahrulsolihin224@gmail.com")

print(user1.check_username("incygenius"))

