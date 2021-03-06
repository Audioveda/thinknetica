# 1.2.4 Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ('a'..'z').to_a 
# создаем массив alphabet куда пихаем range из букв от a до z ('a'..'z')

vowels_array = %w[a e i o u y] 
# создаем второй массив vowels_array чтобы потом пробежать по нему в цикле, пихая в хэш в качестве ключей

vowels_hash = {} 
# создаем пустой хэш

vowels_array.each { |vowel| vowels_hash[vowel] = alphabet.index(vowel) + 1 } 
=begin
  итак погнали: 
  бежим по массиву гласных 
  каждую гласную пихаем в качестве ключа в хэш vowels_hash[vowel.to_s], 
  присваивая ключу значение, которое равно индексу этой гласной в первом массиве alphabet.index(vowel)
  добавляя единичку ибо индексация массива начинается с нуля
=end

puts vowels_hash 
# выводим хэш на экран
