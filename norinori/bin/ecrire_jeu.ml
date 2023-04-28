open Type_jeu

let coord_to_case (x:int) (y:int) (l:largeur) : (int) =
    x + (y-1)*l


let rec dimacs_case_de_colonnes (file:out_channel) (x:int) (y:int) (l:largeur) (h:hauteur) : (unit) =
    (* Effectue la règle 1 sur tout les case d'une colone *)
     match x,y with
        | _,y when y = h+1 -> ()

        (* Règle N°1 & 2 *)

        (* Cas spéciaux *)
        (* Cases dans les Coins *)

        | 1,1 ->
                if (x=l && y=h) then 
                        Printf.fprintf file "-%d 0\n" (coord_to_case x y l);
                        dimacs_case_de_colonnes file x (y+1) l h
                else
                (if (x=l) then 
                        Printf.fprintf file "-%d -%d 0\n" (coord_to_case x y l) (coord_to_case x (y+1) l);
                        dimacs_case_de_colonnes file x (y+1) l h
                else
                if (y=h) then 
                        Printf.fprintf file "-%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l);
                        dimacs_case_de_colonnes file x (y+1) l h
                else
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                Printf.fprintf file "-%d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                (* Ensuite on Récure *)
                )
                dimacs_case_de_colonnes file x (y+1) l h

        | 1,y when y = h -> 
                Printf.fprintf file "-%d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes file x (y+1) l h

        | x,1 when x = l -> 
                Printf.fprintf file "-%d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes file x (y+1) l h

        | x,y when x = l && y = h -> 
                Printf.fprintf file "-%d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes file x (y+1) l h

        (* Cases sur les arretes / bords *)

        | _,1 ->    
                Printf.fprintf file "-%d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes file x (y+1) l h

        | 1,_ ->    
                Printf.fprintf file "-%d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes file x (y+1) l h

        | x,_ when x = l ->    
                Printf.fprintf file "-%d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes file x (y+1) l h

        | _,y when y = h ->    
                Printf.fprintf file "-%d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes file x (y+1) l h

        (* Cas généraux *)

        | _,_ ->      
                Printf.fprintf file "-%d %d %d %d %d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case (x-1) y l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y+1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x+1) y l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y+1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case (x-1) y l) (coord_to_case x (y-1) l);
                Printf.fprintf file "-%d -%d -%d 0\n" (coord_to_case x y l) (coord_to_case x (y+1) l) (coord_to_case x (y-1) l);
                
                (* Ensuite on Récure *)
                dimacs_case_de_colonnes file x (y+1) l h

let rec dimacs_colonnes (file:out_channel) (x:int) (l:largeur) (h:hauteur) : unit =
    match x with
        | x when x = l+1 -> ()
        | _ -> dimacs_case_de_colonnes file x 1 l h;
               dimacs_colonnes file (x+1) l h;
               ()
 
let rec applique_au_plus_sur_une_zone (file:out_channel) (l:largeur) (h:hauteur) (z:zone) (n:int) (to_print:string) : unit =
            match n,z with
            | 0,_ -> Printf.fprintf file "%s 0\n" to_print
            | _,[] -> ()
            | _,(x,y)::fin ->
                        (Int.to_string (-(coord_to_case x y l)))
                        |> fun str -> (String.cat str " ")
                        |> (String.cat to_print)
                        |> (applique_au_plus_sur_une_zone file l h fin (n-1));
            applique_au_plus_sur_une_zone file l h fin n to_print



let dimacs_zone_au_plus_2 (file:out_channel) (j:jeu) : unit =
            (* Regle du au plus 2, soit les triplés de non. *)
            let (l,h,_,zl) = j in
            List.iter (fun z -> applique_au_plus_sur_une_zone file l h z 3 "") zl 
            
let iterateur_2_au_moin_2 (file:out_channel) (l:largeur) (case_a_ignorer:case) (c:case):unit =
            if (c = case_a_ignorer)
                        then ()
                        else let (x,y) = c in
                            Printf.fprintf file "%d " (coord_to_case x y l)

let iterateur_1_au_moin_2 (file:out_channel) (z:zone) (fonction_a_iterer: case -> case -> unit) (c:case) : unit = 
            List.iter (fonction_a_iterer c) z;
            Printf.fprintf file "0\n"

let applique_au_moins_sur_une_zone (file:out_channel) (l:largeur) (z:zone): unit =
            List.iter (iterateur_1_au_moin_2 file z (iterateur_2_au_moin_2 file l)) z;
            ()


let dimacs_zone_au_moins_2 (file:out_channel) (j:jeu) : unit =
            let (l,_,_,lz) = j in
            List.iter (applique_au_moins_sur_une_zone file l) lz; 
            ()
            (* Regle du au moins 2, toutes les combinaisons sauf une. *)

let en_tete (file:out_channel) (j:jeu):unit =
            let (l,h,_,lz) = j in
            let regle_cases:int = (7*l*h - 3*(2*l + 2*h) + 4) in
            let regle_au_plus_2:int = l*h in
            let regle_au_moins_2:int = List.fold_left (fun x z -> (Maths.k_parmis_n 3 (List.length z)) + x) 0 lz in
            Printf.fprintf file "p cnf %d %d\n" (l*h) (regle_cases + regle_au_moins_2 + regle_au_plus_2);
            ()

let sortie_dimacs (nom_sortie:string) (j:jeu) : unit = 
            

            let file:out_channel = open_out nom_sortie in

            (* Règle N°1&2 *)
            
            let (l,h,_,_) = j in
            en_tete file j;
            dimacs_colonnes file 1 l h; 

            (* Règle N°3 *)
            
            dimacs_zone_au_plus_2 file j;
            dimacs_zone_au_moins_2 file j;
            close_out file;
            ()




