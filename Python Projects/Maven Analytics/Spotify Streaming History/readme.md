## Title: Spotify Streaming History Analysis and Listener Profile Insights

### Objective:
The objective of this analysis is to explore a user's Spotify streaming history to uncover listening patterns, preferences, and trends. By leveraging data cleaning, clustering, and predictive analytics, the goal is to provide actionable insights into the user's music consumption habits, including top artists, listening volume, and recommendations for new artists to explore, while forecasting future listening trends.

### Analysis:
The analysis is based on a Spotify streaming history dataset (`spotify_history.csv`) containing 149,860 entries, filtered to 94,194 significant plays (tracks played for over 30 seconds). The dataset includes fields such as track name, artist name, album, timestamp, platform, play duration (`ms_played`), and playback context (e.g., shuffle, skipped). The analysis process is structured as follows:

1. **Data Cleaning and Transformation**:
   - **Filtering**: Removed tracks with less than 30 seconds of playtime to focus on meaningful listens, reducing the dataset to 94,194 entries. This step eliminated previews or accidental plays (e.g., "Half Mast" with 0 ms).
   - **Handling Nulls**: Identified 107 nulls in `reason_start` and 73 in `reason_end`, indicating minor gaps in playback context data, which were likely addressed in subsequent steps (e.g., imputation or exclusion).
   - **Feature Engineering**: Likely involved creating derived features (e.g., playtime in minutes, temporal features like hour or month) for clustering and trend analysis, though specific code is truncated.

2. **Clustering with Gaussian Mixture Model (GMM)**:
   - Applied GMM to group listening data into 27 clusters based on features like playtime, artist, or temporal patterns.
   - Used Principal Component Analysis (PCA) with 19 components, capturing 80.14% of variance, to reduce dimensionality and focus on key listening patterns.
   - Achieved a high reliability score (silhouette score of 0.9359), indicating well-separated clusters.

3. **Trend Analysis**:
   - Analyzed monthly playtime trends for the top GMM cluster (Cluster 25) using a line plot, saved as `monthly_trend_top_cluster.png`.
   - Predicted future playtime for Cluster 25 by averaging the last three months' playtime (584.8 minutes).

4. **Recommendation System**:
   - Excluded noise (low-probability GMM assignments) and the largest cluster (Cluster 25) to identify niche artists for recommendations.
   - Recommended artists based on less dominant clusters: Calvin Harris, James Arthur, Emeli Sandé, MGMT, and Passion Pit.
   - Calculated engagement metrics for recommended artists (e.g., MGMT: 295.4 minutes, Passion Pit: 245.9 minutes).

5. **Summary Generation**:
   - Created a user-friendly summary for web display, saved as `summary.txt`, detailing listening time, top artists, clustering insights, and actionable recommendations.

### Findings:
1. **Listening Volume**:
   - Total listening time in 2024 was 28,790.6 minutes (~480 hours).
   - Top artists were John Mayer (1,514.58 minutes) and The Killers (1,351.28 minutes), indicating strong preferences for specific artists, possibly driven by nostalgia or frequent playlist revisits.

2. **Cluster Insights**:
   - Cluster 25 was the most dominant, with 95,150 minutes and 1,739 unique tracks, averaging 827.4 minutes monthly. This suggests a broad, frequently played playlist.
   - Smaller clusters (e.g., 302.77 minutes) reflect niche or one-off listening interests.
   - GMM clustering with a silhouette score of 0.9359 indicates robust grouping of listening patterns.

3. **Preference Shifts**:
   - Significant increases in listening time for ABBA (59.45 to 964.76 minutes) and Howard Shore (702.76 to 859.23 minutes) in 2024 suggest evolving tastes, possibly influenced by media trends (e.g., movie soundtracks) or seasonal listening.

4. **Trend Prediction**:
   - Predicted playtime for Cluster 25 is 584.8 minutes for the next month, a decrease from 790.1 minutes, suggesting potential fatigue or a shift toward other music preferences.

5. **Recommendations**:
   - Recommended artists (Calvin Harris, James Arthur, Emeli Sandé, MGMT, Passion Pit) align with emerging or less dominant listening patterns, offering diversity.
   - Engagement with recommended artists totals 637.0 minutes, with MGMT and Passion Pit showing significant playtime, indicating potential interest in similar genres.

### Conclusions:
The analysis reveals a detailed picture of the user's music listening habits, characterized by a strong preference for artists like John Mayer and The Killers, alongside evolving interests in artists like ABBA and Howard Shore. The use of GMM clustering and PCA effectively identified distinct listening patterns, with Cluster 25 representing a core playlist and smaller clusters highlighting niche interests. The predicted decline in Cluster 25 engagement suggests a potential shift in preferences, which could be addressed by exploring recommended artists like MGMT and Passion Pit. These recommendations, grounded in less dominant clusters, offer a tailored way to diversify the user's music experience. To further enhance engagement, the user could balance listening times across different parts of the day (e.g., morning sessions) and monitor enjoyment of new artists. The robust methodology (high silhouette score, PCA variance coverage) ensures reliable insights, making this analysis a valuable tool for personalized music discovery and planning future listening habits.
