# Grocery List

Description: A simple list CLI app. For the sake of our project, our minimum viable product is just CRUD (create, read, update, delete). We are creating this with the explicit possibility of expanding it in the future to have more detailed information, like price, category, location in store, brand, etc.

## Object Relations

Shopper > List > ListItem < Item

Our single source of truth is the ListItem joiner class/table.
* Each ListItem belongs to 1 Item, 1 List, and 1 Shopper through List.
* Each List belongs to 1 Shopper and can have many ListItems.
* Each Shopper can have many Lists, and many ListItems through List.
* Each Item can have many ListItems.

The columns in ListItem are id, list_id, item_id, and still_needed. Two shoppers who have the same 2 items on their Lists would be 4 ListItems in the database, but just 2 Shoppers and 2 Items. The still_needed column allows Shoppers to "check off" items on their list without deleting them so they can

## Functions

Inside their classes in lib.

---
### Common Questions:
- How do I turn off my SQL logger?
```ruby
# in config/environment.rb add this line:
ActiveRecord::Base.logger = nil
```
