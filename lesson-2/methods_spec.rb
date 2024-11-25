require 'rspec'
require './methods.rb'

# Тестирует функцию foobar
RSpec.describe "Foobar" do

  it "Возвращает второе число, если одно из двух равно 20" do
    expect(foobar(20, 5)).to eq(5)
  end

  it "Возвращает сумму двух чисел, если ни одно из двух не равно 20" do
    expect(foobar(30, 10)).to eq(40)
  end

end

# Тестирует функцию greeting
RSpec.describe "Greeting" do

  it "Возвращает приветствие и \"Тебе меньше 18 лет, но начать учиться программировать никогда не рано\, если введенный пользователем возраст меньше 18" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('Jetruby', 'Academy', 15)

    expect(greeting).to eq(puts "Привет, Jetruby Academy. Тебе меньше 18 лет, но начать учиться программировать никогда не рано")
  end

  it "Возвращает приветствие и \"Самое время заняться делом!\, если введенный пользователем возраст больше или равен 18" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('Jetruby', 'Academy', 27)

    expect(greeting).to eq(puts "Привет, Jetruby Academy. Самое время заняться делом!")
  end
end

