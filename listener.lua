--[[
    listener.lua
    ~~~~~~~~~~~~~
    Dependency of signal.lua, this is the module to create a listener object
    for a signal

    API Reference:

    listener.new(callback) -> listenerObject
    Creates a new listener object with the given callback function

    listenerObject:getId() -> string
    Returns the listener Id

    listener:disconnect() -> nil
    Disconnects the listener from the signal
]]

local listener = {}

local function generateUUID()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    math.randomseed(os.time())

    return string.gsub(template, "[xy]", function(character)
        local replacement = (character == "x") and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format("%x", replacement)
    end)
end

function listener.new(callback)
    local self = setmetatable({
        ["Class"] = "Listener",
        ["_id"] = generateUUID(),
        ["_callback"] = callback
    }, listener)

    self.new = nil
    return self
end

function listener:getId()
    return self._id
end

function listener:disconnect()
    if self.Parent ~= nil then
        self.Parent._listeners[self._uuid] = nil
        self.Parent = nil
    end
end

listener.__index=  listener
return listener