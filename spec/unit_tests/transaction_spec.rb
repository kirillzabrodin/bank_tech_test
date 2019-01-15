require 'transaction'

describe Transaction do
  subject(:subject) { Transaction.new }

  describe '#initialize' do
    it 'starts balance at 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#credit' do
    it 'changes balance by given number' do
      n = rand_to_1000
      expect { subject.credit(n) }.to change { subject.balance }.from(0).to(n)
    end
  end

  describe '#debit' do
    it 'changes balance by given number' do
      n = rand_to_1000
      expect { subject.debit(n) }.to change { subject.balance }.from(0).to(-n)
    end
  end

  def rand_to_1000
    rand(1..1000)
  end
end
