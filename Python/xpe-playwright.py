from playwright.sync_api import sync_playwright, Playwright

with sync_playwright() as playwright:
    lCarVal = dict()
    i = 0
    nomMarque = 'Audi'
    firefox = playwright.firefox
    browser = firefox.launch(headless=False, slow_mo=50)
    page = browser.new_page()
    page.goto("https://www.motorsdb.com/fiches-techniques.html")
    page.get_by_role("link", name="Constructeurs principaux").click()
    page.get_by_role("link", name=nomMarque).click()
    page.get_by_role("link", name="Tous les modèles").click()
    baseURL = page.url
    page.query_selector('a.pagination_deb').click()
    dernierePage = page.title()
    dernierePage = dernierePage.split("-")
    dernierePage = dernierePage[2].split(" ")
    dernierePage = int(dernierePage[2]) + 1
    page.go_back()
    page.wait_for_timeout(3000)
    print(dernierePage)
    for pageAct in range(2, dernierePage):
        newURL = baseURL[:-6] + str(pageAct) + ".html"
        print(page.url)
        page.wait_for_load_state("domcontentloaded")
        element = page.get_by_role("row")
        carLST = element.all_inner_texts()
        carLST.pop(0)
        newCarLST = list()
        for car in carLST:
            if (car[3] != ""):
                newCarLST.append(car[5:].strip())
            else:
                newCarLST.append(car[6:].strip())
        for car in newCarLST:
            i += 1
            print(i)
            print("Point de passage")
            if (car[0] != "↳"):
                while (car[0] != nomMarque[0]):
                    car = car[1:]
                    print(car)
                lCarDict = {"fuel":"", "engine":"","displacement":"", "boost":"", "power":"", "torque":"", "transmission":"", "gearbox":"", "weight":"", "speed":"", "0-62":"" }
                page.get_by_role("table").get_by_role("link", name=car).first.click()
                elt = page.get_by_role("row", name="Énergie")
                if (elt.all_inner_texts() != []):
                    lCarDict["fuel"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="Type")
                if (elt.all_inner_texts() != [] ):
                    print("Je suis dans le premier if != []")
                    if (len(elt.all_inner_texts()) > 1):
                        print("Je suis dans le 2ème if != si c'est supérieur a 1")
                        lCarDict["engine"] = elt.all_inner_texts()[0].split("\t")[1]
                        lCarDict["transmission"] = elt.all_inner_texts()[1].split("\t")[1]
                    elif ((elt.all_inner_texts()[0] == "Type\tIntégrale") or  (elt.all_inner_texts()[0] == "Type\tPropulsion") or (elt.all_inner_texts()[0] == "Type\tTraction")):
                        print("Je suis dans le premier elif")
                        lCarDict["transmission"] = elt.all_inner_texts()[0].split("\t")[1]
                    else :
                        print("Je suis dans le else")
                        lCarDict["engine"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="Cylindrée")
                if (elt.all_inner_texts() != []):
                    lCarDict["displacement"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="Suralimentation")
                if (elt.all_inner_texts() != []):
                    lCarDict["boost"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="Puissance")
                if (elt.all_inner_texts() != []):
                    lCarDict["power"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="Couple")
                if (elt.all_inner_texts() != []):
                    lCarDict["torque"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="Boite de vitesses")
                if (elt.all_inner_texts() != []):
                    lCarDict["gearbox"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="Poids")
                if (elt.all_inner_texts() != []):
                    lCarDict["weight"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="Vitesse maximale")
                if (elt.all_inner_texts() != []):
                    lCarDict["speed"] = elt.all_inner_texts()[0].split("\t")[1]
                elt = page.get_by_role("row", name="0-100 km/h")
                if (elt.all_inner_texts() != []):
                    lCarDict["0-62"] = elt.all_inner_texts()[0].split("\t")[1]
                lCarVal[car] = lCarDict
                page.go_back()
                page.wait_for_load_state("domcontentloaded")
        page.goto(newURL)
    browser.close()
    
    
def remove_two_digits_if_present(s):
    if len(s) >= 2 and s[0].isdigit() and s[1].isdigit():
        return s[2:]
    return s