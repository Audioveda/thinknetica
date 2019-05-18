puts "Здравствуйте! Представьтесь пожалуйста"
user_name = gets.chomp
puts "Приятно познакомиться, #{user_name}! Для расчета идеального веса введите свой рост в сантиметрах"
user_height = gets.chomp.to_i
ideal_weight = user_height - 110
if ideal_weight > 0
puts "#{user_name}, идеальный вес для вас: #{ideal_weight} килограммов"
else
	puts "Ваш вес уже идеальный"
end