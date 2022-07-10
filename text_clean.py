# import libraries
import nltk
import locationtagger
import pandas as pd
import numpy as np

# essential entity models downloads
nltk.downloader.download("maxent_ne_chunker")
nltk.downloader.download("words")
nltk.downloader.download("treebank")
nltk.downloader.download("maxent_treebank_pos_tagger")
nltk.downloader.download("punkt")
nltk.download("averaged_perceptron_tagger")

# get data from csvs saved from Google API
text1 = pd.read_csv("text.csv")
text2 = pd.read_csv("text2.csv")
text3 = pd.read_csv("text3.csv")
text4 = pd.read_csv("text4.csv")
text5 = pd.read_csv("text5.csv")

# potential city
text1 = text1.append(text2, ignore_index=True)
text1 = text1.append(text3, ignore_index=True)
# technology city
text4 = text4.append(text5, ignore_index=True)

# only get the title column and desc columns
potential_words = text1.loc[:, ["title", "desc"]]
stem_words = text4.loc[:, ["title", "desc"]]
potential_words.to_csv("potential_words.csv")
stem_words.to_csv("stem_words.csv")

# get shape of dataframe
col_number1 = potential_words.shape[1]
row_number1 = potential_words.shape[0]
col_number2 = stem_words.shape[1]
row_number2 = stem_words.shape[0]

# saving texts to string
str1 = ""
for i in range(row_number1):
    for j in range(2):
        str1 += " " + potential_words.iloc[i, j]

str2 = ""
for i in range(row_number2):
    for j in range(2):
        str2 += " " + stem_words.iloc[i, j]

# save location from the strings
place_entity1 = locationtagger.find_locations(text=str1)
place_entity2 = locationtagger.find_locations(text=str2)

# check what we need
# getting all countries from potential cities
print("The countries in potential words : ")
print(place_entity1.countries)

# getting all states from potential cities
print("The states in potential words : ")
print(place_entity1.regions)

# getting all cities from potential cities
print("The cities in potential words : ")
print(place_entity1.cities)

# getting all countries from technology cities
print("The countries in stem words : ")
print(place_entity2.countries)

# getting all states from technology cities
print("The states in stem words : ")
print(place_entity2.regions)

# getting all cities from technology cities
print("The cities in stem words : ")
print(place_entity2.cities)

# saving cities for output
potential_cities_counter = []
stem_cities_counter = []
cities1 = place_entity1.cities
cities2 = place_entity2.cities

potential_regions_counter = []
stem_regions_counter = []
regions1 = place_entity1.regions
regions2 = place_entity2.regions

# saving cities appearances times
lst_count1 = []
lst_count2 = []
for i in cities1:
    print(f"{i} is {str1.count(i)}")
    lst_count1.append(str1.count(i))
for i in cities2:
    print(f"{i} is {str2.count(i)}")
    lst_count2.append(str2.count(i))

lst_count3 = []
lst_count4 = []
for i in regions1:
    print(f"{i} is {str1.count(i)}")
    lst_count3.append(str1.count(i))
for i in regions2:
    print(f"{i} is {str2.count(i)}")
    lst_count4.append(str2.count(i))

# combine city names and counts as a dataframe
data1 = {"cities": cities1, "counts": lst_count1}
data1 = pd.DataFrame(data1)
data2 = {"cities": cities2, "counts": lst_count2}
data2 = pd.DataFrame(data2)

data3 = {"regions": regions1, "counts": lst_count3}
data3 = pd.DataFrame(data3)
data4 = {"regions": regions2, "counts": lst_count4}
data4 = pd.DataFrame(data4)

# merge potential cities and technology cities to one dataframe
# add them together as a rank for the city
data_full = pd.merge(data1, data2, on="cities", how="outer")
data_full = data_full.replace(np.nan, 0)
sum_column = data_full["counts_x"] + data_full["counts_y"]
data_full["rank"] = sum_column
data_full["counts_x"] = data_full["counts_x"].astype(int)
data_full["counts_y"] = data_full["counts_y"].astype(int)
data_full["rank"] = data_full["rank"].astype(int)
data_full.to_csv("city_clean.csv")

data_full2 = pd.merge(data3, data4, on="regions", how="outer")
data_full2 = data_full2.replace(np.nan, 0)
sum_column = data_full2["counts_x"] + data_full2["counts_y"]
data_full2["rank"] = sum_column
data_full2["counts_x"] = data_full["counts_x"].astype(int)
data_full2["counts_y"] = data_full["counts_y"].astype(int)
data_full2["rank"] = data_full["rank"].astype(int)
data_full2.to_csv("regions_clean.csv")