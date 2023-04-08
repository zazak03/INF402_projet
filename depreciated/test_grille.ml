type largeur = int;;
type hauteur = int;;
type nb_zones = int;;

type case = int;;
type grille = case list list;;
type jeu = largeur*hauteur*nb_zones*grille;;

type etat_automate = Largeur|Hauteur|Zone|Fin|CS of (int*int)*case list list*case list;; (*CS((x,y),liste_de_collones,colonne)*)
type mem_automate = jeu*int*etat_automate;;



let file = "test.liz";;
let rec print_array (l:string list) = 
    match l with
        | pr::[] -> Printf.printf "%s\n" pr
        | pr::fin -> let ()= Printf.printf "%s\n" pr in print_array fin
        [@@warning "-8"]
;;
let lines_array = Arg.read_arg file;;
let lines = Array.to_list lines_array;;
print_array lines;;

let concatener_liste_string (l:string list) : string = String.concat "" l;;

Printf.printf "---\n";;
let all_lines = concatener_liste_string lines;;
Printf.printf "%s\n" all_lines;;
Printf.printf "---\n";;



let automate (((larg, haut, zone, gril), nb, etat):mem_automate) (carac:char): mem_automate=
    match carac,etat with
    | ';',Largeur ->    ((nb, haut, zone, []), 0, Hauteur)
    | ';',Hauteur ->    ((larg, nb, zone, []), 0, Zone)
    | ';',Zone ->       ((larg, haut, nb, []), 0, CS((1,1), [], []))
    |  _ ,Fin ->        ((larg, haut, zone, gril), 0, Fin)
    | ';',CS((x,y),liste_de_colones, colone) -> if (x == larg)
                        then if (y == haut) 
                            then ((larg, haut, zone, (List.rev ((List.rev (nb::colone))::liste_de_colones))), 0, (Fin))
                            else ((larg, haut, zone, []), 0, CS((1,y+1), ((List.rev (nb::colone))::liste_de_colones), []))
                        else ((larg, haut, zone, []), 0, CS((x+1,y), liste_de_colones, nb::colone))
    | a,etat -> (*etat!=Fin*) ((larg, haut, zone, []), nb*10 + (Char.code a) - 48 (*ascii(48) = '0'*) , etat);;




let mon_jeu = (0,0,0,[]);;
let ma_mem_automate = (mon_jeu, 0, Largeur);;

let mon_nouv_automate = (String.fold_left (automate) ma_mem_automate all_lines);;
let (mon_jeu, _, _) = mon_nouv_automate;;
mon_nouv_automate;;
mon_jeu;;

