# ─────────────────────────────────────────────────────────────────────────────
# CARGA DE LIBRERÍAS
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)
library(fmsb)
library(ggthemes)
library(showtext)
library(broom)
library(plm)
library(lmtest)
library(sandwich)
library(car)
library(patchwork)
library(tidyverse)
library(readxl)

# Configuración de la fuente
font_add(family = "Times", regular = "Times New Roman.ttf")
showtext_auto()

# ─────────────────────────────────────────────────────────────────────────────
# LECTURA E INSPECCIÓN DE DATOS
# ─────────────────────────────────────────────────────────────────────────────

df_final <- read.csv(
  file = "/Users/camilocarrascal/Library/Mobile Documents/com~apple~CloudDocs/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.csv",
  header = TRUE,
  stringsAsFactors = FALSE
)

head(df_final)
str(df_final)
summary(df_final)

# ─────────────────────────────────────────────────────────────────────────────
# CREACIÓN DE VARIABLES DE REZAGO (LAG) POR AÑO
# ─────────────────────────────────────────────────────────────────────────────

df_final <- df_final %>%
  mutate(
    rezago_2021 = 2021 - promedio_anio_2021,
    rezago_2022 = 2022 - promedio_anio_2022,
    rezago_2023 = 2023 - promedio_anio_2023,
    rezago_2024 = 2024 - promedio_anio_2024,
    rezago_2025 = 2025 - promedio_anio_2025
  )

# ─────────────────────────────────────────────────────────────────────────────
# GRÁFICO DE CAJA CON PUNTOS JITTER (BOXPLOT)
# ─────────────────────────────────────────────────────────────────────────────

df_rezago_all <- df_final %>%
  select(ECONOMY_NAME, starts_with("rezago_")) %>%
  pivot_longer(
    cols = starts_with("rezago_"),
    names_to = "año_GII",
    values_to = "rezago"
  ) %>%
  mutate(año_GII = gsub("rezago_", "", año_GII))

df_rank_long <- df_final %>%
  select(ECONOMY_NAME, starts_with("GII_Rank_")) %>%
  pivot_longer(
    cols = starts_with("GII_Rank_"),
    names_to = "año_rank",
    values_to = "GII_Rank"
  ) %>%
  mutate(año_GII = str_extract(año_rank, "\\d{4}")) %>%
  select(-año_rank)

df_plot <- df_rezago_all %>%
  left_join(df_rank_long, by = c("ECONOMY_NAME", "año_GII")) %>%
  drop_na(GII_Rank, rezago)

g <- ggplot(df_plot, aes(x = año_GII, y = rezago)) +
  geom_boxplot(outlier.shape = NA, width = 0.4, fill = "grey92", color = "black") +
  geom_jitter(aes(color = GII_Rank), width = 0.18, size = 2, alpha = 0.7) +
  scale_color_gradientn(
    colors = c("#08306B", "#B0B0B0", "#67000D"),
    name = "GII Rank",
    guide = guide_colorbar(barwidth = 10, barheight = 0.4, title.position = "top")
  ) +
  labs(x = "GII Year", y = "Data lag (years)") +
  theme_minimal(base_family = "Times") +
  theme(
    legend.position = "bottom",
    legend.title.align = 0.5,
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12),
    legend.text = element_text(size = 10),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.margin = margin(10, 10, 10, 10)
  )

print(g)
ggsave(
  filename = "/Users/camilocarrascal/Library/Mobile Documents/com~apple~CloudDocs/Desktop/2025/Tesis Doctorado /Códigos y Gráficos Finales/rezago_boxplot_anyo_a_anyo.png",
  plot = g,
  width = 8, height = 5.5, units = "in", dpi = 320
)

# ─────────────────────────────────────────────────────────────────────────────
# CREACIÓN DE REZAGOS INPUT Y OUTPUT
# ─────────────────────────────────────────────────────────────────────────────

df_final <- df_final %>%
  mutate(
    rezago_in_2021  = 2021 - promedio_IN_2021,
    rezago_in_2022  = 2022 - promedio_IN_2022,
    rezago_in_2023  = 2023 - promedio_IN_2023,
    rezago_in_2024  = 2024 - promedio_IN_2024,
    rezago_in_2025  = 2025 - promedio_IN_2025,
    
    rezago_out_2021 = 2021 - promedio_OUT_2021,
    rezago_out_2022 = 2022 - promedio_OUT_2022,
    rezago_out_2023 = 2023 - promedio_OUT_2023,
    rezago_out_2024 = 2024 - promedio_OUT_2024,
    rezago_out_2025 = 2025 - promedio_OUT_2025
  )

