local stop = false

local standstopickup = {"ZaHandoBandDrop"} -- unused for now dw

local tweenserv = game:GetService("TweenService")
local userinput = game:GetService("UserInputService")

spawn(function()
    repeat
        wait(1)
        for i,v in pairs(game.Workspace:GetChildren()) do
            if v.Name == "BankNote" then
                local distance = math.abs((game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - v.CFrame.Position).Magnitude)
                
                if distance > 1 then
                    local tweeninf = TweenInfo.new(distance/75, Enum.EasingStyle.Linear)
                    tweenserv:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweeninf, {CFrame = v.CFrame}):Play()
                    wait(distance/75)
                end
                fireclickdetector(v.ClickDetector, 1)
            end
        end
    until stop == true
end)

userinput.InputBegan:Connect(function(inputk, gameProcessed)
    if inputk.KeyCode == Enum.KeyCode.P then
        stop = true
        script:Destroy()
    end
end)
