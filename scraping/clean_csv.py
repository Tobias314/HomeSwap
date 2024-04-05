import pandas as pd

def start():
    df = pd.read_csv("new.csv", index_col="ID")

    def clean_and_convert(value):
        cleaned_value = value.replace('€', '').replace('m²', '').replace(".", "").replace('"', "").replace(",", ".").replace(" nicht angegeben ", "").strip()  # Remove '€', 'm²' and strip leading/trailing spaces
        try:
            return float(cleaned_value)
        except ValueError:
            print("Problematic value:", value)
            return None

    df['offer_price'] = df['offer_price'].apply(clean_and_convert)
    df['offer_size'] = df['offer_size'].apply(clean_and_convert)
    df['offer_rooms'] = df['offer_rooms'].apply(clean_and_convert)
    df['pref_max_price'] = df['pref_max_price'].apply(clean_and_convert)
    df['pref_min_size'] = df['pref_min_size'].apply(clean_and_convert)
    df['pref_min_rooms'] = df['pref_min_rooms'].apply(clean_and_convert)

    df.to_csv("filtered.csv")

    import csv_to_json
    csvFilePath = r'filtered.csv'
    jsonFilePath = r'data.json'
    csv_to_json.csv_to_json(csvFilePath, jsonFilePath)