# ─────────────────────────────────────────────────────────────────────────────
# TABLA RESUMEN: MEDIA Y SD DEL DATA LAG POR AÑO
# ─────────────────────────────────────────────────────────────────────────────

tabla_lag_sd <- tibble(
  Year = 2025:2021,
  
  Overall_Mean = c(
    mean(df_final$rezago_2025, na.rm = TRUE),
    mean(df_final$rezago_2024, na.rm = TRUE),
    mean(df_final$rezago_2023, na.rm = TRUE),
    mean(df_final$rezago_2022, na.rm = TRUE),
    mean(df_final$rezago_2021, na.rm = TRUE)
  ),
  Overall_SD = c(
    sd(df_final$rezago_2025, na.rm = TRUE),
    sd(df_final$rezago_2024, na.rm = TRUE),
    sd(df_final$rezago_2023, na.rm = TRUE),
    sd(df_final$rezago_2022, na.rm = TRUE),
    sd(df_final$rezago_2021, na.rm = TRUE)
  ),
  
  IN_Mean = c(
    mean(df_final$rezago_in_2025, na.rm = TRUE),
    mean(df_final$rezago_in_2024, na.rm = TRUE),
    mean(df_final$rezago_in_2023, na.rm = TRUE),
    mean(df_final$rezago_in_2022, na.rm = TRUE),
    mean(df_final$rezago_in_2021, na.rm = TRUE)
  ),
  IN_SD = c(
    sd(df_final$rezago_in_2025, na.rm = TRUE),
    sd(df_final$rezago_in_2024, na.rm = TRUE),
    sd(df_final$rezago_in_2023, na.rm = TRUE),
    sd(df_final$rezago_in_2022, na.rm = TRUE),
    sd(df_final$rezago_in_2021, na.rm = TRUE)
  ),
  
  OUT_Mean = c(
    mean(df_final$rezago_out_2025, na.rm = TRUE),
    mean(df_final$rezago_out_2024, na.rm = TRUE),
    mean(df_final$rezago_out_2023, na.rm = TRUE),
    mean(df_final$rezago_out_2022, na.rm = TRUE),
    mean(df_final$rezago_out_2021, na.rm = TRUE)
  ),
  OUT_SD = c(
    sd(df_final$rezago_out_2025, na.rm = TRUE),
    sd(df_final$rezago_out_2024, na.rm = TRUE),
    sd(df_final$rezago_out_2023, na.rm = TRUE),
    sd(df_final$rezago_out_2022, na.rm = TRUE),
    sd(df_final$rezago_out_2021, na.rm = TRUE)
  )
) %>%
  mutate(across(-Year, ~ round(.x, 2)))

print(tabla_lag_sd)



# ─────────────────────────────────────────────────────────────────────────────
# ESTIMACIONES: CORRELACIONES Y GRÁFICOS DISPERSIÓN CON REGRESIÓN LINEAL
# ─────────────────────────────────────────────────────────────────────────────

correlaciones <- df_final %>%
  summarise(
    pearson_2021 = cor(GII_Score_2021, rezago_2021, use = "complete.obs", method = "pearson"),
    pearson_2022 = cor(GII_Score_2022, rezago_2022, use = "complete.obs", method = "pearson"),
    pearson_2023 = cor(GII_Score_2023, rezago_2023, use = "complete.obs", method = "pearson"),
    pearson_2024 = cor(GII_Score_2024, rezago_2024, use = "complete.obs", method = "pearson"),
    pearson_2025 = cor(GII_Score_2025, rezago_2025, use = "complete.obs", method = "pearson")
  )

df_cor <- correlaciones %>%
  pivot_longer(everything(), names_to = "year", values_to = "cor") %>%
  mutate(year = str_extract(year, "\\d{4}"))

theme_custom <- theme_minimal(base_family = "Times") +
  theme(
    plot.title = element_text(size = 16),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 13)
  )

