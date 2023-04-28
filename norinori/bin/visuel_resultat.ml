open Type_jeu

type etat_automate_2 = Espace | Mot
type memoire_automate_2 = out_channel*largeur*etat_automate_2*int

let automate (((file:out_channel),(l:largeur),(etat:etat_automate_2),(avancement:int)):memoire_automate_2) (carac:char): memoire_automate_2=
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
    match carac,etat,((avancement+1) mod l) with
    | ' ',_,_      ->     (file,l,Espace,avancement) 
    | '0',Espace,_ ->     (file,l,Mot,avancement)
    | '-',Espace,0 ->     Printf.fprintf file ".\n";
                          (file,l,Mot,(avancement+1))
    | '-',Espace,_ ->     Printf.fprintf file "."; 
                          (file,l,Mot,(avancement+1))
    |   _,Espace,0 ->     Printf.fprintf file "#\n"; 
                          (file,l,Mot,(avancement+1))
    |   _,Espace,_ ->     Printf.fprintf file "#"; 
                          (file,l,Mot,(avancement+1))
    |   _,_,_      ->     (file,l,Mot,avancement)




let faire_visuel (j:jeu) (nom_entree:string) (nom_sortie:string) : unit =
    (*
    | SPÉCIFICATION
    | automate : permet douvrir un fichier, de le parser et retourner le jeu corespondant.
    | - Profil : automate : string -> jeu
    | - Sémantique : (lire_fichier string) : récupère toutes les lignes puis applique un String.fold_left avec l'automate et retourne le jeu renvoyé.
    | - Implémentation :
    *)
    let (l,_,_,_) = j in 
    let lines_array = (Arg.read_arg nom_entree) in (*on recupere les lignes*)
    let solution = lines_array.(1) in (*on concatene toutes les lignes*)
    let file:out_channel = open_out nom_sortie in
    let _ = (String.fold_left automate (file, l, Espace, 0) solution) in
    Printf.fprintf file "\n";
    close_out file;
    ()
