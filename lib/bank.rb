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
    @statment.prepend("#{Time.now.strftime("%d/%m/%Y %H:%M")} || #{'%.2f' % num} || || #{'%.2f' % @balance}\n")
    return '%.2f' % @balance
  end

  def debit(num)
    @balance -= num
    @statment.prepend("#{Time.now.strftime("%d/%m/%Y %H:%M")} || || #{'%.2f' % num} || #{'%.2f' % @balance}\n")
    return '%.2f' % @balance
  end
end
