declare
%%Map Function
fun {Map Rule L}
   % return [nil] when the input is nil. 
   if L == [nil] then
      [nil]
   else
      [{Rule A} suchthat A in L]
   end
end

%%Two functions that can be use to test
fun {Twice A}
   A + A
end
fun {Addone A}
   A + 1
end

declare
L0 = [nil]
L1 = [0]
L2 = [2 0 1 9]
L3 = [99 9 19 29]
L4 = [1 2 3 4]
{Browse {Map Twice L0}}
{Browse {Map Twice L1}}
{Browse {Map Twice L2}}
{Browse {Map Addone L3}}
{Browse {Map Addone L4}}
