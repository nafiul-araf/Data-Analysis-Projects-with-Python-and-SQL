# **Data Loading**



*   Mount the google drive
*   Import necessary libraries and set the visuals
*   Load the data using Pandas




```python
from google.colab import drive
drive.mount('/content/drive')
```

    Mounted at /content/drive
    


```python
import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

# Set Seaborn theme for a modern look
sns.set_theme(style="darkgrid", palette="coolwarm")

# Customize figure and font settings
plt.rcParams["figure.figsize"] = (15, 6)
font = {'family': 'serif', 'weight': 'bold', 'size': 14}
mpl.rc('font', **font)

# Set custom background and other plot aesthetics
plt.rcParams["axes.facecolor"] = "#F3F4F6"
plt.rcParams["axes.edgecolor"] = "#333333"
plt.rcParams["xtick.color"] = "#333333"
plt.rcParams["ytick.color"] = "#333333"
plt.rcParams["grid.color"] = "#D3D3D3"

# Seed for reproducibility
np.random.seed(42)

# Suppress warnings for a cleaner output
import warnings
warnings.filterwarnings('ignore')
```


```python
df=pd.read_csv('/content/drive/MyDrive/Data Analysis Projects/Project 4/WA_Fn-UseC_-Telco-Customer-Churn.csv')
df.head()
```



```python
df.shape
```




    (7043, 21)




```python
df.columns
```




    Index(['customerID', 'gender', 'SeniorCitizen', 'Partner', 'Dependents',
           'tenure', 'PhoneService', 'MultipleLines', 'InternetService',
           'OnlineSecurity', 'OnlineBackup', 'DeviceProtection', 'TechSupport',
           'StreamingTV', 'StreamingMovies', 'Contract', 'PaperlessBilling',
           'PaymentMethod', 'MonthlyCharges', 'TotalCharges', 'Churn'],
          dtype='object')



# **Exploratory Data Analysis (EDA)**

## **Step A: Data Checking and Cleaning**

### **Check the data types of the columns**


```python
df.dtypes
```




- **TotalCharges** should be numeric, but it’s currently an object.
- **SenionCitizen** should be categorical column.


```python
df['OnlineBackup']
```


<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>OnlineBackup</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Yes</td>
    </tr>
    <tr>
      <th>1</th>
      <td>No</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Yes</td>
    </tr>
    <tr>
      <th>3</th>
      <td>No</td>
    </tr>
    <tr>
      <th>4</th>
      <td>No</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
    </tr>
    <tr>
      <th>7038</th>
      <td>No</td>
    </tr>
    <tr>
      <th>7039</th>
      <td>Yes</td>
    </tr>
    <tr>
      <th>7040</th>
      <td>No</td>
    </tr>
    <tr>
      <th>7041</th>
      <td>No</td>
    </tr>
    <tr>
      <th>7042</th>
      <td>No</td>
    </tr>
  </tbody>
</table>
<p>7043 rows × 1 columns</p>
</div><br><label><b>dtype:</b> object</label>



It was only the column that does not visible on the `df.head()`, The data type is ok.

### **Convert `SeniorCitizen` data type to category.**


```python
df['SeniorCitizen']=df['SeniorCitizen'].astype('category')
df.dtypes
```


<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>customerID</th>
      <td>object</td>
    </tr>
    <tr>
      <th>gender</th>
      <td>object</td>
    </tr>
    <tr>
      <th>SeniorCitizen</th>
      <td>category</td>
    </tr>
    <tr>
      <th>Partner</th>
      <td>object</td>
    </tr>
    <tr>
      <th>Dependents</th>
      <td>object</td>
    </tr>
    <tr>
      <th>tenure</th>
      <td>int64</td>
    </tr>
    <tr>
      <th>PhoneService</th>
      <td>object</td>
    </tr>
    <tr>
      <th>MultipleLines</th>
      <td>object</td>
    </tr>
    <tr>
      <th>InternetService</th>
      <td>object</td>
    </tr>
    <tr>
      <th>OnlineSecurity</th>
      <td>object</td>
    </tr>
    <tr>
      <th>OnlineBackup</th>
      <td>object</td>
    </tr>
    <tr>
      <th>DeviceProtection</th>
      <td>object</td>
    </tr>
    <tr>
      <th>TechSupport</th>
      <td>object</td>
    </tr>
    <tr>
      <th>StreamingTV</th>
      <td>object</td>
    </tr>
    <tr>
      <th>StreamingMovies</th>
      <td>object</td>
    </tr>
    <tr>
      <th>Contract</th>
      <td>object</td>
    </tr>
    <tr>
      <th>PaperlessBilling</th>
      <td>object</td>
    </tr>
    <tr>
      <th>PaymentMethod</th>
      <td>object</td>
    </tr>
    <tr>
      <th>MonthlyCharges</th>
      <td>float64</td>
    </tr>
    <tr>
      <th>TotalCharges</th>
      <td>object</td>
    </tr>
    <tr>
      <th>Churn</th>
      <td>object</td>
    </tr>
  </tbody>
</table>
</div><br><label><b>dtype:</b> object</label>



### **Convert `TotalCharges` data type to numeric.**


```python
df['TotalCharges']=pd.to_numeric(df['TotalCharges'], errors='coerce')
df.dtypes
```


<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>customerID</th>
      <td>object</td>
    </tr>
    <tr>
      <th>gender</th>
      <td>object</td>
    </tr>
    <tr>
      <th>SeniorCitizen</th>
      <td>category</td>
    </tr>
    <tr>
      <th>Partner</th>
      <td>object</td>
    </tr>
    <tr>
      <th>Dependents</th>
      <td>object</td>
    </tr>
    <tr>
      <th>tenure</th>
      <td>int64</td>
    </tr>
    <tr>
      <th>PhoneService</th>
      <td>object</td>
    </tr>
    <tr>
      <th>MultipleLines</th>
      <td>object</td>
    </tr>
    <tr>
      <th>InternetService</th>
      <td>object</td>
    </tr>
    <tr>
      <th>OnlineSecurity</th>
      <td>object</td>
    </tr>
    <tr>
      <th>OnlineBackup</th>
      <td>object</td>
    </tr>
    <tr>
      <th>DeviceProtection</th>
      <td>object</td>
    </tr>
    <tr>
      <th>TechSupport</th>
      <td>object</td>
    </tr>
    <tr>
      <th>StreamingTV</th>
      <td>object</td>
    </tr>
    <tr>
      <th>StreamingMovies</th>
      <td>object</td>
    </tr>
    <tr>
      <th>Contract</th>
      <td>object</td>
    </tr>
    <tr>
      <th>PaperlessBilling</th>
      <td>object</td>
    </tr>
    <tr>
      <th>PaymentMethod</th>
      <td>object</td>
    </tr>
    <tr>
      <th>MonthlyCharges</th>
      <td>float64</td>
    </tr>
    <tr>
      <th>TotalCharges</th>
      <td>float64</td>
    </tr>
    <tr>
      <th>Churn</th>
      <td>object</td>
    </tr>
  </tbody>
</table>
</div><br><label><b>dtype:</b> object</label>



### **Check for missing values**


```python
df.isnull().sum()
```


<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>customerID</th>
      <td>0</td>
    </tr>
    <tr>
      <th>gender</th>
      <td>0</td>
    </tr>
    <tr>
      <th>SeniorCitizen</th>
      <td>0</td>
    </tr>
    <tr>
      <th>Partner</th>
      <td>0</td>
    </tr>
    <tr>
      <th>Dependents</th>
      <td>0</td>
    </tr>
    <tr>
      <th>tenure</th>
      <td>0</td>
    </tr>
    <tr>
      <th>PhoneService</th>
      <td>0</td>
    </tr>
    <tr>
      <th>MultipleLines</th>
      <td>0</td>
    </tr>
    <tr>
      <th>InternetService</th>
      <td>0</td>
    </tr>
    <tr>
      <th>OnlineSecurity</th>
      <td>0</td>
    </tr>
    <tr>
      <th>OnlineBackup</th>
      <td>0</td>
    </tr>
    <tr>
      <th>DeviceProtection</th>
      <td>0</td>
    </tr>
    <tr>
      <th>TechSupport</th>
      <td>0</td>
    </tr>
    <tr>
      <th>StreamingTV</th>
      <td>0</td>
    </tr>
    <tr>
      <th>StreamingMovies</th>
      <td>0</td>
    </tr>
    <tr>
      <th>Contract</th>
      <td>0</td>
    </tr>
    <tr>
      <th>PaperlessBilling</th>
      <td>0</td>
    </tr>
    <tr>
      <th>PaymentMethod</th>
      <td>0</td>
    </tr>
    <tr>
      <th>MonthlyCharges</th>
      <td>0</td>
    </tr>
    <tr>
      <th>TotalCharges</th>
      <td>11</td>
    </tr>
    <tr>
      <th>Churn</th>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div><br><label><b>dtype:</b> int64</label>



Replace the missing values of **TotalCharges** with the **median** value.


```python
df['TotalCharges']=df['TotalCharges'].fillna(df['TotalCharges'].median())

df.isnull().sum()
```


<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>customerID</th>
      <td>0</td>
    </tr>
    <tr>
      <th>gender</th>
      <td>0</td>
    </tr>
    <tr>
      <th>SeniorCitizen</th>
      <td>0</td>
    </tr>
    <tr>
      <th>Partner</th>
      <td>0</td>
    </tr>
    <tr>
      <th>Dependents</th>
      <td>0</td>
    </tr>
    <tr>
      <th>tenure</th>
      <td>0</td>
    </tr>
    <tr>
      <th>PhoneService</th>
      <td>0</td>
    </tr>
    <tr>
      <th>MultipleLines</th>
      <td>0</td>
    </tr>
    <tr>
      <th>InternetService</th>
      <td>0</td>
    </tr>
    <tr>
      <th>OnlineSecurity</th>
      <td>0</td>
    </tr>
    <tr>
      <th>OnlineBackup</th>
      <td>0</td>
    </tr>
    <tr>
      <th>DeviceProtection</th>
      <td>0</td>
    </tr>
    <tr>
      <th>TechSupport</th>
      <td>0</td>
    </tr>
    <tr>
      <th>StreamingTV</th>
      <td>0</td>
    </tr>
    <tr>
      <th>StreamingMovies</th>
      <td>0</td>
    </tr>
    <tr>
      <th>Contract</th>
      <td>0</td>
    </tr>
    <tr>
      <th>PaperlessBilling</th>
      <td>0</td>
    </tr>
    <tr>
      <th>PaymentMethod</th>
      <td>0</td>
    </tr>
    <tr>
      <th>MonthlyCharges</th>
      <td>0</td>
    </tr>
    <tr>
      <th>TotalCharges</th>
      <td>0</td>
    </tr>
    <tr>
      <th>Churn</th>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div><br><label><b>dtype:</b> int64</label>



### **Check for duplicates: italicized text Ensure each `customerID` is unique.**


```python
df.duplicated().sum()
```




    0



### **Identify any outliers in numeric columns like `tenure`, `MonthlyCharges`, and `TotalCharges`.**


```python
sns.boxplot(data=df, y='tenure')
plt.title("Outlier findings in Tenure")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```

    


**Inference from the Box Plot:** Outlier Findings in Tenure

The box plot represents the distribution of tenure data, with a median value close to the middle of the interquartile range (IQR).

- **Range**: The tenure ranges from approximately 0 to 70.
- **Median**: The median is around 30, suggesting that half of the values lie below and half above this point.
- **IQR (Interquartile Range)**: The IQR, represented by the height of the box, captures the middle 50% of tenure values, approximately between 9 and 55.
- **Outliers**: There are no visible outliers in this plot, as there are no data points beyond the "whiskers" (the lines extending from the box), which indicate the range of the non-outlier data.

This distribution suggests that tenure values are relatively concentrated within the IQR without extreme values that could be considered outliers. It indicates a fairly consistent spread in tenure among individuals in this dataset.


```python
sns.boxplot(data=df, y='MonthlyCharges')
plt.title("Outlier findings in Monthly Charge")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```

    


**Inference from the Box Plot:** Outlier Findings in Monthly Charge

