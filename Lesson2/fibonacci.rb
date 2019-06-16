# 1.2.3 Заполнить массив числами фибоначчи до 100

fib = [0, 1]
next_number = 1
while next_number <= 100
  fib << next_number 
  next_number = fib[-1] + fib[-2]
end
puts fib
