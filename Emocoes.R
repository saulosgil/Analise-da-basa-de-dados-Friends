# Carregando pacotes ------------------------------------------------------

library(ggplot2)
library(patchwork)

# Lendo a base da base Friends --------------------------------------------

a  <-  friends::friends_emotions |>
  dplyr::select(emotion) |>
  dplyr::filter(!emotion == "Neutral") # excluindo a emoção neutra

# Fazendo o gráfico para ver a emoção mais frequente -----------------------

g0 <- ggplot(data = a,
       mapping = aes(x = forcats::fct_reorder(emotion, emotion),
                     fill =  emotion)) +
  geom_bar(color = "black",
           show.legend = FALSE,
           width = 1) +
  labs(title = "FRIENDS: Número de Visualizações por temporada",
       x = "Característica da cena",
       y = "Frequência absoluta (n)"
      ) +
  theme(aspect.ratio = 1,
        plot.title = element_text(family = "Times New Roman",
                                  size = 14,
                                  hjust = 0.5),
        axis.title = element_text(family = "Times New Roman",
                                  size = 12,
                                  hjust = 0.5,
                                  face = "bold"),
        axis.line = element_line(colour = "black"),
        axis.ticks = element_line(colour = "black"),
        axis.text = element_text(family = "Times New Roman",
                                 size = 10,
                                 hjust = 0.5,
                                 face = "bold")) +
  scale_x_discrete(labels = c(
    "Joyful" = "Alegre",
    "Mad" = "Maluco",
    "Peaceful" = "Calmo",
    "Powerful" = "Poderoso",
    "Sad" = "Triste",
    "Scared" = "Assustado"
  )
)

g0 + labs(title = "Frequência de emoções de cada cena em todas as temporadas") +
  coord_flip() # barras na horizontal

g0 + coord_polar() # pie chart

