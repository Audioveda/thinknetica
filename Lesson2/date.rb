=begin 1.2.5 Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
  Найти порядковый номер даты, начиная отсчет с начала года. 
  Учесть, что год может быть високосным. 
  (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) 
  Алгоритм опредления високосного года: www.adm.yar.ru
  Високосный год вычисляется с помощью простого алгоритма. К сожалению, существуют системы и приложения, которые не определяют 2000 г. как високосный, и при использовании этих систем даты после 29 февраля 2000 г. могут оказаться ошибочно сдвинуты на один день. Високосный год определяется по следующему правилу:
  Год високосный, если он делится на четыре без остатка, но если он делится на 100 без остатка, это не високосный год. Однако, если он делится без остатка на 400, это високосный год. Таким образом, 2000 г. является особым високосным годом, который бывает лишь раз в 400 лет.
=end

print "Введите день (число) : "
user_day = gets.to_i
print "Введите порядковый номер месяца : "
user_month = gets.to_i
print "Введите год : "
user_year = gets.to_i
# запрашиваем у юзера три числа: число месяц и год соответственно user_day, user_month, user_year

month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
def leap_year?(year)
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
end

month_days[1] = 29 if leap_year?(user_year)

date_counter = user_day + month_days.take(user_month - 1).reduce(0, :+)

puts "в #{user_year} году этот день имел порядковый номер #{date_counter} с начала года"
# выводим юзеру каим по счету был этот день  