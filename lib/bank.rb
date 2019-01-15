require './lib/transaction'

class Bank
  attr_reader :transaction
  def initialize(transaction = Transaction.new)
    @transaction = transaction
    @header = 'date || credit || debit || balance'
    @statement = []
  end

  def statement
    puts @header.to_s
    @statement.each { |line| puts line }
  end

  def credit(amount)
    raise "#{amount} is not a number" unless amount.is_a? Numeric

    @transaction.credit(amount)
    add_to_statement(credit_format(amount))
  end

  def debit(amount)
    raise "#{amount} is not a number" unless amount.is_a? Numeric

    @transaction.debit(amount)
    add_to_statement(debit_format(amount))
  end

  private

  def add_to_statement(line)
    @statement.push("#{time} || #{line} || #{balance}\n")
  end

  def debit_format(amount)
    "|| #{format('%.2f', amount)}"
  end

  def credit_format(amount)
    "#{format('%.2f', amount)} ||"
  end

  def time
    Time.now.strftime('%d/%m/%Y')
  end

  def balance
    format('%.2f', @transaction.balance)
  end
end
