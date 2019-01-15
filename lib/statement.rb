class Statement
  def initialize
    @header = 'date || credit || debit || balance'
    @lines = []
  end

  def print
    puts @header.to_s
    @lines.each { |line| puts line }
  end

  def add_credit_line(amount, balance)
    add_to_statement(credit_format(amount), balance)
  end

  def add_debit_line(amount, balance)
    add_to_statement(debit_format(amount), balance)
  end

  private

  def add_to_statement(line, balance)
    @lines.push("#{time} || #{line} || #{balance}\n")
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
end
