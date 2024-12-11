require_relative './paths.rb'
require_relative './bank.rb'

# Имитирует работу банка
def bank_account(balance_path)

  money = Bank::DEFAULT_BALANCE

  if File.exist?(balance_path)
    File.open(balance_path, 'r') do |file|
      money = file.read.to_i
    end
  end
  command = ''

  while command != 'q'
    puts 'Введите комманду: D (Deposit), W(withdraw), B (balance), Q (quit)'
    command = gets.chomp.downcase

    case command

    when 'd'
      puts 'Введите сумму депозита: '
      deposit = gets.to_i

      if deposit > 0
        money += deposit
        puts "Новый баланс: #{money}"
      else
        puts 'Некорректная сумма. Убедитесь, чтобы она была > 0'
      end

    when 'w'
      puts 'Введите сумму для снятия: '
      withdrawal = gets.to_i

      if withdrawal > 0 && withdrawal <= money
        money -= withdrawal
        puts "Новый баланс: #{money}"
      else
        puts 'Некорректная сумма. Убедитесь, чтобы она была > 0 и <= вашему балансу'
      end

    when 'b'
      puts "Ваш баланс: #{money}"

    when 'q'
      f = File.open(balance_path, 'w')
      f.write(money)
      f.close
    else
      puts 'Неизвестная комманда'
    end
  end
end