#!/usr/bin/env python
# coding: utf-8

# In[7]:


import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


# In[13]:


df=pd.read_csv(r"C:\Users\I506155\Downloads\world_population (1).csv")
df


# In[12]:


pd.set_option('display.float_format', lambda x:'%.2f' % x)


# In[14]:


df.info()


# In[15]:


df.describe()


# In[16]:


df.isnull().sum()


# In[17]:


df.nunique()


# In[21]:


df.sort_values(by='2022 Population', ascending=False).head(10)


# In[23]:


df.corr(numeric_only=True)


# In[26]:


sns.heatmap(df.corr(numeric_only=True), annot = True)
plt.rcParams['figure.figsize']= (20,7)
plt.show()


# In[32]:


df.groupby('Continent').mean(numeric_only=True).sort_values(by = '2022 Population', ascending=False)


# In[31]:


df[df['Continent'].str.contains('Oceania')]


# In[51]:


df2=df.groupby('Continent')[['1970 Population',
       '1980 Population', '1990 Population', '2000 Population',
       '2010 Population', '2015 Population', '2020 Population',
       '2022 Population']].mean(numeric_only=True).sort_values(by = '2022 Population', ascending=False)
df2



# In[42]:


df.columns #создали, чтобы скопировать нужные колонки и вставить в верхнюю часть


# In[52]:


df3=df2.transpose()
df3


# In[53]:


df3.plot()


# In[55]:


df.boxplot(figsize=(20,10))


# In[58]:


df.select_dtypes(include='number')


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




