import sys #Pour recuperer le nom du fichier a parse.

def parsing_fichier(fichier):
  # On ouvre le fichier
  f = open(fichier)
  lines_in_list = f.readlines()
  f.close()
  
  line = ""
  # On concatene toutes les lignes pour n'en faire que une.
  for elem in lines_in_list:
      line += elem

  c = 0
  buffer = ""
  info_grille = []
  nbr_separator_seen = 0

  # Parsing des info de la grille info_grille = [largeur, hauteur, nb_zone]
  while nbr_separator_seen < 3:
      if line[c] == ';':
          nbr_separator_seen += 1
          info_grille.append(int(buffer))
          buffer = ""
      else:
          buffer += line[c]

      c += 1

  # On recupere les information de la grille dans des variables
  largeur = info_grille[0]
  hauteur = info_grille[1]
  nb_zones = info_grille[2]
  #print(info_grille)

  # On crée une matrice vide de la taille de notre grille
  matrix = [[0 for y in range(hauteur)] for x in range(largeur)]

  # On parse le fichier dans la matrice
  i, j = 0, 0
  for c in range(c, len(line)-1):

      if j == largeur:
          j = 0
          i += 1

      if line[c] == ';':
          matrix[i][j] = int(buffer)
          buffer = ""
          j += 1

      else:
          buffer += line[c]

  #print(matrix)
  return info_grille,matrix

if __name__ == "__main__":
  info_grille, matrix = parsing_fichier(sys.argv[1])
  print(info_grille)
  print(matrix)
