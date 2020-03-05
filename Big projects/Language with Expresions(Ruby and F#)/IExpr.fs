module IExpr 
// Define IExpr type that can contain only int number
type IExpr() = class
    let mutable number = 0
    // method that return the value of IExpr
    member this.Num() = 
        number
    // Method that construct a new IExpr with input int
    member this.Const(a : int) =
        number <- a
        this
end

// Define functions that calculate on IExpr types.
// For all the functions, the inputs are IExpr types 
// The output is a new IExpr.
// They are easy to understand
let plus(a : IExpr, b : IExpr) = 
    let number = a.Num() + b.Num() 
    let c = IExpr()
    c.Const(number)
 
let minus(a : IExpr, b : IExpr) = 
    let number = a.Num() - b.Num()
    let c = IExpr()
    c.Const(number)

let times(a : IExpr, b : IExpr) = 
    let number = a.Num() * b.Num()
    let c = IExpr()
    c.Const(number)
    
let rec exp(a : IExpr, b : IExpr) =
    // We don't want negative power because IExpr only 
    // can calculate on int
    if b.Num() < 0 then 
        failwith "no negative power"
    else
        let mutable n = a.Num()
	// Calculate using for loop
        for i in 0 .. b.Num() do
            n <- n * a.Num()
        IExpr().Const(n)

let abs(a : IExpr) = 
    let n = a.Num()
    let mutable number = 0
    if n > -n then
        (number <- n)
    else (number <- -n)
    let c = IExpr()
    c.Const(number)

let neg(a : IExpr) =
    let number = -a.Num()
    let c = IExpr()
    c.Const(number)
// Function that output the int that input IExpr contains.
let interpret(a : IExpr) =
    a.Num()
    