plots <- map(df_cor$year, function(yr) {
  ggplot(df_final, aes_string(x = paste0("rezago_", yr), y = paste0("GII_Score_", yr))) +
    geom_point(color = "darkblue", alpha = 0.7) +
    geom_smooth(method = "lm", se = FALSE, color = "darkred", linewidth = 1) +
    labs(
      x = "Data lag (years)",
      y = "GII Score",
      title = paste("Year", yr, "(r =", round(df_cor$cor[df_cor$year == yr], 3), ")")
    ) +
    theme_custom
})

fig_cor <- (plots[[1]] | plots[[2]]) / (plots[[3]] | plots[[4]]) / plots[[5]]
print(fig_cor)

ggsave(
  filename = "/Users/camilocarrascal/Library/Mobile Documents/com~apple~CloudDocs/Desktop/2025/Tesis Doctorado /Códigos y Gráficos Finales/correlaciones_rezagos.png",
  plot = fig_cor,
  width = 14, height = 6, dpi = 320,
  bg = "transparent"
)

# ─────────────────────────────────────────────────────────────────────────────
# ESTIMACIONES OLS AÑO A AÑO
# ─────────────────────────────────────────────────────────────────────────────

cat("### Resultados OLS por año ###\n")
for (year in 2021:2025) {
  temp <- df_final %>%
    mutate(
      GII_Score = get(paste0("GII_Score_", year)),
      rezago = get(paste0("rezago_", year)),
      PPPPC = get(paste0("PPPPC_", year)),
      POP = get(paste0("POP_", year))
    ) %>%
    drop_na(GII_Score, rezago)
  
  model_ols <- lm(GII_Score ~ rezago + PPPPC + POP, data = temp)
  cat("\n--- OLS para el año", year, "---\n")
  print(summary(model_ols))
}

ols_rezago <- map_dfr(2021:2025, function(year) {
  temp <- df_final %>%
    mutate(
      GII_Score = get(paste0("GII_Score_", year)),
      rezago = get(paste0("rezago_", year)),
      PPPPC = get(paste0("PPPPC_", year)),
      POP = get(paste0("POP_", year))
    ) %>%
    drop_na(GII_Score, rezago)
  
  model <- lm(GII_Score ~ rezago + PPPPC + POP, data = temp)
  tidy(model) %>%
    filter(term == "rezago") %>%
    mutate(year = as.character(year))
})

g_rezago <- ggplot(ols_rezago, aes(x = year, y = estimate)) +
  geom_point(size = 3, color = "black") +
  geom_errorbar(aes(ymin = estimate - std.error, ymax = estimate + std.error),
                width = 0.15, color = "darkred") +
  labs(
    x = "Year",
    y = "Estimated effect of data lag on GII Score"
  ) +
  theme_minimal(base_family = "Times") +
  theme(
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 14)
  )

ggsave(
  filename = "/Users/camilocarrascal/Library/Mobile Documents/com~apple~CloudDocs/Desktop/2025/Tesis Doctorado /Códigos y Gráficos Finales/ols_rezago_effect.png",
  plot = g_rezago,
  width = 8, height = 5, units = "in", dpi = 320
)

# ─────────────────────────────────────────────────────────────────────────────
# ANÁLISIS DE DATOS DE PANEL
# ─────────────────────────────────────────────────────────────────────────────

df_panel <- df_final %>%
  pivot_longer(
    cols = starts_with("GII_Score_"),
    names_to = "year_score",
    values_to = "GII_Score"
  ) %>%
  mutate(year = str_extract(year_score, "\\d{4}")) %>%
  left_join(
    df_final %>%
      pivot_longer(
        cols = starts_with("rezago_"),
        names_to = "year_rezago",
        values_to = "rezago"
      ) %>%
      mutate(year = str_extract(year_rezago, "\\d{4}")) %>%
      select(ECONOMY_NAME, year, rezago),
    by = c("ECONOMY_NAME", "year")
  ) %>%
  left_join(
    df_final %>%
      pivot_longer(
        cols = starts_with("PPPPC_"),
        names_to = "year_ppp",
        values_to = "PPPPC"
      ) %>%
      mutate(year = str_extract(year_ppp, "\\d{4}")) %>%
      select(ECONOMY_NAME, year, PPPPC),
    by = c("ECONOMY_NAME", "year")
  ) %>%
  left_join(
    df_final %>%
      pivot_longer(
        cols = starts_with("POP_"),
        names_to = "year_pop",
        values_to = "POP"
      ) %>%
      mutate(year = str_extract(year_pop, "\\d{4}")) %>%
      select(ECONOMY_NAME, year, POP),
    by = c("ECONOMY_NAME", "year")
  ) %>%
  drop_na()

