local guiAPI = {}

local newScreenGUI = Instance.new("ScreenGui")
newScreenGUI.Parent = game:GetService("CoreGui")
newScreenGUI.ResetOnSpawn = false
newScreenGUI.IgnoreGuiInset = false 

local moveableWindows = {}
local colorSchemes = {}
local thingsInTabs = {}
local buttonValues = {}

-- dbm barnacle crash

local function clickSound()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://2037448430"
	sound.Volume = 0.4
	sound.PlaybackSpeed = 1.1
	sound.Parent = newScreenGUI
	sound:Play()
	debrisServ:AddItem(sound, 1)
end

local function updateInfo(frame)
	local success, errormes = pcall(function()
		local valuething = nil
		local basisframe = nil
		local basisscroll = nil

		valuething = frame:FindFirstChildOfClass("StringValue")

		basisframe = frame:FindFirstChild("Content")
		if basisframe then
			basisscroll = basisframe:FindFirstChildOfClass("ScrollingFrame")
		end

		if valuething and basisframe and basisscroll then
			for i,v in pairs(basisscroll:GetChildren()) do
				if not v:IsA("UIListLayout") and not v:IsA("UIGridLayout") then
					v:Destroy()
				end
			end

			for key,v in pairs(thingsInTabs) do
				if v[1] == valuething.Value and v[2] == frame then
					local i = v[5]
					if v[4]["LayoutOrder"] then
						i = v[4]["LayoutOrder"]
					end
					local guiType = v[3]

					if guiType == "textlabel" then
						local label = Instance.new("TextLabel")
						label.BackgroundTransparency = v[4]["backgroundtransparency"]
						local size = UDim2.new(0,0,0,0)
						if v[4]["scalewithlines"] == true then
							local _, count = v[4]["text"]:gsub("\n", "")
							if count == 0 then
								count = 1
							end
							size = UDim2.new(v[4]["size"].X.Scale, v[4]["size"].X.Offset, v[4]["size"].Y.Scale * count, v[4]["size"].Y.Offset * count)
						else
							size = v[4]["size"]
						end
						label.Size = size
						label.BorderSizePixel = 0
						label.BackgroundColor3 = v[4]["backgroundcolor"]
						label.Text = v[4]["text"]
						label.TextColor3 = v[4]["color"]
						label.Font = v[4]["font"]
						label.TextScaled = true
						label.LayoutOrder = i
						label.Parent = basisscroll
					elseif guiType == "togglebutton1" then
						local function getIfHas()
							if buttonValues[v[4]["togglename"]] == true then
								return true
							elseif buttonValues[v[4]["togglename"]] == false then
								return false
							end
						end

						if v[4]["style"] == "switch" then
							local baseframe = Instance.new("Frame")
							baseframe.BorderSizePixel = 0
							baseframe.BackgroundTransparency = v[4]["backgroundtransparency"]
							baseframe.Size = v[4]["size"]
							baseframe.BackgroundColor3 = v[4]["backgroundcolor"]
							baseframe.LayoutOrder = i
							baseframe.Parent = basisscroll

							local label = Instance.new("TextLabel")
							label.BackgroundTransparency = 1
							label.Size = UDim2.new(0.75,0,1,0)
							label.Text = v[4]["text"]
							label.Font = v[4]["font"]
							label.TextColor3 = v[4]["color"]
							label.TextScaled = true
							label.TextXAlignment = Enum.TextXAlignment.Left
							label.Parent = baseframe

							local buttonFrame = Instance.new("Frame")
							buttonFrame.Size = UDim2.new(0.25,0,0.8,0)
							buttonFrame.AnchorPoint = Vector2.new(1,0.5)
							buttonFrame.Position = UDim2.new(1,0,0.5,0)
							buttonFrame.BackgroundColor3 = Color3.fromRGB(100,100,100)
							buttonFrame.BorderSizePixel = 0
							buttonFrame.Parent = baseframe

							local switch = Instance.new("TextButton")
							switch.Text = ""
							switch.Position = UDim2.new(0,0,0,0)
							switch.AnchorPoint = Vector2.new(0,0)
							switch.Size = UDim2.new(0.5,0,1,0)
							switch.BackgroundColor3 = Color3.fromRGB(200,200,200)
							switch.BorderSizePixel = 0
							switch.Parent = buttonFrame

							local framecorner = Instance.new("UICorner")
							framecorner.CornerRadius = UDim.new(0,25)
							framecorner.Parent = buttonFrame

							local switchcorner = Instance.new("UICorner")
							switchcorner.CornerRadius = UDim.new(0,25)
							switchcorner.Parent = switch

							local function buttontoggle()
								local hasgot = getIfHas()
								if hasgot == true then
									local goal = {}
									goal.BackgroundColor3 = v[4]["oncolor"]
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(buttonFrame, tweenInfo, goal)
									tween:Play()

									local goal = {}
									goal.Position = UDim2.new(1,0,0,0)
									goal.AnchorPoint = Vector2.new(1,0)
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(switch, tweenInfo, goal)
									tween:Play()
								elseif hasgot == false then
									local goal = {}
									goal.BackgroundColor3 = v[4]["offcolor"]
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(buttonFrame, tweenInfo, goal)
									tween:Play()

									local goal = {}
									goal.Position = UDim2.new(0,0,0,0)
									goal.AnchorPoint = Vector2.new(0,0)
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(switch, tweenInfo, goal)
									tween:Play()
								end
							end

							switch.Activated:Connect(function()
								local hasgot = getIfHas()
								clickSound()
								if hasgot == true then
									buttonValues[v[4]["togglename"]] = false
									buttontoggle()
								elseif hasgot == false then
									buttonValues[v[4]["togglename"]] = true
									buttontoggle()
								end
							end)
							buttontoggle()
						elseif v[4]["style"] == "box" then
							local baseframe = Instance.new("Frame")
							baseframe.BorderSizePixel = 0
							baseframe.BackgroundTransparency = 1
							baseframe.Size = v[4]["size"]
							baseframe.LayoutOrder = i
							baseframe.Parent = basisscroll

							local switch = Instance.new("TextButton")
							switch.Text = ""
							switch.Position = UDim2.new(0,0,0,0)
							switch.AnchorPoint = Vector2.new(0,0)
							switch.Size = UDim2.new(1,0,1,0)
							switch.Text = v[4]["text"]
							switch.TextColor3 = v[4]["color"]
							switch.TextScaled = true
							switch.Font = v[4]["font"]
							switch.BackgroundTransparency = v[4]["backgroundtransparency"]
							switch.BackgroundColor3 = v[4]["backgroundcolor"]
							switch.BackgroundColor3 = Color3.fromRGB(200,200,200)
							switch.BorderSizePixel = 0
							switch.Parent = baseframe

							local framecorner = Instance.new("UICorner")
							framecorner.CornerRadius = UDim.new(0,25)
							framecorner.Parent = switch

							local function buttontoggle()
								local got = getIfHas()

								if got == true then
									local goal = {}
									goal.BackgroundColor3 = v[4]["oncolor"]
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(switch, tweenInfo, goal)
									tween:Play()
									switch.Text = v[4]["text"].." ON"
								else
									local goal = {}
									goal.BackgroundColor3 = v[4]["offcolor"]
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(switch, tweenInfo, goal)
									tween:Play()
									switch.Text = v[4]["text"].." OFF"
								end
							end

							switch.Activated:Connect(function()
								local hasgot = getIfHas()
								clickSound()
								if hasgot == true then
									buttonValues[v[4]["togglename"]] = false
									buttontoggle()
								elseif hasgot == false then
									buttonValues[v[4]["togglename"]] = true
									buttontoggle()
								end
							end)
							buttontoggle()
						end
					elseif guiType == "togglebutton2" then
						local function getIfHas()
							if table.find(v[4]["tableaddto"], v[4]["togglename"]) then
								return true
							else
								return false
							end
						end

						if v[4]["style"] == "switch" then
							local baseframe = Instance.new("Frame")
							baseframe.BorderSizePixel = 0
							baseframe.BackgroundTransparency = v[4]["backgroundtransparency"]
							baseframe.Size = v[4]["size"]
							baseframe.BackgroundColor3 = v[4]["backgroundcolor"]
							baseframe.LayoutOrder = i
							baseframe.Parent = basisscroll

							local label = Instance.new("TextLabel")
							label.BackgroundTransparency = 1
							label.Size = UDim2.new(0.75,0,1,0)
							label.Text = v[4]["text"]
							label.TextColor3 = v[4]["color"]
							label.Font = v[4]["font"]
							label.TextScaled = true
							label.TextXAlignment = Enum.TextXAlignment.Left
							label.Parent = baseframe

							local buttonFrame = Instance.new("Frame")
							buttonFrame.Size = UDim2.new(0.25,0,0.8,0)
							buttonFrame.AnchorPoint = Vector2.new(1,0.5)
							buttonFrame.Position = UDim2.new(1,0,0.5,0)
							buttonFrame.BackgroundColor3 = Color3.fromRGB(100,100,100)
							buttonFrame.BorderSizePixel = 0
							buttonFrame.Parent = baseframe

							local switch = Instance.new("TextButton")
							switch.Text = ""
							switch.Position = UDim2.new(0,0,0,0)
							switch.AnchorPoint = Vector2.new(0,0)
							switch.Size = UDim2.new(0.5,0,1,0)
							switch.BackgroundColor3 = Color3.fromRGB(200,200,200)
							switch.BorderSizePixel = 0
							switch.Parent = buttonFrame

							local framecorner = Instance.new("UICorner")
							framecorner.CornerRadius = UDim.new(0,25)
							framecorner.Parent = buttonFrame

							local switchcorner = Instance.new("UICorner")
							switchcorner.CornerRadius = UDim.new(0,25)
							switchcorner.Parent = switch

							local function buttontoggle()
								local got = getIfHas()
								if got == true then
									local goal = {}
									goal.BackgroundColor3 = v[4]["oncolor"]
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(buttonFrame, tweenInfo, goal)
									tween:Play()

									local goal = {}
									goal.Position = UDim2.new(1,0,0,0)
									goal.AnchorPoint = Vector2.new(1,0)
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(switch, tweenInfo, goal)
									tween:Play()
								else
									local goal = {}
									goal.BackgroundColor3 = v[4]["offcolor"]
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(buttonFrame, tweenInfo, goal)
									tween:Play()

									local goal = {}
									goal.Position = UDim2.new(0,0,0,0)
									goal.AnchorPoint = Vector2.new(0,0)
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(switch, tweenInfo, goal)
									tween:Play()
								end
							end

							switch.Activated:Connect(function()
								local got = getIfHas()
								clickSound()
								if got == true then
									table.remove(v[4]["tableaddto"], table.find(v[4]["tableaddto"], v[4]["togglename"]))
									buttontoggle()
								else
									table.insert(v[4]["tableaddto"], v[4]["togglename"])
									buttontoggle()
								end
							end)
							buttontoggle()
						elseif v[4]["style"] == "box" then
							local baseframe = Instance.new("Frame")
							baseframe.BorderSizePixel = 0
							baseframe.BackgroundTransparency = 1
							baseframe.Size = v[4]["size"]
							baseframe.LayoutOrder = i
							baseframe.Parent = basisscroll

							local switch = Instance.new("TextButton")
							switch.Text = ""
							switch.Position = UDim2.new(0,0,0,0)
							switch.AnchorPoint = Vector2.new(0,0)
							switch.Size = UDim2.new(1,0,1,0)
							switch.Text = v[4]["text"]
							switch.TextColor3 = v[4]["color"]
							switch.Font = v[4]["font"]
							switch.TextScaled = true
							switch.BackgroundTransparency = v[4]["backgroundtransparency"]
							switch.BackgroundColor3 = v[4]["backgroundcolor"]
							switch.BackgroundColor3 = Color3.fromRGB(200,200,200)
							switch.BorderSizePixel = 0
							switch.Parent = baseframe

							local framecorner = Instance.new("UICorner")
							framecorner.CornerRadius = UDim.new(0,5)
							framecorner.Parent = switch

							local function buttontoggle()
								local got = getIfHas()

								if got == true then
									local goal = {}
									goal.BackgroundColor3 = v[4]["oncolor"]
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(switch, tweenInfo, goal)
									tween:Play()
									switch.Text = v[4]["text"].." ON"
								else
									local goal = {}
									goal.BackgroundColor3 = v[4]["offcolor"]
									local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
									local tween = tweenServ:Create(switch, tweenInfo, goal)
									tween:Play()
									switch.Text = v[4]["text"].." OFF"
								end
							end

							switch.Activated:Connect(function()
								local got = getIfHas()
								clickSound()
								if got == true then
									table.remove(v[4]["tableaddto"], table.find(v[4]["tableaddto"], v[4]["togglename"]))
									buttontoggle()
								else
									table.insert(v[4]["tableaddto"], v[4]["togglename"])
									buttontoggle()
								end
							end)
							buttontoggle()
						end
					elseif guiType == "numberbox" then
						local baseframe = Instance.new("Frame")
						baseframe.BorderSizePixel = 0
						baseframe.BackgroundTransparency = v[4]["backgroundtransparency"]
						baseframe.Size = v[4]["size"]
						baseframe.BackgroundColor3 = v[4]["backgroundcolor"]
						baseframe.LayoutOrder = i
						baseframe.Parent = basisscroll

						local label = Instance.new("TextLabel")
						label.BackgroundTransparency = 1
						label.Size = UDim2.new(0.45,0,1,0)
						label.Text = v[4]["text"]
						label.TextColor3 = v[4]["color"]
						label.Font = v[4]["font"]
						label.TextScaled = true
						label.TextXAlignment = Enum.TextXAlignment.Left
						label.Parent = baseframe

						local downbutton = Instance.new("TextButton")
						downbutton.Text = "-"
						downbutton.TextScaled = true
						downbutton.TextColor3 = Color3.new(255,255,255)
						downbutton.Position = UDim2.new(1,0,0.5,0)
						downbutton.AnchorPoint = Vector2.new(1,0.5)
						downbutton.Size = UDim2.new(0.1,0,0.9,0)
						downbutton.BackgroundColor3 = v[4]["downcolor"]
						downbutton.BorderSizePixel = 0
						downbutton.Parent = baseframe

						local switchcorner = Instance.new("UICorner")
						switchcorner.CornerRadius = UDim.new(0,6)
						switchcorner.Parent = downbutton

						local upbutton = Instance.new("TextButton")
						upbutton.Text = "+"
						upbutton.TextScaled = true
						upbutton.TextColor3 = Color3.new(255,255,255)
						upbutton.Position = UDim2.new(0.9,0,0.5,0)
						upbutton.AnchorPoint = Vector2.new(1,0.5)
						upbutton.Size = UDim2.new(0.1,0,0.9,0)
						upbutton.BackgroundColor3 = v[4]["upcolor"]
						upbutton.BorderSizePixel = 0
						upbutton.Parent = baseframe

						local switchcorner = Instance.new("UICorner")
						switchcorner.CornerRadius = UDim.new(0,6)
						switchcorner.Parent = upbutton

						local textlabel = Instance.new("TextLabel")
						textlabel.Text = "0"
						textlabel.TextScaled = true
						textlabel.TextColor3 = Color3.new(255,255,255)
						textlabel.Position = UDim2.new(0.75,0,0.5,0)
						textlabel.AnchorPoint = Vector2.new(1,0.5)
						textlabel.Size = UDim2.new(0.3,0,0.9,0)
						textlabel.BackgroundColor3 = v[4]["displayBackgroundColor"]
						textlabel.BackgroundTransparency = 0.25

						textlabel.TextColor3 = v[4]["displayTextColor"]
						textlabel.Font = Enum.Font.Code

						textlabel.BorderSizePixel = 0
						textlabel.Parent = baseframe

						local function updateDisplay()
							textlabel.Text = tostring(math.floor(buttonValues[v[4]["varname"]]*1000)/1000)
						end

						updateDisplay()

						upbutton.Activated:Connect(function()
							buttonValues[v[4]["varname"]] = math.clamp(buttonValues[v[4]["varname"]] + v[4]["inc"], v[4]["minnum"], v[4]["maxnum"])
							updateDisplay()
							clickSound()
						end)
						downbutton.Activated:Connect(function()
							buttonValues[v[4]["varname"]] = math.clamp(buttonValues[v[4]["varname"]] - v[4]["inc"], v[4]["minnum"], v[4]["maxnum"])
							updateDisplay()
							clickSound()
						end)
					elseif guiType == "whitespace" then
						local baseframe = Instance.new("Frame")
						baseframe.BorderSizePixel = 0
						baseframe.BackgroundTransparency = 1
						baseframe.Size = UDim2.new(1,0,v[4]["size"],0)
						baseframe.LayoutOrder = i
						baseframe.Parent = basisscroll
					elseif guiType == "functionbutton" then
						local switch = Instance.new("TextButton")
						switch.Text = ""
						switch.Position = UDim2.new(0,0,0,0)
						switch.AnchorPoint = Vector2.new(0,0)
						switch.Size = v[4]["size"]
						switch.Text = v[4]["text"]
						switch.TextColor3 = v[4]["color"]
						switch.TextScaled = true
						switch.Font = v[4]["font"]
						switch.BackgroundTransparency = v[4]["transparency"]
						switch.BackgroundColor3 = v[4]["backgroundcolor"]
						switch.BorderColor3 = v[4]["strokecolor"]
						switch.BorderSizePixel = 4
						switch.BorderMode = Enum.BorderMode.Inset
						switch.LayoutOrder = i
						switch.Parent = basisscroll

						switch.Activated:Connect(v[4]["pressfunction"])
					end
				end
			end
		end
	end)
	if not success then
		warn(errormes)
	end
