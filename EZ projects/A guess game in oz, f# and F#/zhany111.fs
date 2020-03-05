open System

let guessgame() = //Define the game function
    let rnd = Random()
    let a = rnd.Next(100) // generate the number
    printf "Please enter a number between 1 and 99: " 
    let mutable s = ""
    s <- Console.ReadLine()
    let mutable b = s |> int // Get the user input numbner
    while not(a.Equals(b)) do // While not correct, let the user input again
        if a < b then 
            printf "It's too big! Guess another one: "
            s <- Console.ReadLine()
            b <- s |> int
        elif a > b then 
            printf "It's too small! Guess another one: "
            s <- Console.ReadLine()
            b <- s |> int
    printf "You are correct!\n" // Show winning

while true do //loop the function
    guessgame()