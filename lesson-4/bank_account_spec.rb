require 'rspec'
require_relative './paths.rb'
require_relative './bank_account.rb'

RSpec.describe 'bank_account' do
  let(:balance_path) { Paths::BALANCE_TEST_PATH }

  before do
    File.open(balance_path, 'w') { |file| file.write('100') }
    stub_const('Paths::BALANCE_TEST_PATH', balance_path)
    stub_const('Bank::DEFAULT_BALANCE', 50)
  end

  after do
    File.delete(balance_path) if File.exist?(balance_path)
  end

  it 'allows depositing money and updates balance' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '200', 'q')

    expect {
      bank_account(balance_path)
    }.to output("Введите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\nВведите сумму депозита: \nНовый баланс: 300\nВведите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\n").to_stdout

    # Verify balance file updated
    final_balance = File.read(balance_path).to_i
    expect(final_balance).to eq(300)
  end

  it 'allows withdrawing money and updates balance' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('w', '50', 'q')

    expect {
      bank_account(balance_path)
    }.to output("Введите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\nВведите сумму для снятия: \nНовый баланс: 50\nВведите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\n").to_stdout

    # Verify balance file updated
    final_balance = File.read(balance_path).to_i
    expect(final_balance).to eq(50)
  end

  it 'shows an error for invalid deposit amounts' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '-10', 'q')

    expect {
      bank_account(balance_path)
    }.to output("Введите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\nВведите сумму депозита: \nНекорректная сумма. Убедитесь, чтобы она была > 0\nВведите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\n").to_stdout

    # Verify balance file remains unchanged
    final_balance = File.read(balance_path).to_i
    expect(final_balance).to eq(100)
  end

  it 'shows an error for invalid withdrawal amounts' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('w', '150', 'q')

    expect {
      bank_account(balance_path)
    }.to output("Введите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\nВведите сумму для снятия: \nНекорректная сумма. Убедитесь, чтобы она была > 0 и <= вашему балансу\nВведите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\n").to_stdout

    # Verify balance file remains unchanged
    final_balance = File.read(balance_path).to_i
    expect(final_balance).to eq(100)
  end

  it 'displays the current balance with the B command' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('b', 'q')

    expect {
      bank_account(balance_path)
    }.to output("Введите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\nВаш баланс: 100\nВведите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\n").to_stdout

    # Verify balance file remains unchanged
    final_balance = File.read(balance_path).to_i
    expect(final_balance).to eq(100)
  end

  it 'exits the program and saves balance with Q command' do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('q')

    expect {
      bank_account(balance_path)
    }.to output("Введите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)\n").to_stdout

    # Verify balance file remains unchanged
    final_balance = File.read(balance_path).to_i
    expect(final_balance).to eq(100)
  end
end

