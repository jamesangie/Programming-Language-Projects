
let rec Reduce (rule, result, li : List<'T>) =
    let mutable l = li
    let mutable a = result
    ///when there are enough elements, produce
    /// the next output by recursion.
    if l.Length >= 1 then
        a <- rule(a, l.Head)
        l <- l.Tail 
        Reduce (rule, a, l)
    //if there are no more element, return the result
    else
        a

///The same idea as the last function, just inverse 
/// the input list
let rec Accumulate (rule, result, li : List<'T>) =
    let mutable l = li |> List.rev
    let mutable a = result
    if l.Length >= 1 then
        a <- rule(a, l.Head)
        l <- l.Tail 
        Accumulate (rule, a, l)
    else
        a

///Functions to test
let Sum (a, b) =
    a + b
let Power (a, b) =
    let mutable p = 1
    for i = 1 to b do
        p <- p * a
    p
let Add (a, b) =
    a + b

//empty list
let l0 = []
let t01 = Reduce(Sum, 0, l0)
let t02 = Accumulate(Sum, 0, l0)
printfn "%O" t01
printfn "%O" t02

//Sum and Power on non-empty int list 
let l1 = [1; 2; 3; 4]
let t11 = Reduce(Sum, 0, l1)
let t12 = Accumulate(Sum, 0, l1)
printfn "%O" t11
printfn "%O" t12


let l2 = [1; 2]
let t21 = Reduce(Power, 2, l2)
let t22 = Accumulate(Power, 2, l2)
printfn "%O" t21
printfn "%O" t22

let l3 = [1; 2; 3]
let t31 = Reduce(Power, 3, l3)
let t32 = Accumulate(Power, 3, l3)
printfn "%O" t31
printfn "%O" t32

//test Accumulate does reverse the list
let l4 = ["1"; "2"; "3"]
let t41 = Reduce(Add, "", l4)
let t42 = Accumulate(Add, "", l4)
printfn "%O" t41
printfn "%O" t42