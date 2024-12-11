require 'rspec'
require './filter_students.rb'
require './paths.rb'

RSpec.describe 'filter_students' do

  let(:input_path) { Paths::INPUT_TEST_PATH }
  let(:input_path_all_same_age) { Paths::INPUT_TEST_PATH_ALL_SAME_AGE }
  let(:output_path) { Paths::RESULT_TEST_PATH }

  before do
    File.open(input_path, 'w') do |file|
      file.puts("Иван Иванов 20")
      file.puts("Петр Петров 21")
      file.puts("Алексей Алексеев 20")
    end

    File.open(input_path_all_same_age, 'w') do |file|
      file.puts("Иван Иванов 20")
      file.puts("Петр Петров 20")
      file.puts("Алексей Алексеев 20")
    end
  end

  after do
    File.delete(input_path) if File.exist?(input_path)
    File.delete(output_path) if File.exist?(output_path)
    File.delete(input_path_all_same_age) if File.exist?(input_path_all_same_age)
  end

  it 'Если пользователь ввел -1, возвращает содержимое results.txt' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("20\n", "-1\n")

    expect {
      filter_students(input_path, output_path)
    }.to output(/Иван Иванов 20\nАлексей Алексеев 20/).to_stdout

    result = File.read(output_path)
    expect(result).to include("Иван Иванов 20")
    expect(result).to include("Алексей Алексеев 20")
    expect(result).not_to include("Петр Петров 21")
  end

  it 'Независимо от ввода пользователя возвращает содержимое results.txt, если все студенты были туда перемещены' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return("20\n", "100\n")

    expect {
      filter_students(input_path_all_same_age, output_path)
    }.to output(/Иван Иванов 20\nПетр Петров 20\nАлексей Алексеев 20/).to_stdout

    result = File.read(output_path)
    expect(result).to include("Иван Иванов 20")
    expect(result).to include("Петр Петров 20")
    expect(result).to include("Алексей Алексеев 20")
  end
end