require 'bank'
require 'timecop'

describe Bank do
  let(:transaction) { double :transaction, credit: true, debit: true }
  subject(:bank) { Bank.new(transaction) }
  let(:header) { "date || credit || debit || balance\n" }

  before do
    Timecop.freeze(Time.local(2008, 9, 1, 10, 5, 0))
  end

  describe '#statement' do
    it 'returns empty status if no transactions' do
      expect { subject.statement }.to output(header).to_stdout
    end
  end

  describe '#credit' do
    it 'calls credit with the amount described' do
      amount = rand_to_1000
      expect(transaction).to receive(:credit).with(amount)
      expect(bank).to receive(:add_to_statement).with(credit_format(amount))
      bank.credit(amount)
    end

    it 'errors out when non-number given' do
      expect { bank.credit('Hello') }.to raise_error 'Hello is not a number'
    end

    it "errors out when negative number" do
      allow(transaction).to receive(:balance).and_return(0)
      expect { bank.credit(-1) }.to raise_error("Numbers must be positive.")
    end
  end

  describe '#debit' do
    it 'calls debit with the amount described' do
      amount = rand_to_1000
      expect(transaction).to receive(:balance).and_return(amount)
      expect(transaction).to receive(:debit).with(amount)
      expect(bank).to receive(:add_to_statement).with(debit_format(amount))
      bank.debit(amount)
    end

    it 'errors out when non-number given' do
      expect { bank.debit('Hello') }.to raise_error 'Hello is not a number'
    end

    it "errors out when balance too low" do
      allow(transaction).to receive(:balance).and_return(0)
      expect { bank.debit(1) }.to raise_error("Not enough credit, your balance is 0.00.")
    end

    it "errors out when negative number" do
      allow(transaction).to receive(:balance).and_return(0)
      expect { bank.debit(-1) }.to raise_error("Numbers must be positive.")
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
