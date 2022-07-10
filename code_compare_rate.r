library(dplyr)
library(stringr)
library(plotly)

select_city <- read.csv("NewData/ten_city.csv")

year2012 <- select_city[str_detect(select_city$date, "2012"), ]
year2013 <- select_city[str_detect(select_city$date, "2013"), ]
year2014 <- select_city[str_detect(select_city$date, "2014"), ]
year2015 <- select_city[str_detect(select_city$date, "2015"), ]
year2016 <- select_city[str_detect(select_city$date, "2016"), ]
year2017 <- select_city[str_detect(select_city$date, "2017"), ]
year2018 <- select_city[str_detect(select_city$date, "2018"), ]
year2019 <- select_city[str_detect(select_city$date, "2019"), ]
year2020 <- select_city[str_detect(select_city$date, "2020"), ]
year2021 <- select_city[str_detect(select_city$date, "2021"), ]

order <- c(
  "Austin", "Dallas", "Miami", "New York", "Orlando",
  "Boston", "Los Angeles", "San Jose", "San Francisco", "Seattle"
)

year2012 <- year2012 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate))
year2012 <- year2012[match(order, year2012$city), ]
year2013 <- year2013 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate))
year2013 <- year2013[match(order, year2013$city), ]
year2014 <- year2014 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate))
year2014 <- year2014[match(order, year2014$city), ]
year2015 <- year2015 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate))
year2015 <- year2015[match(order, year2015$city), ]
year2016 <- year2016 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate))
year2016 <- year2016[match(order, year2016$city), ]
year2017 <- year2017 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate))
year2017 <- year2017[match(order, year2017$city), ]
year2018 <- year2018 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate, na.rm = TRUE))
year2018 <- year2018[match(order, year2018$city), ]
year2019 <- year2019 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate))
year2019 <- year2019[match(order, year2019$city), ]
year2020 <- year2020 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate))
year2020 <- year2020[match(order, year2020$city), ]
year2021 <- year2021 %>%
  group_by(city) %>%
  summarise(tb = mean(tbrate), cd = mean(conrate, na.rm = TRUE))
year2021 <- year2021[match(order, year2021$city), ]

fig <- plot_ly(width = 800, height = 500) %>%
  add_trace(data = year2012, x = year2012$city, y = year2012$tb, type = "scatter", mode = "lines+markers", name = "2012 2B") %>%
  add_trace(data = year2013, x = year2013$city, y = year2013$tb, type = "scatter", mode = "lines+markers", name = "2013 2B") %>%
  add_trace(data = year2014, x = year2014$city, y = year2014$tb, type = "scatter", mode = "lines+markers", name = "2014 2B") %>%
  add_trace(data = year2015, x = year2015$city, y = year2015$tb, type = "scatter", mode = "lines+markers", name = "2015 2B") %>%
  add_trace(data = year2016, x = year2016$city, y = year2016$tb, type = "scatter", mode = "lines+markers", name = "2016 2B") %>%
  add_trace(data = year2017, x = year2017$city, y = year2017$tb, type = "scatter", mode = "lines+markers", name = "2017 2B") %>%
  add_trace(data = year2018, x = year2018$city, y = year2018$tb, type = "scatter", mode = "lines+markers", name = "2018 2B") %>%
  add_trace(data = year2019, x = year2019$city, y = year2019$tb, type = "scatter", mode = "lines+markers", name = "2019 2B") %>%
  add_trace(data = year2020, x = year2020$city, y = year2020$tb, type = "scatter", mode = "lines+markers", name = "2020 2B") %>%
  add_trace(data = year2021, x = year2021$city, y = year2021$tb, type = "scatter", mode = "lines+markers", name = "2021 2B") # %>%

fig <- fig %>%
  add_trace(data = year2012, x = year2012$city, y = year2012$cd, type = "scatter", mode = "lines+markers", name = "2012 Condo") %>%
  add_trace(data = year2013, x = year2013$city, y = year2013$cd, type = "scatter", mode = "lines+markers", name = "2013 Condo") %>%
  add_trace(data = year2014, x = year2014$city, y = year2014$cd, type = "scatter", mode = "lines+markers", name = "2014 Condo") %>%
  add_trace(data = year2015, x = year2015$city, y = year2015$cd, type = "scatter", mode = "lines+markers", name = "2015 Condo") %>%
  add_trace(data = year2016, x = year2016$city, y = year2016$cd, type = "scatter", mode = "lines+markers", name = "2016 Condo") %>%
  add_trace(data = year2017, x = year2017$city, y = year2017$cd, type = "scatter", mode = "lines+markers", name = "2017 Condo") %>%
  add_trace(data = year2018, x = year2018$city, y = year2018$cd, type = "scatter", mode = "lines+markers", name = "2018 Condo") %>%
  add_trace(data = year2019, x = year2019$city, y = year2019$cd, type = "scatter", mode = "lines+markers", name = "2019 Condo") %>%
  add_trace(data = year2020, x = year2020$city, y = year2020$cd, type = "scatter", mode = "lines+markers", name = "2020 Condo") %>%
  add_trace(data = year2021, x = year2021$city, y = year2021$cd, type = "scatter", mode = "lines+markers", name = "2021 Condo") # %>%

fig <- fig %>% layout(
  title = "Growth Rate Change for 2-Bedroom Apartment and Condo Average Price: 2012-2021",
  xaxis = list(title = "City"),
  yaxis = list(title = "Price Growth Rate (%)"),
  updatemenus = list(
    list(
      x = 1.75,
      y = 0.95,
      buttons = list(
        list(
          method = "restyle",
          args = list("visible", list(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)),
          label = "Total"
        ),
        list(
          method = "restyle",
          args = list("visible", list(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)),
          label = "2 Bedroom Apartment"
        ),
        list(
          method = "restyle",
          args = list("visible", list(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)),
          label = "Condo"
        )
      )
    )
  )
)

fig <- fig %>% layout(
  xaxis = list(
    title = "City",
    showline = T,
    showgrid = F,
    zerolinewidth = 0.01,
    categoryorder = "array",
    categoryarray = c(
      "Austin", "Dallas", "Miami", "New York", "Orlando",
      "Boston", "Los Angeles", "San Jose", "San Francisco", "Seattle"
    )
  ),
  yaxis = list(
    title = "Average Price Growth Rate (%)",
    showgrid = F,
    showline = T
  ),
  legend = list(y = 0.5, title = list(text = "Property Types", size = 6))
)

htmlwidgets::saveWidget(as_widget(fig), "viz_rate_comparasion.html")
