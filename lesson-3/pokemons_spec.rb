require 'rspec'
require './pokemons.rb'

# Тестирует функцию pokemons
RSpec.describe 'Pokemons' do

  it 'Возвращает массив покемонов' do
    allow_any_instance_of(Kernel).to receive(:gets)
            .and_return(
              '2',
              'Beedrill',
              'Orange',
              'Pikachu',
              'Yellow'
            )

    expect(pokemons)
      .to eq([{:name => 'Beedrill', :color => 'Orange'}, {:name => 'Pikachu', :color => 'Yellow'}])
  end
end

