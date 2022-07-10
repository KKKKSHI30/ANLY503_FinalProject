#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import plotly.express as px


# In[2]:


select_city = pd.read_csv("NewData/select_city.csv", index_col=0)
select_city.reset_index(inplace=True)
select_city["year"] = pd.DatetimeIndex(select_city["date"]).year
select_city = select_city.dropna()
select_city


# In[3]:


# select_city_rate = select_city.groupby(['city']).mean()
# select_city_rate = select_city_rate.dropna()
# select_city['tbrate'].astype('float')
# select_city['conrate'].astype('float')
# select_city['tbrate'] = round((select_city_rate['tbrate']),2)
# select_city['conrate'] = round((select_city_rate['conrate']),2)
# select_city_rate.reset_index(inplace=True)
select_city_rate = select_city.loc[:, ["year", "city", "conrate", "tbrate"]]
# select_city_rate = select_city_rate.dropna()
select_city_rate.head(100)


# In[ ]:


# In[4]:


select_city_tb = select_city_rate.iloc[:, 0:3]
select_city_tb["label"] = "tb"
select_city_tb = pd.DataFrame(select_city_tb)
select_city_conrate = select_city_rate.loc[:, ["city", "conrate", "year"]]
select_city_conrate["label"] = "con"
select_city_conrate = pd.DataFrame(select_city_conrate)
select_city_tb = select_city_tb.rename(columns={"conrate": "rate"})
select_city_conrate = select_city_conrate.rename(columns={"conrate": "rate"})

select_city_tb


# In[5]:


newrate = select_city_tb.append(select_city_conrate)
# newrate = newrate.rename(columns={'conrate_x': 'tbrate', 'conrate_y': 'conrate'})
# rank_city.head()
# newrate[["conrate","tbrate"]].bfill(axis = 1)

newrate.head(600)


# In[7]:


import plotly.graph_objects as go

import pandas as pd

fig = go.Figure()

fig.add_trace(
    go.Violin(
        x=newrate["city"][newrate["label"] == "tb"],
        y=newrate["rate"][newrate["label"] == "tb"],
        legendgroup="tb",
        scalegroup="tb",
        name="Two Bedroom Growth Rate",
        side="negative",
        # animation_frame='year',
        line_color="#005f73",
    )
)
fig.add_trace(
    go.Violin(
        x=newrate["city"][newrate["label"] == "con"],
        y=newrate["rate"][newrate["label"] == "con"],
        legendgroup="con",
        scalegroup="con",
        name="Condo Growth Rate",
        # animation_frame='year',
        side="positive",
        line_color="#ee9b00",
    )
)
# fig.update_traces(box_visible=True, meanline_visible=True)
# fig.update_layout(violingap=0, violinmode='overlay')
fig.update_traces(meanline_visible=True, box_visible=True, width=0.8)
fig.update_layout(
    title_text="Average Growth Rate for 2-Bedroom Apartment and Condo from 2012 - 2021 <br><i>Five Most Popular STEM Cities VS Five Most Potential STEM Cities",
    violingap=0,
    violingroupgap=0,
    violinmode="overlay",
    legend=dict(orientation="h"),
    plot_bgcolor='white',
    width=1000, height=680
)
fig.show()


# In[10]:


fig.write_html("viz_select_city_violin.html")




"""
plot = px.violin(
    newrate,
    x=newrate["city"][newrate["label"] == "tb"],
    y=newrate["rate"][newrate["label"] == "tb"],
    animation_frame=newrate["year"][newrate["label"] == "tb"],
)
plot.show()
"""



