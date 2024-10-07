# Read the API key from the home directory
with open("~/USDA-API-key.txt", "r") as file:
    api_key = file.read().strip()

# Now you can use the api_key variable for your API requests
query = "chicken"
url = f"https://api.nal.usda.gov/fdc/v1/foods/search?query={query}&api_key={api_key}"
response = requests.get(url)
data = response.json()

# Check if any food data was found
if data['foods']:
    first_food = data['foods'][0]
    
    # Print the header for the TSV format
    print("Food Item\tNutrient\tAmount\tUnit")
    
    # Print the food name and nutrient information in TSV format
    for nutrient in first_food['foodNutrients']:
        nutrient_name = nutrient['nutrientName']
        amount = nutrient['value']
        unit = nutrient['unitName']
        print(f"{first_food['description']}\t{nutrient_name}\t{amount}\t{unit}")
else:
    print("No food found.")
