
(*open Type_jeu*)
open Lire_jeu
open Ecrire_jeu
open Visuel_resultat




let () =
    if (Array.length Sys.argv != 2)
        then Printf.printf "\nusage: %s <nom>\n" Sys.argv.(0)
    else

    let nom:string = Sys.argv.(1) in (*le fichier est donné en argument*)
    let file_entree:string = (String.cat "INSTANCES/" (String.cat nom ".liz")) in
    let file_dimacs:string = (String.cat "DIMACS/" (String.cat nom ".dimacs")) in
    let file_sortie:string = (String.cat "RESULTATS/" (String.cat nom ".res")) in
    let file_visuel:string = (String.cat "RESULTATS/" (String.cat nom ".visu")) in

    (*Printf.printf "mon nom: %s\n" file;*)
    let mon_jeu = lire_fichier file_entree in (* on parse le fichier *)

    (*print_jeu mon_jeu;*) (*affichage de jeu*)
    sortie_dimacs file_dimacs mon_jeu;

    (* On va lancer minisat sur notre instance *)
    let commande = (String.cat "minisat " (String.cat file_dimacs (String.cat " " file_sortie))) in
    Printf.printf "\ncommande: %s\n" commande;
    let _ = Sys.command commande in
    faire_visuel mon_jeu file_sortie file_visuel;

    ()
    [@@warning "-8"]


