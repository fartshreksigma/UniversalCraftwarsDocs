--[=[
@class InventoryFilterParams

The parameters used to filter the inventory
]=]

--[=[
@prop Search string
@within InventoryFilterParams

The string used to filter by item name
]=]

--[=[
@prop ClassFilters {Class?}
@within InventoryFilterParams

The classes used to filter items by
]=]

--[=[
@prop RarityFilter Rarity
@within InventoryFilterParams

The rarity used to filter items
]=]

--[=[
@prop PageNumber number
@within InventoryFilterParams

The page used to decide where to return once results are filtered
]=]

--[=[
@prop SlotsPerPage number
@within InventoryFilterParams

The amount of slots that are registered on the page, should always be 10
]=]