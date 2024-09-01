--[=[
@class CraftingFilterParams

The parameters used to filter the crafting menu
]=]

--[=[
@prop Search string
@within CraftingFilterParams

The string used to filter by item name
]=]

--[=[
@prop PageNumber number
@within CraftingFilterParams

The page used to decide where to return once results are filtered
]=]

--[=[
@prop SlotsPerPage number
@within CraftingFilterParams

The amount of slots that are registered on the page, should always be 10
]=]

--[=[
@prop CraftingType CraftingType
@within CraftingFilterParams

The type of crafting recipe to filter by
]=]