local repStorage = game:GetService("ReplicatedStorage")
local repFirst = game:GetService("ReplicatedFirst")
local blacklistFromSpy = {"SoftShutdownLocal", 
"RemoteFunction",
"RemoteEvent"
}
local queue = {}

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
	local Args = {...}
	local NamecallMethod = getnamecallmethod()

	if not checkcaller() and (NamecallMethod == "FireServer" or NamecallMethod == "InvokeServer") and table.find(blacklistFromSpy, Self.Name) == nil then
		local scriptcalling = getcallingscript()
		queue[Self.Name] = {Self, scriptcalling, Args}
		return OldNameCall(Self, ...)
	end

	return OldNameCall(Self, ...)
end)

local cor = coroutine.wrap(function()
	repeat 
		task.wait(0.1)
		for i,v in pairs(queue) do
			print(v[1]:GetFullName())
			if v[2] ~= nil then
				print(v[2]:GetFullName())
			end
			for i2,varg in pairs(v[3]) do
				local class = typeof(varg)
				print(i2, varg, class)
			end
			print("--")
			queue[i] = nil
		end
	until _G.failsafe == false
	
	toCheck = {}
	queue = {}
end)
cor()
