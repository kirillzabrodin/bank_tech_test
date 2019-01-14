require 'transaction'

class Bank
  def initialize(transaction = Transaction.new)
    @transaction = transaction
    @balance = 0
    @header = "date || credit || debit || balance\n"
  end

  def status
    puts "#{@header} + #{@transaction.list}"
  end

  def credit(num)
    @balance += num
    line = "#{format('%.2f', num)} ||"
    add_to_statement(line)
    puts format('%.2f', @balance)
  end

  def debit(num)
    @balance -= num
    line = "|| #{format('%.2f', num)}"
    add_to_statement(line)
    puts format('%.2f', @balance)
  end

  private

  def add_to_statement(line)
    @statement << "#{time} || #{line} || #{format('%.2f', @balance)}\n"
  end

  def time
    Time.now.strftime('%d/%m/%Y %H:%M')
  end
end
