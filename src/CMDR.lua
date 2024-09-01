--[=[
@class Cmdr

The [Cmdr](https://eryn.io/Cmdr/) library, which is a powerful and easy to use command bar tool.
]=]

--[=[
@type bindableResource "Chat"
@within Cmdr

Frankly, I have no idea as to the purpose of this type, potentially for things like StarterGui:SetCore()?
]=]

--[=[
@type brickColor BrickColor
@within Cmdr

Represents a [BrickColor](https://create.roblox.com/docs/reference/engine/datatypes/BrickColor) DataType.
]=]

--[=[
@type brickColors {brickColor}
@within Cmdr

Represents a group of [BrickColors](https://create.roblox.com/docs/reference/engine/datatypes/BrickColor).
]=]

--[=[
@type color3 Color3
@within Cmdr

Represents a [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) value, made up of a sequence of [RGB](https://en.wikipedia.org/wiki/RGB_color_model#:~:text=The%20RGB%20color%20model%20is,red%2C%20green%2C%20and%20blue) values
]=]

--[=[
@type color3s {color3}
@within Cmdr

Represents a group of [Color3s](https://create.roblox.com/docs/reference/engine/datatypes/Color3), made up of sequences of [RGB](https://en.wikipedia.org/wiki/RGB_color_model#:~:text=The%20RGB%20color%20model%20is,red%2C%20green%2C%20and%20blue) values
]=]

--[=[
@type hexColor3 string
@within Cmdr

Represents a [Hexadecimal Color Code](https://en.wikipedia.org/wiki/Web_colors#Hex_triplet), being similiar to a color3 just differently formatted
]=]

--[=[
@type hexColor3s {hexColor3}
@within Cmdr

Represents a group of [Hexadecimal Color Codes](https://en.wikipedia.org/wiki/Web_colors#Hex_triplet), being similiar to color3s just differently formatted
]=]

--[=[
@type command CmdrCommand
@within Cmdr

Represents a command name that has been registered with the Cmdr registry
]=]

--[=[
@type commands {command}
@within Cmdr

Represents a group of command names that have been registered with the Cmdr registry
]=]

--[=[
@type conditionFunction string
@within Cmdr

A condition for a function, the only current option is startsWith, likely used to determine conditions for custom commands
]=]

--[=[
@type duration number
@within Cmdr

A duration inputted with a format such as 5d for 5 days, which is then converted to a number
]=]

--[=[
@type durations {duration}
@within Cmdr

A collection of durations inputted with formats such as 5d for 5 days, which are then converted to numbers
]=]

--[=[
@type json {[primative]: [primative]}
@within Cmdr

A JSON decoded table which was inputed into the command bar in an encoded format
]=]

--[=[
@type mathOperator Operator
@within Cmdr

Common math operators such as ```+```, ```-```, ```*```, ```/```, ```**```, and ```%```
]=]

--[=[
@type player Player
@within Cmdr

A player who is currently in the server, inputted by their name
:::tip
You can use ```.``` for it to use the executor, ```*``` for all players, ```**``` for others, and ```?``` for random
:::
]=]

--[=[
@type players {player}
@within Cmdr

A group of players who are in the server
:::info
Prefixing a player type with ```%``` will instead use the teamPlayers type
:::
]=]

--[=[
@type playerId number
@within Cmdr

Inputs a player by their full username, and returns their UserId
:::tip
You can use ```.``` for it to use the executor, ```*``` for all players, ```**``` for others, and ```?``` for random
:::
]=]

--[=[
@type playerIds {playerId}
@within Cmdr

A group of players UserIds
:::info
Prefixing with ```#``` will instead use a players UserId over name
:::
]=]

--[=[
@type stringType string
@within Cmdr

A string primative, due to conflicting with unrelated mentions of the string datatype this has been renamed from string to stringType
:::tip
You can surround a string which contains spaces with ```"``` in order for it to take the whole string instead of just the first word
:::
]=]

--[=[
@type numberType number
@within Cmdr

A number primative, due to conflicting names with a primative type, it has been renamed from number to numberType
]=]

--[=[
@type integer number
@within Cmdr

An integer, meaning a number which has no decimal portion
]=]

--[=[
@type positiveInteger number
@within Cmdr

An integer which is greater than 0
]=]

--[=[
@type nonNegativeInteger number
@within Cmdr

An integer which is greater than or equal to 0
]=]

--[=[
@type byte number
@within Cmdr

A 16 bit number, being between 0 and 255
]=]

--[=[
@type digit number
@within Cmdr

A single digit number, being between 0 and 9
]=]

--[=[
@type booleanType boolean
@within Cmdr

A boolean value, containing either true or false, due to conflicting names with a commonly used primative, this has been renamed from boolean to booleanType
:::info
Other options than ```true``` and ```false``` can be inputed, being ```t```, ```yes```, ```y```, ```on```, ```enable```, ```enabled```,
 ```1```, and ```+```, for true, and ```f```, ```no```, ```n```, ```off```, ```disable```, ```disabled```, ```0```, and ```-``` for false
:::
]=]

--[=[
@type stringTypes {stringType}
@within Cmdr

A group of string primatives, due to conflicting with unrelated mentions of the string datatype this has been renamed from strings to stringTypes
]=]

--[=[
@type numberTypes {numberType}
@within Cmdr

A group of number primatives, due to conflicting names with a primative type, it has been renamed from numbers to numberTypes
]=]

--[=[
@type integers {integer}
@within Cmdr

A group of integers, meaning numbers with no decimal portion
]=]

--[=[
@type positiveIntegers {positiveInteger}
@within Cmdr

A group of integers which are greater than 0
]=]

--[=[
@type nonNegativeIntegers {nonNegativeInteger}
@within Cmdr

A group of integers which are greater than or equal to 0
]=]

--[=[
@type bytes {byte}
@within Cmdr

A group of 16 bit numbers, being between 0 and 255
]=]

--[=[
@type digits {digit}
@within Cmdr

A group of single digit numbers, being between 0 and 9
]=]

--[=[
@type booleanTypes {booleanType}
@within Cmdr

A group of boolean values, containing either true or false, due to conflicting names with a commonly used primative, this has been renamed from booleans to booleanTypes
]=]

--[=[
@type storedKey string
@within Cmdr

A stored value within Cmdr
:::info
The string used to query for storedKey types must begin with either ```.``` ```$``` or ```$.```
:::
]=]

--[=[
@type storedKeys {storedKey}
@within Cmdr

A group of stored keys
]=]

--[=[
@type team Team
@within Cmdr

A team, identified by it's name
]=]

--[=[
@type teams {team}
@within Cmdr

A group of teams, identified by names
]=]

--[=[
@type teamPlayers {Player}
@within Cmdr

An array of the players within a team
]=]

--[=[
@type teamColor BrickColor
@within Cmdr

The BrickColor used in it's TeamColor property
]=]

--[=[
@type teamColors {teamColor}
@within Cmdr

A group of BrickColors, used in the corresponding teams TeamColor
]=]

--[=[
@type typeType CmdrType
@within Cmdr

A type used within Cmdr, the representing string is type, however to avoid conflicts typeType is used to define it
]=]

--[=[
@type typeTypes {typeType}
@within Cmdr

A group of types used within Cmdr, typeTypes is used to represent the type as types may conflict
]=]

--[=[
@type url string
@within Cmdr

A [URL](https://en.wikipedia.org/wiki/URL) used to identify a website
:::info
The URL must begin with either ```https://``` or ```http://```
:::
]=]

--[=[
@type urls {url}
@within Cmdr

A group of URLs used to identify websites
]=]

--[=[
@type userInput UserInputType
@within Cmdr

An Enum.UserInputType representing a button press such as mouse click
]=]

--[=[
@type userInputs {userInput}
@within Cmdr

A group of Enum.UserInputType representing button presses, such as mouse clicks
]=]

--[=[
@type vector3 Vector3
@within Cmdr

A 3-Dimensional Vector with an X, Y, and Z axis
]=]

--[=[
@type vector3s {vector3}
@within Cmdr

A group of 3-Dimensional Vectors with X, Y, and Z axes
]=]

--[=[
@type vector2 Vector2
@within Cmdr

A 2-Dimensional Vector with an X and Y axis
]=]

--[=[
@type vector2s {vector2}
@within Cmdr

A group of 2-Dimensional Vectors with X and Y axes
]=]

--[=[
@type unixtimestamp DateTime
@within Cmdr
@tag Custom

A unix timestamp, which is converted into a [DateTime](https://create.roblox.com/docs/reference/engine/datatypes/DateTime)
]=]

--[=[
@type unixtimestampmillis DateTime
@within Cmdr
@tag Custom

A unix timestamp in milliseconds, converted into a [DateTime](https://create.roblox.com/docs/reference/engine/datatypes/DateTime) object
]=]

--[=[
@type universaltime DateTime
@within Cmdr
@tag Custom

A time provided in format ```(year)-(month)-(day)-(hour)-(minute)-(second)-(millisecond)``` and formatted as a Universal Time
]=]

--[=[
@type localtime DateTime
@within Cmdr
@tag Custom

A time provided in ```(year)-(month)-(day)-(hour)-(minute)-(second)-(millisecond)``` format as a Local Time
]=]

--[=[
@type isodate DateTime
@within Cmdr
@tag Custom

A time provided as an ISODate, ```(year)-(month)-(day)T(hour):(minute):(second)Z```
]=]

--[=[
@type itemid Item
@within Cmdr
@tag Custom

An itemid, despite the name a name is provided within the command bar which is then converted to an ID
]=]

--[=[
@type itemids {itemid}
@within Cmdr
@tag Custom

A group of itemids, which are provided as names and coverted to IDs
]=]

--[=[
@type service Service
@within Cmdr
@tag Custom

A Roblox service, such as ReplicatedStorage, ServerScriptService, etc.
]=]

--[=[
@type services {service}
@within Cmdr
@tag Custom

A group of Roblox services such as ReplicatedStorage, ServerScriptService, etc.
]=]