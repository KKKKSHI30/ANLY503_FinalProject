library(dplyr)
library(stringr)
library(plotly)
library(ggplot2)
library(tidyr)
library(plyr)
library(ggpubr)

select_city <- read.csv("NewData/ten_city.csv")
select_city$month <- rep(c(
  "Jan", "Feb", "Mar", "Apr", "May", "June", "July",
  "Aug", "Sept", "Oct", "Nov", "Dec"
), 10)
select_city$cityname <- as.factor(select_city$city)

select_city$year <- str_split_fixed(select_city$date, "-", 2)[, 1]



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



p1 <- ggplot(year2012, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2012") +
  ylab("City") +
  labs(color = "2-Bedroom Apartment Growth Rate (%)")
p2 <- ggplot(year2013, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2013") +
  ylab("City")
p3 <- ggplot(year2014, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2014") +
  ylab("City")
p4 <- ggplot(year2015, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2015") +
  ylab("City")
p5 <- ggplot(year2016, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2016") +
  ylab("City")
p6 <- ggplot(year2017, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2017") +
  ylab("City")
p7 <- ggplot(year2018, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2018") +
  ylab("City")
p8 <- ggplot(year2019, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2019") +
  ylab("City")
p9 <- ggplot(year2020, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2020") +
  ylab("City")
p10 <- ggplot(year2021, aes(month, cityname, fill = tbrate)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "#f7fcf0", high = "#084081") +
  xlab("Year=2021") +
  ylab("City")

pt <- ggarrange(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10,
  ncol = 2, nrow = 5, # main="Average Price for 2-Bedroom Apartments Growth Rates: 2012-2021",
  common.legend = TRUE, legend = "bottom"
) # ,labels=c("2012","2013","2014","2015","2016","2017","2018","2019","2020","2021"))
pt <- annotate_figure(pt,
  top = text_grob("Average Price for 2-Bedroom Apartments Growth Rates: 2012-2021", size = 14)
)
pt
ggsave("image.png", pt, width = 800, height = 500, limitsize = FALSE)
