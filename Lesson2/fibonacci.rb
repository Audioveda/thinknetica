fib = [0,1]
i = 1
result = 0
while result <= 100
  result = fib[i] + fib[i-1]
  if result <= 100
    fib.push result
  end
  i += 1
end
puts fib