pdata <- pdata.frame(df_panel, index = c("ECONOMY_NAME", "year"))

fe_model <- plm(GII_Score ~ rezago + PPPPC + POP, data = pdata, model = "within")
re_model <- plm(GII_Score ~ rezago + PPPPC + POP, data = pdata, model = "random")

cat("\n\n### Modelo de Efectos Fijos (FE) ###\n")
print(summary(fe_model))

cat("\n\n### Modelo de Efectos Aleatorios (RE) ###\n")
print(summary(re_model))

cat("\n\n### Test de Hausman (FE vs RE) ###\n")
print(phtest(fe_model, re_model))

cat("\n\n### VIF para Multicolinealidad ###\n")
vif_model <- lm(GII_Score ~ rezago + PPPPC + POP, data = df_panel)
print(vif(vif_model))

cat("\n\n### Test de Heterocedasticidad (Breusch-Pagan) ###\n")
print(bptest(fe_model))

# ─────────────────────────────────────────────────────────────────────────────
# MODELO CON INPUT / OUTPUT DIFERENCIADOS
# ─────────────────────────────────────────────────────────────────────────────

df_panel <- df_panel %>%
  mutate(
    promedio_IN = case_when(
      year == "2021" ~ promedio_IN_2021,
      year == "2022" ~ promedio_IN_2022,
      year == "2023" ~ promedio_IN_2023,
      year == "2024" ~ promedio_IN_2024,
      year == "2025" ~ promedio_IN_2025
    ),
    promedio_OUT = case_when(
      year == "2021" ~ promedio_OUT_2021,
      year == "2022" ~ promedio_OUT_2022,
      year == "2023" ~ promedio_OUT_2023,
      year == "2024" ~ promedio_OUT_2024,
      year == "2025" ~ promedio_OUT_2025
    ),
    rezago_in = as.numeric(year) - promedio_IN,
    rezago_out = as.numeric(year) - promedio_OUT
  ) %>%
  drop_na(rezago_in, rezago_out)

pdata_io <- pdata.frame(df_panel, index = c("ECONOMY_NAME", "year"))
fe_model_io <- plm(GII_Score ~ rezago_in + rezago_out + PPPPC + POP,
                   data = pdata_io, model = "within")

cat("\n\n### Modelo con rezagos diferenciados (input/output) ###\n")
print(summary(fe_model_io))


cat("\n### VIF por año ###\n")

vif_por_anio <- map_dfr(2021:2025, function(year) {
  temp <- df_final %>%
    mutate(
      GII_Score = get(paste0("GII_Score_", year)),
      rezago = get(paste0("rezago_", year)),
      PPPPC = get(paste0("PPPPC_", year)),
      POP = get(paste0("POP_", year))
    ) %>%
    drop_na(GII_Score, rezago, PPPPC, POP)
  
  model <- lm(GII_Score ~ rezago + PPPPC + POP, data = temp)
  vif_vals <- car::vif(model)
  
  tibble(
    year = year,
    variable = names(vif_vals),
    vif = as.numeric(vif_vals)
  )
})

print(vif_por_anio)

# ─────────────────────────────────────────────────────────────────────────────
# CREACIÓN DE APÉNDICE
# INTEGRACIÓN DE CLASIFICACIÓN DE INGRESO DESDE LOS ARCHIVOS TECH1 DEL GII
# SIN MODIFICAR df_final
# ─────────────────────────────────────────────────────────────────────────────

# Ruta base donde están los archivos Excel
ruta_base <- "/Users/camilocarrascal/Library/Mobile Documents/com~apple~CloudDocs/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024"

# Nombres de archivos
archivo_2021 <- file.path(ruta_base, "wipo-pub-2000-2021-tech1.xlsx")
archivo_2022 <- file.path(ruta_base, "wipo-pub-2000-2022-tech1.xlsx")
archivo_2023 <- file.path(ruta_base, "wipo-pub-2000-2023-tech1.xlsx")
archivo_2024 <- file.path(ruta_base, "wipo-pub-2000-2024-tech1.xlsx")
archivo_2025 <- file.path(ruta_base, "wipo-pub-2000-2025-tech1.xlsx")

