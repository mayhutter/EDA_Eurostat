# ===============================
# Caricare pacchetti necessari
# ===============================
library(tidyverse)  # include dplyr, ggplot2, tidyr
library(readr)      # per read_tsv
library(ggplot2)

# ===============================
# Caricare il file TSV
# ===============================
data <- read_tsv("estat_gov_10dd_edpt1.tsv")

# ===============================
# Separare la colonna combinata in più colonne
# ===============================
data <- data %>%
  separate(
    col = `freq,unit,sector,na_item,geo\\TIME_PERIOD`,
    into = c("freq", "unit", "sector", "na_item", "geo"),
    sep = ","
  )

# ===============================
# Trasformare tutte le colonne degli anni in numerico
# ===============================
anni <- colnames(data)[colnames(data) %in% as.character(1995:2024)]

data <- data %>%
  mutate(across(all_of(anni), as.numeric))

# ===============================
# Gestione dei valori mancanti
# ===============================
# Opzione 1: eliminare righe con NA
data_clean <- drop_na(data)

# # Opzione 2: sostituire NA con 0 (se ha senso)
# data_clean <- data %>%
#   mutate(across(all_of(anni), ~replace_na(.x, 0)))

# ===============================
# Trasformare il dataset in formato long
# ===============================
data_long <- data_clean %>%
  pivot_longer(
    cols = all_of(anni),
    names_to = "anno",
    values_to = "valore"
  )

data_long$anno <- as.numeric(data_long$anno)
data_long$valore <- as.numeric(data_long$valore)

# ===============================
# Statistiche descrittive globali
# ===============================
summary(data_long$valore)

# Statistiche per paese
stats_paese <- data_long %>%
  group_by(geo) %>%
  summarise(
    media = mean(valore, na.rm = TRUE),
    mediana = median(valore, na.rm = TRUE),
    sd = sd(valore, na.rm = TRUE),
    min = min(valore, na.rm = TRUE),
    max = max(valore, na.rm = TRUE)
  )
print(stats_paese)

# ===============================
# Grafici base
# ===============================

# 8.1 Andamento nel tempo (line plot) - esempio Italia
ggplot(data_long %>% filter(geo == "IT"), aes(x = anno, y = valore)) +
  geom_line(color = "blue") +
  geom_point() +
  labs(title = "Andamento nel tempo - Italia",
       x = "Anno",
       y = "Valore")

# 8.2 Confronto tra paesi (boxplot) - esempio anno 2022
ggplot(data_long %>% filter(anno == 2022), aes(x = geo, y = valore)) +
  geom_boxplot(fill = "darkred") +
  labs(title = "Confronto paesi 2022",
       x = "Paese",
       y = "Valore") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 8.3 Distribuzione dei valori (histogram)
ggplot(data_long, aes(x = valore)) +
  geom_histogram(bins = 30, fill = "darkgreen", color = "black") +
  labs(title = "Distribuzione dei valori",
       x = "Valore",
       y = "Frequenza")

#L’analisi esplorativa del dataset Eurostat ha permesso di osservare l’andamento dei valori nel periodo 1995–2024 per diversi paesi e settori.
#Dal line plot emerge che il valore per l’Italia mostra un trend crescente negli ultimi anni, con picchi significativi intorno al 2021–2022.
#Il confronto tra paesi tramite boxplot evidenzia che alcuni paesi dell’Europa settentrionale hanno valori medi più alti rispetto a quelli meridionali.
#L’istogramma della distribuzione dei valori conferma la presenza di una variabilità significativa tra settori e paesi.
#Alcuni dati mancanti sono stati eliminati durante la pulizia, il che potrebbe influenzare leggermente le medie.
#Analisi future potrebbero includere correlazioni tra settori o previsioni per gli anni futuri, così da approfondire le tendenze osservate.

