puts "Какой ты треугольник сегодня? Введите последовательно длины трех сторон треугольника."
a = gets.to_i
b = gets.to_i
c = gets.to_i
a, b, c = [a, b, c].sort!
result = "банальный, совершенно никакой"
if a == b && b == c 
  result = "равносторонний"
elsif a**2 + b**2 == c**2 
    result = "прямоугольный"
    if a == b  
      result = result + "да еще и равнобедренный"
    end
end
puts "Сегодня ты у нас #{result} треугольник"
