#!/usr/bin/env python
# coding: utf-8

# In[164]:


import pandas as pd
import requests
import plotly.express as px
import zipfile as z


# In[165]:


zf = z.ZipFile("NewData/New_city.csv.zip")
zf.namelist()
city_growth = pd.read_csv(zf.open("New_city.csv"))
city_growth["year"] = pd.DatetimeIndex(city_growth["date"]).year
city_growth.head()


# In[166]:


state_growth = city_growth.groupby(["state_code", "year"]).mean()
state_growth = state_growth.dropna()
state_growth.head(20)


# In[167]:


state_growth["rate"].astype("float")
state_growth["growth_rate"] = round((state_growth["rate"]), 3)
state_growth.reset_index(inplace=True)
state_growth.head()


# In[ ]:


# In[ ]:


# In[ ]:


# In[ ]:


# In[168]:


statename = {
    "AL": "Alabama",
    "AK": "Alaska",
    "AZ": "Arizona",
    "AR": "Arkansas",
    "CA": "California",
    "CO": "Colorado",
    "CT": "Connecticut",
    "DE": "Delaware",
    "DC": "District of Columbia",
    "FL": "Florida",
    "GA": "Georgia",
    "HI": "Hawaii",
    "ID": "Idaho",
    "IL": "Illinois",
    "IN": "Indiana",
    "IA": "Iowa",
    "KS": "Kansas",
    "KY": "Kentucky",
    "LA": "Louisiana",
    "ME": "Maine",
    "MD": "Maryland",
    "MA": "Massachusetts",
    "MI": "Michigan",
    "MN": "Minnesota",
    "MS": "Mississippi",
    "MO": "Missouri",
    "MT": "Montana",
    "NE": "Nebraska",
    "Nevada": "NV",
    "NH": "New Hampshire",
    "NJ": "New Jersey",
    "NV": "Nevada",
    "NM": "New Mexico",
    "NY": "New York",
    "NC": "North Carolina",
    "ND": "North Dakota",
    "OH": "Ohio",
    "OK": "Oklahoma",
    "OR": "Oregon",
    "PA": "Pennsylvania",
    "RI": "Rhode Island",
    "SC": "South Carolina",
    "SD": "South Dakota",
    "TN": "Tennessee",
    "TX": "Texas",
    "UT": "Utah",
    "VT": "Vermont",
    "VA": "Virginia",
    "WA": "Washington",
    "WV": "West Virginia",
    "WI": "Wisconsin",
    "WY": "Wyoming",
}


# In[169]:


state_growth["state_name"] = state_growth["state_code"].map(statename)
state_growth


# In[170]:


fig = px.choropleth(
    state_growth,
    locations="state_code",
    color="growth_rate",
    color_continuous_scale="gnbu",
    animation_frame="year",
    hover_name="state_name",
    locationmode="USA-states",
    labels={"2012-2021 U.S. 50 States Average House Price Growth Rate": "growth rate %"},
    scope="usa",
)
fig.update_layout(
    title_text="2012-2021 U.S. 50 States Average Real Estate Price Growth Rate<br>(Percentage Change)"
)


# In[171]:


fig.show()


# In[118]:


fig.write_html("viz_state_growth_rate.html")


# In[ ]:


# In[ ]:


# In[ ]:
