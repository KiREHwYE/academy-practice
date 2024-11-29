# Запрашивает число покемонов для ввода.
# Для каждого покемона запрашивает имя и цвет.
# Возвращает массив хэшей, содержащих имя и цвет покемона
def pokemons
  print 'Сколько покемонов вы хотите добавить?'
  desired_amount = gets.chomp.to_i

  pokemons = []

  desired_amount.times do
    print 'Имя:'
    name = gets.chomp
    print 'Цвет:'
    color = gets.chomp

    pokemons << {name: name, color: color}
  end

  pokemons
end

puts pokemons