end

guiAPI.newColorScheme = function(name, basecolor, topcolor, bordercolor)
	colorSchemes[name] = {basecolor, topcolor, bordercolor}
end

guiAPI.CreateNewWindow = function(sizeX, sizeY, name, colorscheme, moveable, closeable, haslist, toptextname, startValue, gridType, gridInfo)
	if not gridType then
		gridType = "list"
	end

	local basecolor = Color3.fromRGB(50,50,50)
	local topcolor = Color3.fromRGB(25,25,25)
	local bordercolor = Color3.fromRGB(50,50,150)

	if colorSchemes[colorscheme] then
		basecolor = colorSchemes[colorscheme][1]
		topcolor = colorSchemes[colorscheme][2]
		bordercolor = colorSchemes[colorscheme][3]
	end

	local topFrame = Instance.new("Frame")
	topFrame.BorderSizePixel = 0
	topFrame.BackgroundTransparency = 0.1
	topFrame.Size = UDim2.new(sizeX,0,0.035,0)
	topFrame.Name = name
	topFrame.BackgroundColor3 = topcolor
	topFrame.AnchorPoint = Vector2.new(0,0)
	topFrame.Position = UDim2.new(0.5,0,0.5,0)
	topFrame.Parent = newScreenGUI

	local topText = Instance.new("TextLabel")
	topText.Size = UDim2.new(1,0,1,0)
	topText.BackgroundTransparency = 1
	topText.BorderSizePixel = 0
	topText.TextColor3 = Color3.fromRGB(255,255,255)
	topText.Font = Enum.Font.Code
	topText.TextXAlignment = Enum.TextXAlignment.Left
	topText.TextScaled = true
	topText.Text = toptextname
	topText.Parent = topFrame

	local basis = Instance.new("Frame")
	basis.BackgroundTransparency = 0.1
	basis.Size = UDim2.new(1,0,sizeY,0)
	basis.Name = "Content"
	basis.BorderSizePixel = 0
	basis.BackgroundColor3 = basecolor
	basis.AnchorPoint = Vector2.new(0,0)
	basis.Position = UDim2.new(0,0,1,0)
	basis.Parent = topFrame

	local basisscrolling = Instance.new("ScrollingFrame")
	basisscrolling.Size = UDim2.new(1,0,1,0)
	basisscrolling.Position = UDim2.new(0,0,0,0)
	basisscrolling.BackgroundTransparency = 1
	basisscrolling.ScrollBarThickness = 0
	basisscrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
	basisscrolling.CanvasSize = UDim2.new(0,0,0,0)
	basisscrolling.Parent = basis

	if gridType == "list" then
		local listlayout2 = Instance.new("UIListLayout")
		listlayout2.Parent = basisscrolling
		listlayout2.SortOrder = Enum.SortOrder.LayoutOrder
		listlayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	elseif gridType == "grid" then
		local listlayout2 = Instance.new("UIGridLayout")
		listlayout2.Parent = basisscrolling
		listlayout2.SortOrder = Enum.SortOrder.LayoutOrder
		listlayout2.CellSize = gridInfo["size"]
		listlayout2.CellPadding = gridInfo["padding"]
	end

	local tabSelected = Instance.new("StringValue")
	if not startValue then
		startValue = ""
	end
	tabSelected.Value = startValue
	tabSelected.Parent = topFrame

	if haslist == true then
		local listframe = Instance.new("Frame")
		listframe.BackgroundTransparency = 0.1
		listframe.Size = UDim2.new(0.25,0,sizeY+1,0)
		listframe.Name = "List"
		listframe.BorderSizePixel = 0
		listframe.BackgroundColor3 = topcolor
		listframe.AnchorPoint = Vector2.new(1,0)
		listframe.Position = UDim2.new(0,0,0,0)
		listframe.Parent = topFrame

		local scrolling = Instance.new("ScrollingFrame")
		scrolling.Size = UDim2.new(1,0,1,0)
		scrolling.Position = UDim2.new(0,0,0,0)
		scrolling.BackgroundTransparency = 1
		scrolling.ScrollBarThickness = 0
		scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scrolling.CanvasSize = UDim2.new(0,0,0,0)
		scrolling.Parent = listframe

		local listlayout = Instance.new("UIListLayout")
		listlayout.Padding = UDim.new(0.015,0)
		listlayout.Parent = scrolling
		listlayout.SortOrder = Enum.SortOrder.LayoutOrder
		listlayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	end

	local border = Instance.new("Frame")
	border.BackgroundTransparency = 1
	border.AnchorPoint = Vector2.new(1,0)
	border.Position = UDim2.new(1,0,0,0)
	if haslist == true then
		border.Size = UDim2.new(1.25,0,sizeY+1,0)
	else
		border.Size = UDim2.new(1,0,sizeY+1,0)
	end
	border.Parent = topFrame

	local stroke = Instance.new("UIStroke")
	stroke.Color = bordercolor
	stroke.Thickness = 1.5
	stroke.Transparency = 0.2
	stroke.Parent = border

	if moveable == true then
		table.insert(moveableWindows, topFrame)
	end

	if closeable == true then
		local button = Instance.new("TextButton")
		button.Text = "X"
		button.Size = UDim2.new(0.1,0,1,0)
		button.AnchorPoint = Vector2.new(1,0)
		button.Position = UDim2.new(1,0,0,0)
		button.BackgroundTransparency = 1
		button.TextScaled = true
		button.Font = Enum.Font.Code
		button.TextColor3 = bordercolor
		button.Parent = topFrame

		button.Activated:Connect(function()
			clickSound()

			local shift = 0
			for key, val in ipairs(thingsInTabs) do
				if val and val[2] == topFrame then
					continue
				else
					table.remove(thingsInTabs, key-shift)
					shift += 1
				end
			end

			topFrame:Destroy()

		end)
	end

	return topFrame
