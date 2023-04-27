
(*open Type_jeu*)
open Lire_jeu
open Ecrire_jeu

let () =
    let file:string = ( if (Array.length Sys.argv = 2)
      then Sys.argv.(1) (*le fichier est donné en argument*)
      else "test.liz") in (*nom de fichier pas defaut*)
    (*Printf.printf "mon nom: %s\n" file;*)
    let mon_jeu = lire_fichier file in (* on parse le fichier *)

    (*print_jeu mon_jeu;*) (*affichage de jeu*)
    let (l,h,_,_) = mon_jeu in 
    
    Printf.printf "cases:\n";
    dimacs_colonnes 1 l h; 
    Printf.printf "au plus 2:\n";
    dimacs_zone_au_plus_2 mon_jeu;
    Printf.printf "au moins 2:\n";
    dimacs_zone_au_moins_2 mon_jeu;
    ()
    [@@warning "-8"]


