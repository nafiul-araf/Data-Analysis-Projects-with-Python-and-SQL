# Retail Customer Segmentation Using Cluster Analysis

This repository presents a comprehensive **clustering analysis project** aimed at segmenting retail customers based on their **transactional data**, specifically focusing on features such as **Quantity**, **UnitPrice**, and **Revenue**. Using advanced data science techniques, the project extracts actionable insights to support targeted customer engagement and enhance relationship management strategies. These insights are particularly valuable for banks and financial institutions seeking to optimize customer targeting, personalize services, and drive strategic decision-making.  

---

## **1. Loading Libraries and Dataset**

### **Explanation**:
- Libraries like `pandas`, `numpy`, `matplotlib`, and `seaborn` are used for data handling and visualization.
- `scikit-learn` and `yellowbrick` support clustering and evaluation.
- `LightGBM` is used for classification.
- `kagglehub` helps download the dataset from Kaggle.

### **Code**:
```python
# Import required libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.cluster import KMeans
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import silhouette_score
from yellowbrick.cluster import KElbowVisualizer
from lightgbm import LGBMClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, classification_report
```

---

## **2. Loading the Dataset**

### **Explanation**:
- The dataset is an Excel file containing transactional data for an online retail store.
- Initial steps include checking the data's shape, data types, and missing values.

### **Code**:
```python
df = pd.read_excel('Online Retail.xlsx')
df.head()
```

---

## **3. Data Cleaning**

### **Explanation**:
- Duplicates are removed to ensure data integrity.
- Missing `CustomerID` rows are dropped since they are essential for customer segmentation.

### **Code**:
```python
# Remove duplicates
df.drop_duplicates(inplace=True)

# Drop missing CustomerIDs
df.dropna(subset=['CustomerID'], inplace=True)
```

---

## **4. Feature Engineering**

### **Explanation**:
- `Revenue` is calculated as \( \text{Quantity} \times \text{UnitPrice} \).
- Columns irrelevant for clustering, like `InvoiceNo`, `Description`, and `Country`, are dropped.

### **Code**:
```python
# Add Revenue column
df['Revenue'] = df['Quantity'] * df['UnitPrice']

# Drop unnecessary columns
df = df.drop(['InvoiceNo', 'Description', 'Country'], axis=1)
```

---

## **5. Data Preprocessing**

### **Sub-Steps**:

#### **a. Outlier Removal**
- Outliers in `Quantity` and `UnitPrice` are treated using the 99.5th percentile.

#### **Code**:
```python
df = df[df['Quantity'] <= df['Quantity'].quantile(0.995)]
df = df[df['UnitPrice'] <= df['UnitPrice'].quantile(0.995)]
```

#### **b. Log Transformation**
- Log transformation is applied to normalize skewed features.

#### **Code**:
```python
df['LogQuantity'] = np.log1p(df['Quantity'])
df['LogRevenue'] = np.log1p(df['Revenue'])
```

#### **c. Scaling**
- Min-Max scaling is applied to standardize the data.

#### **Code**:
```python
scaler = MinMaxScaler()
scaled_data = scaler.fit_transform(df[['LogQuantity', 'LogRevenue']])
```

#### **d. Visualization**
- Boxplots and correlation heatmaps are used for data exploration.

---

## **6. Clustering**

### **Sub-Steps**:

#### **a. Elbow Method**
- The `KElbowVisualizer` is used to determine the optimal number of clusters (\( k = 6 \)).

#### **Code**:
```python
visualizer = KElbowVisualizer(KMeans(), k=(2, 10))
visualizer.fit(scaled_data)
visualizer.show()
```

#### **b. K-Means Clustering**
- Data is segmented into 6 clusters based on `Quantity`, `UnitPrice`, and `Revenue`.

#### **Code**:
```python
kmeans = KMeans(n_clusters=6, random_state=42)
df['Cluster'] = kmeans.fit_predict(scaled_data)
```

---

## **7. Cluster Profiling**

### **Explanation**:
- Clusters are assigned back to the dataset.
- Summary statistics like `Quantity` and `Revenue` are computed for each cluster.

### **Code**:
```python
cluster_summary = df.groupby('Cluster').agg({'Quantity': 'mean', 'Revenue': 'mean'}).reset_index()
sns.barplot(x='Cluster', y='Revenue', data=cluster_summary)
```

---

## **8. Classification from Clustering Results**

### **Purpose**:
- Clusters are used as labels to build a classification model for predicting cluster membership.

### **Sub-Steps**:

#### **a. Train-Test Split**
- The dataset is split into training and testing sets (70%-30% split).

#### **Code**:
```python
X = scaled_data
y = df['Cluster']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
```

#### **b. LightGBM Model**
- A **LightGBM Classifier** is trained on the processed data.

#### **Code**:
```python
model = LGBMClassifier()
model.fit(X_train, y_train)
y_pred = model.predict(X_test)
```

#### **c. Evaluation**
- A confusion matrix and classification report are generated to evaluate the model.

#### **Code**:
```python
print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))
```

---

## **9. Visualization of Results**

### **Explanation**:
- A heatmap of the confusion matrix is plotted to assess classification performance.

### **Code**:
```python
sns.heatmap(confusion_matrix(y_test, y_pred), annot=True, fmt='d')
```

---

## **Key Insights**

1. **Clusters**:
   - Represent distinct customer groups based on purchasing behavior.
   - Can be used for targeted marketing and personalized promotions.

2. **Trends**:
   - Revenue and `Quantity` trends across clusters reveal seasonal patterns.

3. **Classification**:
   - The model accurately predicts cluster membership for new customers.

---

### **Conclusion**

This pipeline demonstrates a structured approach to **customer segmentation** using clustering and classification techniques. The insights drive strategic decisions in marketing, promotions, and inventory planning, and the framework is flexible for other datasets or domains.
