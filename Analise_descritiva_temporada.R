library(ggplot2)

# Sumarizar (media e mediana) por temporada -------------------------------

bgrouped <-
  friends::friends_info |>
  dplyr::group_by(season) |>
  dplyr::summarise(mean_views = mean(us_views_millions),
                   median_views = median(us_views_millions))

# Dois episódios mais assistidos ------------------------------------------

top_2 <-
  friends::friends_info |>
  dplyr::arrange(desc(us_views_millions)) |>
  dplyr::select(season, title, us_views_millions) |>
  head(4) |>
  dplyr::distinct()

# Criando boxplot por temporada -------------------------------------------

camada1 <-
  friends::friends_info |> # boxplot por temporada
  ggplot(mapping = aes(x = factor(season),
                       y = us_views_millions,
                       color = factor(season))) +
  geom_boxplot(outlier.size = 1,
               notch = TRUE,
               show.legend = FALSE)

camada2 <- camada1 + # Inserindo valor da média
  geom_point(data = bgrouped,
             mapping = aes(x = factor(season),
                           y = mean_views),
             show.legend = FALSE,
             shape = 3,
             size = 2,
             stroke = 1.5
             )

camada3 <-  camada2 + # Rotulando as 2 maiores visualizações
  geom_label(data = top_2,
             mapping = aes(x = factor(season),
                           y = us_views_millions,
                           label = title),
             show.legend = FALSE
            ) +
   labs(title = "FRIENDS: Número de Visualizações por temporada",
       x = "Temporada",
       y = "Número de visualizaçãoes (milhões)") +
    theme_bw() +
    theme(plot.title = element_text(family = "Times New Roman",
                                    size = 18,
                                    hjust = 0.5),
          axis.title = element_text(size = 12, face = "bold"),
          axis.text = element_text(color = "black", size = 10, face = "bold")
    )

camada3
