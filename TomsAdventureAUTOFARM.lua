local mouse = game.Players.LocalPlayer:GetMouse()
local userinput = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local screengui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local frametop = Instance.new("Frame", screengui)
frametop.Size = UDim2.new(0,300,0,25)
frametop.Position = UDim2.new(0.5,0,0.5,0)
frametop.AnchorPoint = Vector2.new(0.5,0.5)
frametop.BackgroundTransparency = 0.2
frametop.BorderSizePixel = 0
frametop.BackgroundColor3 = Color3.fromRGB(20,50,50)
local baseframe = Instance.new("Frame", frametop)
baseframe.Size = UDim2.new(1,0,10,0)
baseframe.Position = UDim2.new(0,0,1,0)
baseframe.AnchorPoint = Vector2.new(0,0)
baseframe.BackgroundTransparency = 0.25
baseframe.BorderSizePixel = 0
baseframe.BackgroundColor3 = Color3.fromRGB(20,50,100)
local scrollingframe = Instance.new("ScrollingFrame", baseframe)
scrollingframe.Size = UDim2.new(1,0,1,0)
scrollingframe.BackgroundTransparency = 1
scrollingframe.BorderSizePixel = 0
local farmswitch = Instance.new("TextButton", scrollingframe)
farmswitch.AnchorPoint = Vector2.new(0.5,0)
farmswitch.Position = UDim2.new(0.5,0,0.05,0)
farmswitch.Size = UDim2.new(0.9,0,0.05,0)
farmswitch.Text = "Item ESP: OFF"
farmswitch.BackgroundTransparency = 0.5
farmswitch.BorderSizePixel = 3
farmswitch.BackgroundColor3 = Color3.fromRGB(255,0,0)
farmswitch.BorderColor3 = Color3.fromRGB(200,0,0)
farmswitch.TextScaled = true
farmswitch.Font = "Legacy"
local autocollect = Instance.new("TextButton", scrollingframe)
autocollect.AnchorPoint = Vector2.new(0.5,0)
autocollect.Position = UDim2.new(0.5,0,0.15,0)
autocollect.Size = UDim2.new(0.9,0,0.05,0)
autocollect.Text = "Auto Collect Items: OFF"
autocollect.BackgroundTransparency = 0.5
autocollect.BorderSizePixel = 3
autocollect.BackgroundColor3 = Color3.fromRGB(255,0,0)
autocollect.BorderColor3 = Color3.fromRGB(200,0,0)
autocollect.TextScaled = true
autocollect.Font = "Legacy"
local toptext = Instance.new("TextLabel", frametop)
toptext.BackgroundTransparency = 1
toptext.Size = UDim2.new(0.8,0,1,0)
toptext.TextScaled = true
toptext.Text = "Ball's Bad GUI"
toptext.Font = "Arcade"
toptext.TextColor3 = Color3.fromRGB(255,255,255)
toptext.BorderSizePixel = 0

local espswitch = false
local autocollectswitch = false

local espcorou = coroutine.create(function()
	local stop = false
	repeat
		wait(1)
		for i, item in pairs(game.Workspace.Terrain.Items:GetChildren()) do
			if item.Name == "Item" then
				if item:FindFirstChild("Indicator") == nil then
					game.Workspace.Effects.Spawn:Play()
					local newpart = Instance.new("Part", item)
					newpart.Name = "Indicator"
					newpart.Anchored = true
					newpart.CanCollide = false
					newpart.CFrame = item.Base.CFrame
					newpart.Transparency = 1
					local typeofitem = "?"
					if item.Base.MeshId == "rbxassetid://7163644418" then
						typeofitem = "Hat"
					else

					end
					local billboard = Instance.new("BillboardGui", newpart)
					billboard.AlwaysOnTop = true
					billboard.Size = UDim2.new(0,50,0,50)
					local text = Instance.new("TextLabel")
					text.Parent = billboard
					text.Text = typeofitem
					text.BackgroundTransparency = 1
					text.Size = UDim2.new(1,0,1,0)
					text.TextScaled = true
					text.TextColor3 = Color3.fromRGB(217, 0, 3)
				end
				if autocollectswitch == true then
					local savedcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.Base.CFrame
					wait(0.2)
					fireclickdetector(item.ClickDetector)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
				end
			end
		end
	until stop == true
end)

farmswitch.MouseButton1Click:Connect(function()
	if espswitch == false then
		farmswitch.BackgroundColor3 = Color3.fromRGB(0,255,0)
		farmswitch.BorderColor3 = Color3.fromRGB(0,200,0)
		farmswitch.Text = "Item ESP: ON"
		espswitch = true
		coroutine.resume(espcorou)
	elseif espswitch == true then
		farmswitch.BackgroundColor3 = Color3.fromRGB(255,0,0)
		farmswitch.BorderColor3 = Color3.fromRGB(200,0,0)
		farmswitch.Text = "Item ESP: OFF"
		espswitch = false
		coroutine.yield(espcorou)
	end
end)

autocollect.MouseButton1Click:Connect(function()
	if autocollectswitch == false then
		autocollect.BackgroundColor3 = Color3.fromRGB(0,255,0)
		autocollect.BorderColor3 = Color3.fromRGB(0,200,0)
		autocollect.Text = "Auto Collect Items: ON"
		autocollectswitch = true
	elseif autocollectswitch == true then
		autocollect.BackgroundColor3 = Color3.fromRGB(255,0,0)
		autocollect.BorderColor3 = Color3.fromRGB(200,0,0)
		autocollect.Text = "Auto Collect Items: OFF"
		autocollectswitch = false
	end
	
end)


local dragging = false
local draggingoffset = Vector2.new(0,0)

RunService.RenderStepped:Connect(function(step)
	if dragging == true then
		frametop.Position = frametop.Position:Lerp(UDim2.new(0.5,mouse.X+draggingoffset.X,0.5,mouse.Y+draggingoffset.Y), 0.5)
	end
end)

userinput.InputBegan:Connect(function(input, processed)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y)) do
			if v == frametop then
				draggingoffset = Vector2.new(frametop.Position.X.Offset-mouse.X,frametop.Position.Y.Offset-mouse.Y)
				dragging = true
			end
		end
	end
end)

userinput.InputEnded:Connect(function(input, processed)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
