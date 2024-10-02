import xml.etree.ElementTree as ET

# Charger le XML depuis le fichier
tree = ET.parse('output.xml')
root = tree.getroot()

# Initialiser une liste pour stocker les données
tableau = []

# Parcourir les éléments du XML
for voiture in root.findall('.//attributes'):
    # Créer un dictionnaire pour stocker les informations de chaque voiture
    voiture_info = {
        'Year': voiture.find('year').text,
        'Make': voiture.find('make').text,
        'Model': voiture.find('model').text,
        'Fuel Capacity': voiture.find('fuel_capacity').text,
        'City Mileage': voiture.find('city_mileage').text,
        # Ajouter d'autres champs selon les besoins
    }

    # Ajouter le dictionnaire à la liste
    tableau.append(voiture_info)

# Afficher le tableau résultant

print(voiture_info)
for voiture_info in tableau:
    print(voiture_info)
