module IExpr_with_subst
// The IExpr class that can contain strings, can also substitube number into strings
// Most of the codes are same as in Part 1, just a few changes.
type IExpr() = class
    let mutable number = 0
    // with a initial value of letter, we can check if the IExpr.letter is empty or not
    let mutable letter = ""

    member this.Num() = 
	// check if this IExpr contains a letter, if yes then fail because
	// This method is only called on calculating numbers but not on letters
        if letter <> "" then failwith "cannot calculate letters"
        else 
            number
    // Method that return the letter IExpr contains. 
    member this.Letter() =
        letter
    // method that create a IExpr contains string
    member this.Ident(s : string) =
        letter <- s
        this

    member this.Const(a : int) =
        number <- a
        this
end

// Function that change s to a if s = a.
// We assume a is substituded only when s = b.letter()
// Same as in Part 1. All function returns a new IExpr.
let subst(s : string, a : IExpr, b : IExpr) =
    // fail when we connot subsitude anything
    if s = "" then failwith ("nothing to substitube")
    elif b.Letter() = "" then failwith ("nothing to be substituded")
    else
	// As we assumed, substitude only when s = b
        if b.Letter() = s then
            let c = a.Num()
            IExpr().Const(c)
        else 
            b
// Function that output the number IExpr contains
let interpret(a : IExpr) =
    // Check if IExpr contains a letter or not, if yes 
    // fail because we connot interpret letters
    if a.Letter() <> "" then
        failwith "cannot interpret expresion with letters"
    else 
        a.Num()

// Codes below are the same as in Part 1
let rec exp(a : IExpr, b : IExpr) =
    if b.Num() < 0 then 
        failwith "no negative power"
    else
        let mutable n = a.Num()
        for i in 0 .. b.Num() do
            n <- n * a.Num()
        IExpr().Const(n)
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
 





