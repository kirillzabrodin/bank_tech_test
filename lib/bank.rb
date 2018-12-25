class Bank

  def initialize
    @balance = 0
    @statment = "date || credit || debit || balance\n"
  end

  def status
    return @statment
  end

  def credit(num)
    @balance += num
    @statment += "#{Time.now.strftime("%d/%m/%Y %H:%M")} || #{'%.2f' % num} || || #{'%.2f' % @balance}\n"
    return '%.2f' % @balance
  end

  def debit(num)
    @balance -= num
    @statment += "#{Time.now.strftime("%d/%m/%Y %H:%M")} || #{'%.2f' % num} || || #{'%.2f' % @balance}\n"
    return '%.2f' % @balance
  end

end
