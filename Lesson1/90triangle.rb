puts "Какой ты треугольник сегодня? Введите последовательно длины трех сторон треугольника."
a = gets.to_i
b = gets.to_i
c = gets.to_i
result = "банальный, совершенно никакой"
if a == b && b == c 
  result = "равносторонний"
else 
  if (a*a == (b*b + c*c)) || (b*b == (a*a + c*c)) || (c*c == (a*a + b*b)) 
    result = "прямоугольный"
    if a == b || b == c || c == a  
      result = result + "да еще и равнобедренный"
    end
  end
end
puts "Сегодня ты у нас #{result} треугольник"
