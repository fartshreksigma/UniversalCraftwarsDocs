--[=[
@class BiomeHandler
The handler for biomes within Universal Craftwars
]=]

--[=[
@type Biome "Overworld" | "Snow" | "Flame" | "Nature" | "Starry"
@within BiomeHandler
A biome, typically used in the biome handler

```lua
local BiomeToUse: Biome = "Flame"
BiomeHandler:AdjustBiome(BiomeToUse)
```

]=]

--[=[
@interface ExtraBiomeData
@within BiomeHandler
.Chance number -- The chance of the biome occuring, in %
.Duration number -- The duration of the biome, in seconds
The extra data for a Biome, including Chance and Duration

```lua
local CurrentBiomeData: ExtraBiomeData = BiomeHandler.CurrentBiomeData
print("The current biome has a duration of " .. CurrentBiomeData.Duration .. " seconds")
```

]=]

--[=[
@prop BiomeChanged RBXScriptSignal
@within BiomeHandler
@readonly
An RBXScriptSignal which fires when the biome is changed, passing the new [Biome](#Biome) as an argument

```lua
BiomeHandler.BiomeChanged:Connect(function(NewBiome: Biome)
    print(NewBiome)
end)
```

]=]

--[=[
@prop BiomeStartTick number
@within BiomeHandler
@readonly
The time the biome started according to [tick()](https://create.roblox.com/docs/reference/engine/globals/RobloxGlobals#tick)

```lua
task.wait(5)
print("The biome started at " .. BiomeHandler.BiomeStartTick)
```

]=]

--[=[
@prop CurrentBiome Biome
@within BiomeHandler
@readonly
The current [Biome](#Biome)

```lua
if BiomeHandler.CurrentBiome == "Starry" then
    print("It's starry tonight!")
end
```

]=]

--[=[
@prop CurrentBiomeData ExtraBiomeData
@within BiomeHandler
@readonly
The [extra data](#ExtraBiomeData) about the current biome

```lua
local CurrentBiomeData: ExtraBiomeData = BiomeHandler.CurrentBiomeData
print("The current biome has a " .. CurrentBiomeData.Chance .. "% chance of occuring")
```

]=]

--[=[
@prop EnableBiomeTick boolean
@within BiomeHandler
@readonly
Whether or not the game with attempt to change the biome

```lua
while true do
    if not BiomeHandler.EnableBiomeTick then
        print("Biome tick is disabled!")
    else
      print("Biome tick is enabled!")
    end
    task.wait()
end
```

]=]

--[=[
@within BiomeHandler
@function AdjustBiome

@param BiomeName Biome -- The biome to set to

@return nil

Sets the current biome to the specified one

```lua
task.wait(5)
BiomeHandler.AdjustBiome("Snow")
-- Changes the biome to snow 5 seconds after the game is run
```
]=]

--[=[
@within BiomeHandler
@function TickBiome
@private

@return boolean -- Whether or not the biome was set from Overworld

Ticks the biome, only works when the current biome is Overworld

```lua
while true do
    if BiomeHandler.CurrentBiome ~= "Overworld" then
        task.wait(0.1)
        return
    end
    BiomeHandler.TickBiome()
    task.wait(0.1)
end
-- Ticks the biomoe every 0.1 seconds it is overworld
```

:::warning
Attempting to tick the biome when it is not Overworld will cause it to not work. Manual checks must be implemented in the script calling BiomeHandler.TickBiome.
:::

]=]