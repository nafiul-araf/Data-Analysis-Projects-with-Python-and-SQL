# Bank Customer Segmentation Using Cluster Analysis

This repository showcases a clustering analysis project to segment bank customers based on their transaction data, demographics, and account information. By leveraging data science techniques, the goal is to provide actionable insights that can guide customer targeting and relationship management strategies for banks.

---

### **1. Loading the Libraries and Dataset**
```python
!pip install kagglehub
import kagglehub

# Download latest version
path = kagglehub.dataset_download("shivamb/bank-customer-segmentation")
print("Path to dataset files:", path)
```
- **Purpose**: Installs and uses the `kagglehub` library to download the dataset for customer segmentation. The `dataset_download()` function retrieves the dataset's path.

```python
import numpy as np
import pandas as pd
pd.set_option('display.max_column', None)

from datetime import datetime, timedelta
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from yellowbrick.cluster import KElbowVisualizer
from sklearn.cluster import KMeans
import warnings
warnings.filterwarnings('ignore')
```
- **Purpose**: Imports libraries for data manipulation, visualization, statistical operations, machine learning, and clustering. Suppresses warnings for a clean workflow.

```python
df = pd.read_csv("<file_path>")
df.shape, df.head(), df.info(), df.describe().transpose().round(2)
```
- **Purpose**: Reads the dataset, checks its dimensions, previews the first few rows, displays the column data types, and provides a statistical summary.

---

### **2. Data Cleaning**
```python
df1 = df.copy()
df1.dropna(inplace=True)
```
- **Purpose**: Creates a copy of the dataset (`df1`) and removes rows with missing values.

```python
df1['CustomerDOB'] = pd.to_datetime(df1['CustomerDOB'], errors='coerce')
df1.loc[df1['CustomerDOB'].dt.year > 2000, 'CustomerDOB'] -= DateOffset(years=100)
```
- **Purpose**: Converts the `CustomerDOB` column to a proper `datetime` format and adjusts erroneously interpreted birth years greater than 2000.

```python
df1['CustomerBY'] = df1['CustomerDOB'].dt.year
```
- **Purpose**: Extracts the customer's birth year (`CustomerBY`) from the `CustomerDOB` column.

---

### **3. Feature Engineering**
```python
df2['CustGender'] = df2['CustGender'].map({'M': 'Male', 'F': 'Female'})
df2['CustAge'] = 2016 - df2['CustomerBY']
```
- **Purpose**: Maps gender codes (`M`, `F`) to full names (`Male`, `Female`) and calculates the customer's age based on the dataset's 2016 timeline.

```python
df2 = df2[df2['CustAge'] <= 100]
```
- **Purpose**: Removes rows with unrealistic ages (greater than 100 years).

---

### **4. Data Preprocessing**
```python
df3.drop(['TransactionID', 'CustomerID', 'CustomerDOB', 'CustLocation', 'TransactionDate', 'TransactionTime'], axis=1, inplace=True)
```
- **Purpose**: Drops unnecessary columns that do not contribute to clustering or classification.

```python
for column in skew_df.query("Skewed == True")['Feature'].values:
  df3[column] = np.log1p(df3[column])
```
- **Purpose**: Applies a logarithmic transformation to highly skewed numerical columns to normalize their distributions.

```python
df4 = pd.get_dummies(df4, drop_first=True).astype(int)
```
- **Purpose**: Encodes categorical variables into numerical format using one-hot encoding while avoiding redundancy.

```python
scaler = StandardScaler()
df5 = pd.DataFrame(scaler.fit_transform(df4), columns=df4.columns)
```
- **Purpose**: Scales numerical features using `StandardScaler` to standardize values with mean=0 and standard deviation=1.

---

### **5. Principal Component Analysis (PCA)**
```python
pca = PCA(n_components=3)
df6 = pd.DataFrame(pca.fit_transform(df5), columns=["PC1", "PC2", "PC3"])
```
- **Purpose**: Reduces the dataset's dimensionality to three principal components (`PC1`, `PC2`, `PC3`) for visualization and clustering purposes.

```python
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection="3d")
ax.scatter(df6["PC1"], df6["PC2"], df6["PC3"], c="red", marker="o")
```
- **Purpose**: Visualizes the transformed data in a 3D scatter plot.

---

### **6. Clustering**
```python
Elbow = KElbowVisualizer(KMeans(), k=20)
Elbow.fit(df7)
```
- **Purpose**: Uses the Elbow method to find the optimal number of clusters (k) for KMeans clustering.

```python
kmeans = KMeans(n_clusters=7)
yhat = kmeans.fit_predict(df7)
```
- **Purpose**: Performs KMeans clustering with 7 clusters and assigns a cluster label to each data point.

```python
sns.countplot(x=df7['Clusters'])
```
- **Purpose**: Visualizes the distribution of data points across the identified clusters.

---

### **7. Cluster Profiling**
```python
final = df2.merge(df7['Clusters'], left_index=True, right_index=True)
summary = final.groupby('Clusters').describe().transpose()
```
- **Purpose**: Merges the cleaned data with cluster labels and generates summary statistics for each cluster, enabling insights into their unique characteristics.

---

### **8. Classification**
```python
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.10, random_state=42)
xgb = XGBClassifier()
xgb.fit(X_train, y_train)
```
- **Purpose**: Splits the data into training and testing sets and trains an `XGBClassifier` to classify cluster labels.

```python
y_pred = xgb.predict(X_test)
cm = confusion_matrix(y_test, y_pred)
sns.heatmap(cm, annot=True, cmap="Blues")
```
- **Purpose**: Predicts cluster labels for test data, computes the confusion matrix, and visualizes it.

```python
print(classification_report(y_test, y_pred))
```
- **Purpose**: Generates a detailed classification report including precision, recall, F1-score, and support for each class.

---

### **9. Model Evaluation on Test Data**
```python
roc_auc = roc_auc_score(test_y, xgb.predict_proba(test_x), multi_class="ovr", average="macro")
```
- **Purpose**: Evaluates the model's performance using the ROC-AUC score for multiclass classification.

```python
logloss = log_loss(test_y, xgb.predict_proba(test_x))
```
- **Purpose**: Computes the log-loss metric to assess prediction probabilities against actual cluster labels.

```python
test_predictions = xgb.predict(test_x)
sns.heatmap(confusion_matrix(test_y, test_predictions), annot=True)
```
- **Purpose**: Predicts test data, computes a confusion matrix, and visualizes the performance.

### **Conclusion**:

The project demonstrates a robust framework for customer segmentation and prediction. The combined use of clustering and classification models provides actionable insights for businesses to optimize their customer engagement strategies. This methodology can be extended to other industries or datasets for similar use cases.
---
