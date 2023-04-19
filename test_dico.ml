type largeur = int;;
type hauteur = int;;
type nb_zones = int;;

type case = int*int;;
type list_zone = case list list;;
type jeu = largeur*hauteur*nb_zones*list_zone;;

type etat_automate = Largeur|Hauteur|Zone|Fin|CS of (int*int);; (*CS((x,y),liste_de_collones,colonne)*)
type mem_automate = jeu*int*etat_automate;;

let print_jeu ((larg, haut, zone, l): jeu) = 
    (*
    | SPÉCIFICATION
    | print_jeu : affiche dans le terminal le jeu.
    | - Profil : append_n_eme : element -> int -> 'a list list -> 'a list list
    | - Sémantique : (append_n_eme element int ('a list list) ('a list list)) : 
    | - Exemple et propriétés :
    |   (a) automate (5) (2) ([[0;1];[3;4];[]]):  [[0;1];[3;4];[5]]
    |   (b) automate ('u') (0) ([couco]):  [[coucou]]
    | - Implémentation :
*)
    let p_iteri (index: int) (l: case list) =
        let () = Printf.printf "    %d: [ " (index+1) in
        let () = (List.iter (fun (x,y) -> Printf.printf "(%d,%d); " x y) l ) in
        let () = Printf.printf "]\n" in
        ()
    in
    let () = Printf.printf "largeur: %d\nhauteur: %d\nnombre de zones: %d\ndictionnaire de zone:\n" larg haut zone  in
    let () = List.iteri p_iteri l in
    ()
;;

let rec append_n_eme (element: 'a) (n: int) (pr::fin: 'a list list): 'a list list =
    (*
    | SPÉCIFICATION
    | append_n_eme : rajoute un élément à la n eme liste de la liste de liste donné en argument.
    |                /!\ premier élément d'indice 0.
    |                /!\ la liste de liste donné doir avoir au moins n+1 listes (pour pouvoir incrémenter la n eme liste).
    | - Profil : append_n_eme : element -> int -> 'a list list -> 'a list list
    | - Sémantique : (append_n_eme element int ('a list list) ('a list list)) : 
    | - Exemple et propriétés :
    |   (a) automate (5) (2) ([[0;1];[3;4];[]]):  [[0;1];[3;4];[5]]
    |   (b) automate ('u') (0) ([couco]):  [[coucou]]
    | - Implémentation :
*)
    match n with
    | 0 -> (element::pr)::fin 
    | n -> pr::(append_n_eme element (n-1) fin)
    [@@warning "-8"]
;;

let automate (((larg, haut, zone, gril), nb, etat):mem_automate) (carac:char): mem_automate=
(*
    | SPÉCIFICATION
    | automate : a utiliser dans un String.fold_left, parse le fichier.
    | - Profil : automate : mem_automate -> char -> mem_automate
    | - Sémantique : (automate  mem_automate  char  mem_automate) : la fonction modifie mem_automate en fontion du caractere donnee et de son etat.
    | - Exemple et propriétés :
    |   (a) automate ((0, 0, 0, []), 15, Largeur) (';'): ((15, 0, 0, []), 0, Hauteur)
    |   (b) automate ((15, 0, 0, []), 2, Hauteur) ('4'): ((15, 0, 0, []), 24, Hauteur)
    | - Implémentation :
*)
    match carac,etat with
    | ';',Largeur ->    ((nb(*<- enregistre la largeur ici*), haut, zone, gril), 0, Hauteur) 
    | ';',Hauteur ->    ((larg, nb, zone, gril), 0, Zone)
    | ';',Zone ->       ((larg, haut, nb, List.init nb (fun x -> [])), 0, CS(1,1))
    |  _ ,Fin ->        ((larg, haut, zone, gril), 0, Fin)
    | ';',CS((x,y)) -> if (x == larg)
                        then if (y == haut) 
                            then ((larg, haut, zone, (append_n_eme (x,y) (nb-1) gril)), 0, Fin)
                            else ((larg, haut, zone, (append_n_eme (x,y) (nb-1) gril)), 0, CS(1,y+1))
                        else ((larg, haut, zone, (append_n_eme (x,y) (nb-1) gril)), 0, CS(x+1,y))
    | a,etat -> (*etat!=Fin*) if (((Char.code a) >= 48) && ((Char.code a) <= 57))
       then ((larg, haut, zone, gril), nb*10 + (Char.code a) - 48 (*ascii(48) = '0'*) , etat)
        else ((larg, haut, zone, gril), nb, etat) (* si le carac n'est pas reconus en tant que chiffre, on le passe*)
;;

let lire_fichier (file: string) : jeu = 
    (*
    | SPÉCIFICATION
    | automate : permet douvrir un fichier, de le parser et retourner le jeu corespondant.
    | - Profil : automate : string -> jeu
    | - Sémantique : (lire_fichier string) : récupère toutes les lignes puis applique un String.fold_left avec l'automate et retourne le jeu renvoyé.
    | - Implémentation :
*)
    let lines_array = Array.to_list (Arg.read_arg file) in (*on recupere les lignes*)
    let lines =  String.concat "" lines_array in (*on concatene toutes les lignes*)
    let (mon_jeu, _, _) = (String.fold_left (automate) ((((0,0,0,[]): jeu), 0, Largeur):mem_automate) lines ) in (*on parse*)
    mon_jeu (*return*)
;;







let file:string = ( if (Array.length Sys.argv == 2)
then Sys.argv.(1) (*le fichier est donné en argument*)
else "test.liz");; (*nom de fichier pas defaut*)
let mon_jeu = lire_fichier file;; (* on parse le fichier *)

print_jeu mon_jeu;; (*affichage de jeu*)


let a = 5;; 
