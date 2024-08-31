--[=[
@class DatastoreService

Custom functions for easy interaction with ProfileService
]=]

--[=[
@within DatastoreService
@method AddCash

Gives a player an amount of cash

```lua
for _, Player in game:GetService("Players"):GetChildren() do
    DatastoreService:AddCash(Player, 200)
end
-- Give every Player 200 cash
```

@param Player Player -- The player to give cash to
@param Amount number -- The amount of cash to give to the player
@return nil
]=]

--[=[
@within DatastoreService
@method AddEXP

Adds the amount of EXP to a player, then runs DatastoreService:CheckEXP on the player

```lua
for _, Player in game:GetService("Players"):GetChildren() do
    if Player.Name == "Shedletsky" then
        DatastoreService:AddEXP(Player, 2006)
    end
end
-- Give Shedletsky 2006 EXP if he's in the server
```

@param Player Player -- The player to give EXP to
@return nil
]=]

--[=[
@within DatastoreService
@method AddRank

Adds a set amount of ranks to the player

```lua
game.PlayerAdded:Connect(function(Player: Player)
    Player:AddRank(Player, Player.AccountAge)
end)
-- Give every player who joins the amount of ranks as their account age
```

@param Player Player -- The player to give ranks to
@param Amount number -- The amount of ranks to give, negatives and 0 are supported
@return nil
]=]

--[=[
@within DatastoreService
@method CalculateExpNeeded

Calculated the amount of EXP the player needs for another level

```lua
local RankToCalculate = 23
local EXPNeededToLevelUp = DatastoreService:CalculateExpNeeded(RankToCalculate)
print("You need " .. EXPNeededToLevelUp .. " EXP to level up from level " .. RankToCalculate)
-- Calculate how much EXP is needed to level up from rank 23
```

@param Rank number -- The rank used to calculate the amount of EXP needed
@return FilteredItemsList -- The amount of EXP needed for the next level+
]=]

--[=[
@within DatastoreService
@method CheckEXP

Checks the players EXP to see if a rank needs to be added

```lua
workspace.Part.Touched:Connect(function(Hit)
    local FoundPlayer = game:GetService("Players"):GetPlayerFromCharacter(Hit.Parent)
    if FoundPlayer then
        DatastoreService:CheckEXP(FoundPlayer)
    end
end)
-- Checks the EXP of anyone who touches a part
```

@param Player Player -- The player to check the EXP of
@return nil
]=]

--[=[
@within DatastoreService
@method EquipItem

Attemps to equip an item for the player

```lua
local ChosenPlayer = game:GetService("Players"):GetPlayers()[1]
if not ChosenPlayer then return end
DatastoreService:EquipItem(ChosenPlayer, 3)
-- Equip item with ID 3 to the first player
```

@param Player Player -- The player to try equip the item to
@param ItemId Item -- The Item to try equip
@return boolean -- Whether or not the item was equipped
@return string? -- If the item was not equipped, a message as to why is returned
]=]

--[=[
@within DatastoreService
@method GetProfileData

Returns the data of a profile if that profile exists, or nil if it doesnt

```lua
local Roblox = game:GetService("Players"):FindFirstChild("Roblox")
if Roblox and Roblox:IsA("Player") then
    local RobloxData = DatastoreService:GetProfileData(Roblox)
    if not RobloxData then
        print("Roblox has no data or it isn't loaded yet!")
        return
    end
    print("Roblox has: " .. RobloxData.Cash .. " cash!")
end
-- View Roblox's Cash value assuming he is in the server and has data loaded
```

@param Player Player -- The player to get the data of
@return DataTemplate -- The data of the player
]=]

--[=[
@within DatastoreService
@method GiveItem

Gives the chosen player an item

```lua
game:GetService("Players").PlayerAdded:Connect(function(Player)
    Player.Chatted:Connect(function(msg)
        local ChattedID = tonumber(msg)
        if ChattedID then
            DatastoreService:GiveItem(Player, ChattedID, {AdminSpawned = true})
        end
    end)
end)
-- Every time a player chats if the message is an ID, give them that item
```

@param Player Player -- The player to give the item to
@param ItemId Item -- The chosen item to give to the player
@param ExtraData ExtraItemGiveData? -- Any extra data such as whether it was crafted or if it was from an admin
@return nil
]=]

