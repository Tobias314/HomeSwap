import requests
from bs4 import BeautifulSoup

cookies = {
    "tauschwohnung": "e80188375b1d0be651091a1874b5fd53f05427d9"
}

def initial_request():
    url = "https://www.tauschwohnung.com/search/result?city=Berlin&housing_type=1&storey_min=-1&storey_max=100&sort=standard&page=1"
    response = requests.get(url, cookies=cookies)

    if response.status_code == 200:
        print(response.text)
        soup = BeautifulSoup(response.text, 'html.parser')

        page_links = soup.find_all('a', class_='page-link')

        page_numbers = [link['href'].split('=')[-1] for link in page_links]
        print(page_numbers)
    else:
        print("Failed to retrieve the webpage. Status code:", response.status_code)