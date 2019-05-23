#help_url = "http://www.bolshoyvopros.ru/questions/299829-kak-sostavit-algoritm-reshenija-kvadratnogo-uravnenija.html"

puts "Введите последовательно коэффициенты уравнения."
a = gets.to_f
b = gets.to_f
c = gets.to_f

puts "Итак, вот наше уравнение #{a}x² + #{b}x + #{c} = 0"
d = b**2 - 4 * a * c
puts "Дискриминант D, который считаетсчя по формуле «D = (b² – 4ac)» равен у нас #{d}"

if d > 0
  d_sqrt = Math.sqrt(d)
  x1 = (-b + d_sqrt) / (2.0 * a)
  x2 = (-b - d_sqrt) / (2.0 * a)
  puts "Корни уравнения #{x1} и #{x2}"
elsif d == 0
 x = (-b) / (2.0 * a)
  puts "корень уравнения #{x}"
else
  puts "поэтому корней не ждите, их нет"
end
