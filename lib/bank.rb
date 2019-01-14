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
    line = "#{time} || #{format('%.2f', num)} || || #{format('%.2f', @balance)}"
    add_to_statement(line)
    format('%.2f', @balance)
  end

  def debit(num)
    @balance -= num
    line = "#{time} || || #{format('%.2f', num)} || #{format('%.2f', @balance)}"
    add_to_statement(line)
    format('%.2f', @balance)
  end

  private

  def add_to_statement(line)
    @statment.prepend("#{line}\n")
  end

  def time
    Time.now.strftime('%d/%m/%Y %H:%M')
  end
end
