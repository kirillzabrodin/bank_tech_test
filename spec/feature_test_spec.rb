require 'bank'
require 'timecop'
require 'transaction'

describe Bank do

  subject(:bank) { Bank.new() }
  let(:header) { "date || credit || debit || balance\n" }

  before do
    Timecop.freeze(Time.local(2008, 9, 1, 10, 5, 0))
  end

  describe '#statement' do
    it 'returns empty status if no transactions' do
      expect { bank.statement }.to output(header).to_stdout
    end

    it 'returns the status and latest transation' do
      statement = "#{header}"
      statement << "#{make_credit(rand_to_1000)}"
      expect { bank.statement }.to output(statement).to_stdout
    end

    it 'returns the status and latest transation in correct order' do
      statement = "#{header}"
      statement << "#{make_debit(rand_to_1000)}#{make_credit(rand_to_1000)}"
      expect { bank.statement }.to output(statement).to_stdout
    end

    it 'checks for 100 transactions' do
      statement = "#{header}"
      (1..50).each do
        statement << "#{make_debit(rand_to_1000)}#{make_credit(rand_to_1000)}"
      end
      expect { bank.statement }.to output(statement).to_stdout
    end
  end

  def time
    Time.now.strftime('%d/%m/%Y')
  end

  def debit_format(amount)
    "|| #{format('%.2f', amount)}"
  end

  def credit_format(amount)
    "#{format('%.2f', amount)} ||"
  end

  def rand_to_1000
    rand(1..1000)
  end

  def balance
    format('%.2f', bank.transaction.balance)
  end

  def make_debit(amount)
    bank.debit(amount)
    transaction = "#{time} || #{debit_format(amount)} || #{balance}\n"
  end

  def make_credit(amount)
    bank.credit(amount)
    transaction = "#{time} || #{credit_format(amount)} || #{balance}\n"
  end
end
