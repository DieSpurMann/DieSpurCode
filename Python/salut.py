import requests

api_url = 'http://api.carsxe.com/specs?key=jmelhxurc_nlggyrfmf_zkd4bklj4&format=XML&vin=ZFF60FCA8A0169882'
response = requests.get(api_url)

if response.status_code == requests.codes.ok:
    # Enregistre le contenu de la réponse dans un fichier XML
    with open('output.xml', 'w') as xml_file:
        xml_file.write(response.text)

    print("Le fichier XML a été créé avec succès.")

else:
    print("Error:", response.status_code, response.text)