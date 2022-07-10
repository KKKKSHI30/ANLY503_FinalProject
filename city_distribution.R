## read in necessary packages
library(plotly)
library(dplyr)
library(ggplot2)

## select the top 5 potencial STEM cities from the data set
select_city <- read.csv("NewData/select_city.csv", header = TRUE)
m <- select_city[select_city$city == "Miami", ]
n <- select_city[select_city$city == "New York", ]
o <- select_city[select_city$city == "Orlando", ]
d <- select_city[select_city$city == "Dallas", ]
a <- select_city[select_city$city == "Austin", ]

## plot the  2B and Condo for 5 cities with two distributions
## same color for a city with the different color tints for two different housing types
fig1 <- plot_ly(width = 800, height = 500) %>%
  add_trace(data = m, x = m$date, y = m$twobed_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "Miami 2B", line = list(color = "rgb(235,125,91)", dash = "dashed"), fillcolor = "rgba(235,125,91,0.9)") %>%
  add_trace(data = m, x = m$date, y = m$condo_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "Miami Condo", line = list(color = "rgb(249,216,206)", dash = "dashed"), fillcolor = "rgba(249,216,206,0.9)") %>%
  add_trace(data = n, x = n$date, y = n$twobed_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "New York 2B", line = list(color = "rgb(108,162,234)", dash = "dashed"), fillcolor = "rgba(108,162,234,0.9)") %>%
  add_trace(data = n, x = n$date, y = n$condo_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "New York Condo", line = list(color = "rgb(196,218,247)", dash = "dashed"), fillcolor = "rgba(196,218,247,0.7)") %>%
  add_trace(data = o, x = o$date, y = o$twobed_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "Orlando 2B", line = list(color = "rgb(181,211,61)", dash = "dashed"), fillcolor = "rgba(181,211,61,0.9)") %>%
  add_trace(data = o, x = o$date, y = o$condo_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "Orlando Condo", line = list(color = "rgb(225,237,177)", dash = "dashed"), fillcolor = "rgba(225,237,177,0.8)") %>%
  add_trace(data = d, x = d$date, y = d$twobed_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "Dallas 2B", line = list(color = "rgb(240,184,1)", dash = "dashed"), fillcolor = "rgba(240,184,1,0.9)") %>%
  add_trace(data = d, x = d$date, y = d$condo_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "Dallas Condo", line = list(color = "rgb(255,233,159)", dash = "dashed"), fillcolor = "rgba(255,233,159,0.7)") %>%
  add_trace(data = a, x = a$date, y = a$twobed_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "Austin 2B", line = list(color = "rgb(68,34,136)", dash = "dashed"), fillcolor = "rgba(68,34,136,0.9)") %>%
  add_trace(data = a, x = a$date, y = a$condo_price, type = "scatter", mode = "lines", fill = "tozeroy", name = "Austin Condo", line = list(color = "rgb(199,189,219)", dash = "dashed"), fillcolor = "rgba(199,189,219,0.7)")

## add title and side menu bar and legends
fig1 <- fig1 %>% layout(
  title = "Average Prices for 2-Bedroom Apartment and Condo in Top 5 Potential STEM Cities",
  xaxis = list(title = "Date"),
  yaxis = list(title = "Average Price (USD$)"),
  updatemenus = list(
    list(
      x = 1.25,
      y = 0.95,
      buttons = list(
        list(
          method = "restyle",
          args = list("visible", list(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)),
          label = "Total"
        ),
        list(
          method = "restyle",
          args = list("visible", list(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)),
          label = "Miami"
        ),
        list(
          method = "restyle",
          args = list("visible", list(FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)),
          label = "New York"
        ),
        list(
          method = "restyle",
          args = list("visible", list(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE)),
          label = "Orlando"
        ),
        list(
          method = "restyle",
          args = list("visible", list(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE)),
          label = "Dallas"
        ),
        list(
          method = "restyle",
          args = list("visible", list(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE)),
          label = "Austin"
        )
      )
    )
  )
)

## format axis and legend
fig1 <- fig1 %>% layout(
  xaxis = list(
    title = "Date",
    showline = T,
    showgrid = F,
    zerolinewidth = 0.01
  ),
  yaxis = list(
    title = "Average Price (USD$)",
    showgrid = F,
    showline = T
  ),
  legend = list(y = 0.2, title = list(text = "Potential Cities", size = 6))
)

## save html
htmlwidgets::saveWidget(as_widget(fig1), "viz_city_distribution.html")
