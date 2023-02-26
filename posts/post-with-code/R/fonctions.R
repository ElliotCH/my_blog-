#' @title Diviser un traingle en trois traingles plus petit
#' 
#' @description Cette fonction prend en entrée les coordonnées de trois points A, B, C
#' qui définissent un triangle et renvoie une liste contenant les trois triangles
#' obtenus après la première itération de Sierpiński.
#' 
#' @param x coordonnée x des trois points (vecteur de longueur 3)
#' @param y coordonnée y des trois points (vecteur de longueur 3)
#' 
#' @return une liste de trois triangles, chaque triangle étant représenté par une
#' matrice 2x3 contenant les coordonnées x et y des trois sommets.
#' 
#' @exemples
#' triangle <- matrice(c(0, 0, 1, 0, 0.5, sqrt(3)/2), nrow = 3, ncol = 2)
#' diviser_triangle(triangle)
#'

divide_triangle <- function(triangle) {
  A <- triangle[1,]
  B <- triangle[2,]
  C <- triangle[3,]
  
  # Points médians des côtés du triangle
  AB <- (A + B) / 2
  AC <- (A + C) / 2
  BC <- (B + C) / 2
  
  # Les trois triangles issus de la première itération
  triangle1 <- rbind(A, AB, AC)
  triangle2 <- rbind(B, AB, BC)
  triangle3 <- rbind(C, AC, BC)
  
  return(list(triangle1, triangle2, triangle3))
}

#' @title Divise une liste de triangle en quatre triangles
#'
#' @description Étant donné une liste de matrices triangulaires, cette fonction renvoie une nouvelle liste de matrices triangulaires obtenu en divisant chaque triangle en triangles plus petits à l'aide de la fonction diviser_triangle.
#'
#' @param list_triangle une liste de matrices triangulaires
#' @return une nouvelle liste de matrices triangulaires
#' @exemples
#' triangle <- matrice(c(0, 0, 1, 0, 0.5, sqrt(3)/2), nrow = 3, ncol = 2)
#' liste_triangle <- liste(triangle, triangle, triangle)
#' diviser_liste_triangle(liste_triangle)
#'

divide_list_triangle <- function(list_triangle) {
  new_list_triangle <- c()
  for (triangle in list_triangle) {
    new_triangles <- divide_triangle(triangle)
    new_list_triangle <- c(new_list_triangle, new_triangles)
  }
  return(new_list_triangle)
}

#' @title plot 
#'
#' @description  Ctte fonction trace les triangles en utilisant ggplot2 a partir d'une liste de triangle.
#'
#' @param list_triangle une liste de matrices triangulaires
#' @return un objet ggplot
#' @exemples
#' triangle <- matrice(c(0, 0, 1, 0, 0.5, sqrt(3)/2), nrow = 3, ncol = 2)
#' liste_triangle <- liste(triangle, triangle, triangle)
#' plot_triangles(liste_triangle)
#'

library(ggplot2)

plot <- function(list_triangle) {
  plot_data <- data.frame(x = numeric(), y = numeric(), group = numeric())
  for (i in 1:length(list_triangle)) {
    triangle <- list_triangle[[i]]
    plot_data <- rbind(plot_data,
                       data.frame(x = c(triangle[1,1], triangle[2,1], triangle[3,1]),
                                  y = c(triangle[1,2], triangle[2,2], triangle[3,2]),
                                  group = i))
  }
  
  
  ggplot(plot_data, aes(x, y, group = group)) +
    geom_polygon(color = "black") +
    scale_x_continuous(limits = c(-0.1, 1.1), expand = c(0, 0)) +
    scale_y_continuous(limits = c(-0.1, 1.1), expand = c(0, 0)) +
    coord_fixed() +
    theme_void()
}


