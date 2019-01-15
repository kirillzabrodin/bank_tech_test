require './lib/transaction'

class Bank
  attr_reader :transaction
  def initialize(transaction = Transaction.new, statement = Statement.new)
    @transaction = transaction
    @statement = statement
  end

  def print_statement
    @statement.print
  end

  def credit(amount)
    raise "#{amount} is not a number" unless amount.is_a? Numeric
    raise 'Numbers must be positive.' if amount < 0

    @transaction.credit(amount)
    @statement.add_credit_line(amount, balance)
  end

  def debit(amount)
    raise "#{amount} is not a number" unless amount.is_a? Numeric
    raise 'Numbers must be positive.' if amount < 0
    raise "Balance too low. #{balance}." if amount > @transaction.balance

    @transaction.debit(amount)
    @statement.add_debit_line(amount, balance)
  end

  private

  def balance
    format('%.2f', @transaction.balance)
  end
end