--[=[
@within DatastoreService
@method GlobalUpdateProfile
@yields

Globally updates the chosen profile to a new set of data

```lua
DatastoreService:GlobalUpdateProfile("builderman", {Cash = -131, Rank = 1000})
-- Attempt to globaly update buildermans Cash and Rank data
```

:::caution
Calling this function too much may cause issues with data!
Please read the [Profile Service Docs](https://madstudioroblox.github.io/ProfileService/api/#profilestoreglobalupdateprofileasync) for more info!
:::

@param ProfileKey ProfileKey -- The profile key of the player being updated
@param NewData DataTemplate -- The new data of the profile to update, does not need to be complete
@return nil
]=]

--[=[
@within DatastoreService
@method TakeItem

Takes an item from the chosen player

```lua
for _, Player in game:GetService("Players"):GetPlayers() do
    DatastoreService:TakeItem(Player, 1)
    print("Took Item of ID 1 from " .. Player.Name)
end
-- Takes an Item with ID 1 from every player, and prints a message for each player
```

@param Player Player -- The player to take the item from
@param ItemId Item -- The chosen item to take from the player
@param ExtraData ExtraItemGiveData? -- Any extra data such as whether it was crafted or if it was from an admin
@return nil
]=]

--[=[
@within DatastoreService
@method UnequipItem

Attemps to unequip an item for the player

```lua
local PlayersList = game:GetService("Players"):GetPlayers()
local ChosenNumber = math.random(1, #PlayersList)
local ChosenPlayer = PlayersList[ChosenNumber]
DatastoreService:UnequipItem(ChosenPlayer, 2)
-- Unequips Item of ID 2 from a random Player
```

@param Player Player -- The player to try unequip the item for
@param ItemId Item -- The Item to try unequip
@return boolean -- Whether or not the item was unequipped
@return string? -- If the item was not unequipped, a message as to why is returned
]=]

--[=[
@within DatastoreService
@method ViewProfile
@yields

Allows viewing a profile, even when the player is offline / on another server

```lua
local DataFor1x1x1x1 = DatastoreService:ViewProfile("1x1x1x1")

if not DataFor1x1x1x1 then
    print("1x1x1x1 has no data")
    return
end

print("1x1x1x1 is rank " .. DataFor1x1x1x1.Rank)
-- Checks the rank for user 1x1x1x1
```

:::info
While this function does check for players in the server, its recommended to use [DatastoreService:GetProfileData()](#GetProfileData) if their existance is guarenteed.
:::

@param ProfileKey ProfileKey -- The username or userid of the player to view the profile of
@return DataTemplate -- The data of the profile being viewed
]=]

--[=[
@within DatastoreService
@function FilterInventory

Filters through the players inventory based on parameters

```lua
local FoundPlayer = game:GetService("Players"):FindFirstChild("alexnewtron")

if not FoundPlayer then
    return
end

local InventoryFilterParams = SharedCreators.InventoryFilterParams.new()

local FilteredInventory = DatastoreService.FilterInventory(FoundPlayer, InventoryFilterParams)
print(FilteredInventory)
-- Filters alexnewtron's inventory
```

@param Player Player -- The player to filter the inventory for
@param FilterParams InventoryFilterParams -- The parameters used to filter the inventory
@return FilteredItemsList -- A filtered list of the inventory
]=]

--[=[
@within DatastoreService
@function SetStats

Actions code to a player who has just joined, such as leaderstats

```lua
game.Players.PlayerAdded:Connect(function(Player)
    if Player:FindFirstChild("leaderstats") then
        return
    end -- DatastoreService.SetStats will only work once, and if they have leaderstats it's already been set
    DatastoreService.SetStats(Player)
end)
-- Sets the stats of any new player who joins assuming it hasnt already been set
```

@param Player Player -- The player to set the stats for
@return nil
]=]