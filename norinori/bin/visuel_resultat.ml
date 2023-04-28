let faire_visuel (j:jeu) (fichier:string) : unit =
    (*
    | SPÉCIFICATION
    | automate : permet douvrir un fichier, de le parser et retourner le jeu corespondant.
    | - Profil : automate : string -> jeu
    | - Sémantique : (lire_fichier string) : récupère toutes les lignes puis applique un String.fold_left avec l'automate et retourne le jeu renvoyé.
    | - Implémentation :
    *)
    let lines_array = Array.to_list (Arg.read_arg fichier) in (*on recupere les lignes*)
    let lines =  String.concat "" lines_array in (*on concatene toutes les lignes*)