The box plot visualizes the distribution of monthly charge data, providing insights into central tendency, spread, and potential outliers.

- **Range**: The monthly charge values range from approximately 20 to 120.
- **Median**: The median monthly charge appears around 70, suggesting that half of the values lie below and half above this point.
- **IQR (Interquartile Range)**: The IQR, represented by the height of the box, spans roughly between 40 and 90, capturing the middle 50% of the monthly charge values.
- **Outliers**: Similar to the previous plot, there are no visible outliers in this box plot, as there are no points outside the "whiskers."

This distribution indicates a relatively consistent spread of monthly charges within the IQR, with no extreme values that could be flagged as outliers.



```python
sns.boxplot(data=df, y='TotalCharges')
plt.title("Outlier findings in Total Charge")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```

    


**Inference from the Box Plot:** Outlier Findings in Total Charge

The box plot visualizes the distribution of total charge data, providing insights into central tendency, spread, and potential outliers.

- **Range**: The monthly charge values range from approximately 0 to 9000.
- **Median**: The median monthly charge appears around 1500, suggesting that half of the values lie below and half above this point.
- **IQR (Interquartile Range)**: The IQR, represented by the height of the box, spans roughly between 500 and 4000, capturing the middle 50% of the monthly charge values.
- **Outliers**: Similar to the previous plot, there are no visible outliers in this box plot, as there are no points outside the "whiskers."

This distribution indicates that the monthly charges are spread out within a moderate range, with values concentrated around the median and no extreme values outside the whiskers that would typically be flagged as outliers.


## **Step B: Initial Univariate Analysis**

### **Plot the distribution of `Churn` to see the proportion of churned vs. non-churned customers.**


```python
sns.displot(data=df, x='Churn', hue='Churn')
plt.title("Distribution of Churn")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```
    


**Insights from Distribution of Churn Status:**

There are more than 5,000 people who **retented**, while around 2,000 people **churned**.

### **Examine the distribution of categorical variables like `gender`, `Partner`, `Dependents`, `InternetService`, and `PaymentMethod`.**


```python
sns.countplot(data=df, x='gender', hue='gender')
plt.title("Distribution of Gender")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```
    


**Insights from Distribution of Gender:**

The gender distribution is almost identical with around 3500, where **male** customers are slightly more.


```python
sns.countplot(data=df, x='Partner', hue='Partner')
plt.title("Distribution of having Partner")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```
    


**Insights from Distribution of Having Partner:**

There are more than 3,500 people who have no **partner**, while around 3,400 people have a **partner**. That means maximum peoples have no **partners**.


```python
sns.countplot(data=df, x='Dependents', hue='Dependents')
plt.title("Distribution of having Dependents")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Distribution of Having Dependents:**

There are around 5,000 people who have no **dependents**, while around 1,000 people have a **dependents**. That means maximum peoples have no **dependents**.


```python
sns.countplot(data=df, x='InternetService', hue='InternetService')
plt.title("Distribution of type of Internet Service")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Distribution of Type of Internet Services:**

There are around 3,000 people who use **fiber optics** as internet service, while around 3,500 people use **DSL**, and 1,500 people have **no** internet service. That means most people use **fiber-optic** cable.


```python
sns.countplot(data=df, x='PaymentMethod', hue='PaymentMethod')
plt.title("Distribution of type of Payment Method Service")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Distribution of Type of Payment Method:**

There are around 2,500 people who use **electronic check** as payment method service, while the other three methods are used by almost identical numbers of people, ranging from roughly **1,500** to **1,600**. That means most people love **electronic checks** as payment method service.

### **Visualize distributions for `tenure`, `MonthlyCharges`, and `TotalCharges`.**


```python
sns.histplot(data=df, x='tenure', kde=True)
plt.title("Distribution of Tenure")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Inference on the Distribution of Tenure Chart:**

- **High Frequencies at Start and End**: Most employees have either very short tenure or very long tenure, suggesting high early turnover and a stable group of long-term employees.
- **Low Mid-Range Tenure**: Fewer employees have mid-range tenure, indicating potential turnover in these years.
- **Trend Line**: Shows a decrease after initial tenure, stable mid-range, and a slight rise toward long tenure.

This distribution could imply a need for retention strategies in the early years and succession planning for long-term employees.


```python
sns.histplot(data=df, x='MonthlyCharges', kde=True)
plt.title("Distribution of Monthly Charges")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Inference on the Distribution of Monthly Charges Chart:**

- **High Frequency at Lower Charges**: Most customers are concentrated at lower monthly charges, indicating affordability is a key factor.
- **Increasing Frequency in Mid-Range**: The frequency rises again around the 50–80 range, showing another popular pricing tier.
- **Decline at Higher Charges**: Few customers are in the higher charge range (above 100), suggesting limited demand for higher-cost options.

This distribution suggests a potential preference for affordable or mid-range services.


```python
sns.histplot(data=df, x='TotalCharges', kde=True)
plt.title("Distribution of Total Charges")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Inference on the Distribution of Total Charges Chart:**

- **High Frequency at Low Total Charges**: Most customers have low total charges, likely representing newer or short-term customers.
- **Gradual Decline**: There’s a steady decrease in the number of customers as total charges increase, suggesting fewer long-term or high-paying customers.
  
This distribution highlights a customer base with mostly lower total expenditures, likely due to shorter subscription periods or limited service usage.

## **Step C: Bivariate Analysis**

### **Plot boxplots for `tenure`, `MonthlyCharges`, and `TotalCharges` against `Churn` to see if churned customers have different distributions in these variables.**


```python
sns.boxplot(data=df, y='tenure', hue='Churn')
plt.title("Distribution in Tenure with the Churn")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Tenures Distribution by Churn Status:**

- Customers who **did not churn** (blue) generally have higher tenure, with a median around 40.
- Customers who **churned** (red) tend to have lower tenure, with a median around 10.
- There is a wider range of total charges for customers who did not churn, while the distribution for churned customers is more condensed with fewer outliers.
- This suggests that higher lower tenure may be associated with longer customer retention.


```python
sns.boxplot(data=df, y='MonthlyCharges', hue='Churn')
plt.title("Distribution in Monthly Charge with the Churn")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```
    


**Insights from Monthly Charges Distribution by Churn Status:**

- Customers who **did not churn** (blue) trend to have lower monthly charges, with a median around 65.
- Customers who **churned** (red) tend to have higher monthly charges, with a median around 80.
- There is a wider range of monthly charges for customers who did not churn, with no outliers, while the distribution for churned customers is more condensed with fewer outliers.
- This suggests that lower monthly charges may be associated with longer customer retention.


```python
sns.boxplot(data=df, y='TotalCharges', hue='Churn')
plt.title("Distribution in Total Charge with the Churn")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Total Charges Distribution by Churn Status:**

- Customers who **did not churn** (blue) generally have higher total charges, with a median around 4,000.
- Customers who **churned** (red) tend to have lower total charges, with a median around 1,500.
- There is a wider range of total charges for customers who did not churn, while the distribution for churned customers is more condensed with some outliers.
- This suggests that higher total charges may be associated with longer customer retention.


### **Use count plots for variables like `Contract`, `PaymentMethod`, `InternetService`, and `TechSupport` against `Churn`.**


```python
sns.countplot(data=df, x='Contract', hue='Churn')
plt.title("Distribution of type of Contract with Churn")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Inference from Contract Type vs. Churn Chart:**

The chart illustrates the relationship between contract types and churn among customers. Key observations include:

- **Month-to-Month Contracts**: Customers with month-to-month contracts exhibit the highest churn rate, suggesting a need for retention strategies targeting this group.
- **One-Year Contracts**: These contracts show a moderate churn rate, indicating a higher customer commitment than month-to-month contracts.
- **Two-Year Contracts**: Customers with two-year contracts have the lowest churn rate, highlighting that longer-term contracts are associated with increased customer retention.

**Overall Insight**: There is a clear trend where longer contract commitments correspond to lower churn rates. This suggests that providing incentives for month-to-month customers to switch to longer-term contracts could reduce overall churn.



```python
sns.countplot(data=df, x='PaymentMethod', hue='Churn')
plt.title("Distribution of type of Payment Method with Churn")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Inference from Payment Method vs. Churn Chart:**

The chart illustrates the relationship between payment method and churn among customers. Key observations include:

- **Electronic Check Method**: Customers with electronic check methods exhibit the highest churn rate, suggesting a need for retention strategies targeting this group.
- **Mailed Ckeck Method**: These method show a moderate churn rate, indicating a higher customer commitment than electronic check method.
- **Bank Transfer (Automatic) Method**: These method also show a moderate churn rate, indicating a higher customer commitment than electronic check method and almost same as mailed check method.
- **Credit Card (Automatic) Method**: These method also show a moderate churn rate, indicating a higher customer commitment than electronic check method and almost same as both mailed check and bank transfer method.

**Overall Insight**: The analysis reveals that customers using **automatic payment methods** (bank transfer and credit card) generally exhibit a lower churn rate compared to those using **electronic check** or **mailed check** methods. This trend suggests that automatic payment methods are associated with higher customer retention. Encouraging customers, particularly those using electronic check, to switch to an automatic payment option could potentially reduce overall churn and increase customer loyalty.


```python
sns.countplot(data=df, x='InternetService', hue='Churn')
plt.title("Distribution of type of Internet Service with Churn")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Inference from Internet Service vs. Churn Chart:**

The chart illustrates the relationship between internet service and churn among customers. Key observations include:

- **Fiber Optic Service**: Customers with fiber optic service exhibit the highest churn rate, suggesting a need for retention strategies targeting this group.
- **DSL Service**: These method show a moderate churn rate, indicating a higher customer commitment than fiber optic service.
- **No Internet Service**: These service have the lowest churn rate compared to the other two services.

**Overall Insight**: The analysis reveals that customers with **fiber optic internet service** have the highest churn rate, indicating potential dissatisfaction or unmet expectations within this group. In contrast, **DSL service** customers show a moderate churn rate, suggesting greater stability and commitment compared to fiber optic users. Notably, customers without internet service have the **lowest churn rate**, possibly reflecting a lack of reliance on internet connectivity or satisfaction with other services. These findings imply that targeted retention efforts for fiber optic users, such as addressing service quality or pricing concerns, could help reduce c



```python
sns.countplot(data=df, x='TechSupport', hue='Churn')
plt.title("Distribution of Tech Support with Churn")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


### **Calculate correlations between `tenure`, `MonthlyCharges`, and `TotalCharges` to understand their relationships.**


```python
numeric_df=df.select_dtypes(include=['number'])

sns.heatmap(numeric_df.corr(), annot=True, cmap='coolwarm')
plt.title("Correlations between Tenure, Monthly Charges, and Total Charges")
plt.show()
```    


**Insights from the Correlation Matrix:**

- **Tenure and TotalCharges** have a strong positive correlation (0.83), suggesting that customers with longer tenures tend to have higher total charges.
- **MonthlyCharges and TotalCharges** also have a moderate positive correlation (0.65), indicating that higher monthly charges are associated with higher total charges.
- **Tenure and MonthlyCharges** have a weak positive correlation (0.25), implying little to no relationship between a customer's tenure and their monthly charges.


## **Step D: Multivariate Analysis**

### **Explore how `tenure` varies with subscription services (`PhoneService`, `InternetService`, `StreamingTV`, `StreamingMovies`).**


```python
sns.violinplot(data=df, x='InternetService', y='tenure', hue='InternetService')
plt.title('Tenure Distribution by Internet Service')
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Tenure Distribution by Internet Service Type:**

- **DSL** customers have a relatively balanced tenure distribution, with a slight concentration around higher tenures, indicating many customers have stayed for a longer period.
- **Fiber Optic** customers show a higher concentration in lower tenures, suggesting that this group tends to have shorter retention periods compared to DSL.
- Customers with **No Internet Service** have a fairly uniform distribution, with no particular tenure range standing out, likely indicating that tenure is less affected by internet service in this category.



```python
sns.violinplot(data=df, x='PhoneService', y='tenure', hue='PhoneService')
plt.title('Tenure Distribution by Phone Service')
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Tenure Distribution by Phone Service:**

