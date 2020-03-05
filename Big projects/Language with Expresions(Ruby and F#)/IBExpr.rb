# coding: utf-8
$LOAD_PATH << '.'
require 'IExpr.rb'
# Easily construct IBExpr class that oprates on bool types
class IBExpr
  #Task 2
  attr_accessor :b
  # In each method, return self
  def ttt()
    @b = true
    return self
  end
  
  def fff()
    @b = false
    return self
  end
  
  def lnot(a)
    @b = not(a.b)
    return self
  end
  
  def land(a, c)
    @b = a.b && c.b
    return self
  end

  def lor(a, c)
    @b = a.b || c.b
    return self
  end
  
  #Output the bool value of IBExpr
  def interpret
    return @b
  end
  
end