end

guiAPI.newTab = function(tabname, parent, colorscheme, otherdata)
	local listframe = nil
	local scrolling = nil
	local valuething = nil

	listframe = parent:FindFirstChild("List")
	if listframe then
		scrolling = listframe:FindFirstChildOfClass("ScrollingFrame")
	end
	valuething = parent:FindFirstChildOfClass("StringValue")

	if listframe and scrolling then
		local basecolor = Color3.fromRGB(50,50,50)
		local topcolor = Color3.fromRGB(25,25,25)
		local bordercolor = Color3.fromRGB(50,50,150)

		if colorSchemes[colorscheme] then
			basecolor = colorSchemes[colorscheme][1]
			topcolor = colorSchemes[colorscheme][2]
			bordercolor = colorSchemes[colorscheme][3]
		end

		local button = Instance.new("TextButton")
		button.BackgroundTransparency = 0.2
		button.Size = UDim2.new(0.95,0,0.1,0)
		button.Name = tabname
		button.BorderSizePixel = 0
		button.BackgroundColor3 = basecolor
		button.AnchorPoint = Vector2.new(0.5, 0)
		button.Position = UDim2.new(0.5,0,0,0)
		button.LayoutOrder = #scrolling:GetChildren()

		button.Text = ""

		local buttonColor = otherdata[1]
		local buttonFont = otherdata[2]
		local buttonText = otherdata[3]

		if buttonColor and buttonFont then
			button.Text = buttonText
			button.Font = buttonFont
			button.TextColor3 = buttonColor
			button.TextScaled = true
		end

		button.Parent = scrolling

		button.Activated:Connect(function()
			valuething.Value = tabname
			updateInfo(parent)
			clickSound()
		end)

		local buttonstroke = Instance.new("UIStroke")
		buttonstroke.Color = bordercolor
		buttonstroke.Thickness = 1
		buttonstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		buttonstroke.Parent = button

		local uicorner = Instance.new("UICorner")
		uicorner.CornerRadius = UDim.new(0,1)
		uicorner.Parent = button

		button.Parent = scrolling
		return button
	end