- **Customers Without Phone Service**: The tenure distribution for customers without phone service shows a balanced spread across various tenure lengths, with a slight concentration around medium tenure values. This indicates that customers without phone service are spread across different retention periods, with no extreme tendency toward short or long tenure.

- **Customers With Phone Service**: The tenure distribution for customers with phone service is also spread across a range of tenure lengths but has a higher concentration around the mid-range tenure. This suggests that most customers with phone service fall in the moderate retention period, with fewer extreme tenures on either end of the distribution.

**Overall Insight**: Both groups display a relatively even tenure distribution, indicating that phone service availability does not heavily impact tenure length. However, a slightly higher concentration in the mid-tenure range for customers with phone service may imply some degree of stability in this segment.


```python
sns.violinplot(data=df, x='StreamingTV', y='tenure', hue='StreamingTV')
plt.title('Tenure Distribution by TV Streaming')
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Tenure Distribution by TV Streaming Service:**

- **No TV Streaming**: Customers without TV streaming service exhibit a balanced tenure distribution with a slight concentration around medium tenures, indicating that a significant portion of these customers stay for a moderate period without opting for TV streaming.

- **TV Streaming Enabled**: Customers who have opted for TV streaming show a broader spread in tenure, with the distribution concentrated around medium tenures as well. This suggests that while TV streaming customers are spread across different tenure lengths, they lean towards staying for a moderate amount of time.

- **No Internet Service**: For customers with no internet service (and hence no TV streaming), the tenure distribution appears relatively even, with no strong concentration in any tenure range. This may suggest that tenure length is less impacted by the lack of internet and TV streaming services in this category.

**Overall Insight**: Both customers with and without TV streaming services exhibit moderate retention periods, with a slight tendency for mid-range tenures. The absence of TV streaming appears not to significantly influence tenure, but retention strategies could target TV streaming subscribers to ensure long-term engagement.



```python
sns.violinplot(data=df, x='StreamingMovies', y='tenure', hue='StreamingMovies')
plt.title('Tenure Distribution by Movies Streaming')
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Tenure Distribution by Movies Streaming:**


The violin plot reveals a clear distinction in tenure distribution based on movie streaming habits:

* **Yes (Stream Movies):** This group exhibits a wider distribution, with a notable peak around the higher tenure range. This indicates that customers who stream movies tend to stay with the company for a longer duration.
* **No (Do not Stream Movies):** This group shows a more concentrated distribution, with a peak at a lower tenure range. This suggests that customers who do not stream movies have a shorter average tenure.

**Overall Insight**: It's worth noting that while the "No Internet Service" group has the highest median tenure, the distribution is much narrower compared to the "Yes" group. This might suggest that factors other than movie streaming influence tenure for customers without internet service.

### **Analyze how different services impact `MonthlyCharges`. For example, compare `MonthlyCharges` across different `InternetService` types.**


```python
sns.boxplot(data=df, y='MonthlyCharges', hue='InternetService')
plt.title("Impact of Different Internet Services on Monthly Charges")
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Impact of Different Internet Services on Monthly Charges:**

**Fiber Optic** internet service has the highest monthly charges, while No Internet Service has the lowest.

* **Fiber Optic:** This service has the highest median charge, indicating that customers typically pay more for this service. The box also shows a wider range and a longer whisker, suggesting greater variability in charges.
* **DSL:** This service has a lower median charge compared to Fiber Optic. The box is narrower, indicating less variability in charges.
* **No Internet Service:** This group has the lowest median charge, as expected. The distribution is highly concentrated, suggesting that charges for this group are relatively consistent.

**Overall Insights:** It's important to note that the **No Internet** Service group might have additional charges or fees, which are not captured in this plot.

### **Segment customers by `Contract` type and analyze their average `tenure`, `MonthlyCharges`, and `Churn rates`.**


```python
summary_table=df.groupby('Contract').agg(
    Avg_Tenure=('tenure', 'mean'),
    Avg_Monthly_Charge=('MonthlyCharges', 'mean'),
    Churn_Rate_pct=('Churn', lambda x: (x=='Yes').mean()*100)
).reset_index()


summary_table
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Contract</th>
      <th>Avg_Tenure</th>
      <th>Avg_Monthly_Charge</th>
      <th>Churn_Rate_pct</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Month-to-month</td>
      <td>18.036645</td>
      <td>66.398490</td>
      <td>42.709677</td>
    </tr>
    <tr>
      <th>1</th>
      <td>One year</td>
      <td>42.044807</td>
      <td>65.048608</td>
      <td>11.269518</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Two year</td>
      <td>56.735103</td>
      <td>60.770413</td>
      <td>2.831858</td>
    </tr>
  </tbody>
</table>


```python
melted_summary=summary_table.melt(id_vars='Contract', var_name='Metric', value_name='Value')
melted_summary
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Contract</th>
      <th>Metric</th>
      <th>Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Month-to-month</td>
      <td>Avg_Tenure</td>
      <td>18.036645</td>
    </tr>
    <tr>
      <th>1</th>
      <td>One year</td>
      <td>Avg_Tenure</td>
      <td>42.044807</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Two year</td>
      <td>Avg_Tenure</td>
      <td>56.735103</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Month-to-month</td>
      <td>Avg_Monthly_Charge</td>
      <td>66.398490</td>
    </tr>
    <tr>
      <th>4</th>
      <td>One year</td>
      <td>Avg_Monthly_Charge</td>
      <td>65.048608</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Two year</td>
      <td>Avg_Monthly_Charge</td>
      <td>60.770413</td>
    </tr>
    <tr>
      <th>6</th>
      <td>Month-to-month</td>
      <td>Churn_Rate_pct</td>
      <td>42.709677</td>
    </tr>
    <tr>
      <th>7</th>
      <td>One year</td>
      <td>Churn_Rate_pct</td>
      <td>11.269518</td>
    </tr>
    <tr>
      <th>8</th>
      <td>Two year</td>
      <td>Churn_Rate_pct</td>
      <td>2.831858</td>
    </tr>
  </tbody>
</table>



```python
sns.barplot(x='Contract', y='Value', hue='Metric', data=melted_summary)
plt.title('Contract Type Analysis: Average Tenure, Monthly Charge, and Churn Rate')

plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
plt.xlabel('')
plt.ylabel('')
plt.tight_layout()
plt.show()
```    


**Insights from Contract Type Analysis: Average Tenure, Monthly Charge, and Churn Rate**

This chart provides a comparative analysis of key metrics across different contract types:

**Tenure:**

* **Month-to-Month:** Customers on this plan have the shortest average tenure.
* **One-Year:** This plan shows a significant increase in average tenure compared to Month-to-Month.
* **Two-Year:** Customers with Two-Year contracts exhibit the highest average tenure, indicating a strong commitment.

**Monthly Charge:**

* **Month-to-Month:** Despite the lowest tenure, customers on this plan have the highest average monthly charge.
* **One-Year:** This plan shows a moderate decrease in average monthly charge compared to Month-to-Month.
* **Two-Year:** Customers with Two-Year contracts have the lowest average monthly charge, suggesting potential discounts for longer commitments.

**Churn Rate:**

* **Month-to-Month:** This plan has the highest churn rate, indicating a higher propensity for customers to switch providers.
* **One-Year:** The churn rate decreases significantly for One-Year contracts.
* **Two-Year:** Customers with Two-Year contracts have the lowest churn rate, further reinforcing the impact of longer commitments on customer retention.

**Overall Insights:** The chart highlights the trade-offs between flexibility, cost, and customer loyalty associated with different contract types.

## **Step E: Advanced Visualizations**

### **Create pair plots to visualize interactions among `tenure`, `MonthlyCharges`, and `TotalCharges`, particularly segmented by `Churn`.**


```python
numeric_df_churn=df[['tenure', 'MonthlyCharges', 'TotalCharges', 'Churn']]
numeric_df_churn.head()
```

</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>tenure</th>
      <th>MonthlyCharges</th>
      <th>TotalCharges</th>
      <th>Churn</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>29.85</td>
      <td>29.85</td>
      <td>No</td>
    </tr>
    <tr>
      <th>1</th>
      <td>34</td>
      <td>56.95</td>
      <td>1889.50</td>
      <td>No</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>53.85</td>
      <td>108.15</td>
      <td>Yes</td>
    </tr>
    <tr>
      <th>3</th>
      <td>45</td>
      <td>42.30</td>
      <td>1840.75</td>
      <td>No</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2</td>
      <td>70.70</td>
      <td>151.65</td>
      <td>Yes</td>
    </tr>
  </tbody>
</table>


```python
sns.pairplot(numeric_df_churn, hue='Churn', kind='reg')
plt.suptitle('Interactions among tenure, MonthlyCharges, and TotalCharges, segmented by Churn')
plt.tight_layout()
plt.show()
```    


**Inferences from the Interactions Among Tenure, MonthlyCharges, and TotalCharges, Segmented by Churn**

- **Tenure vs. Churn**:
    - Customers with longer tenure (higher number of months) are less likely to churn, as shown by the density plot on the upper left.
    - A higher concentration of churn (in red) appears in the early tenure months, suggesting that customers who leave tend to do so early in their service period.

- **Monthly Charges vs. Churn**:
    - Churned customers (in red) tend to have higher monthly charges, as indicated by the density plot and scatter plot in the middle row. This suggests a potential association between higher monthly costs and increased likelihood of churn.
    - Lower monthly charges are more associated with customers who do not churn.

- **Total Charges vs. Churn**:
    - Total charges, a cumulative measure over tenure, show that customers with higher total charges generally have longer tenures and are less likely to churn. This is reflected by the strong correlation between tenure and total charges.
    - Churned customers tend to have lower total charges, which aligns with shorter tenures and possibly reflects an exit from the service before accumulating high total charges.

- **Interaction Insights**:
    - The linear relationship between total charges and tenure is clear for both churned and non-churned customers, as total charges are directly tied to how long customers stay.
    - Monthly charges appear to be a more influential factor in churn compared to tenure alone, as churned customers are more prevalent at higher monthly charge levels, irrespective of total tenure.

**Summary:** High monthly charges and low tenure are key indicators of churn, while customers with lower monthly charges and longer tenure are less likely to churn.


### **Analyze `PaperlessBilling` and `PaymentMethod` against `Churn` to see if these billing preferences impact churn rates.**


```python
churn_summary=df.groupby(['PaperlessBilling', 'PaymentMethod']).agg(
    Churn_Rate_pct=('Churn', lambda x: (x=='Yes').mean()*100)
).reset_index()
```


```python
churn_summary
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>PaperlessBilling</th>
      <th>PaymentMethod</th>
      <th>Churn_Rate_pct</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>No</td>
      <td>Bank transfer (automatic)</td>
      <td>11.026034</td>
    </tr>
    <tr>
      <th>1</th>
      <td>No</td>
      <td>Credit card (automatic)</td>
      <td>10.000000</td>
    </tr>
    <tr>
      <th>2</th>
      <td>No</td>
      <td>Electronic check</td>
      <td>32.744783</td>
    </tr>
    <tr>
      <th>3</th>
      <td>No</td>
      <td>Mailed check</td>
      <td>13.493724</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Yes</td>
      <td>Bank transfer (automatic)</td>
      <td>20.875421</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Yes</td>
      <td>Credit card (automatic)</td>
      <td>19.047619</td>
    </tr>
    <tr>
      <th>6</th>
      <td>Yes</td>
      <td>Electronic check</td>
      <td>49.770379</td>
    </tr>
    <tr>
      <th>7</th>
      <td>Yes</td>
      <td>Mailed check</td>
      <td>27.286585</td>
    </tr>
  </tbody>
</table>


```python
sns.barplot(data=churn_summary, x='PaymentMethod', y='Churn_Rate_pct', hue='PaperlessBilling')
plt.title('Churn Rate by Payment Method and Paperless Billing')
plt.ylabel('Churn Rate')
plt.xlabel('Payment Method')
plt.legend(title='Paperless Billing', bbox_to_anchor=(1.05, 1), loc='upper left')
plt.tight_layout()
plt.show()
```    


**Insights from Churn Rate by Payment Method and Paperless Billing**

This chart provides a detailed breakdown of churn rates based on payment method and paperless billing preferences:

