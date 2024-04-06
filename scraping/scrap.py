import requests, time, json, re
from bs4 import BeautifulSoup
import pandas as pd

Max_Resultes = 1752

cookies = {
    "tauschwohnung": "e80188375b1d0be651091a1874b5fd53f05427d9"
}

def extract_int(value):
    return re.findall(r'\d+', value)

df = pd.DataFrame()

for x in range(1):
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
            print("Gesucht:", extracted_item)

            item_characteristics = item_soup.find('div', class_='table-responsive')
            characteristics_table = item_characteristics.find('table', class_='table-characteristics')
            characteristics_rows = characteristics_table.find_all('tr')

            extracted_characteristics = {}
            for row in characteristics_rows:
                cells = row.find_all('td')
                characteristic_name = cells[0].text.strip()
                characteristic_value = cells[1].text.strip().replace("                ", "")
                extracted_characteristics[characteristic_name] = characteristic_value
            
            print("Extracted characteristics:", extracted_characteristics)

            total = extracted_characteristics | extracted_item
            r = json.dumps(total, ensure_ascii=False).encode('utf8')
            #print(r)

            item_details = item_soup.find_all('div', class_='col-4')
            
            extracted_details = {}
            for detail in item_details:
                strong_tag = detail.find('strong')
                if strong_tag:
                    value = strong_tag.text.strip()
                    key = strong_tag.find_next_sibling('span').text.strip()
                    extracted_details[key] = value

            print("Item details:", extracted_details)

            articel_id = item_soup.find('p', 'grey mb-0 pb-0').find('small').text.strip()
            articel_id = extract_int(articel_id)[0]

            try:
                image_url = item_soup.find("img", "embed-responsive-item d-block w-100").get("src")
                extracted_item["img_url"] = "https://www.tauschwohnung.com" + image_url
            except:
                extracted_item["img_url"] = "N/A"

            # df = pd.DataFrame([extracted_details, extracted_characteristics, extracted_item])
            # print(df)
            out = extracted_details | extracted_characteristics | extracted_item
            print(out)
            #df.append(out, index=[articel_id])#index = ["Kaltmiete", "Wohnfläche", "Zimmer", "Antwortrate", "Antwortzeit", "Letzter Login", "Objektart", "Nebenkosten", "Kaution", "Stockwerk", "Außenausstattung", "Innenausstattung", "Fußboden", "Heizung", "Merkmale", "Wohnung", "Gesucht Stadt", "Gesucht Stadtteile", "Gesucht Kaltmiete (max.)", "Gesucht Wohnfläche (min.)", "Gesucht Zimmer (min.)"]
            df = pd.concat([df, pd.DataFrame(out, index=[articel_id])])
            df = df.rename_axis('ID')

df.to_csv("t.csv")
df.to_json("t.json")
df = df.drop(["Antwortrate", "Antwortzeit", "Letzter Login", "Objektart", "Nebenkosten", "Kaution", "Einzugsdatum", "Stockwerk", "Außenausstattung", "Innenausstattung", "Fußboden", "Heizung", "Merkmale", "Wohnung", "Stadtteile"], axis=1)
if 'PLZ' in df.columns:
    df = df.drop(["PLZ"], axis=1)
elif "Mietdauer" in df.columns:
    df = df.drop(["Mietdauer"], axis=1)

df = df.rename(columns={"Kaltmiete (max.)": "pref_max_price", "Wohnfläche (min.)": "pref_min_size", "Zimmer (min.)": "pref_min_rooms"})
df = df.rename(columns={"Kaltmiete": "offer_price", "Wohnfläche": "offer_size", "Zimmer": "offer_rooms"})
df = df.rename(columns={"Stadt": "pref_city"})
df.to_csv("new.csv")
import clean_csv
clean_csv.start()
