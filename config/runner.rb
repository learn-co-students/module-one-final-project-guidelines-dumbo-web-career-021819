require_relative '../config/environment.rb'


# Shopper.destroy_all
# ListItem.destroy_all
# List.destroy_all



carla = Shopper.create(name: "Carla")
partylist = carla.create_list("party")
supperlist = carla.create_list("supper")




partylist.add_item('beer')
partylist.add_item('potatoes')
partylist.add_item('butter')
# partylist.delete_item('butter')
partylist.add_item('streamers')
partylist.check_item('streamers')
partylist.check_item('butter')
# carla.delete_list("supper")
carla.delete_shopper










binding.pry

puts "hey"