**Payment Method:**

* **Electronic Check:** This payment method has the lowest churn rate, indicating that customers using this method tend to be more loyal.
* **Credit Card (Automatic):** This method also shows a relatively low churn rate.
* **Bank Transfer (Automatic):** This method has a slightly higher churn rate compared to Electronic Check and Credit Card.
* **Mailed Check:** This method has the highest churn rate, suggesting that customers using this method might be less committed to the service.

**Paperless Billing:**

* **No:** Customers who do not opt for paperless billing have a significantly higher churn rate across all payment methods. This suggests that paperless billing might contribute to increased customer satisfaction and retention.
* **Yes:** Customers who choose paperless billing have a consistently lower churn rate, regardless of the payment method.

**Overall Insights**, the chart highlights the importance of payment method and paperless billing preferences in predicting customer churn. Customers who opt for Electronic Check or Credit Card and choose paperless billing appear to be more likely to stay with the service.

### **Cohort Analysis: Group customers based on `tenure` ranges (e.g., *0–12*, *13–24* months) to observe churn patterns over time.**


```python
bins=[0, 12, 24, 36, 48, 60, df['tenure'].max()]
labels=['0–12', '13–24', '25–36', '37–48', '49–60', '61+']

df['tenure_range']=pd.cut(df['tenure'], bins=bins, labels=labels, right=False)
df.head()
```


 
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>customerID</th>
      <th>gender</th>
      <th>SeniorCitizen</th>
      <th>Partner</th>
      <th>Dependents</th>
      <th>tenure</th>
      <th>PhoneService</th>
      <th>MultipleLines</th>
      <th>InternetService</th>
      <th>OnlineSecurity</th>
      <th>...</th>
      <th>TechSupport</th>
      <th>StreamingTV</th>
      <th>StreamingMovies</th>
      <th>Contract</th>
      <th>PaperlessBilling</th>
      <th>PaymentMethod</th>
      <th>MonthlyCharges</th>
      <th>TotalCharges</th>
      <th>Churn</th>
      <th>tenure_range</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>7590-VHVEG</td>
      <td>Female</td>
      <td>0</td>
      <td>Yes</td>
      <td>No</td>
      <td>1</td>
      <td>No</td>
      <td>No phone service</td>
      <td>DSL</td>
      <td>No</td>
      <td>...</td>
      <td>No</td>
      <td>No</td>
      <td>No</td>
      <td>Month-to-month</td>
      <td>Yes</td>
      <td>Electronic check</td>
      <td>29.85</td>
      <td>29.85</td>
      <td>No</td>
      <td>0–12</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5575-GNVDE</td>
      <td>Male</td>
      <td>0</td>
      <td>No</td>
      <td>No</td>
      <td>34</td>
      <td>Yes</td>
      <td>No</td>
      <td>DSL</td>
      <td>Yes</td>
      <td>...</td>
      <td>No</td>
      <td>No</td>
      <td>No</td>
      <td>One year</td>
      <td>No</td>
      <td>Mailed check</td>
      <td>56.95</td>
      <td>1889.50</td>
      <td>No</td>
      <td>25–36</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3668-QPYBK</td>
      <td>Male</td>
      <td>0</td>
      <td>No</td>
      <td>No</td>
      <td>2</td>
      <td>Yes</td>
      <td>No</td>
      <td>DSL</td>
      <td>Yes</td>
      <td>...</td>
      <td>No</td>
      <td>No</td>
      <td>No</td>
      <td>Month-to-month</td>
      <td>Yes</td>
      <td>Mailed check</td>
      <td>53.85</td>
      <td>108.15</td>
      <td>Yes</td>
      <td>0–12</td>
    </tr>
    <tr>
      <th>3</th>
      <td>7795-CFOCW</td>
      <td>Male</td>
      <td>0</td>
      <td>No</td>
      <td>No</td>
      <td>45</td>
      <td>No</td>
      <td>No phone service</td>
      <td>DSL</td>
      <td>Yes</td>
      <td>...</td>
      <td>Yes</td>
      <td>No</td>
      <td>No</td>
      <td>One year</td>
      <td>No</td>
      <td>Bank transfer (automatic)</td>
      <td>42.30</td>
      <td>1840.75</td>
      <td>No</td>
      <td>37–48</td>
    </tr>
    <tr>
      <th>4</th>
      <td>9237-HQITU</td>
      <td>Female</td>
      <td>0</td>
      <td>No</td>
      <td>No</td>
      <td>2</td>
      <td>Yes</td>
      <td>No</td>
      <td>Fiber optic</td>
      <td>No</td>
      <td>...</td>
      <td>No</td>
      <td>No</td>
      <td>No</td>
      <td>Month-to-month</td>
      <td>Yes</td>
      <td>Electronic check</td>
      <td>70.70</td>
      <td>151.65</td>
      <td>Yes</td>
      <td>0–12</td>
    </tr>
  </tbody>
</table>


```python
cohort_churn=df.groupby('tenure_range').agg(
    Churn_Rate_pct=('Churn', lambda x: (x=='Yes').mean()*100)
).reset_index()

cohort_churn
```

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>tenure_range</th>
      <th>Churn_Rate_pct</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0–12</td>
      <td>48.284195</td>
    </tr>
    <tr>
      <th>1</th>
      <td>13–24</td>
      <td>29.512894</td>
    </tr>
    <tr>
      <th>2</th>
      <td>25–36</td>
      <td>22.031963</td>
    </tr>
    <tr>
      <th>3</th>
      <td>37–48</td>
      <td>19.518717</td>
    </tr>
    <tr>
      <th>4</th>
      <td>49–60</td>
      <td>15.000000</td>
    </tr>
    <tr>
      <th>5</th>
      <td>61+</td>
      <td>8.296164</td>
    </tr>
  </tbody>
</table>


```python
cohort_churn=cohort_churn.sort_values('Churn_Rate_pct', ascending=False).reset_index(drop=True)
```


```python
colors=sns.color_palette("Blues", n_colors=len(cohort_churn))

sns.barplot(x='tenure_range', y='Churn_Rate_pct', data=cohort_churn, palette=colors)
plt.title('Churn Rate by Tenure Range')
plt.xlabel('Tenure Range (Months)')
plt.ylabel('Churn Rate (%)')
plt.show()
```    


**Insights from Churn Rate by Tenure Range**

This bar chart illustrates the relationship between customer tenure and churn rate:

* **0-12 Months:** Customers in the initial 12 months of their subscription have the highest churn rate. This suggests that the first year is a critical period for customer retention.
* **13-24 Months:** Churn rate decreases significantly in the 13-24 month range, indicating that customers who stay beyond the initial year are less likely to churn.
* **25-36 Months:** The downward trend continues, with a further decrease in churn rate for customers in the 25-36 month range.
* **37-48 Months:** Churn rate remains relatively low in this tenure range.
* **49-60 Months:** A slight increase in churn rate is observed, but it's still lower compared to the initial months.
* **60+ Months:** Customers with a tenure of 60+ months have the lowest churn rate, suggesting strong customer loyalty and satisfaction at this stage.

**Overall Insights** The chart highlights a clear pattern of decreasing churn rate as customers spend more time with the service, churn rate decreases as tenure increases.

# **Hypothesis Test**

## **Normality Test**


```python
df.head()
```





  <div id="df-afce7e79-dd7d-4501-8a59-2d07fdfa641f" class="colab-df-container">
    <div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>customerID</th>
      <th>gender</th>
      <th>SeniorCitizen</th>
      <th>Partner</th>
      <th>Dependents</th>
      <th>tenure</th>
      <th>PhoneService</th>
      <th>MultipleLines</th>
      <th>InternetService</th>
      <th>OnlineSecurity</th>
      <th>...</th>
      <th>TechSupport</th>
      <th>StreamingTV</th>
      <th>StreamingMovies</th>
      <th>Contract</th>
      <th>PaperlessBilling</th>
      <th>PaymentMethod</th>
      <th>MonthlyCharges</th>
      <th>TotalCharges</th>
      <th>Churn</th>
      <th>tenure_range</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>7590-VHVEG</td>
      <td>Female</td>
      <td>0</td>
      <td>Yes</td>
      <td>No</td>
      <td>1</td>
      <td>No</td>
      <td>No phone service</td>
      <td>DSL</td>
      <td>No</td>
      <td>...</td>
      <td>No</td>
      <td>No</td>
      <td>No</td>
      <td>Month-to-month</td>
      <td>Yes</td>
      <td>Electronic check</td>
      <td>29.85</td>
      <td>29.85</td>
      <td>No</td>
      <td>0–12</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5575-GNVDE</td>
      <td>Male</td>
      <td>0</td>
      <td>No</td>
      <td>No</td>
      <td>34</td>
      <td>Yes</td>
      <td>No</td>
      <td>DSL</td>
      <td>Yes</td>
      <td>...</td>
      <td>No</td>
      <td>No</td>
      <td>No</td>
      <td>One year</td>
      <td>No</td>
      <td>Mailed check</td>
      <td>56.95</td>
      <td>1889.50</td>
      <td>No</td>
      <td>25–36</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3668-QPYBK</td>
      <td>Male</td>
      <td>0</td>
      <td>No</td>
      <td>No</td>
      <td>2</td>
      <td>Yes</td>
      <td>No</td>
      <td>DSL</td>
      <td>Yes</td>
      <td>...</td>
      <td>No</td>
      <td>No</td>
      <td>No</td>
      <td>Month-to-month</td>
      <td>Yes</td>
      <td>Mailed check</td>
      <td>53.85</td>
      <td>108.15</td>
      <td>Yes</td>
      <td>0–12</td>
    </tr>
    <tr>
      <th>3</th>
      <td>7795-CFOCW</td>
      <td>Male</td>
      <td>0</td>
      <td>No</td>
      <td>No</td>
      <td>45</td>
      <td>No</td>
      <td>No phone service</td>
      <td>DSL</td>
      <td>Yes</td>
      <td>...</td>
      <td>Yes</td>
      <td>No</td>
      <td>No</td>
      <td>One year</td>
      <td>No</td>
      <td>Bank transfer (automatic)</td>
      <td>42.30</td>
      <td>1840.75</td>
      <td>No</td>
      <td>37–48</td>
    </tr>
    <tr>
      <th>4</th>
      <td>9237-HQITU</td>
      <td>Female</td>
      <td>0</td>
      <td>No</td>
      <td>No</td>
      <td>2</td>
      <td>Yes</td>
      <td>No</td>
      <td>Fiber optic</td>
      <td>No</td>
      <td>...</td>
      <td>No</td>
      <td>No</td>
      <td>No</td>
      <td>Month-to-month</td>
      <td>Yes</td>
      <td>Electronic check</td>
      <td>70.70</td>
      <td>151.65</td>
      <td>Yes</td>
      <td>0–12</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 22 columns</p>
</div>
    <div class="colab-df-buttons">

  <div class="colab-df-container">
    <button class="colab-df-convert" onclick="convertToInteractive('df-afce7e79-dd7d-4501-8a59-2d07fdfa641f')"
            title="Convert this dataframe to an interactive table."
            style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
    <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
  </svg>
    </button>

  <style>
    .colab-df-container {
      display:flex;
      gap: 12px;
    }

    .colab-df-convert {
      background-color: #E8F0FE;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      display: none;
      fill: #1967D2;
      height: 32px;
      padding: 0 0 0 0;
      width: 32px;
    }

    .colab-df-convert:hover {
      background-color: #E2EBFA;
      box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
      fill: #174EA6;
    }

    .colab-df-buttons div {
      margin-bottom: 4px;
    }

    [theme=dark] .colab-df-convert {
      background-color: #3B4455;
      fill: #D2E3FC;
    }

    [theme=dark] .colab-df-convert:hover {
      background-color: #434B5C;
      box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
      filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
      fill: #FFFFFF;
    }
  </style>

    <script>
      const buttonEl =
        document.querySelector('#df-afce7e79-dd7d-4501-8a59-2d07fdfa641f button.colab-df-convert');
      buttonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';

      async function convertToInteractive(key) {
        const element = document.querySelector('#df-afce7e79-dd7d-4501-8a59-2d07fdfa641f');
        const dataTable =
          await google.colab.kernel.invokeFunction('convertToInteractive',
                                                    [key], {});
        if (!dataTable) return;

        const docLinkHtml = 'Like what you see? Visit the ' +
          '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
          + ' to learn more about interactive tables.';
        element.innerHTML = '';
        dataTable['output_type'] = 'display_data';
        await google.colab.output.renderOutput(dataTable, element);
        const docLink = document.createElement('div');
        docLink.innerHTML = docLinkHtml;
        element.appendChild(docLink);
      }
    </script>
  </div>


