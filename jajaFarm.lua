if syn then

else
	_G.autoReplay = false
	_G.autoUlt = false

	_G.savedGuiPos = UDim2.new(0.5,0,0.5,0)
end

spawn(function()
	repeat wait(0) until game.Players.LocalPlayer
	game.Players.LocalPlayer.CharacterAdded:Wait()
	local scriptdisable = false

	local tweenserv = game:GetService("TweenService")
	local heheheha = function()

	end

	local mouse = game.Players.LocalPlayer:GetMouse()
	local userinput = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")

	local listlength = 4

	local screengui = Instance.new("ScreenGui")
	if syn then
		syn.protect_gui(screengui)
		screengui.Name = "lskjflsjf;lkjasf;lksajdf;lajsfd;lkasjfd;lkasjdf"
		screengui.Parent = game:GetService("CoreGui")
		if not isfolder("Assets") then
			makefolder("Assets")
		end
	else
		screengui.Parent = game.Players.LocalPlayer.PlayerGui
	end

	local frametop = Instance.new("Frame", screengui)
	frametop.Size = UDim2.new(0,300,0,25)
	frametop.Position = _G.savedGuiPos
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
	local closebutton = Instance.new("TextButton", frametop)
	closebutton.AnchorPoint = Vector2.new(1,0)
	closebutton.Position = UDim2.new(1,0,0,0)
	closebutton.Size = UDim2.new(0.2,0,1,0)
	closebutton.Text = "X"
	closebutton.BackgroundTransparency = 0.5
	closebutton.BorderSizePixel = 0
	closebutton.BackgroundColor3 = Color3.fromRGB(255,0,0)
	closebutton.BorderColor3 = Color3.fromRGB(200,0,0)
	closebutton.TextScaled = true
	closebutton.Font = "Legacy"
	local toptext = Instance.new("TextLabel", frametop)
	toptext.BackgroundTransparency = 1
	toptext.Size = UDim2.new(0.8,0,1,0)
	toptext.TextScaled = true
	toptext.Text = "Ball's Autofarm"
	toptext.Font = "Arcade"
	toptext.TextColor3 = Color3.fromRGB(255,255,255)
	toptext.BorderSizePixel = 0

	local function createbutton(parent, size, position, text, name)
		local button = Instance.new("TextButton")
		button.AnchorPoint = Vector2.new(0.5,0)
		button.Position = position
		button.Size = size
		button.Text = text
		button.BackgroundTransparency = 0.5
		button.BorderSizePixel = 3
		button.BackgroundColor3 = Color3.fromRGB(255,0,0)
		button.BorderColor3 = Color3.fromRGB(200,0,0)
		button.TextScaled = true
		button.Font = "Legacy"
		button.Name = name
		button.Parent = parent
		
		return button
	end

	local listlength = 4

	local scrollingframe = Instance.new("ScrollingFrame", baseframe)
	scrollingframe.Size = UDim2.new(1,0,1,0)
	scrollingframe.BackgroundTransparency = 1
	scrollingframe.BorderSizePixel = 0
	scrollingframe.CanvasSize = UDim2.new(0,0,listlength,0)
	
	local autoreplayButton = Instance.new("TextButton", scrollingframe)
	autoreplayButton.AnchorPoint = Vector2.new(0.5,0)
	autoreplayButton.Position = UDim2.new(0.5,0,0.1/listlength,0)
	autoreplayButton.Size = UDim2.new(0.9,0,0.1/listlength,0)
	autoreplayButton.Text = "Auto Replay: OFF"
	autoreplayButton.BackgroundTransparency = 0.5
	autoreplayButton.BorderSizePixel = 3
	autoreplayButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
	autoreplayButton.BorderColor3 = Color3.fromRGB(155,0,0)
	autoreplayButton.TextScaled = true
	autoreplayButton.Font = Enum.Font.Code
	autoreplayButton.TextColor3 = Color3.fromRGB(255,255,255)
	
	local autoUltButton = Instance.new("TextButton", scrollingframe)
	autoUltButton.AnchorPoint = Vector2.new(0.5,0)
	autoUltButton.Position = UDim2.new(0.5,0,0.25/listlength,0)
	autoUltButton.Size = UDim2.new(0.9,0,0.1/listlength,0)
	autoUltButton.Text = "Auto Ult: OFF"
	autoUltButton.BackgroundTransparency = 0.5
	autoUltButton.BorderSizePixel = 3
	autoUltButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
	autoUltButton.BorderColor3 = Color3.fromRGB(155,0,0)
	autoUltButton.TextScaled = true
	autoUltButton.Font = Enum.Font.Code
	autoUltButton.TextColor3 = Color3.fromRGB(255,255,255)


	local autoReplay = false
	local autoUlt = false
	
	local runserv = game:GetService("RunService")
	
	local Lines = {}
	
	local function removeLines()
		for i,v in pairs(Lines) do
			v:Remove()
		end
	end
	
	local function createLines()
		local cornerOne = Vector2.new(0,0)
	end
	
	local function loops()
		repeat
			if _G.autoReplay == true then

			end
			if _G.autoUlt == true then

			end
			removeLines()
			createLines()
			RunService.Heartbeat:Wait()
		until scriptdisable == true
	end

	spawn(function()
		loops()
	end)

	autoreplayButton.MouseButton1Click:Connect(function()
		if _G.autoReplay == false then
			autoreplayButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
			autoreplayButton.BorderColor3 = Color3.fromRGB(0,155,0)
			autoreplayButton.Text = "Auto Replay: ON"
			_G.autoReplay = true
		elseif _G.autoReplay == true then
			autoreplayButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
			autoreplayButton.BorderColor3 = Color3.fromRGB(155,0,0)
			autoreplayButton.Text = "Auto Replay: OFF"
			_G.autoReplay = false
		end
	end)
	
	autoUltButton.MouseButton1Click:Connect(function()
		if _G.autoUlt == false then
			autoUltButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
			autoUltButton.BorderColor3 = Color3.fromRGB(0,155,0)
			autoUltButton.Text = "Auto Ult: ON"
			_G.autoUlt = true
		elseif _G.autoUlt == true then
			autoUltButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
			autoUltButton.BorderColor3 = Color3.fromRGB(155,0,0)
			autoUltButton.Text = "Auto Ult: OFF"
			_G.autoUlt = false
		end
	end)
	
	if _G.autoReplay == true then
		autoreplayButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
		autoreplayButton.BorderColor3 = Color3.fromRGB(0,155,0)
		autoreplayButton.Text = "Auto Replay: ON"
	elseif _G.autoReplay == false then
		autoreplayButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
		autoreplayButton.BorderColor3 = Color3.fromRGB(155,0,0)
		autoreplayButton.Text = "Auto Replay: OFF"
	end
	
	if _G.autoUlt == true then
		autoUltButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
		autoUltButton.BorderColor3 = Color3.fromRGB(0,155,0)
		autoUltButton.Text = "Auto Ult: ON"
	elseif _G.autoUlt == false then
		autoUltButton.BackgroundColor3 = Color3.fromRGB(200,0,0)
		autoUltButton.BorderColor3 = Color3.fromRGB(155,0,0)
		autoUltButton.Text = "Auto Ult: OFF"
	end

	pcall(function()
		speedchangeamt.FocusLost:Connect(function(enter)
			local num = tonumber(speedchangeamt.Text)
			if num ~= nil then
				walkspeedamt2 = num
			end
		end)
	end)

	closebutton.MouseButton1Click:Connect(function()
		frametop:Destroy()
		scriptdisable = true
	end)

	local dragging = false
	local draggingoffset = Vector2.new(0,0)

	RunService.RenderStepped:Connect(function(step)
		if dragging == true then
			frametop.Position = frametop.Position:Lerp(UDim2.new(0.5,mouse.X+draggingoffset.X,0.5,mouse.Y+draggingoffset.Y), 0.5)
			_G.savedGuiPos = frametop.Position
		end
		heheheha()
	end)

	userinput.InputBegan:Connect(function(input, processed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			pcall(function()
				local foundtable = screengui.Parent:GetGuiObjectsAtPosition(mouse.X, mouse.Y)
				for i,v in pairs(foundtable) do
					if v == frametop then
						draggingoffset = Vector2.new(frametop.Position.X.Offset-mouse.X,frametop.Position.Y.Offset-mouse.Y)
						dragging = true
					end
				end
			end)
		end
	end)

	userinput.InputEnded:Connect(function(input, processed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	local function blunction()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ballpeet/scripts/main/jajaFarm.lua", true))()
	end
	
	
	local codeLink = "https://raw.githubusercontent.com/ballpeet/scripts/main/jajaFarm.lua"
	game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
		if State == Enum.TeleportState.Started then
			syn.queue_on_teleport("loadstring(game:HttpGet(codeLink, true))()")
		end
	end)
end)
