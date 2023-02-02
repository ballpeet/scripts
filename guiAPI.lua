local module = {}
	
local plrs = game:GetService("Players")

getgenv().guiElementsStoredDcBp = {}
getgenv().currentRenderedDcBp = {}
getgenv().renderedUseForChildrenDcBp = {}
getgenv().colorThemesDcBp = {}
getgenv().queueForNextRenderDcBp = {}
getgenv().savingVariablesDcBp = {}

local setting = "normal"
if syn then
    setting = "synapse"
end
if getfpscap then
    setting = "scriptwr"
end
local seperatorForParents = "/1.<251/"

local mouse = plrs.LocalPlayer:GetMouse()

local function drawLine(color, z, transparency, tness, start, endp)
    if setting == "scriptwr" then
        local draw = Drawing.new("Line")
        draw.Visible = true
        draw.ZIndex = z
        draw.Transparency = transparency
        draw.Color = color
        draw.Thickness = tness
        draw.From = start
        draw.To = endp
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

local function drawPoint(color, z, transparency, pos, tness, radius, filled)
    if setting == "scriptwr" then
        local draw = Drawing.new("Circle")
        draw.Visible = true
        draw.ZIndex = z
        draw.Transparency = transparency
        draw.Color = color
        draw.Thickness = tness
        draw.Radius = radius
        draw.NumSides = 15
        draw.Filled = filled
        draw.Position = pos
    elseif setting == "synapse" then
        local draw = Drawing.new("Circle")
        draw.Visible = true
        draw.ZIndex = z
        draw.Transparency = transparency
        draw.Color = color
        draw.Thickness = tness
        draw.Radius = radius
        draw.NumSides = 15
        draw.Filled = filled
        draw.Position = pos

        table.insert(getgenv().currentRenderedDcBp, draw)
    else
        
    end
    return
end

local function drawQuad(color, z, transparency, filled, tness, topleft, topright, bleft, bright)
    if setting == "scriptwr" then
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

local function drawImage(z, transparency, size, pos, data)
    if setting == "scriptwr" then
        local draw = Drawing.new("Image")
        draw.Visible = true
        draw.ZIndex = z
        draw.Transparency = transparency
        draw.Data = data
        draw.Size = size
        draw.Position = pos
    elseif setting == "synapse" then
        local draw = Drawing.new("Image")
        draw.Visible = true
        draw.ZIndex = z
        draw.Transparency = transparency
        draw.Data = data
        draw.Size = size
        draw.Position = pos
        table.insert(getgenv().currentRenderedDcBp, draw)
    else

    end
    return
end

