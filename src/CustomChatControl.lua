--[=[
@class ServerChatHandler

The server handler for custom chat functions
]=]

--[=[
@type LoggedChatMessagesServer {[Player]: {[string]: string}}
@within ServerChatHandler

All the logged chat messages on the server
]=]

--[=[
@method CreateChatOnClient
@within ServerChatHandler

@param Player Player -- The Player to create a chat for
@param Text string -- The text to display in chat
@param TextColor Color3? -- The color for the text to be
@param ShouldSanitizeMessage boolean? -- Whether the message should be sanitized for rich text before displayed
@param ShouldFilterMessage boolean? -- Whether the message should be filtered
@param GradientData ChatGradientData? -- Any gradient data for the message

@return string -- The new message Id

Creates a chat message on the specified client
]=]

--[=[
@method EditChatMessage
@within ServerChatHandler

@param Player Player -- The Player to edit the chat message for
@param MessageID string -- The Id of the message to edit
@param NewText string -- The new text to be displayed in the message
@param ShouldSanitizeMessage boolean? -- Whether the new message should be sanitized for rich text before displayed
@param ShouldFilterMessage boolean? -- Whether the new message should be filtered

@return boolean -- If the edit was successful or not

Attempts to edit a chat message for a player, returning whether it was successful.
]=]

--[=[
@method ApplyChatMessageGradientToPlayer
@within ServerChatHandler

@param Player Player -- The player to apply the gradient for
@param MessageID string -- The Id of the message to apply a gradient to
@param GradientColor ColorSequence? -- The color for the gradient to be
@param Transparency number? -- The transparency of the gradient
@param Rotation number? -- The rotation of the gradient
@param Offset Vector2? -- The offset of the gradient

@return boolean -- If the gradient was applied or not

Attempts to apply a gradient to a chat message, returning if it was successful or not.
]=]

--[=[
@method GetLoggedMessages
@within ServerChatHandler

@return LoggedChatMessagesServer -- The chat messages which are logged

Returns the logged chat messages which are on the server
]=]

--[=[
@method CreateChatMessageOnAllClients
@within ServerChatHandler

@param Text string -- The text to display in chat
@param TextColor Color3? -- The color for the text to be
@param ShouldSanitizeMessage boolean? -- Whether the message should be sanitized for rich text before displayed
@param ShouldFilterMessage boolean? -- Whether the message should be filtered
@param GradientData ChatGradientData? -- Any gradient data for the message

@return {[Player]: string} -- A dictionary of each player the message was sent to, and it's ID

Sends a chat message to all players in the server
]=]

--[=[
@method GetLatestMessageID
@within ServerChatHandler

@param Player Player -- The player to get the latest message Id for

@return string? -- The gotten message Id if it exists

Returns the latest chat message Id for a set player if it exists
]=]

--[=[
@class ChatMessageLogDisplay

The creator for message labels, a Roblox LegacyChat instance.
]=]

--[=[
@interface MadeMessageChat
@within ChatMessageLogDisplay
.BaseFrame Frame -- The frame of the message
.BaseMessage TextLabel -- The storage for the text
.Destroy () -> () -- A function to destroy the made message
.Destroyed boolean -- Whether the message is destroyed
.FadeInFunction (duration: number, CurveUtils) -> () -- The function to fade in a message
.FadeOutFunction (duration: number, CurveUtils) -> () -- The function to fade out a message
.GetHeightFunction (xSize: number) -> (number) -- The function to get the message height
.ID number | string -- The message Id, a string for custom messages, and a number for Roblox messages
.ObjectPool ChatObjectPool -- The object pool of the message
.UpdateAnimFunction (dtScale: number, CurveUtils) -> () -- A function to update the text animation
.UpdateTextFunction nil -- A functionto update the text, non-existant in SetCore messages for some reason

A dictionary containing info and functions to do with a message
]=]

--[=[
@method WaitUntilParentedCorrectly
@within ChatMessageLogDisplay
@yields

Yields the thread until it is parented correctly
]=]

--[=[
@method Update
@within ChatMessageLogDisplay

@param dtScale number -- The DeltaTime scale? Unsure.

Calls every UpdateAnimFunction of the made messages
]=]

--[=[
@method FadeInText
@within ChatMessageLogDisplay

@param duration number -- The duration of the fade

Fades in every message
]=]

--[=[
@method FadeOutText
@within ChatMessageLogDisplay

@param duration number -- The duration of the fade

Fades out every message
]=]

--[=[
@method FadeInBackground
@within ChatMessageLogDisplay

@param duration number -- The duration of the fade

Does nothing

```lua
-- This is the function def:
function methods:FadeInBackground(duration)
	--// Do nothing
end
```

]=]

--[=[
@method FadeOutBackground
@within ChatMessageLogDisplay

@param duration number -- The duration of the fade

Does nothing

```lua
-- This is the function def:
function methods:FadeOutBackground(duration)
	--// Do nothing
end
```

]=]

--[=[
@method SetCurrentChannelName
@within ChatMessageLogDisplay

@param name string -- The name of the new channel

Sets the name of the current channel to the provided one
]=]

