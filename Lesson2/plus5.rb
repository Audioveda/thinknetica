# 1.2.2 Заполнить массив числами от 10 до 100 с шагом 5

i = 10
a = Array.new
while i <= 100 
	a.push i
	i += 5
end
puts a
