while true 
  a = rand(1..99)

  print "Guess a value between 1 and 99: "
  b = gets.to_i

  while a != b 
    if a < b then print "It's too big! Guess again: "
    elsif a > b then print "It's too small! Guess again: "
    end
    b = gets.to_i
  end
  print "It's correct!\n"
  
end
