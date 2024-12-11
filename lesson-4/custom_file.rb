require './paths.rb'

class CustomFile < File

  # Выводит все строки
  def index
    rewind
    each do |line|
      Kernel.puts line
    end
  end

  # Находит конкретную строку в файле и выводит ее
  def find(id)
    rewind
    each_with_index do |line, index|
      Kernel.puts line if index == id
    end
  end

  # Находит все строки, где есть указанный паттерн
  def where(pattern)
    rewind
    each do |line|
      Kernel.puts "#{line}" if line.include?(pattern)
    end
  end

  # Обновляет конкретную строку файла
  def update(id, text)
    action_with_buffer(lambda { |line, line_number|
      line_number == id ? text : line
    })
  end

  # Удаляет строку
  def delete(id)
    action_with_buffer(lambda { |line, line_number|
      line if line_number != id
    })
  end

  # Добавляет строку в конец файла
  def add_to_end(text)
    puts(text)
  end

  private
  def action_with_buffer(action)

    buffer = File.new(Paths::BUFFER_PATH, 'w')

    rewind

    each_with_index do |line, line_number|
      buffer.puts action.call(line, line_number)
    end

    buffer.close

    truncate(0)
    rewind
    write(File.read(Paths::BUFFER_PATH))

    File.delete(Paths::BUFFER_PATH) if File.exist?(Paths::BUFFER_PATH)
  end
end

f = CustomFile.new(Paths::FILE_PATH, 'w+')
f.add_to_end('1')
f.add_to_end('2')
f.add_to_end('3')
f.index
f.where('2')