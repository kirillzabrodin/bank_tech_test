require 'bank'
require 'timecop'

describe Bank do
  let(:transaction) { double :transaction, credit: true, debit: true }
  let(:statement) { double :statement }
  subject(:bank) { Bank.new(transaction, statement) }

  before do
    Timecop.freeze(Time.local(2008, 9, 1, 10, 5, 0))
  end

  before(:each) do
    allow(transaction).to receive(:balance).and_return(0)
    allow(statement).to receive(:add_credit_line)
    allow(statement).to receive(:add_debit_line)
  end

  describe '#statement' do
    it 'calls print on statement' do
      expect(statement).to receive(:print)
      bank.print_statement
    end
  end

  describe '#credit' do
    it 'calls credit with the amount described' do
      amount = rand_to_1000
      expect(transaction).to receive(:credit).with(amount)
      expect(statement).to receive(:add_credit_line).with(amount, '0.00')
      bank.credit(amount)
    end

    it 'errors out when non-number given' do
      expect { bank.credit('Hello') }.to raise_error 'Hello is not a number'
    end

    it 'errors out when negative number' do
      allow(transaction).to receive(:balance).and_return(0)
      expect { bank.credit(-1) }.to raise_error('Numbers must be positive.')
    end
  end

  describe '#debit' do
    it 'calls debit with the amount described' do
      amount = rand_to_1000
      expect(transaction).to receive(:balance).and_return(amount)
      expect(transaction).to receive(:debit).with(amount)
      expect(statement).to receive(:add_debit_line).with(amount, '0.00')
      bank.debit(amount)
    end

    it 'errors out when non-number given' do
      expect { bank.debit('Hello') }.to raise_error 'Hello is not a number'
    end

    it 'errors out when balance too low' do
      error_message = 'Balance too low. 0.00.'
      expect { bank.debit(1) }.to raise_error(error_message)
    end

    it 'errors out when negative number' do
      expect { bank.debit(-1) }.to raise_error('Numbers must be positive.')
    end
  end

  def rand_to_1000
    rand(1..1000)
  end
end
