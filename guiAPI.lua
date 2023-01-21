local module = {}
	
local plrs = game:GetService("Players")

_G.guiElementsStoredDcBp = {}
_G.currentRenderedDcBp = {}
_G.renderedUseForChildrenDcBp = {}
_G.colorThemesDcBp = {}

local setting = "normal"
if syn then
    setting = "synapse"
end

_G.screenGUI = Instance.new("ScreenGui")
_G.screenGUI.IgnoreGuiInset = true
_G.screenGUI.ResetOnSpawn = false
_G.screenGUI.Parent = plrs.LocalPlayer.PlayerGui

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
        table.insert(_G.currentRenderedDcBp, draw)
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
        draw.PointA = topleft
        draw.PointB = topright
        draw.PointC = bleft
        draw.PointD = bright
        table.insert(_G.currentRenderedDcBp, draw)
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
    _G.colorThemesDcBp[name] = newTheme
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

        if not _G.guiElementsStoredDcBp[stringThing] then
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
        ["position"] = Vector2.new(_G.screenGUI.AbsoluteSize.X/2,_G.screenGUI.AbsoluteSize.Y/2),
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
    table.insert(_G.guiElementsStoredDcBp, newTable)
    local funcs = {}
    funcs.getFullName = function()
        return totalvals["fullname"]
    end
    funcs.getTopBarName = function()
        return totalvals["fullname"].."TopBar"
    end
    funcs.remove = function()
        for i,v in pairs(_G.guiElementsStoredDcBp) do
            if v[2]["fullname"] == totalvals["fullname"] then
                table.remove(_G.guiElementsStoredDcBp, i)
            end
        end
    end
    return funcs
end

module.clear = function()
    if setting == "normal" then
        for i,v in pairs(_G.currentRenderedDcBp) do
            v:Destroy()
        end
    elseif setting == "synapse" then
        for i,v in pairs(_G.currentRenderedDcBp) do
            v.Remove()
        end
    else
        
    end
    _G.currentRenderedDcBp = {}
    _G.renderedUseForChildrenDcBp = {}
    return
end
module.render = function()
    local absoluteX = _G.screenGUI.AbsoluteSize.X
    local absoluteY = _G.screenGUI.AbsoluteSize.Y
    for i,v in pairs(_G.guiElementsStoredDcBp) do
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
            if v[2]["theme"] ~= "" and _G.colorThemesDcBp[v[2]["theme"]] ~= nil then
                borderColor = _G.colorThemesDcBp[v[2]["theme"]]["border"]
                mainColor = _G.colorThemesDcBp[v[2]["theme"]]["windowcolor"]
                topBarColor = _G.colorThemesDcBp[v[2]["theme"]]["windowtopcolor"]
            end 

            local pointul = Vector2.new(pos.X - (sizex * antianchor.X), pos.Y - (sizey * anchor.Y))
            local pointur = Vector2.new(pos.X + (sizex * anchor.X), pos.Y - (sizey * anchor.Y))
            local pointdl = Vector2.new(pos.X - (sizex * antianchor.X), pos.Y + (sizey * antianchor.Y))
            local pointdr = Vector2.new(pos.X + (sizex * anchor.X), pos.Y + (sizey * antianchor.Y))

            local topLeftTab =  Vector2.new(pos.X - ((sizex * antianchor.X) - 20), pointul.Y - ((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset))
            local topRightTab =  Vector2.new(pos.X + (sizex * anchor.X), pointul.Y - ((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset))

            drawQuad(mainColor, z, 0.1, true, 1, pointul, pointur, pointdl, pointdr)
            drawQuad(topBarColor, z, 0.1, true, 1, topLeftTab, topRightTab, pointul, pointur)
            
            local borderThickness = 4
            drawLine(borderColor, z+0.1, 0, borderThickness, pointul, topLeftTab)
            drawLine(borderColor, z+0.1, 0, borderThickness, topLeftTab, topRightTab)
            drawLine(borderColor, z+0.1, 0, borderThickness, topRightTab, pointdr)
            drawLine(borderColor, z+0.1, 0, borderThickness, pointdr, pointdl)
            drawLine(borderColor, z+0.1, 0, borderThickness, pointdl, pointul)
            
            local topBarPosition = Vector2.new(pointul:Lerp(pointur, 0.5).X, (pos.Y - (sizey * anchor.Y)) - (((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset) / 2))
            _G.renderedUseForChildrenDcBp[v[2]["fullname"]] = {z, pos, Vector2.new(sizex, sizey)}
            _G.renderedUseForChildrenDcBp[v[2]["fullname"].."TopBar"] = {z, topBarPosition, Vector2.new(sizex, (absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset)}
        else
            
        end
    end
    return
end

local runserv = game:GetService("RunService")
runserv.RenderStepped:Connect(function(delta)
    module.clear()
    module.render()
end)

return module
