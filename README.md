---
title: "README.md"
output: html_document
date: "2026-02-08"
---
# Exploratory Data Analysis - Eurostat Dataset

## Descrizione
Questo progetto consiste in un'analisi esplorativa di un dataset Eurostat (1995–2024) contenente dati su [inserisci tema: es. spesa pubblica, lavoro, sanità].  
Il progetto mostra come pulire i dati, trasformarli da formato wide a long e analizzarli in R.

## Obiettivo
- Analizzare trend temporali dei valori per paesi e settori
- Confrontare dati tra paesi
- Visualizzare distribuzioni e anomalie

## Dataset
- Fonte: Eurostat
- Formato: TSV
- Periodo: 1995–2024

## Tecnologie e pacchetti usati
- Linguaggio: R
- Pacchetti: tidyverse (dplyr, tidyr, ggplot2), readr

## Analisi eseguite
1. Pulizia dati (separazione colonne concatenate, gestione NA)  
2. Trasformazione da wide a long format  
3. Statistiche descrittive (media, mediana, deviazione standard, min, max)  
4. Visualizzazioni: line plot, boxplot, istogramma

## Conclusioni
- Trend principali per paesi e settori evidenziati
- Differenze tra paesi nel 2022 mostrate con boxplot
- La distribuzione dei valori conferma la variabilità dei dati
- Possibili sviluppi futuri: correlazioni, previsioni, analisi più approfondite

## Grafici
I grafici sono salvati nella cartella `figures` e includono:
- Andamento nel tempo (Italia)
- Confronto tra paesi (2022)
- Distribuzione dei valori
