# coding: utf-8
class IExpr
  # Task 1
  attr_accessor :number

  # constructor of IExpr. We don't need to worry about types
  # that much because int can be calculated with float in ruby
  def const(n1)
    # Raise error if the input is not an integer
    if not(n1.is_a?(Integer))
      raise "can only calculate int"
    else
      @number = n1
      return self
    end
  end

  #Easily define methods to calculate numbers.
  #In each method, return value is self
  def neg(n1)
    @number = -n1.number
    return self
  end

  def abs(n1)
    #check if input >= 0 or not
    if n1.number >= 0
      @number = n1.number
    else
      @number = 0-n1.number
    end
    return self
  end

  def plus(n1, n2)
    @number = n1.number + n2.number
    return self
  end

  def times(n1, n2)
    @number = n1.number * n2.number
    return self
  end

  def minus(n1, n2)
    @number = n1.number - n2.number
    return self
  end

  def exp(n1, n2)
    @number = n1.number ** n2.number
    return self
  end

  # the function that return the value of IExpr
  def interpret
    return @number
  end

end
