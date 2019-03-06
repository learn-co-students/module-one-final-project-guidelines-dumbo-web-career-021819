Customer.destroy_all
Restaurant.destroy_all
Order.destroy_all
Food.destroy_all

jep = Customer.create(name: "Jep")
matt = Customer.create(name: "Matthew")

panda_express = Restaurant.create(name: "Panda Express", category:"Chinese", location:"43435 Whatever St, Brooklyn, NY")
chipotle = Restaurant.create(name: "Chipotle", category:"Mexican", location: "47 East 4th St, New York, NY")

spring_roll = Food.create(name: "Spring Roll", price: 4.00, restaurant_id: panda_express.id, description: "Cabbage, celery, carrots, green onions and Chinese noodles in a crispy wonton wrapper")
chow_mein = Food.create(name: "Chow Mein", price: 7.00, restaurant_id: panda_express.id, description: "Stir-fried wheat noodles with onions, celery and cabbage")
fried_rice = Food.create(name: "Fried Rice", price: 4.00, restaurant_id: panda_express.id, description: "Prepared steamed white rice with soy sauce, eggs, peas, carrots and green onions")

jep_order_1 = Order.create(restaurant_id: panda_express.id, customer_id: jep.id, location: "175 Jefferson Ave, Queens, NY", cash_or_card: "card")
matt_order = Order.create(restaurant_id: panda_express.id, customer_id: matt.id, location: "123 ABC Rd, Queens, NY", cash_or_card: "cash")
matt_order_2 = Order.create(restaurant_id: panda_express.id, customer_id: matt.id, location: "1500 Other St, Staten Island, NY", cash_or_card: "card")

# ------------------------------------------------------------------------------
# Adding food items to the order

jep_order_1.add_to_order(spring_roll)

matt_order.add_to_order(chow_mein)
matt_order.add_to_order(fried_rice)

matt_order_2.add_to_order(spring_roll)
matt_order_2.add_to_order(chow_mein)

# ------------------------------------------------------------------------------
# Completing an order (tallies up the total and returns the Order object)

matt_order.complete_order

# ------------------------------------------------------------------------------
# Changes the status of :received? when the order is received by the customer

matt_order.receive_order
# ------------------------------------------------------------------------------


# Make more instances to test the project tomorrow to see where
# we are at, in terms of the table relationship.
