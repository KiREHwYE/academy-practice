require_relative '../lesson-4/paths.rb'

# Читает файл по пути input_path, находит в нем студентов с возрастом,
# который введет пользователь, и записывает их в файл по пути output_path.
# Выводит содержимое output_path, если все студенты были в него перемещены
# или пользователь ввел -1
def filter_students(input_path, output_path)

  input = File.open(input_path, 'r')
  output = File.new(output_path, 'w+')

  puts'Введите возраст студента: '
  age = gets.to_i

  all_students_match = true

  input.each do |student|
     student.include?(age.to_s) ? output.puts(student) : all_students_match = false
  end

  input.close

  puts 'Осуществите ввод: '
  user_input = gets.to_i

  if user_input == -1 || all_students_match
    output.rewind
    output.each do |student|
       puts student
    end
  end

  output.close
end