local killLoop = coroutine.wrap(function()
	repeat
		task.wait(0.5)
		local success, errormes = pcall(function()
            for i2, v2 in pairs(game.Workspace:GetChildren()) do
                if v2.Name ~= "Rubber Dummy" then
                    local humthing = v2:FindFirstChild("Humanoid")
                    local plrfound = game.Players:GetPlayerFromCharacter(v2)
                    if humthing and plrfound == nil then
                        local torso = v2:FindFirstChild("HumanoidRootPart") or v2:FindFirstChild("Torso")
                        if humthing.Health > 0 then
                            spawn(function ()
                                local got = hitbox:InvokeServer(55, torso, torso.CFrame, 20000, torso, humthing, false, false, false)
                            end)
                        end
                    end
                end
            end
		end)
		if not success then
			warn(errormes)
		end
	until closed == true
end)
killLoop()
