require 'rspec'
require './paths.rb'
require './custom_file.rb'

RSpec.describe 'CustomFile' do

  let(:file) { CustomFile.new(Paths::FILE_PATH, 'w+') }

  before {
    file.add_to_end('Line 1')
    file.add_to_end('Line 2')
    file.rewind
  }

  after {
    file.close
    File.delete(Paths::FILE_PATH) if File.exist?(Paths::FILE_PATH)
  }

  it 'Добавляет строку в конец файла' do
    last_line = file.readlines.last
    expect(last_line).to eq("Line 2\n")
  end

  it 'Выводит все строки' do
    expect { file.index }.to output("Line 1\nLine 2\n").to_stdout
  end

  it 'Находит конкретную строку в файле и выводит ее' do
    expect { file.find(1) }.to output("Line 2\n").to_stdout
  end

  it 'Находит все строки, где есть указанный паттерн' do
    expect { file.where("2") }.to output("Line 2\n").to_stdout
  end

  it 'Обновляет конкретную строку файла' do
    file.update(1, "Hello!!!")
    file.rewind
    file_content = file.read
    expect(file_content).to eq("Line 1\nHello!!!\n")
  end

  it 'Удаляет строку' do
    file.delete(0)
    file.rewind
    file_content = file.read
    expect(file_content).to eq("\nLine 2\n")
  end

end