module.newTheme = function(colorTable, name)
    local newTheme = {
        ["border"] = Color3.new(0,0,0),
        ["borderpoint"] = Color3.new(0,0,0),
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
        ["position"] = Vector2.new(game.Workspace.Camera.ViewportSize.X/2,game.Workspace.Camera.ViewportSize.Y/2),
        ["z"] = 1,
        ["parent"] = "",
        ["enabled"] = true,
        ["theme"] = "",
    }
    if variables then
        for i,v in pairs(variables) do
            totalvals[i] = v
        end
    end
    totalvals["fullname"] = totalvals["parent"]..seperatorForParents..totalvals["name"]
    
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
    funcs.disable = function()
        for i,v in pairs(getgenv().guiElementsStoredDcBp) do
            if v[2]["fullname"] == totalvals["fullname"] then
                getgenv().guiElementsStoredDcBp[i][2]["enabled"] = false
            end
        end
    end
    funcs.enable = function()
        for i,v in pairs(getgenv().guiElementsStoredDcBp) do
            if v[2]["fullname"] == totalvals["fullname"] then
                getgenv().guiElementsStoredDcBp[i][2]["enabled"] = true
            end
        end
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
    if setting == "scriptwr" then
        cleardrawcache()
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
local inputserv = game:GetService("UserInputService")
module.render = function()
    local mousePos = Vector2.new(mouse.X, mouse.Y + 36)
    drawPoint(Color3.fromRGB(255,255,255), 10, 1, mousePos, 1, 10, true)

    local absoluteX = game.Workspace.Camera.ViewportSize.X
    local absoluteY = game.Workspace.Camera.ViewportSize.Y
    for i,v in pairs(getgenv().guiElementsStoredDcBp) do
        if v[1] == "window" then
            local sizex = (absoluteX * v[2]["size"].X.Scale) + v[2]["size"].X.Offset
            local sizey = (absoluteY * v[2]["size"].Y.Scale) + v[2]["size"].Y.Offset
            
            local z = v[2]["z"]
            local pos = v[2]["position"]
            local anchor = v[2]["anchor"]
            local antianchor = Vector2.new(1 - v[2]["anchor"].X, 1 - v[2]["anchor"].Y)

            for i2, found in pairs(getgenv().savingVariablesDcBp) do
                if found[2] == "windowDrag" and found[1] == v[2]["fullname"].."TopBar" then
                    local posToGoTo = (mousePos - found[3][1]) + (Vector2.new(0,(sizey * anchor.Y) + (((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset) / 2)))
                    local new = pos:Lerp(posToGoTo, 0.6)

                    getgenv().guiElementsStoredDcBp[i][2]["position"] = new
                    pos = new
                end
            end
            
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
            local topRightTab =  Vector2.new(pos.X + ((sizex * anchor.X) - 20), pointul.Y - ((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset))

            drawQuad(mainColor, z, 1, true, 10, pointul, pointur, pointdl, pointdr)
            drawQuad(topBarColor, z + 200, 1, true, 10, topLeftTab, topRightTab, pointul, pointur)
            if v[2]["imagebackground"] ~= nil then
                drawImage(z + 0.1, 0.8, Vector2.new(sizex, sizey), pointul, v[2]["imagebackground"])
            end
            
            local borderThickness = 5

            drawLine(borderColor, z+200, 1, borderThickness, pointul, topLeftTab)
            drawLine(borderColor, z+200, 1, borderThickness, topLeftTab, topRightTab)
            drawLine(borderColor, z+200, 1, borderThickness, topRightTab, pointur)
            drawLine(borderColor, z+200, 1, borderThickness, pointur, pointdr)
            drawLine(borderColor, z+200, 1, borderThickness, pointdr, pointdl)
            drawLine(borderColor, z+200, 1, borderThickness, pointdl, pointul)

            drawPoint(borderColor, z+200, 1, pointul, 0, borderThickness/2, true)
            drawPoint(borderColor, z+200, 1, pointur, 0, borderThickness/2, true)
            drawPoint(borderColor, z+200, 1, pointdl, 0, borderThickness/2, true)
            drawPoint(borderColor, z+200, 1, pointdr, 0, borderThickness/2, true)
            drawPoint(borderColor, z+200, 1, topLeftTab, 0, borderThickness/2, true)
            drawPoint(borderColor, z+200, 1, topRightTab, 0, borderThickness/2, true)
            
            local topBarPosition = Vector2.new(pointul:Lerp(pointur, 0.5).X, (pos.Y - (sizey * anchor.Y)) - (((absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset) / 2))

            getgenv().renderedUseForChildrenDcBp[v[2]["fullname"]] = {z, pointul:Lerp(pointdr, 0.5), Vector2.new(sizex, sizey), "windowFramme"}
            getgenv().renderedUseForChildrenDcBp[v[2]["fullname"].."TopBar"] = {z, topBarPosition, Vector2.new(sizex, (absoluteY * v[2]["topbarwidth"].Scale) + v[2]["topbarwidth"].Offset), "windowTop"}
        else
            
        end
    end

    for i,v in pairs(getgenv().queueForNextRenderDcBp) do
        if v == "click" then
            local mouseHovering = {}
            for i2, renderItem in pairs(getgenv().renderedUseForChildrenDcBp) do
                local offset = Vector2.new(mousePos.X - renderItem[2].X, mousePos.Y - renderItem[2].Y)

                if math.abs(offset.X) < math.abs(renderItem[3].X/2) and math.abs(offset.Y) < math.abs(renderItem[3].Y/2) then
                    mouseHovering[i2] = {offset, renderItem}
                end

            end

            local best = nil
            local bestname = nil
            local offsetbest = nil
            local bestz = nil
            for i2, renderItem in pairs(mouseHovering) do
                if not bestz then
                    best = renderItem[2]
                    bestz = renderItem[2][1]
                    offsetbest = renderItem[1]
                    bestname = i2
                else
                    if bestz < renderItem[2][1] then
                        best = renderItem[2]
                        bestz = renderItem[2][1]
                        offsetbest = renderItem[1]
                        bestname = i2
                    end
                end
            end

            if best then
                if best[4] == "windowTop" then
                    local subname = string.sub(bestname, string.len(bestname) - 5, string.len(bestname))
                    if subname == "TopBar" then
                        print("inside")
        
                        table.insert(getgenv().savingVariablesDcBp, {bestname, "windowDrag", {offsetbest}})
                    end
                end
            end
        elseif v == "clickend" then
            local offset = 0
            for i2, found in pairs(getgenv().savingVariablesDcBp) do
                if found[2] == "windowDrag" then
                    table.remove(getgenv().savingVariablesDcBp, i2 - offset)
                    offset = offset + 1
                end
            end
        end
    end
    getgenv().queueForNextRenderDcBp = {}
    return
end

local runserv = game:GetService("RunService")
runserv.PreRender:Connect(function(delta)
    module.clear()
    module.render()
end)

inputserv.InputBegan:Connect(function(input, gameproc)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        table.insert(getgenv().queueForNextRenderDcBp, "click")
    else

    end
end)
inputserv.InputEnded:Connect(function(input, gameproc)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        table.insert(getgenv().queueForNextRenderDcBp, "clickend")
    else

    end
end)

return module
