# Instalando pacotes e carregandos pacotes que serão utilizados ----------

install.packages("friends")
install.packages("patchwork")
library(friends)
library(patchwork)
library(ggplot2)

# Criando objeto com a base de dados --------------------------------------

b <- friends::friends_info

head(b)

# Verificar visualizações x avaliação (imdb) ------------------------------
# g1 considerado todas as temporadas
g1 <- b |>
  dplyr::select(us_views_millions, imdb_rating) |>
  ggplot(mapping = aes(x = us_views_millions,
                       y = imdb_rating)) +
  geom_point(fill = "blue", alpha = 0.5, size = 2, show.legend = FALSE) +
  geom_smooth(mapping = aes(us_views_millions, imdb_rating),
              color = "black",
              fill = "#5c5c5c",
              method = "lm",
              se = TRUE) +
  labs(x = "Visualizações(milhões)",
       y = "Avaliação (notas)"
  ) +
  theme_bw(base_size = 12)

# g2 considerado os episódios por temporada

g2 <- b |>
  dplyr::select(season, us_views_millions, imdb_rating) |>
  dplyr::rename("Temporada" = season) |>
  ggplot(mapping = aes(x = us_views_millions,
                       y = imdb_rating,
                       color = factor(x = Temporada))) +
  geom_point(alpha = 0.5, size = 2, show.legend = FALSE) +
  geom_smooth(mapping = aes(us_views_millions, imdb_rating),
              method = "lm",
              se = FALSE) +
  labs(x = "Visualizações(milhões)",
       y = "Avaliação (notas)"
       ) +
  theme_bw(base_size = 12) +
  theme(legend.position = "right",
        legend.direction = "vertical"
        )

# Juntando os gráficos ----------------------------------------------------

g1 + g2


