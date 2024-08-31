--[=[
@class BiomeHandler
The handler for biomes within UniversalCraftwars
]=]

--[=[
@type Biome "Overworld" | "Snow" | "Flame" | "Nature" | "Starry"
@within BiomeHandler
A biome, typically used in the biome handler
]=]

--[=[
@interface ExtraBiomeData
@within BiomeHandler
.Chance number -- The chance of the biome occuring, in %
.Duration number -- The duration of the biome, in seconds
]=]

--[=[
@prop BiomeChanged RBXScriptSignal
@within BiomeHandler
@readonly
An RBXScriptSignal which fires when the biome is changed
]=]

--[=[
@prop BiomeStartTick number
@within BiomeHandler
@readonly
The time the biome started according to ticK()
]=]

--[=[
@prop CurrentBiome Biome
@within BiomeHandler
@readonly
The current biome
]=]

--[=[
@prop CurrentBiomeData ExtraBiomeData
@within BiomeHandler
@readonly
The extra data about the current biome
]=]

--[=[
@prop EnableBiomeTick boolean
@within BiomeHandler
@readonly
Whether or not the game with attempt to change the biome
]=]

--[=[
@within BiomeHandler
@function AdjustBiome

@param BiomeName Biome -- The biome to set to

@return nil

Sets the current biome to the specified one
]=]

--[=[
@within BiomeHandler
@function TickBiome
@private

@return boolean -- Whether or not the biome was set from Overworld

Ticks the biome, only works when the current biome is Overworld
]=]