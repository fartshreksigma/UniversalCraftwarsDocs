--[=[
@class CustomTypes
A class container for custom types that are for general use
]=]

--[=[
@type Class "Melee" | "Mage" | "Ranged" | "Summoner"
@within CustomTypes
A class used to denote typically damage type
]=]

--[=[
@type Rarity "Rare" | "None"
@within CustomTypes
A rarity used to denote how rare an item is to aquire
]=]

--[=[
@type CraftingType "Default" | "Furniture" | "Shop"
@within CustomTypes
A type of crafting
]=]

--[=[
@type Item number
@within CustomTypes
An item by its ID
]=]

--[=[
@type FilteredItemsList {Item}
@within CustomTypes
A filtered list of items, containing items based on the filter params used to generate it
]=]

--[=[
@interface InventoryItem
@within CustomTypes
.Id Item -- The ID of the item this inventory slot refers to
.Count number -- The amount of an item is in this slot
An item found within an inventory, containing an ID and amount
]=]

--[=[
@type ProfileKey string | number
@within CustomTypes
A ProfileKey for use in datastores, being either a players name or userid
]=]

--[=[
@interface ExtraItemGiveData
@within CustomTypes
.Crafted boolean? -- Whether or not the item was crafted
.AdminSpawned boolean? -- Whether or not this item was from an admin
.ChatNotify boolean?
Extra data about why or how an item was given / taken
]=]