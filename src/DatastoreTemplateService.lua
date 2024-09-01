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

The template which is used for profilestore generation and as a placeholder type for profile data
]=]

--[=[
@within DatastoreTemplateService
@method GetTemplate

@return DataTemplate -- The template for data

Returns the template for data

```lua
local DataTemplate = DatastoreTemplateService:GetTemplate()

for Key, Value in pairs(DataTemplate) do
    print(Key, Value)
end
-- Prints every Key and Value pair in the Data Template
```

]=]