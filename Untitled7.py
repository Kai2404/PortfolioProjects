#!/usr/bin/env python
# coding: utf-8

# In[36]:


from bs4 import BeautifulSoup
import requests


# In[37]:


url = 'https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue'


# In[38]:


page=requests.get(url)


# In[39]:


soup=BeautifulSoup(page.text, 'html')
print(soup)


# In[43]:


table=soup.find_all('table')[1]
print(table)


# In[46]:


world_titles=table.find_all('th')
print(world_titles)


# In[47]:


world_table_titles=[title.text.strip() for title in world_titles]
print(world_table_titles)


# In[48]:


import pandas as pd


# In[49]:


df=pd.DataFrame(columns=world_table_titles)
df


# In[62]:


column_data=table.find_all('tr')


# In[73]:


for row in column_data[1:]:
    row_data=row.find_all('td')
    individual_raw_data=[data.text.strip() for data in row_data]
    
    length=len(df)
    df.loc[length] = individual_raw_data

 
    
    
    


# In[74]:


df


# In[80]:


df.to_csv(r'C:\Users\I506155\OneDrive - SAP SE\Documents\Kairat\companies.csv', index= False)


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




