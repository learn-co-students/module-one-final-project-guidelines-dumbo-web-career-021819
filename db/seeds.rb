Customer.destroy_all
Restaurant.destroy_all
Order.destroy_all
Food.destroy_all

jep = Customer.create(name: "Jep")
matthew = Customer.create(name: "Matthew")
ayana = Customer.create(name: "Ayana")
graham = Customer.create(name: "Graham")
matt = Customer.create(name: "Matt")
antoinette = Customer.create(name: "Antoinette")
alessandro = Customer.create(name: "Alessandro")

panda_express = Restaurant.create(name: "Panda Express", category:"Chinese", location:"43435 Whatever St, Brooklyn, NY 11201")
mcdonalds = Restaurant.create(name: "McDonalds", catergory: "Fast Food", location: "81 Prospect St, Brooklyn, NY 11201")
andiamo = Restaurant.create(name: "Andiamo", category: "Italian", location: "150 Hardenbaurgh Ave, Closter, NJ 07624")
gran_electra = Restaurant.create(name: "Gran Electra", category: "Mexican", location: "5 French St, Brooklyn, NY 11201")
cecconi_dumbo = Restaurant.create(name: "Cecconi's Dumbo", category: "Italian", location: "55 Water St, Brooklyn, NY 11201")
celestine = Restaurant.create(name: "Celestine", category: "Mediterranean", location: "1 John St, Brooklyn, NY 11201")

spring_roll = Food.create(name: "Spring Roll", price: 4.00, restaurant_id: panda_express.id, description: "Cabbage, celery, carrots, green onions and Chinese noodles in a crispy wonton wrapper")
chow_mein = Food.create(name: "Chow Mein", price: 7.00, restaurant_id: panda_express.id, description: "Stir-fried wheat noodles with onions, celery and cabbage")
fried_rice = Food.create(name: "Fried Rice", price: 4.00, restaurant_id: panda_express.id, description: "Prepared steamed white rice with soy sauce, eggs, peas, carrots and green onions")
orange_chicken = Food.create(name: "Ornage Chicken", price: 10.75, restaurant_id: panda_express.id, description: "Our signature dish. Crispy chicken wok-tossed in a sweet and spicy orange sauce")
kung_pao_chicken = Food.create(name: "Kung Pao Chicken", price: 12.50, restaurant_id: panda_express.id, description: "A Szechwan-inspired dish with chicken, peanuts and vegetables, finished with chili peppers.")
eggplant_tofu = Food.create(name: "Eggplant Tofu", price: 11.75, restaurant_id: panda_express.id, description: "A Szechwan-inspired dish with chicken, peanuts and vegetables, finished with chili peppers")
potsticker = Food.create(name: "Chicken Potsticker", price: 6.50, restaurant_id: panda_express.id, description: "Pan-seared dumplings filled with chicken, cabbage and onion")
white_rice = Food.create(name: "White Steamed Rice", price: 3.50, restaurant_id: panda_express.id, description: "White steamed rice")
wok_fired_shrimp = Food.create(name: "Wok-Fired Shrimp", price: 12.75, restaurant_id: panda_express.id, description: "Seared premium shrimp with fresh veggies tossed in a sweet and spicy sauce and wok'd to perfection")

ceviche_de_atun = Food.create(name: "Ceviche De Atun", price: 17.00, restaurant_id: gran_electra.id, description "Market Tuna, avocado, grapefruit, cilantro, leche de tigre, chayote, poblano, serrgano, shallots")
ensalada_de_cesar = Food.create(name: "Ensalada de Cesar", price: 14.00, restaurant_id: gran_electra.id, description: "Market greens, housemade cesar dressing, cotija, anchiovies, guajillo, oregano, spiced croutons")
chips_salsa = Food.create(name: "Chips and Salsa", price: 7.00, restaurant_id: gran_electra.id, description: "Charred tomatoes, tomatillo, garlic, serrgano, onion, morita, costeno, cilantro, cumin")

hummus = Food.create(name: "Hummus", price: 9.00, restaurant_id: celestine.id, description: "Urfa biber, crispy artichokes")
pennsylvania_chicken = Food.create(name: "Pennsylvania Chicken", price: 29.00, restaurant_id: celestine.id, description: "Grapes, almonds, cuccumbers, freekeh")
grilled_striploin = Food.create(name: "Grilled Striploin", price: 42.00, restaurant_id: celestine.id, description: "Turnip sarladaise, tanzeya, natural jus")

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

#-------------------------------------------------------------------------------

# When we '> rake console' the console doesn't contain the information that
# we declared inside of db/seeds.rb.

# Possibly what's happening? : Maybe the '> rake console' task isn't connecting
# with our db/seeds.rb file..

# How do we fix this??? (Googled the problem couldn't find a good answer)

# THE FIX !!!!!
#--------------
# when you use rake db:seed, the local variables will not be available to you
# within the console. BUT the information will exist within your databases.
