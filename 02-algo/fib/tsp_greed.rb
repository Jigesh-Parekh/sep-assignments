require_relative 'city'

def nearestNeighbor(graph_cities, current_city) 
	track = [current_city.name]
	while graph_cities[0] != nil 
		#set next city position
		next_city = graph_cities[0]
		graph_cities.each do |alternate| 
			if distanceCalculator(current_city, next_city) > distanceCalculator(current_city, alternate)
				next_city = alternate
			end
		end
		current_city = next_city
		graph_cities.delete(next_city)
		track.push(current_city.name)
	end
	#return the tracked path
	track
end

def distanceCalculator(point1, point2)
	#determine hypotneuse given the point on a grid (mirroring a lat long) 
	#and determine the distance of the hypotenuse angle between the points
	Math.hypot(point2.x - point1.x, point2.y - point1.y)
end

home = City.new("seattle", 0, 0)
city2 = City.new("boise", 1, 9)
city3 = City.new("new jersey", 21, 9)
city4 = City.new("london", 22, 10)
city5 = City.new("new york", 19, 10)
city6 = City.new("texas", 15, 4)
city7 = City.new("japan", 45, 1)

city_graph = [city2, city4, city3, city7, city6, city5]

trip = nearestNeighbor(city_graph, home)
puts trip
