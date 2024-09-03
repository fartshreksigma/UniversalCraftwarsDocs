--[=[
@class CustomTypes
A class container for custom types that are for general use
]=]

--[=[
@type Class "Melee" | "Mage" | "Ranged" | "Summoner"
@within CustomTypes
A class used to denote typically damage type

```lua
local MeleeClass: Class = "Melee"
```

]=]

--[=[
@type CraftingType "Default" | "Furniture" | "Shop"
@within CustomTypes
A type of crafting

```lua
local CraftingTypes: {CraftingType} = {
    "Default",
    "Furniture",
    "Shop",
}
```

]=]

--[=[
@interface ExtraItemGiveData
@within CustomTypes
.Crafted boolean? -- Whether or not the item was crafted
.AdminSpawned boolean? -- Whether or not this item was from an admin
.ChatNotify boolean?
Extra data about why or how an item was given / taken

```lua
local ExtraGiveData: ExtraItemGiveData = {
    Crafted = true,
    AdminSpawned = false,
    ChatNotify = true,
}
```

]=]

--[=[
@type FilteredItemsList {InventoryItem}
@within CustomTypes
A filtered list of items, containing items based on the filter params used to generate it

```lua
local FilteredInventory: FilteredItemsList = {
    {Id = 1, Count = 15},
    {Id = 5, Count = 29},
    {Id = 3, Count = 7},
}
```

]=]

--[=[
@interface InventoryItem
@within CustomTypes
.Id Item -- The ID of the item this inventory slot refers to
.Count number -- The amount of an item is in this slot
An item found within an inventory, containing an ID and amount

```lua
local InventorySlotOne: InventoryItem = {Id = 10, Count = 24}
```

]=]

--[=[
@type Item number
@within CustomTypes
An item by its ID

```lua
local FirstItemID: Item = 1
```

]=]

--[=[
@type ProfileKey string | number
@within CustomTypes
A ProfileKey for use in datastores, being either a players name or userid

```lua
local ProfileKey: ProfileKey = "builderman"
```

]=]

--[=[
@type Rarity "Rare" | "None"
@within CustomTypes
A rarity used to denote how rare an item is to aquire

```lua
local RareRarity: Rarity = "None"
```

]=]

--[=[
@interface ChatGradientData
@within CustomTypes
.Transparency number? -- The transparency of the gradient
.GradientColor ColorSequence? -- The color of the gradient
.Rotation number? -- The rotation of the gradient
.Offset Vector2? -- The offset of the gradient

A gradient applied to a chat message
]=]

--[=[
@interface ChatObjectPool
@within CustomTypes
.InstancePoolsByClass {[string]: {Instance}} -- The object pool of each class within in
.Name string -- The name of the ObjectPool
.PoolSizePerType number -- The size of the pool per type

An object pool for a chat object
]=]

--[=[
@interface ChatMessageData
@within CustomTypes
.Channel string -- The channel the message is in
.ExtraData {} -- Data about things such as tags
.ID number | string -- The messages Id, number if Roblox made, else a string
.IsFiltered boolean -- If the message was filtered
.Message string -- The message text
.MessageLength number -- The message length through string.len
.MessageLengthUtf8 number -- The message length through utf8.len
.MessageType string -- The type of message
.OriginalChannel string -- The channel this message originally was sent in
.Time number -- The time the message was sent at

The data of a message used when creating it
]=]