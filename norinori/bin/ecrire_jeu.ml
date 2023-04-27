open Type_jeu

let coord_to_case (x:int) (y:int) (l:largeur) : (int) =
    x + (y-1)*l


let rec dimacs_case_de_colonnes (x:int) (y:int) (l:largeur) (h:hauteur) : (unit) =
    (* Effectue la règle 1 sur tout les case d'une colone *)
     match x,y with
        | _,y when y = h+1 -> ()

        (* Règle N°1 & 2 *)

        (* Cas spéciaux *)
        (* Cases dans les Coins *)

        | 1,1 -> 
                 Printf.printf "-%d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                 Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

        | 1,y when y = h -> 
                 Printf.printf "-%d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                 Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

        | x,1 when x = l -> 
                 Printf.printf "-%d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                 Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

        | x,y when x = l && y = h -> 
                 Printf.printf "-%d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                 Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

        (* Cases sur les arretes / bords *)

        | _,1 ->    
                    Printf.printf "-%d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

        | 1,_ ->    
                    Printf.printf "-%d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

        | x,_ when x = l ->    
                    Printf.printf "-%d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

        | _,y when y = h ->    
                    Printf.printf "-%d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

        (* Cas généraux *)

        | _,_ ->      
                    Printf.printf "-%d %d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                    Printf.printf "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes x (y+1) l h

let rec dimacs_colonnes (x:int) (l:largeur) (h:hauteur) : unit =
    match x with
        | x when x = l+1 -> ()
        | _ -> dimacs_case_de_colonnes x 1 l h;
               dimacs_colonnes (x+1) l h;
               ()
 
let rec applique_au_plus_sur_une_zone (l:largeur) (h:hauteur) (z:zone) (n:int) (to_print:string) : unit =
            match n,z with
            | 0,_ -> Printf.printf "%s 0\n" to_print
            | _,[] -> ()
            | _,(x,y)::fin ->
                        (Int.to_string (-(coord_to_case x y l)))
                        |> fun str -> (String.cat str " ")
                        |> (String.cat to_print)
                        |> (applique_au_plus_sur_une_zone l h fin (n-1));
            applique_au_plus_sur_une_zone l h fin n to_print



let dimacs_zone_au_plus_2 (j:jeu) : unit =
            (* Regle du au plus 2, soit les triplés de non. *)
            let (l,h,_,zl) = j in
            List.iter (fun z -> applique_au_plus_sur_une_zone l h z 3 "") zl 
            
let b (l:largeur) (case_a_ignorer:case) (c:case):unit =
            if (c = case_a_ignorer)
                        then ()
                        else let (x,y) = c in
                            Printf.printf "%d " (coord_to_case x y l)

let a (z:zone) (fonction_a_iterer: case -> case -> unit) (c:case) : unit = 
            List.iter (fonction_a_iterer c) z;
            Printf.printf("0\n")

let applique_au_moins_sur_une_zone (l:largeur) (z:zone): unit =
            List.iter (a z (b l)) z;
            ()


let dimacs_zone_au_moins_2 (j:jeu) : unit =
            let (l,_,_,lz) = j in
            List.iter (applique_au_moins_sur_une_zone l) lz; 
            ()
            (* Regle du au moins 2, toutes les combinaisons sauf une. *)
(*
let rec dimacs_zone (jeu:jeu) : unit =
            let (largeur,hauteur,nb_zones,list_zone) = jeu in 

            (* Règle N°3 *)
            
            dimacs_zone_au_plus_2 jeu;
            dimacs_zone_au_moins_2 jeu;
*)

