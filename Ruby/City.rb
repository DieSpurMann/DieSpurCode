
# city.rb
#
# Author:: DieSpurMann
# Date:: 2025-09-20
#
# This class represents a city and provides methods to access its name and population.
#
# == Example
#
#   city = City.new("Paris", 2148000)
#   puts city.name         # => "Paris"
#   puts city.population   # => 2148000
#
# == Attributes
#
# * +name+ - The name of the city (String)
# * +population+ - The population of the city (Integer)




##
# This class is used to define a city.

class City
	private_class_method :new

	def initialize(name, population)
		@name = name
		@population = population
	end

    ##
	# Creates a new City object.
	#
	# === Parameters
	# * +name+ - The name of the city (String)
	# * +population+ - The population of the city (Integer)
    def City.settle(name, population)
        new(name, population)
    end

	##
	# Returns the name of the city.
	#
	# === Returns
	# * +String+ - The name of the city
	def name
		@name
	end

	##
	# Returns the population of the city.
	#
	# === Returns
	# * +Integer+ - The population of the city
	def population
		@population
	end

    ##
    # Returns a string representation of the city.
    # === Returns
    # * +String+ - A string representation of the city
    def to_s
        return "La ville #{@name} a #{@population} habitants."
    end
end

# Example usage:
paris = City.settle("Paris", 2148000)
miami = City.settle("Miami", 467963)
nyc = City.settle("New York City", 8419600)
delhi = City.settle("Delhi", 16787941)
newdelhi = City.settle("New Delhi", 257803)
seattle = City.settle("Seattle", 753675)
acapulco = City.settle("Acapulco", 687608)
tokyo = City.settle("Tokyo", 13929286)
shanghai = City.settle("Shanghai", 24183300)
beijing = City.settle("Beijing", 21542000)
berlin = City.settle("Berlin", 3769000)
bangkok = City.settle("Bangkok", 8281000)
mumbai = City.settle("Mumbai", 12442373)
lyon = City.settle("Lyon", 515695)
marseille = City.settle("Marseille", 861635)
stuttgart = City.settle("Stuttgart", 635911)
cologne = City.settle("Cologne", 1085664)
london = City.settle("London", 8982000)
manchester = City.settle("Manchester", 553230)
birmingham = City.settle("Birmingham", 1141816)
edinburgh = City.settle("Edinburgh", 482005)
glasgow = City.settle("Glasgow", 635640)
swansea = City.settle("Swansea", 246466)
leeds = City.settle("Leeds", 789194)
reading = City.settle("Reading", 163203)
woking = City.settle("Woking", 103900)
shenzhen = City.settle("Shenzhen", 125283000)
warsaw = City.settle("Warsaw", 1793579)
prague = City.settle("Prague", 1301132)
vienna = City.settle("Vienna", 1897491)
budapest = City.settle("Budapest", 1752286)
lisbon = City.settle("Lisbon", 504718)
porto = City.settle("Porto", 237591)
rome = City.settle("Rome", 2873000)
milan = City.settle("Milan", 1366180)
naples = City.settle("Naples", 962003)
turin = City.settle("Turin", 870952)
venice = City.settle("Venice", 261905)
florence = City.settle("Florence", 382258)
bordeaux = City.settle("Bordeaux", 257068)
nantes = City.settle("Nantes", 309346)
rennes = City.settle("Rennes", 219272)
strasbourg = City.settle("Strasbourg", 280966)
schengen = City.settle("Schengen", 450)
dresden = City.settle("Dresden", 558640)
hamburg = City.settle("Hamburg", 1841179)
munich = City.settle("Munich", 1471508)
frankfurt = City.settle("Frankfurt", 753056)
copenhagen = City.settle("Copenhagen", 794128)
oslo = City.settle("Oslo", 681067)
stockholm = City.settle("Stockholm", 975551)
helsinki = City.settle("Helsinki", 656611)
riga = City.settle("Riga", 632614)
vilnius = City.settle("Vilnius", 580020)
tallinn = City.settle("Tallinn", 437619)
amsterdam = City.settle("Amsterdam", 872757)
rotterdam = City.settle("Rotterdam", 651446)
brussels = City.settle("Brussels", 1211035)
antwerp = City.settle("Antwerp", 529247)
ghent = City.settle("Ghent", 262219)
bruges = City.settle("Bruges", 118284)
zagreb = City.settle("Zagreb", 806341)
belgrade = City.settle("Belgrade", 1166763)
sarajevo = City.settle("Sarajevo", 275524)
sydney = City.settle("Sydney", 5312163)
melbourne = City.settle("Melbourne", 5078193)
brisbane = City.settle("Brisbane", 2514184)
perth = City.settle("Perth", 2059484)
adelaide = City.settle("Adelaide", 1345777)
canberra = City.settle("Canberra", 431380)
auckland = City.settle("Auckland", 1657000)
wellington = City.settle("Wellington", 215100)
christchurch = City.settle("Christchurch", 381800)
honolulu = City.settle("Honolulu", 345064)

puts paris
puts miami
puts nyc
puts delhi
puts newdelhi
puts seattle
puts acapulco
puts tokyo
puts shanghai
puts beijing
puts berlin
puts bangkok
puts mumbai
puts lyon
puts marseille
puts stuttgart
puts cologne
puts london
puts manchester
puts birmingham
puts edinburgh
puts glasgow
puts swansea
puts leeds
puts reading
puts woking
puts shenzhen
puts warsaw
puts prague
puts vienna
puts budapest
puts lisbon
puts porto
puts rome
puts milan
puts naples
puts turin
puts venice
puts florence
puts bordeaux
puts nantes
puts rennes
puts strasbourg
puts schengen
puts dresden
puts hamburg
puts munich
puts frankfurt
puts copenhagen
puts oslo
puts stockholm
puts helsinki
puts riga
puts vilnius
puts tallinn
puts amsterdam
puts rotterdam
puts brussels
puts antwerp
puts ghent
puts bruges
puts zagreb
puts belgrade
puts sarajevo
puts sydney
puts melbourne
puts brisbane
puts perth
puts adelaide
puts canberra
puts auckland
puts wellington
puts christchurch
puts honolulu 

