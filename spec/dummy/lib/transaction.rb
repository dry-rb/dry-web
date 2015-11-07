require 'rodakase/transaction'

class Transaction
  def success(*args)
    Rodakase::Transaction.Success(*args)
  end

  def failure(*args)
    Rodakase::Transaction.Failure(*args)
  end
end
