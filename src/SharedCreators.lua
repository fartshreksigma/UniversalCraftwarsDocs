--[=[
@class SharedCreators
A storage for creators, also containing some important types
]=]

--[=[
@function CraftingFilterParams.new
@within SharedCreators

@return CraftingFilterParams

Creates a new CraftingFilterParams

```lua
local NewCraftingFilterParams = SharedCreators.CraftingFilterParams.new()
NewCraftingFilterParams.CraftingType = "Furniture"
print("Current search: " .. NewCraftingFilterParams.Search)
-- Creates a new CraftingFilterParams then sets the CraftingType to Furniture and prints the Search
```

]=]

--[=[
@function InventoryFilterParams.new
@within SharedCreators

@return InventoryFilterParams

Creates a new InventoryFilterparams
```lua
local NewInventoryFilterParams = SharedCreators.InventoryFilterParams.new()
NewInventoryFilterParams.PageNumber = 3
print("Current rarity: " .. NewInventoryFilterParams.Rarity)
-- Creates a new InventoryFilterParams then sets the PageNumber to 3 and prints the Rarity
```
]=]