local module = {}
	
local plrs = game:GetService("Players")

getgenv().guiElementsStoredDcBp = {}
getgenv().currentRenderedDcBp = {}
getgenv().renderedUseForChildrenDcBp = {}
getgenv().colorThemesDcBp = {}

local setting = "normal"
if syn then
    setting = "synapse"
end

getgenv().screenGUI = Instance.new("ScreenGui")
getgenv().screenGUI.IgnoreGuiInset = true
getgenv().screenGUI.ResetOnSpawn = false
getgenv().screenGUI.Parent = plrs.LocalPlayer.PlayerGui

local function drawLine(color, z, transparency, tness, start, endp)
    if setting == "normal" then

    elseif setting == "synapse" then
        local draw = Drawing.new("Line")
        draw.Visible = true
        draw.ZIndex = z
        draw.Transparency = transparency
        draw.Color = color
        draw.Thickness = tness
        draw.From = start
        draw.To = endp
        table.insert(getgenv().currentRenderedDcBp, draw)
    else
        
    end
    return
end

local function drawQuad(color, z, transparency, filled, tness, topleft, topright, bleft, bright)
    if setting == "normal" then

    elseif setting == "synapse" then
        local draw = Drawing.new("Quad")
        draw.Visible = true
        draw.ZIndex = z
        draw.Transparency = transparency
        draw.Color = color
        draw.Filled = filled
        draw.Thickness = tness
        draw.PointA = topright
        draw.PointB = topleft
        draw.PointC = bleft
        draw.PointD = bright
        table.insert(getgenv().currentRenderedDcBp, draw)
    else

    end
    return
end

module.newTheme = function(colorTable, name)
    local newTheme = {
        ["border"] = Color3.new(0,0,0),
        ["windowcolor"] = Color3.new(0,0,0),
        ["windowtopcolor"] = Color3.new(0,0,0),
    }
    if colorTable then
        for i,v in pairs(colorTable) do
            newTheme[i] = v
        end
    end
    getgenv().colorThemesDcBp[name] = newTheme
    return
end
module.newKey = function()
    local key = ""
    local flag = false
    repeat
        local stringThing = ""

        local length = math.random(5,10)

        for i = 1,length do
            stringThing = stringThing..string.char(math.random(70, 122))
        end

        if not getgenv().guiElementsStoredDcBp[stringThing] then
            key = stringThing
            flag = true
        end
        task.wait(0)
    until flag == true
    return key
end

module.newWindow = function(variables)
    local totalvals = {
        ["size"] = UDim2.new(0.2,0,0.4,0),
        ["topbarwidth"] = UDim.new(0.025,0),
        ["name"] = "Window",
        ["label"] = "Label Text",
        ["anchor"] = Vector2.new(0.5,0.5),
        ["draggable"] = true,
        ["position"] = Vector2.new(getgenv().screenGUI.AbsoluteSize.X/2,getgenv().screenGUI.AbsoluteSize.Y/2),
        ["z"] = 1,
        ["parent"] = "",
        ["theme"] = ""
    }
    if variables then
        for i,v in pairs(variables) do
            totalvals[i] = v
        end
    end
    totalvals["fullname"] = totalvals["parent"].."/"..totalvals["name"]
    
    local newTable = {
        "window", totalvals
    }
    table.insert(getgenv().guiElementsStoredDcBp, newTable)
    local funcs = {}
    funcs.getFullName = function()
        return totalvals["fullname"]
    end
    funcs.getTopBarName = function()
        return totalvals["fullname"].."TopBar"
    end
    funcs.remove = function()
        for i,v in pairs(getgenv().guiElementsStoredDcBp) do
            if v[2]["fullname"] == totalvals["fullname"] then
                table.remove(getgenv().guiElementsStoredDcBp, i)
            end
        end
    end
    return funcs
end

