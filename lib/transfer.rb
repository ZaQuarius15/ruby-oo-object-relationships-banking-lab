require 'pry'

class Transfer

  attr_accessor :receiver, :amount, :status
  attr_reader :sender

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid? 
    if sender.valid? && receiver.valid?
      return true
    else
      return false
    end
  end

  def execute_transaction
    if self.valid? && @status == "pending" && @sender.balance >= @amount
      @sender.balance -= @amount
      self.receiver.deposit(@amount)
      @status = "complete"
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @receiver.balance -= @amount
      self.sender.deposit(@amount)
      @status = "reversed"
    end
  end
  
end
