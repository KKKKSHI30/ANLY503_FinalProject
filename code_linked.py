#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May  7 10:53:18 2022

@author: yudichen
"""

import pandas as pd
import altair as alt

select_city = pd.read_csv("NewData/select_city.csv")

select_city = select_city[
    select_city["city"].isin(["Austin", "Dallas", "New York", "Miami", "Orlando"])
]

select_city["date1"] = select_city["date"]

domain_pd = pd.to_datetime(["2012-01-31", "2021-12-31"]).astype(int) / 10 ** 6

selector = alt.selection_single(empty="all", fields=["city"])


scale = alt.Scale(
    domain=["Austin", "Dallas", "New York", "Miami", "Orlando"],
    range=["#442288", "#F0B801", "#6CA2EA", "#EB7D5B", "#B5D33D"],
)

color = alt.Color("city:N", scale=scale)

base = alt.Chart(select_city).properties(width=300, height=250).add_selection(selector)


boxes = (
    base.mark_boxplot()
    .encode(
        x=alt.X("twobed_price:Q", title="Two-Bedroom Apartment Average Price (USD:$)"),
        y=alt.Y(
            "city:O",
            sort=["Austin", "Dallas", "New York", "Miami", "Orlando"],
            title="City",
        ),
        color=alt.condition(selector, color, alt.value("lightgray")),
    )
    .properties(title="Two-Bedroom Apartment Average Price Boxplot")
)

lines = (
    base.mark_line()
    .encode(
        alt.X("date:T", title="Date"),
        alt.Y("tbrate:Q", title="Two-Bedroom Apartment Price Monthly Growth Rate (%)"),
        color=alt.condition(selector, color, alt.value("lightgray")),
        tooltip=[
            "city",
            alt.Tooltip("date1:T", title="date"),
            alt.Tooltip("price:N", title="USD($)"),
            alt.Tooltip("tbrate:N", title="growth rate (%)"),
        ],
    )
    .properties(width=500, title="Two-Bedroom Apartment Growth Rate over 10 Years")
)

boxes_condo = (
    base.mark_boxplot()
    .encode(
        x=alt.X("condo_price:Q", title="Condo Average Price (USD:$)"),
        y=alt.Y(
            "city:O",
            sort=["Austin", "Dallas", "New York", "Miami", "Orlando"],
            title="City",
        ),
        color=alt.condition(selector, color, alt.value("lightgray")),
    )
    .properties(title="Condo Average Price Boxplot")
)

lines_condo = (
    base.mark_line()
    .encode(
        alt.X("date:T", title="Date"),
        alt.Y("conrate:Q", title="Condo Price Monthly Growth Rate (%)"),
        color=alt.condition(selector, color, alt.value("lightgray")),
        tooltip=[
            "city",
            alt.Tooltip("date1:T", title="date"),
            alt.Tooltip("price:N", title="USD($)"),
            alt.Tooltip("tbrate:N", title="growth rate (%)"),
        ],
    )
    .properties(width=500, title="Condo Growth Rate over 10 Years")
)

fig = (lines | boxes) & (lines_condo | boxes_condo)
fig = (
    fig.properties(
        title={
            "text": ["Two-Bedroom Apartment and Condo Average Price and Growth: 2012-2021"],
            "subtitle": ["Scaled by 5 Potential STEM Cities"],
        }
    )
    .configure_axis(grid=False)
    .configure_title(fontSize=14, anchor="middle")
)  # .configure_legend(orient="top",direction="horizontal")


fig.save("viz_linked.html")
# (lines | boxes).save("ALTAIR.html")