end

local amtofobjects = 0
guiAPI.newTabObject = function(tab, parent, typeObject, typeData)
	amtofobjects = amtofobjects + 1
	if typeObject == "togglebutton1" then
		buttonValues[typeData["togglename"]] = false
	end
	if typeObject == "numberbox" then
		buttonValues[typeData["varname"]] = typeData["startnum"]
	end

	local key = ""
	local flag = false
	repeat
		local stringThing = ""

		local length = math.random(5,40)

		for i = 1,length do
			stringThing = stringThing..string.char(math.random(70, 122))
		end

		if not thingsInTabs[stringThing] then
			key = stringThing
			flag = true
		end
		task.wait(0)
	until flag == true
	thingsInTabs[key] = {tab, parent, typeObject, typeData, amtofobjects}
	return key
end

guiAPI.refreshWindow = function(window)
	updateInfo(window)
end

local holdingGUI = nil
local holdingGUIOffset = nil
inputServ.InputBegan:Connect(function(input, gameproc)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if holdingGUI == nil then
			local pos = Vector2.new(mouse.X, mouse.Y)
			local gotGUIs = newScreenGUI.Parent:GetGuiObjectsAtPosition(pos.X,pos.Y)

			for i,guiObject in pairs(gotGUIs) do
				if holdingGUI == nil then
					if table.find(moveableWindows, guiObject) then
						holdingGUI = guiObject
						holdingGUIOffset = guiObject.AbsolutePosition - pos
					end
				end
			end
		end
	end
end)

inputServ.InputEnded:Connect(function(input, gameproc)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if holdingGUI then
			holdingGUI = nil
			holdingGUIOffset = nil
		end
	end
end)

runServ.RenderStepped:Connect(function()
	if holdingGUI and holdingGUIOffset then
		local mousepos = Vector2.new(mouse.X, mouse.Y)

		holdingGUI.Position = UDim2.fromOffset(mousepos.X + holdingGUIOffset.X, mousepos.Y + holdingGUIOffset.Y)
	end
end)

return guiAPI