<div id="df-d366a7cf-d8ba-41ad-8c0c-13b2e60b51aa">
  <button class="colab-df-quickchart" onclick="quickchart('df-d366a7cf-d8ba-41ad-8c0c-13b2e60b51aa')"
            title="Suggest charts"
            style="display:none;">

<svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
     width="24px">
    <g>
        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
    </g>
</svg>
  </button>

<style>
  .colab-df-quickchart {
      --bg-color: #E8F0FE;
      --fill-color: #1967D2;
      --hover-bg-color: #E2EBFA;
      --hover-fill-color: #174EA6;
      --disabled-fill-color: #AAA;
      --disabled-bg-color: #DDD;
  }

  [theme=dark] .colab-df-quickchart {
      --bg-color: #3B4455;
      --fill-color: #D2E3FC;
      --hover-bg-color: #434B5C;
      --hover-fill-color: #FFFFFF;
      --disabled-bg-color: #3B4455;
      --disabled-fill-color: #666;
  }

  .colab-df-quickchart {
    background-color: var(--bg-color);
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: none;
    fill: var(--fill-color);
    height: 32px;
    padding: 0;
    width: 32px;
  }

  .colab-df-quickchart:hover {
    background-color: var(--hover-bg-color);
    box-shadow: 0 1px 2px rgba(60, 64, 67, 0.3), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
    fill: var(--button-hover-fill-color);
  }

  .colab-df-quickchart-complete:disabled,
  .colab-df-quickchart-complete:disabled:hover {
    background-color: var(--disabled-bg-color);
    fill: var(--disabled-fill-color);
    box-shadow: none;
  }

  .colab-df-spinner {
    border: 2px solid var(--fill-color);
    border-color: transparent;
    border-bottom-color: var(--fill-color);
    animation:
      spin 1s steps(1) infinite;
  }

  @keyframes spin {
    0% {
      border-color: transparent;
      border-bottom-color: var(--fill-color);
      border-left-color: var(--fill-color);
    }
    20% {
      border-color: transparent;
      border-left-color: var(--fill-color);
      border-top-color: var(--fill-color);
    }
    30% {
      border-color: transparent;
      border-left-color: var(--fill-color);
      border-top-color: var(--fill-color);
      border-right-color: var(--fill-color);
    }
    40% {
      border-color: transparent;
      border-right-color: var(--fill-color);
      border-top-color: var(--fill-color);
    }
    60% {
      border-color: transparent;
      border-right-color: var(--fill-color);
    }
    80% {
      border-color: transparent;
      border-right-color: var(--fill-color);
      border-bottom-color: var(--fill-color);
    }
    90% {
      border-color: transparent;
      border-bottom-color: var(--fill-color);
    }
  }
</style>

  <script>
    async function quickchart(key) {
      const quickchartButtonEl =
        document.querySelector('#' + key + ' button');
      quickchartButtonEl.disabled = true;  // To prevent multiple clicks.
      quickchartButtonEl.classList.add('colab-df-spinner');
      try {
        const charts = await google.colab.kernel.invokeFunction(
            'suggestCharts', [key], {});
      } catch (error) {
        console.error('Error during call to suggestCharts:', error);
      }
      quickchartButtonEl.classList.remove('colab-df-spinner');
      quickchartButtonEl.classList.add('colab-df-quickchart-complete');
    }
    (() => {
      let quickchartButtonEl =
        document.querySelector('#df-d366a7cf-d8ba-41ad-8c0c-13b2e60b51aa button');
      quickchartButtonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';
    })();
  </script>
</div>

    </div>
  </div>




### Check `tenure`, `MonthlyCharges` and `TotalCharges` follows normal distribution or not.




```python
from scipy.stats import shapiro

def normality_test(data):
    """
    Perform the Shapiro-Wilk test for normality on the given dataset.

    Parameters:
    data (array-like): The dataset or column of data to test for normality.

    Returns:
    None: Prints the test statistic and p-value, and indicates if the data is
    normally distributed based on a 0.05 significance level.

    Interpretation:
    If the p-value is less than 0.05, the data is considered not normally
    distributed. If the p-value is 0.05 or higher, the data is considered
    normally distributed.
    """
    stat, p_value=shapiro(data)
    print(f'Statistic: {stat}, p-value: {p_value}')

    if p_value < 0.05:
        print("The data is not normally distributed.")
    else:
        print("The data is normally distributed.")
```

**Check for `tenure`:**

**Null Hypothesis (H₀):** The data is normally distributed.

**Alternative Hypothesis (H₁):** The data is not normally distributed.


```python
normality_test(df['tenure'])
```

    Statistic: 0.9037273891853457, p-value: 7.527283766475277e-55
    The data is not normally distributed.
    

**Check for `MonthlyCharges`:**

**Null Hypothesis (H₀):** The data is normally distributed.

**Alternative Hypothesis (H₁):** The data is not normally distributed.


```python
normality_test(df['MonthlyCharges'])
```

    Statistic: 0.9208891764819073, p-value: 2.2295643949026396e-51
    The data is not normally distributed.
    

**Check for `TotalCharges`:**

**Null Hypothesis (H₀):** The data is normally distributed.

**Alternative Hypothesis (H₁):** The data is not normally distributed.


```python
normality_test(df['TotalCharges'])
```

    Statistic: 0.8603441208009667, p-value: 9.497691568057198e-62
    The data is not normally distributed.
    

## **Other Test**

### **1. Monthly Charges and Churn Patterns**

**Hypothesis 1:** Churned customers have different average monthly charges compared to non-churned customers.

**H₀:** There is no significant difference in average `MonthlyCharges` between churned and non-churned customers.

**H₁:** There is a significant difference in average `MonthlyCharges` between churned and non-churned customers.

**Solve by Two-sample T-test**


```python
churned=df[df['Churn'] == 'Yes']
not_churned=df[df['Churn'] == 'No']
```


```python
from scipy.stats import ttest_ind

stat, p_value=ttest_ind(churned['MonthlyCharges'], not_churned['MonthlyCharges'])

print(f'Statistic: {stat}, p-value: {p_value}')

if p_value < 0.05:
  print("✅ Result: Reject the Null Hypothesis (H₀)")
  print("  ➡ There *is* a statistically significant difference in average MonthlyCharges between churned and non-churned customers (p < 0.05).")
else:
  print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
  print("  ➡ There is *no* statistically significant difference in average MonthlyCharges between churned and non-churned customers (p ≥ 0.05).")
```

    Statistic: 16.536738015936308, p-value: 2.7066456068884154e-60
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ There *is* a statistically significant difference in average MonthlyCharges between churned and non-churned customers (p < 0.05).
    

**Hypothesis 2:** Customers with different `contract types` have varying `monthly charges`.

**H₀:** The mean `MonthlyCharges` is the same across all Contract types (Month-to-month, One year, Two years).

**H₁:** The mean `MonthlyCharges` differs significantly across `Contract types`.

**Solve by One-way ANOVA**


```python
month_to_month=df[df['Contract'] == 'Month-to-month']['MonthlyCharges']
one_year=df[df['Contract'] == 'One year']['MonthlyCharges']
two_year=df[df['Contract'] == 'Two year']['MonthlyCharges']
```


```python
from scipy.stats import f_oneway

stat, p_value=f_oneway(month_to_month, one_year, two_year)

print(f'Statistic: {stat}, p-value: {p_value}')

if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ There *is* a statistically significant difference in mean MonthlyCharges across the Contract types (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* statistically significant difference in mean MonthlyCharges across the Contract types (p ≥ 0.05).")
```

    Statistic: 20.828045474730274, p-value: 9.575270975935273e-10
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ There *is* a statistically significant difference in mean MonthlyCharges across the Contract types (p < 0.05).
    

**Hypothesis 3:** Is there a difference in `monthly charges` based on `churn status` and `contract` type?

**H₀:** There is no significant difference in monthly charges based on churn status, contract type, or the interaction between churn status and contract type.

**H₁:** There is a significant difference in monthly charges based on churn status, contract type, or the interaction between churn status and contract type.

**Solve by Two-way ANOVA**


```python
import statsmodels.api as sm
from statsmodels.formula.api import ols

model=ols("MonthlyCharges ~ C(Churn) * C(Contract)", data=df).fit()
anova_table=sm.stats.anova_lm(model, typ=2)
anova_table
```





  <div id="df-b353b702-a43d-4255-9595-486320b2a72d" class="colab-df-container">
    <div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>sum_sq</th>
      <th>df</th>
      <th>F</th>
      <th>PR(&gt;F)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>C(Churn)</th>
      <td>2.110748e+05</td>
      <td>1.0</td>
      <td>243.357460</td>
      <td>5.797360e-54</td>
    </tr>
    <tr>
      <th>C(Contract)</th>
      <td>1.020540e+04</td>
      <td>2.0</td>
      <td>5.883128</td>
      <td>2.799778e-03</td>
    </tr>
    <tr>
      <th>C(Churn):C(Contract)</th>
      <td>2.382092e+04</td>
      <td>2.0</td>
      <td>13.732096</td>
      <td>1.116437e-06</td>
    </tr>
    <tr>
      <th>Residual</th>
      <td>6.103503e+06</td>
      <td>7037.0</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>
    <div class="colab-df-buttons">

  <div class="colab-df-container">
    <button class="colab-df-convert" onclick="convertToInteractive('df-b353b702-a43d-4255-9595-486320b2a72d')"
            title="Convert this dataframe to an interactive table."
            style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
    <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
  </svg>
    </button>

  <style>
    .colab-df-container {
      display:flex;
      gap: 12px;
    }

    .colab-df-convert {
      background-color: #E8F0FE;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      display: none;
      fill: #1967D2;
      height: 32px;
      padding: 0 0 0 0;
      width: 32px;
    }

    .colab-df-convert:hover {
      background-color: #E2EBFA;
      box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
      fill: #174EA6;
    }

    .colab-df-buttons div {
      margin-bottom: 4px;
    }

    [theme=dark] .colab-df-convert {
      background-color: #3B4455;
      fill: #D2E3FC;
    }

    [theme=dark] .colab-df-convert:hover {
      background-color: #434B5C;
      box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
      filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
      fill: #FFFFFF;
    }
  </style>

    <script>
      const buttonEl =
        document.querySelector('#df-b353b702-a43d-4255-9595-486320b2a72d button.colab-df-convert');
      buttonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';

      async function convertToInteractive(key) {
        const element = document.querySelector('#df-b353b702-a43d-4255-9595-486320b2a72d');
        const dataTable =
          await google.colab.kernel.invokeFunction('convertToInteractive',
                                                    [key], {});
        if (!dataTable) return;

        const docLinkHtml = 'Like what you see? Visit the ' +
          '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
          + ' to learn more about interactive tables.';
        element.innerHTML = '';
        dataTable['output_type'] = 'display_data';
        await google.colab.output.renderOutput(dataTable, element);
        const docLink = document.createElement('div');
        docLink.innerHTML = docLinkHtml;
        element.appendChild(docLink);
      }
    </script>
  </div>


<div id="df-2f27b01e-0595-41f0-84af-c751dc56950b">
  <button class="colab-df-quickchart" onclick="quickchart('df-2f27b01e-0595-41f0-84af-c751dc56950b')"
            title="Suggest charts"
            style="display:none;">

<svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
     width="24px">
    <g>
        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
    </g>
</svg>
  </button>

