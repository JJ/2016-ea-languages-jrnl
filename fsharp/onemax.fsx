open System

let iterations = 100000
let len        = 65536

let randombinary n =
    let rnd = System.Random()
    List.init n (fun _ -> rnd.Next(2))
    ;;

let benchmark length =
    // Random vector generation
    let vector = randombinary length
    
    // Timing
    let time = System.Diagnostics.Stopwatch.StartNew()
    let sum = List.sum (List.map (fun _ -> List.sum vector) [1..iterations])
    time.Stop()
    
    printf "F#-List, %d, %f\n" length (time.Elapsed.TotalMilliseconds/1000.0)
    ;;

[<EntryPoint>]
let main (argv:string[]) =
    [for n in 4..16 -> pown 2 n] |> List.iter (benchmark) 
    0
    ;;

