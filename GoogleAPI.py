# libraries
from GoogleNews import GoogleNews
import pandas as pd

# result list
resultlist = []

# get pages of text from API
for i in range(51, 100):
    googlenews = GoogleNews(lang="en", period="1y")
    googlenews.search("technology job city in US")
    googlenews.get_page(i)
    results = googlenews.results(sort=True)
    googlenews.clear()

    # saving to list
    for result in results:
        print("\n\nTITLE:", result["title"], "\nDESC:", result["desc"])
        resultlist.append(result)

# change to dataframe and output
resultlist = pd.DataFrame(resultlist)
resultlist.to_csv("text5.csv")
