--[=[
@class WindLines

A [library](https://devforum.roblox.com/t/wind-shake-high-performance-wind-effect-for-leaves-and-foliage/1039806) used to generate wind lines in the grassy biome, but slightly forked.
]=]

--[=[
@interface WindLinesSettings
@within WindLines
.Lifetime number -- The lifetime of the wind lines which are generated in seconds
.Direction Vector3 -- The direction which the lines travel
.Speed number -- The speed at which the lines move
.Position Vector3 -- The position to spawn the wind line, I forgot if this was custom added

The settings used to initialize the WindLines library
]=]

--[=[
@method Init
@within WindLines

@param Settings WindLinesSettings -- Settings used for the wind lines, containing information like Lifetime

@return nil

Initializes the WindLines module, and begins creating wind lines until [WindLines:Cleanup()](#Cleanup) is called
]=]

--[=[
@method Cleanup
@within WindLines

@return nil

Cleans up the WindLines module, causing it to stop producing lines
]=]

--[=[
@method Create
@within WindLines
@private

@param Settings WindLinesSettings

@return nil

Creates a wind line based on the provided [WindLinesSettings](#WindLinesSettings)
]=]