# Función para estandarizar grupos de ingreso
recode_income <- function(x) {
  case_when(
    is.na(x) ~ NA_character_,
    x %in% c("NA", "N/A", "n/a", "Unclassified", "unclassified", "") ~ NA_character_,
    x %in% c("HI", "H", "High income", "High-income") ~ "high_income",
    x %in% c("UM", "UMI", "Upper middle income", "Upper-middle income") ~ "upper_middle_income",
    x %in% c("LM", "LMI", "Lower middle income", "Lower-middle income") ~ "lower_middle_income",
    x %in% c("LI", "LIC", "Low income", "Low-income") ~ "low_income",
    TRUE ~ as.character(x)
  )
}

# Lectura de clasificación de ingreso 2021
income_2021 <- read_excel(archivo_2021, sheet = "Economies in Context") %>%
  select(ISO3, Income) %>%
  mutate(
    ISO3 = as.character(ISO3),
    income_2021 = recode_income(Income)
  ) %>%
  select(ISO3, income_2021)

# Lectura de clasificación de ingreso 2022
income_2022 <- read_excel(archivo_2022, sheet = "Economies") %>%
  select(ISO3, INCOME) %>%
  mutate(
    ISO3 = as.character(ISO3),
    income_2022 = recode_income(INCOME)
  ) %>%
  select(ISO3, income_2022)

# Lectura de clasificación de ingreso 2023
income_2023 <- read_excel(archivo_2023, sheet = "Economies") %>%
  select(ISO3, INCOME) %>%
  mutate(
    ISO3 = as.character(ISO3),
    income_2023 = recode_income(INCOME)
  ) %>%
  select(ISO3, income_2023)

# Lectura de clasificación de ingreso 2024
income_2024 <- read_excel(archivo_2024, sheet = "Economies") %>%
  select(ISO3, INCOME) %>%
  mutate(
    ISO3 = as.character(ISO3),
    income_2024 = recode_income(INCOME)
  ) %>%
  select(ISO3, income_2024)

# Lectura de clasificación de ingreso 2025
income_2025 <- read_excel(archivo_2025, sheet = "Economies") %>%
  select(ISO3, INCOME) %>%
  mutate(
    ISO3 = as.character(ISO3),
    income_2025 = recode_income(INCOME)
  ) %>%
  select(ISO3, income_2025)

# ─────────────────────────────────────────────────────────────────────────────
# CREACIÓN DE COPIA ENRIQUECIDA DE df_final
# df_final NO SE TOCA
# ─────────────────────────────────────────────────────────────────────────────

df_final_income <- df_final %>%
  mutate(ISO3 = as.character(ISO3)) %>%
  left_join(income_2021, by = "ISO3") %>%
  left_join(income_2022, by = "ISO3") %>%
  left_join(income_2023, by = "ISO3") %>%
  left_join(income_2024, by = "ISO3") %>%
  left_join(income_2025, by = "ISO3") %>%
  mutate(
    income_group_fixed_2025 = income_2025,
    rezago_2021 = 2021 - promedio_anio_2021,
    rezago_2022 = 2022 - promedio_anio_2022,
    rezago_2023 = 2023 - promedio_anio_2023,
    rezago_2024 = 2024 - promedio_anio_2024,
    rezago_2025 = 2025 - promedio_anio_2025
  )

# ─────────────────────────────────────────────────────────────────────────────
# APÉNDICE
# BASE LARGA CON CLASIFICACIÓN DE INGRESO VARIABLE POR AÑO
# ─────────────────────────────────────────────────────────────────────────────

df_appendix <- df_final_income %>%
  transmute(
    ISO3,
    ECONOMY_NAME,
    
    GII_Score_2021, GII_Score_2022, GII_Score_2023, GII_Score_2024, GII_Score_2025,
    rezago_2021, rezago_2022, rezago_2023, rezago_2024, rezago_2025,
    PPPPC_2021, PPPPC_2022, PPPPC_2023, PPPPC_2024, PPPPC_2025,
    POP_2021, POP_2022, POP_2023, POP_2024, POP_2025,
    
    income_2021, income_2022, income_2023, income_2024, income_2025
  ) %>%
  pivot_longer(
    cols = -c(ISO3, ECONOMY_NAME),
    names_to = c(".value", "year"),
    names_pattern = "(.*)_(2021|2022|2023|2024|2025)"
  ) %>%
  mutate(
    year = as.integer(year),
    income_group = income
  ) %>%
  drop_na(GII_Score, rezago, income_group)

