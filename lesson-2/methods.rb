# Запрашивает имя, фамилию, возраст и
# выводит приветствие на основе возраста
def greeting
  puts "Введите Ваши имя, фамилию и возраст"

  user_name = gets.chomp
  user_surname = gets.chomp
  user_age = gets.to_i

  if user_age < 18
    puts "Привет, #{user_name} #{user_surname}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано"
  else
    puts "Привет, #{user_name} #{user_surname}. Самое время заняться делом!"
  end
end

# Принимает на вход 2 числа. Если хотя бы одно равно 20,
# возвращает второе число, иначе - их сумму
def foobar (num1, num2)
    if num1 == 20 || num2 == 20
      return num2
    end

    num1 + num2
end

greeting