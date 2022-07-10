#!/usr/bin/env python
# coding: utf-8

# In[4]:


import pandas as pd


# In[14]:


rank_city = pd.read_csv("NewData/city_clean.csv", index_col=0)

rank_city = rank_city.rename(columns={"counts_x": "potential", "counts_y": "tech"})
rank_city.head()


# In[12]:


# read into the github city lat and lon
us_cities = pd.read_csv(
    "https://raw.githubusercontent.com/plotly/datasets/master/us-cities-top-1k.csv"
)
us_cities.head()


# In[18]:


import math

df = pd.merge(rank_city, us_cities, left_on="cities", right_on="City", how="left")
df1 = df.dropna()
sort_df = df1.sort_values(by=["rank"], ascending=False)
sort_df = sort_df.reset_index(drop=True)
sort_df


# In[ ]:


# In[ ]:


# In[48]:


import plotly.graph_objects as go
# counts 98 times in potential city news
sort_df["text"] = (
    sort_df["City"]
    + "<br> Counts "
    + (sort_df["potential"].astype(str))
    + " times"
    + " in potential city News "
    + "<br> Counts "
    + (sort_df["tech"].astype(str))
    + " times"
    + " in technology News "
)
limits = [(0, 3), (4, 10), (11, 20), (21, 30), (31, 60)]
colors = ["#ae2012", "#ee9b00", "#005f73", "#94d2bd", "#e9d8a6"]
cities = []
scale = 0.25

fig = go.Figure()

for i in range(len(limits)):
    lim = limits[i]
    df_sub = sort_df.iloc[lim[0] : lim[1]]
    fig.add_trace(
        go.Scattergeo(
            locationmode="USA-states",
            lon=df_sub["lon"],
            lat=df_sub["lat"],
            text=df_sub["text"],
            marker=dict(
                size=df_sub["rank"] / scale,
                color=colors[i],
                line_color="rgb(40,40,40)",
                line_width=0.5,
                sizemode="area",
                symbol="star",
            ),
            name="{0} - {1}".format(lim[0], lim[1]),
        )
    )

fig.update_layout(
    title_text="Word Frequency Rank of Cities with Potential and Technology in the United States <br>(Source: Google News API)",
    showlegend=True,
    legend=dict(
        title="Word Frequency Rank of US Potential and Technology Cities",
        orientation="h",
    ),
    font=dict(family="Courier New, monospace", size=11),
    geo=dict(scope="usa", landcolor="rgb(217, 217, 217)",),
)

fig.show()


# In[49]:


fig.write_html("viz_city_rank.html")


# In[ ]:


# In[ ]:


# In[ ]:
