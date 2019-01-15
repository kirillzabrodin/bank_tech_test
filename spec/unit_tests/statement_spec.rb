require 'statement'

describe Statement do
  subject(:statement) { Statement.new }
  let(:header) { "date || credit || debit || balance\n" }

  describe '#print' do
    it 'prints statment to terminal' do
      expect { subject.print }.to output(header).to_stdout
    end
  end

  describe '#add_credit_line' do
    it 'adds correctly formatted line' do
      credit_line = ["01/09/2008 || 1.00 || || 2\n"]
      expect(statement.add_credit_line(1, 2)).to eq credit_line
    end
  end

  describe '#add_debit_line' do
    it 'adds correctly formatted line' do
      debit_line = ["01/09/2008 || || 1.00 || 2\n"]
      expect(statement.add_debit_line(1, 2)).to eq debit_line
    end
  end
end