module.clear = function()
    if setting == "normal" then
        for i,v in pairs(getgenv().currentRenderedDcBp) do
            v:Destroy()
        end
    elseif setting == "synapse" then
        for i,v in pairs(getgenv().currentRenderedDcBp) do
            v.Remove()
        end
    else
        
    end
    getgenv().currentRenderedDcBp = {}
    getgenv().renderedUseForChildrenDcBp = {}
    return
end
module.render = function()
    local absoluteX = getgenv().screenGUI.AbsoluteSize.X
    local absoluteY = getgenv().screenGUI.AbsoluteSize.Y
    for i,v in pairs(getgenv().guiElementsStoredDcBp) do
        if v[1] == "window" then
            local sizex = (absoluteX * v[2]["size"].X.Scale) + v[2]["size"].X.Offset
            local sizey = (absoluteY * v[2]["size"].Y.Scale) + v[2]["size"].Y.Offset
            
            local z = v[2]["z"]
            local pos = v[2]["position"]
            local anchor = v[2]["anchor"]
            local antianchor = Vector2.new(1 - v[2]["anchor"].X, 1 - v[2]["anchor"].Y)
            
            local borderColor = Color3.fromRGB(200,50,50)
            local mainColor = Color3.fromRGB(75,75,75)
            local topBarColor = Color3.fromRGB(25,25,25)
            if v[2]["theme"] ~= "" and getgenv().colorThemesDcBp[v[2]["theme"]] ~= nil then
                borderColor = getgenv().colorThemesDcBp[v[2]["theme"]]["border"]
                mainColor = getgenv().colorThemesDcBp[v[2]["theme"]]["windowcolor"]
                topBarColor = getgenv().colorThemesDcBp[v[2]["theme"]]["windowtopcolor"]
            end 

            local pointul = Vector2.new(pos.X - (sizex * antianchor.X), pos.Y - (sizey * anchor.Y))
            local pointur = Vector2.new(pos.X + (sizex * anchor.X), pos.Y - (sizey * anchor.Y))
            local pointdl = Vector2.new(pos.X - (sizex * antianchor.X), pos.Y + (sizey * antianchor.Y))
            local pointdr = Vector2.new(pos.X + (sizex * anchor.X), pos.Y + (sizey * antianchor.Y))

            local topLeftTab =  Vector2.new(pos.X - ((sizex * antianchor.X) - 20), pointul.Y - ((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset))
            local topRightTab =  Vector2.new(pos.X + (sizex * anchor.X), pointul.Y - ((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset))

            drawQuad(mainColor, z, 0.9, true, 10, pointul, pointur, pointdl, pointdr)
            drawQuad(topBarColor, z, 0.9, true, 10, topLeftTab, topRightTab, pointul, pointur)
            
            local borderThickness = 4
            drawLine(borderColor, z+0.1, 1, borderThickness, pointul, topLeftTab)
            drawLine(borderColor, z+0.1, 1, borderThickness, topLeftTab, topRightTab)
            drawLine(borderColor, z+0.1, 1, borderThickness, topRightTab, pointdr)
            drawLine(borderColor, z+0.1, 1, borderThickness, pointdr, pointdl)
            drawLine(borderColor, z+0.1, 1, borderThickness, pointdl, pointul)
            
            local topBarPosition = Vector2.new(pointul:Lerp(pointur, 0.5).X, (pos.Y - (sizey * anchor.Y)) - (((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset) / 2))
            getgenv().renderedUseForChildrenDcBp[v[2]["fullname"]] = {z, pos, Vector2.new(sizex, sizey)}
            getgenv().renderedUseForChildrenDcBp[v[2]["fullname"].."TopBar"] = {z, topBarPosition, Vector2.new(sizex, (absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset)}
        else
            
        end
    end
    return
end

local runserv = game:GetService("RunService")
local tally = 0
runserv.RenderStepped:Connect(function(delta)
    tally = math.fmod(tally + 1, 3)
    if tally == 1 then
        module.clear()
        module.render()
    end
end)

return module
