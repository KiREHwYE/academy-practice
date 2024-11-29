require 'rspec'
require './cs_end.rb'

# Тестирует функцию cs_end?
RSpec.describe "CS Tail Handler" do

  it 'Возвращает 2 в степени, равной длине переданного слова, если оно оканчивается на \'cs\' в любом регистре' do
    expect(cs_end?('hello')).to eq('olleh')
  end

  it 'Возвращает слово задом наперед, если оно НЕ оканчивается на \'cs\' в любом регистре' do
    expect(cs_end?('helloCS')).to eq(128)
  end

  it 'Возвращает слово задом наперед, если оно НЕ оканчивается на \'cs\' в любом регистре' do
    expect(cs_end?('helloCs')).to eq(128)
  end

  it 'Возвращает слово задом наперед, если оно НЕ оканчивается на \'cs\' в любом регистре' do
    expect(cs_end?('hellocS')).to eq(128)
  end

  it 'Возвращает слово задом наперед, если оно НЕ оканчивается на \'cs\' в любом регистре' do
    expect(cs_end?('hellocs')).to eq(128)
  end

  it 'Слово должно быть длины больше или равной 2-м' do
    expect { cs_end?('a') }.to raise_error(message = "Слово должно иметь длину больше или равной 2-м")
  end

end

