


let rec factorielle (n:int):int = 
            match n with
            | 0 | 1 -> 1
            | n when n > 0 -> n*(factorielle (n-1))
            | _ -> 1


let k_parmis_n (k:int) (n:int):int = 
            if (n < k) then 0
            else ((factorielle n) / ((factorielle k) * (factorielle (n-k))))
