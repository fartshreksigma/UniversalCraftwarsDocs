--[=[
@class DatastoreService

Custom functions for easy interaction with ProfileService
]=]

--[=[
@within DatastoreService
@method CalculateExpNeeded

Calculated the amount of EXP the player needs for another level

@param Rank number -- The rank used to calculate the amount of EXP needed
@return FilteredItemsList -- The amount of EXP needed for the next level+
]=]

--[=[
@within DatastoreService
@function FilterInventory

Filters through the players inventory based on parameters

@param Player Player -- The player to filter the inventory for
@param FilterParams InventoryFilterParams -- The parameters used to filter the inventory
@return FilteredItemsList -- A filtered list of the inventory
]=]

--[=[
@within DatastoreService
@function SetStats

Actions code to a player who has just joined, such as leaderstats

@param Player Player -- The player to set the stats for
@return nil
]=]

--[=[
@within DatastoreService
@method GetProfileData

Returns the data of a profile if that profile exists, or nil if it doesnt

@param Player Player -- The player to get the data of
@return DataTemplate -- The data of the player
]=]

--[=[
@within DatastoreService
@method ViewProfile

Allows viewing a profile, even when the player is offline / on another server

@param ProfileKey ProfileKey -- The username or userid of the player to view the profile of
@return DataTemplate -- The data of the profile being viewed
]=]

--[=[
@within DatastoreService
@method GlobalUpdateProfile

Globally updates the chosen profile to a new set of data

@param ProfileKey ProfileKey -- The profile key of the player being updated
@param NewData DataTemplate -- The new data of the profile to update, does not need to be complete
@return nil
]=]

--[=[
@within DatastoreService
@method GiveItem

Gives the chosen player an item

@param Player Player -- The player to give the item to
@param ItemId Item -- The chosen item to give to the player
@param ExtraData ExtraItemGiveData? -- Any extra data such as whether it was crafted or if it was from an admin
@return nil
]=]

--[=[
@within DatastoreService
@method TakeItem

Takes an item from the chosen player

@param Player Player -- The player to take the item from
@param ItemId Item -- The chosen item to take from the player
@param ExtraData ExtraItemGiveData? -- Any extra data such as whether it was crafted or if it was from an admin
@return nil
]=]

--[=[
@within DatastoreService
@method AddRank

Adds a set amount of ranks to the player

@param Player Player -- The player to give ranks to
@param Amount number -- The amount of ranks to give, negatives and 0 are supported
@return nil
]=]

--[=[
@within DatastoreService
@method CheckEXP

Checks the players EXP to see if a rank needs to be added

@param Player Player -- The player to check the EXP of
@return nil
]=]

--[=[
@within DatastoreService
@method AddEXP

Adds the amount of EXP to a player, then runs DatastoreService:CheckEXP on the player

@param Player Player -- The player to give EXP to
@return nil
]=]

--[=[
@within DatastoreService
@method AddCash

Gives a player an amount of cash

@param Player Player -- The player to give cash to
@param Amount number -- The amount of cash to give to the player
@return nil
]=]

--[=[
@within DatastoreService
@method EquipItem

Attemps to equip an item for the player

@param Player Player -- The player to try equip the item to
@param ItemId Item -- The Item to try equip
@return boolean -- Whether or not the item was equipped
@return string? -- If the item was not equipped, a message as to why is returned
]=]

--[=[
@within DatastoreService
@method UnequipItem

Attemps to unequip an item for the player

@param Player Player -- The player to try unequip the item for
@param ItemId Item -- The Item to try unequip
@return boolean -- Whether or not the item was unequipped
@return string? -- If the item was not unequipped, a message as to why is returned
]=]