--[=[
@method Clear
@within ChatMessageLogDisplay

@param excludeCustom boolean -- Whether custom messages will be ignored in the clear

Clears all messages under the MessageLogDisplay
]=]

--[=[
@method ReorderAllMessages
@within ChatMessageLogDisplay

Reorders all the messages under the log
]=]

--[=[
@method PositionMessageLabelInWindow
@within ChatMessageLogDisplay

@param messageObject MadeMessageChat -- The message to position
@param index number -- Where in the frame to position the message

Positions a message at a certain index under the log
]=]

--[=[
@method UpdateMessageTextHeight
@within ChatMessageLogDisplay

@param messageObject MadeMessageChat -- The message to update the height of

Updates a select message's height
]=]

--[=[
@method IsScrolledDown
@within ChatMessageLogDisplay

@return boolean -- If the display is scrolled down

Returns if the log display gui is scrolled down
]=]

--[=[
@method RemoveLastMessage
@within ChatMessageLogDisplay

Destroys the last chat message
]=]

--[=[
@method AddMessageAtIndex
@within ChatMessageLogDisplay

@param messageData ChatMessageData -- The data of the message to add
@param index number -- The index of where to add the message

Adds a message to the log at an index
]=]

--[=[
@method RemoveMessageAtIndex
@within ChatMessageLogDisplay

@param index number -- The index of what message to remove

Removes a message from the log at an index
]=]

--[=[
@method AddMessage
@within ChatMessageLogDisplay

@param messageData ChatMessageData -- The data of the message to add

Adds a message to the log
]=]

--[=[
@method RefreshMessagePlacement
@within ChatMessageLogDisplay

@param messageData ChatMessageData -- The data of the message to refresh the placement of

Refreshes the placement of message from its ChatMessageData
]=]

--[=[
@method UpdateMessageFiltered
@within ChatMessageLogDisplay

@param messageData ChatMessageData -- The data of the message to update the filtering of

Updates a message after being externally filtered
]=]

--[=[
@method SetActive
@within ChatMessageLogDisplay

@param active boolean -- THe boolean of the active state

Toggles the message log display gui
]=]

--[=[
@method Destroy
@within ChatMessageLogDisplay

Destroys the MessageLogDisplay
]=]

--[=[
@prop Destroyed boolean
@within ChatMessageLogDisplay

Whether the MessageLogDisplay is destroyed
]=]

--[=[
@prop GuiObject Frame
@within ChatMessageLogDisplay

The frame of the MessageLogDisplay gui
]=]

--[=[
@prop Scroller ScrollingFrame
@within ChatMessageLogDisplay

The scrolling frame of the MessageLogDisplay gui
]=]

--[=[
@prop Layout UIListLayout
@within ChatMessageLogDisplay

The UIListLayout of the gui
]=]

--[=[
@prop MessageObjectLog {}
@within ChatMessageLogDisplay

The object log of the MessageLogDisplay
]=]

--[=[
@prop Name string
@within ChatMessageLogDisplay

The name of the MessageLogDisplay
]=]

--[=[
@prop CurrentChannelName string
@within ChatMessageLogDisplay

The name of the current channel of the MessageLogDisplay
]=]

--[=[
@class ClientChatHandler

Handles client implementations of custom functions
]=]

--[=[
@method RegisterMessageLogDisplay
@within ClientChatHandler

@param MessageLogDisplay ChatMessageLogDisplay -- The MessageLogDisplay from the LegacyChat script

@return nil

Registers the MessageLogDisplay used to create message labels
]=]

--[=[
@method CreateChatMessageClient
@within ClientChatHandler

@param Text string -- The text of the chat to create
@param Color Color3? -- The colour of the chat
@param GradientData ChatGradientData? -- The gradient data for the chat message

@return MadeMessageChat -- The new message made from the function

Creates a new message
]=]

--[=[
@method EditChatMessageClient
@within ClientChatHandler

@param MessageID string -- The Id of the message to edit
@param NewText string -- The new text to apply to the message

@return boolean -- Whether the edit was able to be applied

Edits a message
]=]

--[=[
@method ApplyChatMessageGradientClient
@within ClientChatHandler

@param MessageID string -- The Id of the message to apply a gradient to
@param GradientColor ColorSequence? -- The color for the gradient to be
@param Transparency number? -- The transparency of the gradient
@param Rotation number? -- The rotation of the gradient
@param Offset Vector2? -- The offset of the gradient

@return boolean -- Whether the gradient was applied or not

Applies a gradient to a message
]=]

--[=[
@method WaitForMessageLogDisplay
@within ClientChatHandler
@yields

Yields the running thread until there is a MessageLogDisplay
]=]

--[=[
@class ChatMessageLogDisplayCreator

The creator for [```ChatMessageLogDisplay```](/api/ChatMessageLogDisplay) objects
]=]

--[=[
@function new
@within ChatMessageLogDisplayCreator

@return ChatMessageLogDisplay -- The created MessageLogDisplay

Creates a new MessageLogDisplay object
]=]