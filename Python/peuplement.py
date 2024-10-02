import csv
import psycopg2

conn = psycopg2.connect(dbname="postgres", user="postgres", password="admin", port="5432", host="localhost", options="-c search_path=dbo,automotive")
curr = conn.cursor()

with open('value2.csv', newline='') as csvfile:
    cars = csv.reader(csvfile, delimiter=',')
    listVoitures = list(cars)

for row in listVoitures:
        curr.execute("INSERT INTO _Models values ('"+row[0]+"','"+row[1]+"',"+row[2]+",'"+row[3]+"',"+row[4]+",'"+row[5]+"','"+row[6]+"'"+",'"+row[7]+"'"+",'"+row[8]+"'"+","+row[9]+","+row[10]+",'"+row[11]+"'"+",'"+row[12]+"'"+","+row[13]+",'"+row[14]+"'"+","+row[15]+","+row[16]+",'"+row[17]+"'"+",'"+row[18]+"'"+","+row[19]+","+row[20]+","+row[21]+","+row[22]+");")