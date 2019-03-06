require_relative '../config/environment.rb'

carla = Shopper.create(name: "Carla")
partylist = carla.create_list("party")

partylist.add_item('beer')
partylist.add_item('potatoes')
partylist.add_item('butter')
partylist.delete_item('butter')
partylist.add_item('streamers')
partylist.check_item('streamers')







binding.pry

puts "hey"
