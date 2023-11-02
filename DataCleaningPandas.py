#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[6]:


df=pd.read_excel(r'C:\Users\I506155\Downloads\Customer Call List.xlsx')
df


# In[18]:


df=df.drop_duplicates()
df


# In[16]:


#del df ['Not_Useful_Column']


# In[29]:


df['Last_Name']=df['Last_Name'].str.replace('[\W_]','',regex=True)
#df['Last_Name']=df['Last_Name'].str.strip('123./') альтерьнативный вариант
df




# In[43]:


df['Phone_Number']=df['Phone_Number'].str.replace('\W','',regex=True)
#df['Phone_Number']=df['Phone_Number'].str.replace('[^a-zA-Z0-9]','') альтернатива чтобы удалить лишние знаки из колонки phonenumber
df['Phone_Number'] = df['Phone_Number'].str.replace(r'(\d{3})(\d{3})(\d{4})', r'\1-\2-\3', regex=True)
#df['Phone_Number']=df['Phone_Number'].apply(lambda x: str(x)) альтернатива добавить тире между цифрами
#df['Phone_Number'].apply(lambda x:x[0:3]+ '-' +x[3:6]+ '-' +x[6:10]) альтернатива добавить тире между цифрами
df['Phone_Number']=df['Phone_Number'].str.replace('Na', '')

df


# In[66]:


df[['Strret Address', 'State', 'ZIP']]=df['Address'].str.split(',',n=2, expand=True) 
df


# In[75]:


df['Paying Customer']=df['Paying Customer'].str.replace('Yeseses', 'Y')
df['Paying Customer']=df['Paying Customer'].str.replace('Nooo', 'N')
df['Do_Not_Contact']=df['Do_Not_Contact'].str.replace('Yes', 'Y')
df['Do_Not_Contact']=df['Do_Not_Contact'].str.replace('No', 'N')
df=df.replace('N/a','')
df




# In[76]:


df=df.fillna('') # удалил везде где none/NaN
df


# In[80]:


for x in df.index:
    if df.loc[x, 'Do_Not_Contact'] == 'Y':
        df.drop(x, inplace=True)
        
df


# In[81]:


for x in df.index:
    if df.loc[x, 'Phone_Number'] == '':
        df.drop(x, inplace=True)
        
df


# In[83]:


df=df.reset_index(drop=True)
df


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




