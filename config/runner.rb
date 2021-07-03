require_relative '../config/environment.rb'



carla = Shopper.create(name: "Carla")
# party_list = List.create(name: "party")
party_list = carla.create_list("party")
# grocery_list = List.create(name: "grocery")
# carla.create_list(grocery_list)

# freak_list = List.create(name: "FrEaK")














binding.pry

puts "hey"
