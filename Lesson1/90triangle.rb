puts "Какой ты треугольник сегодня? Введите последовательно длины трех сторон треугольника."
a = gets.to_i
b = gets.to_i
c = gets.to_i
puts "Повезло этот треугольник у нас - "
if a == b && b == c 
  puts "равнобедренный и равносторонний, но не прямоугольный"
else 
  if (a*a == (b*b + c*c)) || (b*b == (a*a + c*c)) || (c*c == (a*a + b*b)) 
    puts "прямоугольный "
  end
  if a == b || b == c || c == a  
    puts "равнобедренный "
  end
end
