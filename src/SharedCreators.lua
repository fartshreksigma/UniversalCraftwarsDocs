--[=[
@class SharedCreators
A storage for creators, also containing some important types
]=]

--[=[
@interface CraftingFilterParams
@within SharedCreators
.Search string -- The string used to filter by item name
.PageNumber number -- The page used to decide where to return once results are filtered
.SlotsPerPage number -- The amount of slots that are registered by page, should always be 10
.CraftingType CraftingType -- The type of crafting recipe to filter by
The parameters used to filter crafting
]=]

--[=[
@interface InventoryFilterParams
@within SharedCreators
.Search string -- The string used to filter by item name
.ClassFilters {Class?} -- The classes used to filter items by
.RarityFilter Rarity -- The rarity used to filter items
.PageNumber number -- The page used to decide where to return once results are filtered
.SlotsPerPage number -- The amount of slots that are registered by page, should always be 10
The parameters used to filter the inventory
]=]

--[=[
@function CraftingFilterParams.new
@within SharedCreators

@return CraftingFilterParams
]=]

--[=[
@function InventoryFilterParams.new
@within SharedCreators

@return InventoryFilterParams
]=]