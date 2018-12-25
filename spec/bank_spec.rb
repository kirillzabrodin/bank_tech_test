require 'bank'


describe Bank do

  describe 'status' do
    it 'returns empty status if no transactions' do
      expect(subject.status).to eq 'date || credit || debit || balance'
    end
  end

end
