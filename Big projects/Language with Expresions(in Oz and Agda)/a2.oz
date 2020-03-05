declare
% constants are records with no fields, just a label
fun {True} ttt() end

fun {False} fff() end

% operator applications are records with subexpressions
fun {Eq Subexpr1 Subexpr2} eq(Subexpr1 Subexpr2) end


%Int exprestions
fun {Int N} int() end

%find type of expressions
%function that raises error if input is bool
fun {IsInt Expr}
  case Expr
  of ttt()
    then '???'
  [] fff()
    then '???'
  else true
  end
end

%function that raise erroe if input is Int
fun {IsBool Expr}
  case Expr
  of Int()
    then '???'
  else true
  end
end


%operations of expressions
fun {NEq Subexpr1 Subexpr2} neq(Subexpr1 Subexpr2) end

fun {GreaterorEqual Subexpr1 Subexpr2} goe(Subexpr1 Subexpr2) end

fun {Greater Subexpr1 Subexpr2}
  if {And {IsInt Subexpr1} {IsInt Subexpr2}} then gre(Subexpr1 Subexpr2) end
end

fun {LessorEqual Subexpr1 Subexpr2}
  if {And {IsInt Subexpr1} {IsInt Subexpr2}} then loe(Subexpr1 Subexpr2) end
end

fun {Less Subexpr1 Subexpr2}
  if {And {IsInt Subexpr1} {IsInt Subexpr2}} then les(Subexpr1 Subexpr2) end
end

fun {Plus Subexpr1 Subexpr2}
  if {And {IsInt Subexpr1} {IsInt Subexpr2}} then plus(Subexpr1 Subexpr2) end 
end

fun {Minus Subexpr1 Subexpr2}
  if {And {IsInt Subexpr1} {IsInt Subexpr2}} then minus(Subexpr1 Subexpr2) end
end

fun {Times Subexpr1 Subexpr2}
  if {And {IsInt Subexpr1} {IsInt Subexpr2}} then times(Subexpr1 Subexpr2) end
end

fun {Divs Subexpr1 Subexpr2}
  if {And {IsInt Subexpr1} {IsInt Subexpr2}} then divs(Subexpr1 Subexpr2) end
end

fun {Mods Subexpr1 Subexpr2}
  if {And {IsInt Subexpr1} {IsInt Subexpr2}} then mods(Subexpr1 Subexpr2) end
end

%Statements -- toDo



% To use this pretty print function with the Browser,
% enable “Virtual Strings” under “Options → Representations…”
fun {PrettyPrint Expr}
  case Expr
  of ttt()
     then 'true'
  [] fff()
     then 'false'
  [] eq(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" == "#{PrettyPrint Subexpr2}
  [] neq(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" /= "#{PrettyPrint Subexpr2}
  [] goe(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" >= "#{PrettyPrint Subexpr2}
  [] gre(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" > "#{PrettyPrint Subexpr2}
  [] loe(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" <= "#{PrettyPrint Subexpr2}
  [] les(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" < "#{PrettyPrint Subexpr2}
  [] plus(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" + "#{PrettyPrint Subexpr2}
  [] minus(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" - "#{PrettyPrint Subexpr2}
  [] times(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" * "#{PrettyPrint Subexpr2}
  [] divs(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" div "#{PrettyPrint Subexpr2}
  [] mods(Subexpr1 Subexpr2)
     then {PrettyPrint Subexpr1}#" mod "#{PrettyPrint Subexpr2}
  else '???' % error case
  end

end

{Browser {1 == 1}}