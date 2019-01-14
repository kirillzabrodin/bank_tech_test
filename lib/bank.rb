class Bank
  def initialize
    @balance = 0
    @header = "date || credit || debit || balance\n"
    @statment = ''
  end

  def status
    @header + @statment
  end

  def credit(num)
    @balance += num
    line = "#{format('%.2f', num)} ||"
    add_to_statement(line)
    format('%.2f', @balance)
  end

  def debit(num)
    @balance -= num
    line = "|| #{format('%.2f', num)}"
    add_to_statement(line)
    format('%.2f', @balance)
  end

  private

  def add_to_statement(line)
    @statment.prepend("#{time} || #{line} || #{format('%.2f', @balance)}\n")
  end

  def time
    Time.now.strftime('%d/%m/%Y %H:%M')
  end
end
