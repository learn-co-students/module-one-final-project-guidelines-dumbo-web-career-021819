# mcdonalds_menu = Menu.create(restaurant_id: mcdonalds.id)
# panda_express_menu = Menu.create(restaurant_id: panda_express.id)
Customer.destroy_all
Restaurant.destroy_all
Order.destroy_all
Food.destroy_all

jep = Customer.create(name: "Jep")
matt = Customer.create(name: "Matthew")

panda_express = Restaurant.create(name: "Panda Express", category:"Chinese", location:"43435 Whatever St, Brooklyn, NY")
chipotle = Restaurant.create(name: "Chipotle", category:"Mexican", location: "47 East 4th St, New York, NY")

spring_roll = Food.create(name: "Spring Roll", price: 4.00, restaurant_id: panda_express.id)
lo_mein = Food.create(name: "Lo Mein", price: 7.00, restaurant_id: panda_express.id)
fried_rice = Food.create(name: "Fried Rice", price: 4.00, restaurant_id: panda_express.id)

jep_order_1 = Order.create(restaurant_id: panda_express.id, customer_id: jep.id, location: "175 Jefferson Ave, Queens, NY", received?: false)

matt_order = Order.create(restaurant_id: panda_express.id, customer_id: matt.id, location: "123 ABC rd Queens,NY", received?: false)



jep_order_1.add_to_order(spring_roll)

matt_order.add_to_order(lo_mein)
matt_order.add_to_order(fried_rice)








# THE ISSUE HERE IS THAT chipotle local variable (@menu) KEEPS RETURNINNG A NIL VALUE

# the below solution would add food to an item variable BUT this requires a lot of coding

# chipotle.menu = [ burrito ]
# chipotle.menu << taco
# chipotle.menu << bowl
      #   DOES NOT WORK

# Restaurant menu get and set is a method, but returns nil - we want it to return an empty array instead
# chipolte.menu is nil

# THE ISSUE HERE IS THAT chipotle local variable (@menu) KEEPS RETURNINNG A NIL VALUE



# Make more instances to test the project tomorrow to see where
# we are at, in terms of the table relationship.
