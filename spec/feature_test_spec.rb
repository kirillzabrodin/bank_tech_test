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
      bank.credit(1000)
      statement = "#{header}#{time} || 1000.00 || || 1000.00\n"
      expect { bank.statement }.to output(statement).to_stdout
    end

    it 'returns the status and latest transation in correct order' do
      bank.debit(10)
      bank.credit(1000)
      transaction_1 = "#{time} || || 10.00 || -10.00\n"
      transaction_2 = "#{time} || 1000.00 || || 990.00\n"
      statement = "#{header}#{transaction_1}#{transaction_2}"
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
end
