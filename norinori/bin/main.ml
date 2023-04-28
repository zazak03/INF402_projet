
(*open Type_jeu*)
open Lire_jeu
open Ecrire_jeu

let () =
    if (Array.length Sys.argv != 2)
        then Printf.printf "\nusage: %s <nom>\n" Sys.argv.(0)
    else
    let nom:string = Sys.argv.(1) in (*le fichier est donné en argument*)
    let file_entree:string = (String.cat "INSTANCES/" (String.cat nom ".liz")) in
    let file_dimacs:string = (String.cat "DIMACS/" (String.cat nom ".dimacs")) in
    (*Printf.printf "mon nom: %s\n" file;*)
    let mon_jeu = lire_fichier file_entree in (* on parse le fichier *)

    (*print_jeu mon_jeu;*) (*affichage de jeu*)
    sortie_dimacs file_dimacs mon_jeu;
    ()
    [@@warning "-8"]