cat("\n### Base de apéndice (dinámica por año) ###\n")
print(head(df_appendix, 15))

cat("\n### Conteo por año y grupo de ingreso ###\n")
print(table(df_appendix$year, df_appendix$income_group))

# ─────────────────────────────────────────────────────────────────────────────
# TABLA A1 — CORRELACIONES POR GRUPO DE INGRESO Y AÑO
# ─────────────────────────────────────────────────────────────────────────────

cor_test_safe <- function(x, y) {
  ok <- complete.cases(x, y)
  x <- x[ok]
  y <- y[ok]
  
  if (length(x) < 3 || sd(x) == 0 || sd(y) == 0) {
    return(tibble(
      n = length(x),
      pearson_r = NA_real_,
      p_value = NA_real_
    ))
  }
  
  test <- cor.test(x, y, method = "pearson")
  
  tibble(
    n = length(x),
    pearson_r = unname(test$estimate),
    p_value = test$p.value
  )
}

tabla_A1_long <- df_appendix %>%
  group_by(year, income_group) %>%
  group_modify(~ cor_test_safe(.x$rezago, .x$GII_Score)) %>%
  ungroup() %>%
  mutate(
    sig = case_when(
      is.na(p_value) ~ "",
      p_value < 0.01 ~ "***",
      p_value < 0.05 ~ "**",
      p_value < 0.10 ~ "*",
      TRUE ~ ""
    ),
    pearson_display = ifelse(
      is.na(pearson_r),
      NA,
      paste0(sprintf("%.3f", pearson_r), sig)
    )
  )

cat("\n### Tabla A1 (formato largo) ###\n")
print(tabla_A1_long)

tabla_A1 <- tabla_A1_long %>%
  select(year, income_group, pearson_display) %>%
  pivot_wider(
    names_from = income_group,
    values_from = pearson_display
  ) %>%
  arrange(year)

cat("\n### Tabla A1 (formato ancho) ###\n")
print(tabla_A1)

# ─────────────────────────────────────────────────────────────────────────────
# TABLA A2 — OLS POR GRUPO DE INGRESO Y AÑO (HC0)
# ─────────────────────────────────────────────────────────────────────────────

ols_safe <- function(data) {
  data <- data %>%
    drop_na(GII_Score, rezago, PPPPC, POP)
  
  if (nrow(data) < 10) {
    return(tibble(
      n = nrow(data),
      beta_rezago = NA_real_,
      se_hc0 = NA_real_,
      p_value = NA_real_,
      adj_r2 = NA_real_
    ))
  }
  
  model <- lm(GII_Score ~ rezago + PPPPC + POP, data = data)
  vcov_hc0 <- vcovHC(model, type = "HC0")
  test <- coeftest(model, vcov = vcov_hc0)
  
  tibble(
    n = nrow(data),
    beta_rezago = test["rezago", "Estimate"],
    se_hc0 = test["rezago", "Std. Error"],
    p_value = test["rezago", "Pr(>|t|)"],
    adj_r2 = summary(model)$adj.r.squared
  )
}

tabla_A2_long <- df_appendix %>%
  group_by(year, income_group) %>%
  group_modify(~ ols_safe(.x)) %>%
  ungroup() %>%
  mutate(
    sig = case_when(
      is.na(p_value) ~ "",
      p_value < 0.01 ~ "***",
      p_value < 0.05 ~ "**",
      p_value < 0.10 ~ "*",
      TRUE ~ ""
    ),
    beta_display = ifelse(
      is.na(beta_rezago),
      NA,
      paste0(sprintf("%.3f", beta_rezago), sig)
    ),
    se_display = ifelse(
      is.na(se_hc0),
      NA,
      paste0("(", sprintf("%.3f", se_hc0), ")")
    )
  )

cat("\n### Tabla A2 ###\n")
print(tabla_A2_long)
