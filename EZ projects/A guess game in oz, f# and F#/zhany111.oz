declare
fun {Fact N}
   if N==0 then 1 else N*{Fact N-1} end
end

fun {Comb N R}
   {Fact N} div ({Fact R}*{Fact N-R})
end

%Below this are my codes

fun {Fact2 A B} %Calculate the product of all integers from A down to B
   (if A==B then 1
   else A*{Fact2 A-1 B} end)
end

fun {Comb2 N R} %modified comb function.
   {Fact2 N N-R} div {Fact R}
end

fun {Comb3 N R} %The function that is even more efficient
   if R > N-R then ({Fact2 N R} div {Fact N-R}) end
   {Fact2 N N-R} div {Fact R}
end

{Browse {Comb3 10 7}}