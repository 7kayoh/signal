--[[
    signal.lua
    ~~~~~~~~~~~
    A simple signal/slot implementation in Lua.

    API reference:

    signal.new() -> signalObject
    creates and return a signal object

    signalObject:register(listener) -> nil
    registers a callback function to be called when the signal is being emitted

    signalObject:emit() -> nil
    emits the signal, calling all registered callbacks

    signalObject:clearAll() -> nil
    clears all registered callbacks
]]

local signal = {}

function signal.new()
    local self = setmetatable({
        ["Class"] = "Signal",
        ["_listeners"] = {},
        ["_routines"] = {}
    }, signal)

    self.new = nil
    return self
end

function signal:register(listener)
    if not self then return end
    if listener and listener.Class == "Listener" then
        listener.Parent = self
        self._listeners[listener:getId()] = listener
    end
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