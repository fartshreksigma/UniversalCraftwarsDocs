--[=[
@class DatastoreTemplateService

A storage for the template in order for other scripts to access it
]=]

--[=[
@interface DataTemplate
@within DatastoreTemplateService
.Inventory {InventoryItem} -- The players inventory
.Rank number -- The players rank
.Cash number -- The amount of cash the player has
.EXP number -- The amount of EXP the player has
.EquippedItems {Item} -- The items the player has equipped
]=]