<style>
  .colab-df-quickchart {
      --bg-color: #E8F0FE;
      --fill-color: #1967D2;
      --hover-bg-color: #E2EBFA;
      --hover-fill-color: #174EA6;
      --disabled-fill-color: #AAA;
      --disabled-bg-color: #DDD;
  }

  [theme=dark] .colab-df-quickchart {
      --bg-color: #3B4455;
      --fill-color: #D2E3FC;
      --hover-bg-color: #434B5C;
      --hover-fill-color: #FFFFFF;
      --disabled-bg-color: #3B4455;
      --disabled-fill-color: #666;
  }

  .colab-df-quickchart {
    background-color: var(--bg-color);
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: none;
    fill: var(--fill-color);
    height: 32px;
    padding: 0;
    width: 32px;
  }

  .colab-df-quickchart:hover {
    background-color: var(--hover-bg-color);
    box-shadow: 0 1px 2px rgba(60, 64, 67, 0.3), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
    fill: var(--button-hover-fill-color);
  }

  .colab-df-quickchart-complete:disabled,
  .colab-df-quickchart-complete:disabled:hover {
    background-color: var(--disabled-bg-color);
    fill: var(--disabled-fill-color);
    box-shadow: none;
  }

  .colab-df-spinner {
    border: 2px solid var(--fill-color);
    border-color: transparent;
    border-bottom-color: var(--fill-color);
    animation:
      spin 1s steps(1) infinite;
  }

  @keyframes spin {
    0% {
      border-color: transparent;
      border-bottom-color: var(--fill-color);
      border-left-color: var(--fill-color);
    }
    20% {
      border-color: transparent;
      border-left-color: var(--fill-color);
      border-top-color: var(--fill-color);
    }
    30% {
      border-color: transparent;
      border-left-color: var(--fill-color);
      border-top-color: var(--fill-color);
      border-right-color: var(--fill-color);
    }
    40% {
      border-color: transparent;
      border-right-color: var(--fill-color);
      border-top-color: var(--fill-color);
    }
    60% {
      border-color: transparent;
      border-right-color: var(--fill-color);
    }
    80% {
      border-color: transparent;
      border-right-color: var(--fill-color);
      border-bottom-color: var(--fill-color);
    }
    90% {
      border-color: transparent;
      border-bottom-color: var(--fill-color);
    }
  }
</style>

  <script>
    async function quickchart(key) {
      const quickchartButtonEl =
        document.querySelector('#' + key + ' button');
      quickchartButtonEl.disabled = true;  // To prevent multiple clicks.
      quickchartButtonEl.classList.add('colab-df-spinner');
      try {
        const charts = await google.colab.kernel.invokeFunction(
            'suggestCharts', [key], {});
      } catch (error) {
        console.error('Error during call to suggestCharts:', error);
      }
      quickchartButtonEl.classList.remove('colab-df-spinner');
      quickchartButtonEl.classList.add('colab-df-quickchart-complete');
    }
    (() => {
      let quickchartButtonEl =
        document.querySelector('#df-2f27b01e-0595-41f0-84af-c751dc56950b button');
      quickchartButtonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';
    })();
  </script>
</div>

  <div id="id_3666f0ba-d7f6-44f6-b418-0ae176c1d830">
    <style>
      .colab-df-generate {
        background-color: #E8F0FE;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        display: none;
        fill: #1967D2;
        height: 32px;
        padding: 0 0 0 0;
        width: 32px;
      }

      .colab-df-generate:hover {
        background-color: #E2EBFA;
        box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
        fill: #174EA6;
      }

      [theme=dark] .colab-df-generate {
        background-color: #3B4455;
        fill: #D2E3FC;
      }

      [theme=dark] .colab-df-generate:hover {
        background-color: #434B5C;
        box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
        filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
        fill: #FFFFFF;
      }
    </style>
    <button class="colab-df-generate" onclick="generateWithVariable('anova_table')"
            title="Generate code using this dataframe."
            style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
       width="24px">
    <path d="M7,19H8.4L18.45,9,17,7.55,7,17.6ZM5,21V16.75L18.45,3.32a2,2,0,0,1,2.83,0l1.4,1.43a1.91,1.91,0,0,1,.58,1.4,1.91,1.91,0,0,1-.58,1.4L9.25,21ZM18.45,9,17,7.55Zm-12,3A5.31,5.31,0,0,0,4.9,8.1,5.31,5.31,0,0,0,1,6.5,5.31,5.31,0,0,0,4.9,4.9,5.31,5.31,0,0,0,6.5,1,5.31,5.31,0,0,0,8.1,4.9,5.31,5.31,0,0,0,12,6.5,5.46,5.46,0,0,0,6.5,12Z"/>
  </svg>
    </button>
    <script>
      (() => {
      const buttonEl =
        document.querySelector('#id_3666f0ba-d7f6-44f6-b418-0ae176c1d830 button.colab-df-generate');
      buttonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';

      buttonEl.onclick = () => {
        google.colab.notebook.generateWithVariable('anova_table');
      }
      })();
    </script>
  </div>

    </div>
  </div>




Here is the inference based on the provided ANOVA results:

**Churn Status:** There is a significant difference in monthly charges based on churn status, as indicated by a very low p-value (p < 0.001). This suggests that churn status has a meaningful impact on monthly charges.

**Contract Type:** There is a significant difference in monthly charges based on contract type (p = 0.0028). This indicates that the type of contract affects the average monthly charges.

**Interaction between Churn Status and Contract Type:** There is a significant interaction effect between churn status and contract type on monthly charges (p < 0.001). This means that the impact of churn status on monthly charges varies depending on the contract type.

In summary, churn status, contract type, and their interaction all have significant effects on monthly charges.

### **2. Service Preferences and Total Charges**

**Hypothesis 4:** The type of `internet service` affects the `total charges` a customer accumulates over time.

**H₀:** There is no significant difference in `TotalCharges` based on `InternetService` type.
**H₁:** There is a significant difference in `TotalCharges` based on `InternetService` type.

**Solve by One-way ANOVA**


```python
dsl=df[df['InternetService'] == 'DSL']['TotalCharges']
fiber_optic=df[df['InternetService'] == 'Fiber optic']['TotalCharges']
no=df[df['InternetService'] == 'No']['TotalCharges']
```


```python
stat, p_value=f_oneway(dsl, fiber_optic, no)

print(f'Statistic: {stat}, p-value: {p_value}')

if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ There *is* a statistically significant difference in mean Total Charges across the Internet Service (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* statistically significant difference in mean Total Charges across the Internet Service (p ≥ 0.05).")
```

    Statistic: 798.1133457270053, p-value: 3.93696934826e-313
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ There *is* a statistically significant difference in mean Total Charges across the Internet Service (p < 0.05).
    

**Hypothesis 5:** Customers who use additional streaming services (`StreamingTV` and `StreamingMovies`) incur higher monthly charges on average.

**H₀:** There is no significant difference in `MonthlyCharges` between customers who use streaming services and those who don’t.

**H₁:** Customers who use streaming services have significantly higher `MonthlyCharges`.

**Solve by Two-sample T-test**


```python
movie_service=df[df['StreamingMovies'] == 'Yes']['MonthlyCharges']
tv_service=df[df['StreamingTV'] == 'Yes']['MonthlyCharges']
```


```python
stat, p_value=ttest_ind(movie_service, tv_service)

print(f'Statistic: {stat}, p-value: {p_value}')

if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ Customers who use streaming services *do* incur significantly higher MonthlyCharges on average (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* significant difference in MonthlyCharges between customers who use streaming services and those who don’t (p ≥ 0.05).")
```

    Statistic: -0.5203996318869272, p-value: 0.6028062561052427
    🚨 Result: Fail to Reject the Null Hypothesis (H₀)
      ➡ There is *no* significant difference in MonthlyCharges between customers who use streaming services and those who don’t (p ≥ 0.05).
    

### **3. Tenure and Churn**

**Hypothesis 6:** Long-tenured customers are less likely to churn.

**H₀:** There is no significant difference in churn rate across different tenure ranges (e.g., 0–12 months, 13–24 months).

**H₁:** The churn rate significantly differs across tenure ranges.

**Solve by Chi-Square test for Independence**


```python
contingency_table=pd.crosstab(df['Churn'], df['tenure_range'])
print(contingency_table)
```

    tenure_range  0–12  13–24  25–36  37–48  49–60   61+
    Churn                                               
    No            1070    738    683    602    697  1028
    Yes            999    309    193    146    123    93
    


```python
from scipy.stats import chi2_contingency

stat, p_value, dof, expected=chi2_contingency(contingency_table)

print(f'Statistic: {stat}, p-value: {p_value}\nDegree of Freedom: {dof}\nExpected Table: {expected}\n')

if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ The churn rate *does* significantly differ across tenure ranges (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* significant difference in churn rate across tenure ranges (p ≥ 0.05).")
```

    Statistic: 752.0901213333746, p-value: 2.6709147969459114e-160
    Degree of Freedom: 5
    Expected Table: [[1492.05837449  755.04355635  631.72698698  539.41984733  591.34261338
       808.40862146]
     [ 576.94162551  291.95644365  244.27301302  208.58015267  228.65738662
       312.59137854]]
    
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ The churn rate *does* significantly differ across tenure ranges (p < 0.05).
    

### **4. Payment Method and Churn**

**Hypothesis 7:** `Electronic check` payment methods correlate with a higher churn rate.

**H₀:** The churn rate is the same for customers using `Electronic check` and those using other payment methods.

**H₁:** Customers using `Electronic check` have a significantly higher churn rate than those using other payment methods.

**Solve by Z-test for Proportion**


```python
electronic_check_churn=df[(df['PaymentMethod'] == 'Electronic check') & (df['Churn'] == 'Yes')].shape[0]
electronic_check_total=df[df['PaymentMethod'] == 'Electronic check'].shape[0]

other_method_churn=df[(df['PaymentMethod'] != 'Electronic check') & (df['Churn'] == 'Yes')].shape[0]
other_method_total=df[df['PaymentMethod'] != 'Electronic check'].shape[0]

electronic_check_churn, electronic_check_total, other_method_churn, other_method_total
```




    (1071, 2365, 798, 4678)




```python
count=np.array([electronic_check_churn, other_method_churn])
nobs=np.array([electronic_check_total, other_method_total])
```


```python
from statsmodels.stats.proportion import proportions_ztest

stat, p_value=proportions_ztest(count, nobs, alternative='larger')

print(f'Statistic: {stat}, p-value: {p_value}')


if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ Customers using Electronic check have a significantly higher churn rate (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* significant difference in churn rate between customers using Electronic check and those using other payment methods (p ≥ 0.05).")
```

    Statistic: 25.33780138577476, p-value: 6.123942754483725e-142
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ Customers using Electronic check have a significantly higher churn rate (p < 0.05).
    

**Hypothesis 8:** There is an association between `payment method` and `churn`.

**H₀:** There is no significant association between `PaymentMethod` and `Churn`.

**H₁:** There is a significant association between `PaymentMethod` and `Churn`.

**Solve by Chi-Square test for Independence**


```python
contingency_table=pd.crosstab(df['Churn'], df['PaymentMethod'])
contingency_table
```





  <div id="df-3fe3d388-b894-47b3-95b3-99cf4c2fea3f" class="colab-df-container">
    <div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>PaymentMethod</th>
      <th>Bank transfer (automatic)</th>
      <th>Credit card (automatic)</th>
      <th>Electronic check</th>
      <th>Mailed check</th>
    </tr>
    <tr>
      <th>Churn</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>No</th>
      <td>1286</td>
      <td>1290</td>
      <td>1294</td>
      <td>1304</td>
    </tr>
    <tr>
      <th>Yes</th>
      <td>258</td>
      <td>232</td>
      <td>1071</td>
      <td>308</td>
    </tr>
  </tbody>
