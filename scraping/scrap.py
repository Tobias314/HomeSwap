import requests
import time
from bs4 import BeautifulSoup

Max_Resultes = 1752

cookies = {
    "tauschwohnung": "e80188375b1d0be651091a1874b5fd53f05427d9"
}

for x in range(Max_Resultes):
    x = x + 1
    print(f"Scraping site {x} of {Max_Resultes}")
    url = f"https://www.tauschwohnung.com/search/result?city=Berlin&housing_type=1&storey_min=-1&storey_max=100&sort=standard&page={x}"
    response = requests.get(url, cookies=cookies)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        listing_links = soup.find_all('a', class_='stretched-link')
        listing_urls = [link['href'] for link in listing_links]
        listing_urls = list(set(listing_urls))
        print("Listing URLs found:", listing_urls)

        for item in listing_urls:
            item_response = requests.get("https://www.tauschwohnung.com/" + item, cookies=cookies)
            item_soup = BeautifulSoup(item_response.text, 'html.parser')

            item_card = item_soup.find_all('div', class_='d-none d-sm-block')
            item_element = item_soup.find_all('div', class_='col-6 col-md-2 mb-2')
            
            extracted_item = {}
            for element in item_element:
                key = element.find('br').previous_sibling.strip()
                value = element.find('strong').text.strip().replace("\xa0", "")
                extracted_item[key] = value
            print("Extracted item:", extracted_item)