# Maven_Spotify_Streaming_History

This repository contains a Jupyter Notebook (`Maven_Spotify_Streaming_History.ipynb`) that analyzes personal Spotify streaming history using Python. The notebook leverages data science techniques to uncover insights into listening habits, focusing on artist preferences, song engagement, daily listening patterns, and the balance between exploring new music versus replaying favorites. The analysis is conducted with a filter of `ms_played > 30,000 ms` to ensure meaningful listening data is considered, and visualizations are created using libraries like Matplotlib and Seaborn.

## Overview

The notebook imports Spotify streaming data and metadata, processes it to answer key questions, and generates visualizations to support the findings. It is designed for data enthusiasts or anyone interested in exploring their own streaming habits with a structured, reproducible approach.

## Features

- **Data Import and Cleaning**: Loads Spotify streaming history and metadata from CSV files, setting up a clean DataFrame for analysis.
- **Dependency Setup**: Utilizes Python libraries including `pandas`, `numpy`, `matplotlib`, and `seaborn` for data manipulation and visualization.
- **Key Analyses**:
  - Identifies the top artists for 2023 and 2024, revealing shifts in preferences.
  - Analyzes the most-played songs and their skip rates to gauge engagement.
  - Examines daily listening patterns across morning, afternoon, evening, and night shifts.
  - Compares the proportion of time spent on new artists versus favorite artists, highlighting exploration versus loyalty.
- **Visualization**: Includes charts (e.g., bar plots, pie charts) to visually represent the data insights.
- **Documentation**: Provides inline comments and a summary of findings within the notebook.

## Usage

- The notebook is structured with Markdown cells for explanations and code cells for execution.
- Modify the file paths or data filters (e.g., `ms_played > 30,000 ms`) to suit your dataset.
- Run all cells sequentially to replicate the analysis or explore individual sections based on interest.

## Findings Summary

- **Artist Preference Shift**: The top artist changed from The Killers in 2023 to John Mayer in 2024, with John Mayer leading with ~14,000 minutes in 2024.
- **Song Engagement**: "Ode to The Mets" by The Strokes is the most-played song (~175 plays, ~10,000 minutes) with a low 0.5% skip rate, while "Concerning Hobbits" shows a higher 3.5% skip rate.
- **Listening Patterns**: Peak listening occurs at night (00:00, ~6,000 plays) and evening (17:00–20:00, ~6,000 plays each), with morning being the least active (~500–2,000 plays).
- **Exploration vs. Loyalty**: New artists account for only 4.26% of plays and 3.99% of listening time, while favorite artists dominate with 95.74% of plays and 96.01% of time, indicating a strong replay tendency.

## Acknowledgments

- Thanks to Maven Analytics for inspiring the data analysis journey.
- Spotify for providing the streaming history data export feature.

For any questions or feedback, please open an issue or contact the repository owner. Happy analyzing!
