--[[
    signal.lua
    ~~~~~~~~~~~
    A simple signal/slot implementation in Lua.

    API reference:

    signal.new() -> signalObject
    creates and return a signal object

    signalObject:register(callback) -> listenerObject
    registers a callback function to be called when the signal is being emitted

    signalObject:emit() -> nil
    emits the signal, calling all registered callbacks

    signalObject:clearAll() -> nil
    clears all registered callbacks

    listenerObject:getId() -> string
    returns the listener id

    listenerObject:disconnect() -> nil
    removes the listener from the list of listeners
]]

local signal = {}
local listener = {}

local function generateUUID()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    math.randomseed(os.time())

    return string.gsub(template, "[xy]", function(character)
        local replacement = (character == "x") and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format("%x", replacement)
    end)
end

function listener:getId()
    return self.__uuid
end

function listener:disconnect()
    if self._parent ~= nil then
        self._parent[self._uuid] = nil
    end
end

function signal.new()
    local self = setmetatable({
        _listeners = {},
        _routines = {}
    }, signal)

    self.new = nil
    return self
end

function signal:register(callback)
    if not self then return end
    local listenerObject = setmetatable({
        ["_parent"] = self,
        ["_uuid"] = generateUUID(),
        ["_callback"] = callback
    }, listener)

    self._listeners[listenerObject._uuid] = listenerObject
    return listenerObject
end

function signal:emit(...)
    if not self then return end
    for _, listenerObject in pairs(self._listeners) do
        coroutine.wrap(listenerObject._callback)(...)
    end
end

function signal:clearAll()
    if not self then return end
    self._listeners = {}
end

signal.__index = signal
return signal