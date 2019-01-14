require 'bank'
require 'timecop'

describe Bank do
  t = Time.local(2008, 9, 1, 10, 5, 0)
  Timecop.travel(t) do

    describe 'status' do
      it 'returns empty status if no transactions' do
        expect(subject.status).to eq "date || credit || debit || balance\n"
      end

      it 'returns the status and latest transation' do
        subject.credit(1000)
        expect(subject.status).to eq "date || credit || debit || balance\n#{Time.now.strftime('%d/%m/%Y %H:%M')} || 1000.00 || || 1000.00\n"
      end

      it 'returns the status and latest transation in correct order' do
        subject.credit(10)
        subject.credit(1000)
        statement = "date || credit || debit || balance\n#{Time.now.strftime('%d/%m/%Y %H:%M')} || 1000.00 || || 1010.00\n#{Time.now.strftime('%d/%m/%Y %H:%M')} || 10.00 || || 10.00\n"
        expect(subject.status).to eq statement
      end
    end

    describe 'credit' do
      it 'credits the account with the amount described' do
        expect(subject.credit(1000)).to eq format('%.2f', 1000)
      end
    end

    describe 'debit' do
      it 'debits the account with the amount described' do
        expect(subject.debit(1000)).to eq format('%.2f', -1000)
      end
    end
  end
end
