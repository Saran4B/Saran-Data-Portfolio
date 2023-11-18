# data transformation and visualization pandas 

import pandas as pd
penguins = pd.read_csv('penguins.csv')
penguins.head()

# preview last 5 row
penguins.tail()

# shape of dataframe
penguins.shape
(344, 7)
penguins.info()
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 344 entries, 0 to 343
Data columns (total 7 columns):
 #   Column             Non-Null Count  Dtype  
---  ------             --------------  -----  
 0   species            344 non-null    object 
 1   island             344 non-null    object 
 2   bill_length_mm     342 non-null    float64
 3   bill_depth_mm      342 non-null    float64
 4   flipper_length_mm  342 non-null    float64
 5   body_mass_g        342 non-null    float64
 6   sex                333 non-null    object 
dtypes: float64(4), object(3)
memory usage: 18.9+ KB
penguins.species.head()

penguins.columns
Index(['species', 'island', 'bill_length_mm', 'bill_depth_mm',
       'flipper_length_mm', 'body_mass_g', 'sex'],
      dtype='object')
penguins[["species", "island", "sex"]].tail(10)

# integer location based indexing (iloc)

penguins

penguins.iloc[0:5, [0,1,2]]

penguins.iloc[0:5, 0:3]

mini_penguins = penguins.iloc[0:5, 0:3]
mini_penguins

#filter dataframe with one condition 
penguins['island'] == 'Torgersen' 
 # as boolean

penguins[ penguins['island'] == 'Torgersen' ]

penguins[ penguins['bill_length_mm'] >34 ]

# filter more than one condition 
# and use &

penguins[ (penguins['island'] == 'Torgersen') & (penguins['bill_length_mm'] >34)]

# or use |

penguins[ (penguins['island'] == 'Torgersen') | ( penguins['bill_length_mm'] >34 )]

# filter with .query()

penguins.query('island == "Torgersen" & bill_length_mm > 34') ## ' ""  '

# missing value 
penguins.isna().sum()

penguins[ penguins['sex'].isna()]

penguins.isna().sum()

penguins[ penguins['sex'].isna()]

penguins[ penguins['bill_length_mm'].isna()]

# drop na
clean_penguins = penguins.dropna()
clean_penguins

clean_penguins.isna().sum()

#Mean imputation 
top5_penguins = penguins.head(5)
top5_penguins

avg_value =  top5_penguins['bill_length_mm'].mean()
top5_penguins =  top5_penguins['bill_length_mm'].fillna(value = avg_value)
top5_penguins

# sort dataframe 
penguins.sort_values('bill_length_mm') #insc

penguins.sort_values('bill_length_mm', ascending = False ) # desc

penguins.dropna().sort_values('bill_length_mm').head(10)

# sort multiple column 
penguins.dropna().sort_values(['island', 'bill_length_mm'])

# Unique and Count
penguins['species'].value_counts()

# count more than 1 column 
result = penguins[ ['island', 'species'] ].value_counts().reset_index()

result.columns = ['island', 'species', 'count']
result

#summarise dataframe

penguins.describe()

penguins.describe(include= 'all')

penguins['bill_length_mm'].var()
29.807054329371816
# Group by sum+mean
penguins[penguins['species'] == 'Adelie']['bill_length_mm'].mean()
38.79139072847682
penguins.groupby('species')['bill_length_mm'].mean()

# Aggregate function 
penguins.groupby('species')['bill_length_mm'].agg(['max', 'min', 'mean', 'std'])


result = penguins.groupby(['island', 'species'])\
['bill_length_mm'].agg(['max', 'min', 'mean', 'std'])\
    .reset_index()
result.to_csv('result.csv')
print(result)
      island    species   max   min       mean       std
0     Biscoe     Adelie  45.6  34.5  38.975000  2.480916
1     Biscoe     Gentoo  59.6  40.9  47.504878  3.081857
2      Dream     Adelie  44.1  32.1  38.501786  2.465359
3      Dream  Chinstrap  58.0  40.9  48.833824  3.339256
4  Torgersen     Adelie  46.0  33.5  38.950980  3.025318
# map values MALE : m, FEMALE ; f
penguins['sex_new'] = penguins['sex'].map({'MALE':'m', 'FEMALE':'f' }).fillna('other')
penguins

# Numpy
import numpy as np
# pandas style
penguins['bill_length_mm'].mean()
43.9219298245614
# numpy style
np.mean(penguins['bill_length_mm'])
43.9219298245614
print(np.sum(penguins['bill_depth_mm']))
print(np.var(penguins['bill_length_mm']))
5865.700000000001
29.71989919975377
# where 
score = pd.Series([80,75,70,55,62,14])
np.where(score >= 60, 'pass', 'fall')

df = penguins.query("species == 'Adelie'")[['species', 'bill_length_mm']].dropna()
df['new_coloumn']= np.where(df['bill_length_mm'] > 40, True, False)
df

# Merge
left = {
    'key' : [1,2,3,4],
    'name' : ['aom', 'bew', 'tong', 'beam'],
    'age': [23,23,24,23]
}

right = {
    'key' : [1,2,3,4], 
    'city': ['Floreance', 'Napoli', 'Milan', 'Rome']
}

df_left = pd.DataFrame(left)
df_right = pd.DataFrame(right)
df_left

pd.merge(df_left, df_right, on= 'key')

# Pandas plots
penguins['body_mass_g'].plot(kind = 'hist')


penguins['body_mass_g'].plot(kind = 'hist')


penguins[['body_mass_g', 'bill_length_mm']].plot(kind='hist', bins=10, color=['salmon', 'gold'])


# bar chart
penguins['species'].value_counts().plot(kind='bar', color=['orange', 'red', 'black'])


# scatter plot
penguins[['bill_length_mm', 'bill_depth_mm']].plot(x='bill_length_mm', y='bill_depth_mm', kind='scatter', color='blue')


# Datalore Visualization
penguins