</table>
</div>
    <div class="colab-df-buttons">

  <div class="colab-df-container">
    <button class="colab-df-convert" onclick="convertToInteractive('df-3fe3d388-b894-47b3-95b3-99cf4c2fea3f')"
            title="Convert this dataframe to an interactive table."
            style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
    <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
  </svg>
    </button>

  <style>
    .colab-df-container {
      display:flex;
      gap: 12px;
    }

    .colab-df-convert {
      background-color: #E8F0FE;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      display: none;
      fill: #1967D2;
      height: 32px;
      padding: 0 0 0 0;
      width: 32px;
    }

    .colab-df-convert:hover {
      background-color: #E2EBFA;
      box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
      fill: #174EA6;
    }

    .colab-df-buttons div {
      margin-bottom: 4px;
    }

    [theme=dark] .colab-df-convert {
      background-color: #3B4455;
      fill: #D2E3FC;
    }

    [theme=dark] .colab-df-convert:hover {
      background-color: #434B5C;
      box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
      filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
      fill: #FFFFFF;
    }
  </style>

    <script>
      const buttonEl =
        document.querySelector('#df-3fe3d388-b894-47b3-95b3-99cf4c2fea3f button.colab-df-convert');
      buttonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';

      async function convertToInteractive(key) {
        const element = document.querySelector('#df-3fe3d388-b894-47b3-95b3-99cf4c2fea3f');
        const dataTable =
          await google.colab.kernel.invokeFunction('convertToInteractive',
                                                    [key], {});
        if (!dataTable) return;

        const docLinkHtml = 'Like what you see? Visit the ' +
          '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
          + ' to learn more about interactive tables.';
        element.innerHTML = '';
        dataTable['output_type'] = 'display_data';
        await google.colab.output.renderOutput(dataTable, element);
        const docLink = document.createElement('div');
        docLink.innerHTML = docLinkHtml;
        element.appendChild(docLink);
      }
    </script>
  </div>


<div id="df-bc92e85d-f9a9-4bfb-bc70-f55b493e9237">
  <button class="colab-df-quickchart" onclick="quickchart('df-bc92e85d-f9a9-4bfb-bc70-f55b493e9237')"
            title="Suggest charts"
            style="display:none;">

<svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
     width="24px">
    <g>
        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
    </g>
</svg>
  </button>

<style>
  .colab-df-quickchart {
      --bg-color: #E8F0FE;
      --fill-color: #1967D2;
      --hover-bg-color: #E2EBFA;
      --hover-fill-color: #174EA6;
      --disabled-fill-color: #AAA;
      --disabled-bg-color: #DDD;
  }

  [theme=dark] .colab-df-quickchart {
      --bg-color: #3B4455;
      --fill-color: #D2E3FC;
      --hover-bg-color: #434B5C;
      --hover-fill-color: #FFFFFF;
      --disabled-bg-color: #3B4455;
      --disabled-fill-color: #666;
  }

  .colab-df-quickchart {
    background-color: var(--bg-color);
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: none;
    fill: var(--fill-color);
    height: 32px;
    padding: 0;
    width: 32px;
  }

  .colab-df-quickchart:hover {
    background-color: var(--hover-bg-color);
    box-shadow: 0 1px 2px rgba(60, 64, 67, 0.3), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
    fill: var(--button-hover-fill-color);
  }

  .colab-df-quickchart-complete:disabled,
  .colab-df-quickchart-complete:disabled:hover {
    background-color: var(--disabled-bg-color);
    fill: var(--disabled-fill-color);
    box-shadow: none;
  }

  .colab-df-spinner {
    border: 2px solid var(--fill-color);
    border-color: transparent;
    border-bottom-color: var(--fill-color);
    animation:
      spin 1s steps(1) infinite;
  }

  @keyframes spin {
    0% {
      border-color: transparent;
      border-bottom-color: var(--fill-color);
      border-left-color: var(--fill-color);
    }
    20% {
      border-color: transparent;
      border-left-color: var(--fill-color);
      border-top-color: var(--fill-color);
    }
    30% {
      border-color: transparent;
      border-left-color: var(--fill-color);
      border-top-color: var(--fill-color);
      border-right-color: var(--fill-color);
    }
    40% {
      border-color: transparent;
      border-right-color: var(--fill-color);
      border-top-color: var(--fill-color);
    }
    60% {
      border-color: transparent;
      border-right-color: var(--fill-color);
    }
    80% {
      border-color: transparent;
      border-right-color: var(--fill-color);
      border-bottom-color: var(--fill-color);
    }
    90% {
      border-color: transparent;
      border-bottom-color: var(--fill-color);
    }
  }
</style>

  <script>
    async function quickchart(key) {
      const quickchartButtonEl =
        document.querySelector('#' + key + ' button');
      quickchartButtonEl.disabled = true;  // To prevent multiple clicks.
      quickchartButtonEl.classList.add('colab-df-spinner');
      try {
        const charts = await google.colab.kernel.invokeFunction(
            'suggestCharts', [key], {});
      } catch (error) {
        console.error('Error during call to suggestCharts:', error);
      }
      quickchartButtonEl.classList.remove('colab-df-spinner');
      quickchartButtonEl.classList.add('colab-df-quickchart-complete');
    }
    (() => {
      let quickchartButtonEl =
        document.querySelector('#df-bc92e85d-f9a9-4bfb-bc70-f55b493e9237 button');
      quickchartButtonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';
    })();
  </script>
</div>

  <div id="id_d59c3224-1f6c-4597-a9b8-6ffdb43a9ac2">
    <style>
      .colab-df-generate {
        background-color: #E8F0FE;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        display: none;
        fill: #1967D2;
        height: 32px;
        padding: 0 0 0 0;
        width: 32px;
      }

      .colab-df-generate:hover {
        background-color: #E2EBFA;
        box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
        fill: #174EA6;
      }

      [theme=dark] .colab-df-generate {
        background-color: #3B4455;
        fill: #D2E3FC;
      }

      [theme=dark] .colab-df-generate:hover {
        background-color: #434B5C;
        box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
        filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
        fill: #FFFFFF;
      }
    </style>
    <button class="colab-df-generate" onclick="generateWithVariable('contingency_table')"
            title="Generate code using this dataframe."
            style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
       width="24px">
    <path d="M7,19H8.4L18.45,9,17,7.55,7,17.6ZM5,21V16.75L18.45,3.32a2,2,0,0,1,2.83,0l1.4,1.43a1.91,1.91,0,0,1,.58,1.4,1.91,1.91,0,0,1-.58,1.4L9.25,21ZM18.45,9,17,7.55Zm-12,3A5.31,5.31,0,0,0,4.9,8.1,5.31,5.31,0,0,0,1,6.5,5.31,5.31,0,0,0,4.9,4.9,5.31,5.31,0,0,0,6.5,1,5.31,5.31,0,0,0,8.1,4.9,5.31,5.31,0,0,0,12,6.5,5.46,5.46,0,0,0,6.5,12Z"/>
  </svg>
    </button>
    <script>
      (() => {
      const buttonEl =
        document.querySelector('#id_d59c3224-1f6c-4597-a9b8-6ffdb43a9ac2 button.colab-df-generate');
      buttonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';

      buttonEl.onclick = () => {
        google.colab.notebook.generateWithVariable('contingency_table');
      }
      })();
    </script>
  </div>

    </div>
  </div>





```python
stat, p_value, dof, expected=chi2_contingency(contingency_table)

print(f'Statistic: {stat}, p-value: {p_value}\nDegree of Freedom: {dof}\nExpected Table: {expected}\n')

if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ Churn *do* associate significantly with the payment method (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* significant difference in churn across the payment method (p ≥ 0.05).")
```

    Statistic: 648.1423274814, p-value: 3.6823546520097993e-140
    Degree of Freedom: 3
    Expected Table: [[1134.26891949 1118.10705665 1737.40025557 1184.22376828]
     [ 409.73108051  403.89294335  627.59974443  427.77623172]]
    
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ Churn *do* associate significantly with the payment method (p < 0.05).
    

### **5. Paperless Billing and Churn Rate**

**Hypothesis 9:** `Paperless billing` customers are more likely to churn than non-paperless billing customers.

**H₀:** There is no significant difference in `churn rate` between customers with `PaperlessBilling` and those without.

**H₁:** Customers with `PaperlessBilling` have a significantly higher `churn rate` than those without.

**Solve by Z-test for Proportions**


```python
paperless_billing_yes_churn=df[(df['PaperlessBilling'] == 'Yes') & (df['Churn'] == 'Yes')].shape[0]
paperless_billing_yes_total=df[df['PaperlessBilling'] == 'Yes'].shape[0]

paperless_billing_other_churn=df[(df['PaperlessBilling'] != 'Yes') & (df['Churn'] == 'Yes')].shape[0]
paperless_billing_other_total=df[df['PaperlessBilling'] != 'Yes'].shape[0]

paperless_billing_yes_churn, paperless_billing_yes_total, paperless_billing_other_churn, paperless_billing_other_total
```




    (1400, 4171, 469, 2872)




```python
count=np.array([paperless_billing_yes_churn, paperless_billing_other_churn])
nobs=np.array([paperless_billing_yes_total, paperless_billing_other_total])
```


```python
stat, p_value=proportions_ztest(count, nobs, alternative='larger')

print(f'Statistic: {stat}, p-value: {p_value}')


if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ Customers using Paperless Billing have a significantly higher churn rate (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* significant difference in churn rate between customers using Paperless Billing and those using other Billing methods (p ≥ 0.05).")
```

    Statistic: 16.098477389834656, p-value: 1.3072987118936995e-58
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ Customers using Paperless Billing have a significantly higher churn rate (p < 0.05).
    

### **6. Contract Type and Churn**
**Hypothesis 10:** `Contract` type has a significant association with `churn`.

**H₀:** There is no association between `Contract type` (e.g., month-to-month, one year, two years) and `Churn`.

**H₁:** There is a significant association between `Contract type` and `Churn`.

**Solve by Chi Square for Independence**


```python
contingency_table=pd.crosstab(df['Churn'], df['Contract'])
contingency_table
```





  <div id="df-e0e8a4c9-c1a1-42f2-aafe-eeda8abe8358" class="colab-df-container">
    <div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Contract</th>
      <th>Month-to-month</th>
      <th>One year</th>
      <th>Two year</th>
    </tr>
    <tr>
      <th>Churn</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>No</th>
      <td>2220</td>
      <td>1307</td>
      <td>1647</td>
    </tr>
    <tr>
      <th>Yes</th>
      <td>1655</td>
      <td>166</td>
      <td>48</td>
    </tr>
  </tbody>
</table>
</div>
    <div class="colab-df-buttons">

  <div class="colab-df-container">
    <button class="colab-df-convert" onclick="convertToInteractive('df-e0e8a4c9-c1a1-42f2-aafe-eeda8abe8358')"
            title="Convert this dataframe to an interactive table."
            style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
    <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
  </svg>
    </button>

  <style>
    .colab-df-container {
      display:flex;
      gap: 12px;
    }

    .colab-df-convert {
      background-color: #E8F0FE;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      display: none;
      fill: #1967D2;
      height: 32px;
      padding: 0 0 0 0;
      width: 32px;
    }

    .colab-df-convert:hover {
      background-color: #E2EBFA;
      box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
      fill: #174EA6;
    }

    .colab-df-buttons div {
      margin-bottom: 4px;
    }

    [theme=dark] .colab-df-convert {
      background-color: #3B4455;
      fill: #D2E3FC;
    }

    [theme=dark] .colab-df-convert:hover {
      background-color: #434B5C;
      box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
      filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
      fill: #FFFFFF;
    }
  </style>

    <script>
      const buttonEl =
        document.querySelector('#df-e0e8a4c9-c1a1-42f2-aafe-eeda8abe8358 button.colab-df-convert');
      buttonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';

      async function convertToInteractive(key) {
        const element = document.querySelector('#df-e0e8a4c9-c1a1-42f2-aafe-eeda8abe8358');
        const dataTable =
          await google.colab.kernel.invokeFunction('convertToInteractive',
                                                    [key], {});
        if (!dataTable) return;

        const docLinkHtml = 'Like what you see? Visit the ' +
          '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
          + ' to learn more about interactive tables.';
        element.innerHTML = '';
        dataTable['output_type'] = 'display_data';
        await google.colab.output.renderOutput(dataTable, element);
        const docLink = document.createElement('div');
        docLink.innerHTML = docLinkHtml;
        element.appendChild(docLink);
      }
    </script>
  </div>


<div id="df-03588f9a-23de-48fa-970d-770cc0cba1b7">
  <button class="colab-df-quickchart" onclick="quickchart('df-03588f9a-23de-48fa-970d-770cc0cba1b7')"
            title="Suggest charts"
            style="display:none;">

<svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
     width="24px">
    <g>
        <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
    </g>
</svg>
  </button>

<style>
  .colab-df-quickchart {
      --bg-color: #E8F0FE;
      --fill-color: #1967D2;
      --hover-bg-color: #E2EBFA;
      --hover-fill-color: #174EA6;
      --disabled-fill-color: #AAA;
      --disabled-bg-color: #DDD;
  }

  [theme=dark] .colab-df-quickchart {
      --bg-color: #3B4455;
      --fill-color: #D2E3FC;
      --hover-bg-color: #434B5C;
      --hover-fill-color: #FFFFFF;
      --disabled-bg-color: #3B4455;
      --disabled-fill-color: #666;
  }

  .colab-df-quickchart {
    background-color: var(--bg-color);
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: none;
    fill: var(--fill-color);
    height: 32px;
    padding: 0;
    width: 32px;
  }

  .colab-df-quickchart:hover {
    background-color: var(--hover-bg-color);
    box-shadow: 0 1px 2px rgba(60, 64, 67, 0.3), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
    fill: var(--button-hover-fill-color);
  }

  .colab-df-quickchart-complete:disabled,
  .colab-df-quickchart-complete:disabled:hover {
    background-color: var(--disabled-bg-color);
    fill: var(--disabled-fill-color);
    box-shadow: none;
  }

  .colab-df-spinner {
    border: 2px solid var(--fill-color);
    border-color: transparent;
    border-bottom-color: var(--fill-color);
    animation:
      spin 1s steps(1) infinite;
  }

  @keyframes spin {
    0% {
      border-color: transparent;
      border-bottom-color: var(--fill-color);
      border-left-color: var(--fill-color);
    }
    20% {
      border-color: transparent;
      border-left-color: var(--fill-color);
      border-top-color: var(--fill-color);
    }
    30% {
      border-color: transparent;
      border-left-color: var(--fill-color);
      border-top-color: var(--fill-color);
      border-right-color: var(--fill-color);
    }
    40% {
      border-color: transparent;
      border-right-color: var(--fill-color);
      border-top-color: var(--fill-color);
    }
    60% {
      border-color: transparent;
      border-right-color: var(--fill-color);
    }
    80% {
      border-color: transparent;
      border-right-color: var(--fill-color);
      border-bottom-color: var(--fill-color);
    }
    90% {
      border-color: transparent;
      border-bottom-color: var(--fill-color);
    }
  }
</style>

  <script>
    async function quickchart(key) {
      const quickchartButtonEl =
        document.querySelector('#' + key + ' button');
      quickchartButtonEl.disabled = true;  // To prevent multiple clicks.
      quickchartButtonEl.classList.add('colab-df-spinner');
      try {
        const charts = await google.colab.kernel.invokeFunction(
            'suggestCharts', [key], {});
      } catch (error) {
        console.error('Error during call to suggestCharts:', error);
      }
      quickchartButtonEl.classList.remove('colab-df-spinner');
      quickchartButtonEl.classList.add('colab-df-quickchart-complete');
    }
    (() => {
      let quickchartButtonEl =
        document.querySelector('#df-03588f9a-23de-48fa-970d-770cc0cba1b7 button');
      quickchartButtonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';
    })();
  </script>
</div>

  <div id="id_26d8f2c6-c117-441d-9f13-234446104c1e">
    <style>
      .colab-df-generate {
        background-color: #E8F0FE;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        display: none;
        fill: #1967D2;
        height: 32px;
        padding: 0 0 0 0;
        width: 32px;
      }

      .colab-df-generate:hover {
        background-color: #E2EBFA;
        box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
        fill: #174EA6;
      }

      [theme=dark] .colab-df-generate {
        background-color: #3B4455;
        fill: #D2E3FC;
      }

      [theme=dark] .colab-df-generate:hover {
        background-color: #434B5C;
        box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
        filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
        fill: #FFFFFF;
      }
    </style>
    <button class="colab-df-generate" onclick="generateWithVariable('contingency_table')"
            title="Generate code using this dataframe."
            style="display:none;">

  <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
       width="24px">
    <path d="M7,19H8.4L18.45,9,17,7.55,7,17.6ZM5,21V16.75L18.45,3.32a2,2,0,0,1,2.83,0l1.4,1.43a1.91,1.91,0,0,1,.58,1.4,1.91,1.91,0,0,1-.58,1.4L9.25,21ZM18.45,9,17,7.55Zm-12,3A5.31,5.31,0,0,0,4.9,8.1,5.31,5.31,0,0,0,1,6.5,5.31,5.31,0,0,0,4.9,4.9,5.31,5.31,0,0,0,6.5,1,5.31,5.31,0,0,0,8.1,4.9,5.31,5.31,0,0,0,12,6.5,5.46,5.46,0,0,0,6.5,12Z"/>
  </svg>
    </button>
    <script>
      (() => {
      const buttonEl =
        document.querySelector('#id_26d8f2c6-c117-441d-9f13-234446104c1e button.colab-df-generate');
      buttonEl.style.display =
        google.colab.kernel.accessAllowed ? 'block' : 'none';

      buttonEl.onclick = () => {
        google.colab.notebook.generateWithVariable('contingency_table');
      }
      })();
    </script>
  </div>

    </div>
  </div>





```python
stat, p_value, dof, expected=chi2_contingency(contingency_table)

print(f'Statistic: {stat}, p-value: {p_value}\nDegree of Freedom: {dof}\nExpected Table: {expected}\n')

if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ Churn *do* associate significantly with the Contract Types (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* significant difference in churn across the Contract Types (p ≥ 0.05).")
```

    Statistic: 1184.5965720837926, p-value: 5.863038300673391e-258
    Degree of Freedom: 2
    Expected Table: [[2846.69175067 1082.11018032 1245.198069  ]
     [1028.30824933  390.88981968  449.801931  ]]
    
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ Churn *do* associate significantly with the Contract Types (p < 0.05).
    

**Hypothesis 11:** Longer `contract` types correlate with lower `churn rates`.

**H₀:** The churn rate does not significantly vary with contract length (e.g., month-to-month vs. one-year vs. two-year).

**H₁:** The churn rate significantly decreases with longer contract lengths.

**Solve by Z-test for Proportions.**


```python
def z_test_contracts(data, contract1, contract2):
  """
    Conducts a Z-test to compare churn rates between two contract types in a given dataset.

    Parameters:
    ----------
    data : DataFrame
        The dataset containing customer contract information with columns 'Contract' and 'Churn'.
    contract1 : str
        The first contract type to compare (e.g., 'Month-to-month').
    contract2 : str
        The second contract type to compare (e.g., 'One year' or 'Two year').

    Returns:
    -------
    z_stat : float
        The Z-test statistic for the comparison of churn rates between the two contract types.
    p_value : float
        The p-value indicating if the churn rate of the first contract type is significantly smaller than that of the second.

    Notes:
    ------
    The test uses a one-tailed hypothesis (alternative='smaller') to determine if the churn rate
    for `contract1` is significantly smaller than for `contract2`.

    Example Usage:
    -------------
    z_mm_one, p_mm_one = z_test_contracts(df, 'Month-to-month', 'One year')
    """
  contract1_churn=data[(data['Contract'] == contract1) & (data['Churn'] == 'Yes')].shape[0]
  contract1_total=data[df['Contract'] == contract1].shape[0]

  contract2_churn=data[(data['Contract'] == contract2) & (data['Churn'] == 'Yes')].shape[0]
  contract2_total=data[df['Contract'] == contract2].shape[0]

  count=np.array([contract1_churn, contract2_churn])
  nobs=np.array([contract1_total, contract2_total])

  z_stat, p_value = proportions_ztest(count, nobs, alternative='smaller')

  return z_stat, p_value

z_mm_one, p_mm_one=z_test_contracts(df, 'Month-to-month', 'One year')
z_mm_two, p_mm_two=z_test_contracts(df, 'Month-to-month', 'Two year')
z_one_two, p_one_two=z_test_contracts(df, 'One year', 'Two year')
```


```python
interpretations={
    'Month-to-month vs One year': (z_mm_one, p_mm_one),
    'Month-to-month vs Two year': (z_mm_two, p_mm_two),
    'One year vs Two year': (z_one_two, p_one_two)
}

interpretation_results=[]
significance_level=0.05

for comparison, (z_stat, p_value) in interpretations.items():
    if p_value < significance_level:
        interpretation = (f"For {comparison} comparison: Z-statistic = {z_stat:.2f}, p-value = {p_value:.4f}. "
                          "Result: Significant difference in churn rates.\n")
    else:
        interpretation = (f"For {comparison} comparison: Z-statistic = {z_stat:.2f}, p-value = {p_value:.4f}. "
                          "Result: No significant difference in churn rates.\n")
    interpretation_results.append(interpretation)

interpretation_results
```




    ['For Month-to-month vs One year comparison: Z-statistic = 21.68, p-value = 1.0000. Result: No significant difference in churn rates.\n',
     'For Month-to-month vs Two year comparison: Z-statistic = 29.72, p-value = 1.0000. Result: No significant difference in churn rates.\n',
     'For One year vs Two year comparison: Z-statistic = 9.44, p-value = 1.0000. Result: No significant difference in churn rates.\n']



### **7. Demographic Factors**

**Hypothesis 12:** `Senior` customers have a higher `churn rate` than non-senior customers.

**H₀:** The churn rate for senior customers is the same as for non-senior customers.

**H₁:** Senior customers have a significantly higher churn rate than non-senior customers.

**Solve by Z-test for Proportions.**


```python
df.SeniorCitizen.unique()
```




    [0, 1]
    Categories (2, int64): [0, 1]




```python
senior_churn=df[(df['SeniorCitizen'] == 1) & (df['Churn'] == 'Yes')].shape[0]
senior_total=df[df['SeniorCitizen'] == 1].shape[0]

non_senior_churn=df[(df['SeniorCitizen'] != 1) & (df['Churn'] == 'Yes')].shape[0]
non_senior_total=df[df['SeniorCitizen'] != 1].shape[0]

senior_churn, senior_total, non_senior_churn, non_senior_total
```




    (476, 1142, 1393, 5901)




```python
count=np.array([senior_churn, non_senior_churn])
nobs=np.array([senior_total, non_senior_total])
```


```python
stat, p_value=proportions_ztest(count, nobs, alternative='larger')

print(f'Statistic: {stat}, p-value: {p_value}')


if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ Customers who are Senior have a significantly higher churn rate (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* significant difference in churn rate between customers who are either Senior or non-senior (p ≥ 0.05).")
```

    Statistic: 12.663022223987696, p-value: 4.738951753688018e-37
    ✅ Result: Reject the Null Hypothesis (H₀)
      ➡ Customers who are Senior have a significantly higher churn rate (p < 0.05).
    

**Hypothesis 13:** `Gender` has no significant impact on `churn rates`.

**H₀:** The `churn rate` is the same for `male and female` customers.

**H₁:** There is a significant difference in `churn rate` between `male and female` customers.

**Solve by Chi Square for Independence.**


```python
contingency_table=pd.crosstab(df['Churn'], df['gender'])
print(contingency_table)
```

    gender  Female  Male
    Churn               
    No        2549  2625
    Yes        939   930
    


```python
stat, p_value, dof, expected=chi2_contingency(contingency_table)

print(f'Statistic: {stat}, p-value: {p_value}\nDegree of Freedom: {dof}\nExpected Table: {expected}\n')

if p_value < 0.05:
    print("✅ Result: Reject the Null Hypothesis (H₀)")
    print("  ➡ Churn *do* associate significantly with the Genders (p < 0.05).")
else:
    print("🚨 Result: Fail to Reject the Null Hypothesis (H₀)")
    print("  ➡ There is *no* significant difference in churn across the Genders (p ≥ 0.05).")
```

    Statistic: 0.4840828822091383, p-value: 0.48657873605618596
    Degree of Freedom: 1
    Expected Table: [[2562.38989067 2611.61010933]
     [ 925.61010933  943.38989067]]
    
    🚨 Result: Fail to Reject the Null Hypothesis (H₀)
      ➡ There is *no* significant difference in churn across the Genders (p ≥ 0.05).
    


```python

```
