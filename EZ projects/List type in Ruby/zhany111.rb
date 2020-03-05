def Filter( condition, list)
  a = []
  for i in list do
    if condition.call(i)
      a += i
    end
  end
  return a
end

def f(n)
  if (n == 2)
    return true
  else
    return false
  end
end

l = [1, 2, 3]
puts Filter( f(:int), l)
