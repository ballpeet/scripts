local clickDmg = 5

local barrageCool = true
local barrageCoolLength = 1
local barrageLength = 0
local barragedmg = 8
local strongPunchCool = true
local strongPunchCoolLength = 1
local strongPunchDmg = 500
local standJumpCool = true
local StandJumpCoolLength = 0.25

local mysteryCool = true
local mysteryCoolLength = 1
local mysteryDmg = 5000

local standTimer = 0

_G.truespeedmult = 1
local players = game:GetService("Players")
local player = players.LocalPlayer
local l__Parent__1 = players.LocalPlayer
local l__Character__3 = l__Parent__1.Character;
for i,v in pairs(player.Backpack:GetChildren()) do
	if v.Name ~= "ClientHandler" and v.Name ~= "CustomPose" then
		v:Destroy()
	end
end
local plrgui = player.PlayerGui
local l__cooldowns__1 = plrgui:WaitForChild("cooldowns");
_G.indicatecooldown = function(p1, p2)
	local v11 = l__cooldowns__1.movecd:Clone();
	local v12 = math.max(0, #l__cooldowns__1:GetChildren() - 1);
	if v12 >= 10 then
		v11.Position = UDim2.new(0.11, 0, 0.285 + 0.1 * (v12 - 10), 0);
	elseif v12 >= 5 and v12 < 10 then
		v11.Position = UDim2.new(0.066, 0, 0.285 + 0.1 * (v12 - 5), 0);
	else
		v11.Position = UDim2.new(0.024, 0, 0.285 + 0.1 * v12, 0);
	end;
	v11.Text = p1;
	v11.length.Value = p2;
	v11.start.Value = tick();
	v11.Name = p1;
	v11.numberprogress.Text = tostring(p2);
	v11.Visible = true;
	v11.Parent = l__cooldowns__1;
end
local totalWrap = coroutine.create(function ()
    local l__mouse__2 = l__Parent__1:GetMouse();
    while true do
        wait();
        if l__Parent__1.Character then
            break;
        end;
    end;
    local l__CurrentCamera__4 = workspace.CurrentCamera;
    local l__PlayerGui__5 = l__Parent__1:WaitForChild("PlayerGui");
    local l__Humanoid__6 = l__Character__3:WaitForChild("Humanoid");
    table.foreach(l__Humanoid__6:GetPlayingAnimationTracks(), function(p1, p2)
        p2:Stop();
    end);
    if l__Character__3:FindFirstChild("Animate") then
        l__Character__3:FindFirstChild("Animate"):Destroy();
    end;
    local l__Container__7 = l__Character__3.Head:WaitForChild("Container");
    local l__silenced__8 = l__Character__3:WaitForChild("silenced");
    local l__woosh__9 = l__Character__3.Torso:WaitForChild("woosh");
    
    local VoicelineToModify = l__Character__3.Torso:WaitForChild("voiceline")
    local l__voiceline__10 = l__Character__3.Torso

    local l__Menacing__11 = l__Character__3.Torso:WaitForChild("Menacing");
    local l__summonstand__12 = l__Character__3.Torso:WaitForChild("summonstand");
    local l__UserInputService__13 = game:GetService("UserInputService");
    local l__sendjoints__14 = game:GetService("ReplicatedStorage").Logic.sendjoints;
    local l__receivejoints__15 = game:GetService("ReplicatedStorage").Logic.receivejoints;
    local l__hitbox__16 = game:GetService("ReplicatedStorage").Logic.hitbox;
    local l__misc__17 = game:GetService("ReplicatedStorage").Logic.misc;
    local l__createfakearmevent__18 = game:GetService("ReplicatedStorage").Specials.createfakearmevent;


    local repStorage = game:GetService("ReplicatedStorage")
    local specials = repStorage.Specials
    local logic = repStorage.Logic

    local rtremor = specials.rtremor
    --  cf, dmg, voiceline, sound
    local nuke = specials.nukeevent
    -- cf, dmg, voiceline, sound
    local nuclearwarhead = specials.nwarhead
    -- cfstart, cftowards, dmg, voiceline, sound

    -- crazytrain e = 106
    -- crazytrain r = 113

    local manualStop = false
    local setvoic = game.ReplicatedStorage.Logic.setvoiceline
    local function startSound(id, pitch, loop)
        local soundcor = coroutine.wrap(function ()
            local waitingFor = "rbxassetid://"..tostring(id)
            manualStop = false
            if not loop then
                loop = false
            end
            setvoic:FireServer(tostring(id))
            local waitingTally = 0
            repeat
                task.wait(0.1)
                waitingTally = waitingTally + 1
            until VoicelineToModify.SoundId == waitingFor or waitingTally > 30
            if VoicelineToModify.SoundId == waitingFor then
                l__misc__17:FireServer(2, VoicelineToModify, pitch);
                l__misc__17:FireServer(1, VoicelineToModify, 0)
        
                if loop == true then
                    local connection = nil
                    connection = VoicelineToModify.Ended:Connect(function()
                        if VoicelineToModify.SoundId ~= waitingFor then
                            connection:Disconnect()
                        else
                            if manualStop == false then
                                l__misc__17:FireServer(1, VoicelineToModify, 0)
                            else
                                connection:Disconnect()
                            end
                        end
                    end)
                end
            end
        end)
        soundcor()
    end

    local function stopSound()
        manualStop = true
        l__misc__17:FireServer(1, VoicelineToModify, 1)
    end

    local v19 = 1;
    if l__Parent__1:WaitForChild("Blessing").Value == "Holy" then
        v19 = 0.7;
    end;
    l__misc__17:FireServer(5, l__Humanoid__6, 16);
    local l__Stand__20 = l__Container__7:WaitForChild("Stand");
    if l__Parent__1:WaitForChild("IsHamon").Value == true then
        ScreenGui0 = Instance.new("ScreenGui");
        ImageLabel1 = Instance.new("ImageLabel");
        ImageLabel2 = Instance.new("ImageLabel");
        ScreenGui0.Name = "HamonCharge";
        ScreenGui0.Parent = l__Parent__1.PlayerGui;
        ImageLabel1.Name = "BarFront";
        ImageLabel1.Parent = ScreenGui0;
        ImageLabel1.Transparency = 1;
        ImageLabel1.Size = UDim2.new(0, 0, 0, 20);
        ImageLabel1.Position = UDim2.new(0.449999988, 0, 0.850000024, 0);
        ImageLabel1.BackgroundColor3 = Color3.new(1, 1, 1);
        ImageLabel1.BackgroundTransparency = 1;
        ImageLabel1.ZIndex = 2;
        ImageLabel1.Image = "rbxassetid://1061605343";
        ImageLabel2.Name = "BarBack";
        ImageLabel2.Parent = ScreenGui0;
        ImageLabel2.Size = UDim2.new(0, 200, 0, 20);
        ImageLabel2.Position = UDim2.new(0.449999988, 0, 0.850000024, 0);
        ImageLabel2.BackgroundColor3 = Color3.new(1, 1, 1);
        ImageLabel2.BorderColor3 = Color3.new(0, 0, 0);
        ImageLabel2.BorderSizePixel = 2;
        ImageLabel2.Image = "rbxassetid://1061605343";
        ImageLabel2.ImageColor3 = Color3.new(0.27451, 0.27451, 0.27451);
    end;

    local v25 = {};
    local StandJoints = { l__Stand__20:WaitForChild("Torso").Neck, l__Stand__20:WaitForChild("Torso")["Left Shoulder"], l__Stand__20:WaitForChild("Torso")["Right Shoulder"], l__Stand__20:WaitForChild("Torso")["Left Hip"], l__Stand__20:WaitForChild("Torso")["Right Hip"] };
    local StandTorsoMain = l__Stand__20:WaitForChild("Torso");
    local TorsoOrig = CFrame.new(0, 0, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0);
    local HeadOrig = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0);
    local LeftArmOrig = CFrame.new(-1, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0);
    local RightArmOrig = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0);
    local LeftLegOrig = CFrame.new(-1, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0);
    local RightLegOrig = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0);



    l__Humanoid__6.WalkSpeed = 20;
    local v35 = false;
    local v36 = true;
    local v37 = nil;
    local v38 = nil;
    if l__Parent__1:WaitForChild("IsHamon").Value == true then
        v38 = StandTorsoMain:WaitForChild("Light");
        v37 = StandTorsoMain:WaitForChild("Glow");
    end;
    local u1 = false;
    function randomangle(p3)
        if not p3 then
            return math.random(-6.283185307179586, 6.283185307179586);
        end;
        return math.random(math.rad(-p3), math.rad(p3));
    end;
    function GetAxis(p4, p5)
        local v39 = { (p4[2] - p4[1]).unit, (p4[3] - p4[1]).unit, (p4[5] - p4[1]).unit, (p5[2] - p5[1]).unit, (p5[3] - p5[1]).unit, (p5[5] - p5[1]).unit };
        v39[7] = v39[1]:Cross(v39[4]).unit;
        v39[8] = v39[1]:Cross(v39[5]).unit;
        v39[9] = v39[1]:Cross(v39[6]).unit;
        v39[10] = v39[2]:Cross(v39[4]).unit;
        v39[11] = v39[2]:Cross(v39[5]).unit;
        v39[12] = v39[2]:Cross(v39[6]).unit;
        v39[13] = v39[3]:Cross(v39[4]).unit;
        v39[14] = v39[3]:Cross(v39[5]).unit;
        v39[15] = v39[3]:Cross(v39[6]).unit;

        return v39;
    end;
    function TestAxis(corners1,corners2,axis,surface)
        if axis.Magnitude == 0 or tostring(axis) == "NAN, NAN, NAN" then
            return true;
        end
        local adists, bdists = {},{}
        for i = 1, 8 do
            table.insert(adists, corners1[i]:Dot(axis))
            table.insert(bdists, corners2[i]:Dot(axis))
        end
        local amax, amin = math.max(unpack(adists)), math.min(unpack(adists))
        local bmax, bmin = math.max(unpack(bdists)), math.min(unpack(bdists))
        local longspan = math.max(amax, bmax) - math.min(amin, bmin)
        local sumspan = amax - amin + bmax - bmin
        local pass,mtv
        if surface then
            pass = longspan <= sumspan
        else
            pass = longspan < sumspan
        end
        if pass then
            local overlap = amax > bmax and -(bmax - amin) or (amax - bmin)
            mtv = axis*overlap
        end
        return pass,mtv;
    end;
    function GetCorners(framepos,size)
        local size,corners = size/2,{}
        for x = -1, 1, 2 do
            for y = -1, 1, 2 do
                for z = -1, 1, 2 do
                    table.insert(corners,(framepos*CFrame.new(size * Vector3.new(x, y, z))).p)
                end
            end
        end
        return corners;
    end;
    function NewRegion(framepos,size)
        local region = setmetatable({}, {__index = {}})
        region.surfaceCountsAsCollision = true
        region.cframe = framepos
        region.size = size
        region.planes = {}
        region.corners = GetCorners(region.cframe,region.size)
        for _, enum in next, Enum.NormalId:GetEnumItems() do
            local lnormal = Vector3.FromNormalId(enum)
            local wnormal = region.cframe:vectorToWorldSpace(lnormal)
            local distance = (lnormal*region.size/2).magnitude
            local point = region.cframe.p + wnormal * distance
            table.insert(region.planes,{normal = wnormal,point = point})
        end	
        return region;
    end;
    function ShallowCopy(t)
        local nt = {}
        for k, v in next, t do
            nt[k] = v;
        end
        return nt;
    end;
    function CastPart(part,region)
        local corners1 = region.corners;
        local corners2 = GetCorners(part.CFrame, part.Size)
        local axis, mtvs = GetAxis(corners1,corners2),{}
        for i = 1, #axis do
            local intersect, mtv = TestAxis(corners1, corners2, axis[i], region.surfaceCountsAsCollision);
            if not intersect then return false, Vector3.new(); end;
            if mtv then table.insert(mtvs, mtv) end
        end
        table.sort(mtvs, function(a, b) return a.magnitude < b.magnitude; end);
        return true, mtvs[1]
    end;
    function CastRegion(ignore,maxParts,region)
        local ignore = type(ignore) == "table" and ignore or {ignore}
        local maxParts = maxParts or 20
        local rmin,rmax = {},{}
        local copy = ShallowCopy(region.corners)
        for _, enum in next, {Enum.NormalId.Right,Enum.NormalId.Top,Enum.NormalId.Back} do
            local lnormal = Vector3.FromNormalId(enum)
            table.sort(copy,function(a, b) return a:Dot(lnormal) > b:Dot(lnormal) end)
            table.insert(rmin,copy[#copy])
            table.insert(rmax,copy[1])
        end
        rmin,rmax = Vector3.new(rmin[1].x, rmin[2].y, rmin[3].z), Vector3.new(rmax[1].x,rmax[2].y,rmax[3].z)
        local realRegion3 = Region3.new(rmin,rmax)
        local parts = game.Workspace:FindPartsInRegion3WithIgnoreList(realRegion3,ignore,maxParts)
        local inRegion = {}
        for _, part in next, parts do
            if CastPart(part,region) then
                table.insert(inRegion,part)
            end
        end
        return inRegion;
    end;
    if workspace.timestopped.Value == true and workspace.timestopper.Value ~= l__Parent__1.Name then

    end;
    game:GetService("ReplicatedStorage").Specials.receiveheartattack.OnClientEvent:connect(function(p24, p25, p26)
        if p25 then
            p25.CFrame = p26;
        end;
    end);
    local AnimValue = 0;
    local u6 = 0;
    local AttackingValue = false;
    local AnimKeyframe = 0;
    local u9 = true;
    local Speed = 0.02;
    game:GetService("ReplicatedStorage").Logic.stopgrab.OnClientEvent:connect(function()

    end);
    l__receivejoints__15.OnClientEvent:connect(function(p27, p28, p29, p30)
        if p27 and p27 ~= l__Parent__1 and p27.Character:FindFirstChild("HumanoidRootPart") and p27.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("RootJoint") then
            p27.Character.HumanoidRootPart.RootJoint.C0 = p28[1];
            p27.Character.Torso.Neck.C0 = p28[2];
            p27.Character.Torso["Left Shoulder"].C0 = p28[3];
            p27.Character.Torso["Right Shoulder"].C0 = p28[4];
            p27.Character.Torso["Left Hip"].C0 = p28[5];
            p27.Character.Torso["Right Hip"].C0 = p28[6];
            if p27.Character.Head:FindFirstChild("Container") and (p27.Character.Head.Container:FindFirstChild("fakearm") and p28[7]) then
                p27.Character.Head.Container:FindFirstChild("fakearm").CFrame = p28[7];
                p27.Character.Head.Container:FindFirstChild("fakearm").Size = p28[8];
            end;
            if p29 and p30 then
                p30.CFrame = p29[1];
                p30.Neck.C0 = p29[2];
                p30["Left Shoulder"].C0 = p29[3];
                p30["Right Shoulder"].C0 = p29[4];
                p30["Left Hip"].C0 = p29[5];
                p30["Right Hip"].C0 = p29[6];
                if p27.Character.Head.Container:FindFirstChild("fakearm") and p29[7] then
                    p27.Character.Head.Container:FindFirstChild("fakearm").CFrame = p29[7];
                    p27.Character.Head.Container:FindFirstChild("fakearm").Size = p29[8];
                    p27.Character.Head.Container:FindFirstChild("fakearmpart").CFrame = p29[9];
                    p27.Character.Head.Container:FindFirstChild("fakearmpart").Size = p29[10];
                end;
            end;
        end;
    end);
    local u11 = v35;
    local u12 = 0;
    local u13 = 0;
    local u14 = false;
    local u15 = false;
    local u16 = false;
    local u17 = 0;
    local u18 = 0;
    local u19 = 1;
    local u20 = 0;
    local PlayerJoints = { l__Character__3.HumanoidRootPart.RootJoint, l__Character__3.Torso.Neck, l__Character__3.Torso["Left Shoulder"], l__Character__3.Torso["Right Shoulder"], l__Character__3.Torso["Left Hip"], l__Character__3.Torso["Right Hip"] };
    local u22 = 0;
    local u23 = false;
    local u24 = true;
    game:GetService("RunService").Heartbeat:connect(function(p31)
        if l__Humanoid__6.Health > 0 then
            u22 = u22 + 0.02
            u12 = u12 + 1;
            if u12 % 5 == 0 then
                local l__fakearm__91 = l__Container__7:FindFirstChild("fakearm");
                local l__fakearmpart__92 = l__Container__7:FindFirstChild("fakearmpart");
                if not l__fakearm__91 then
                    l__sendjoints__14:FireServer({ l__Character__3.HumanoidRootPart.RootJoint.C0, l__Character__3.Torso.Neck.C0, l__Character__3.Torso["Left Shoulder"].C0, l__Character__3.Torso["Right Shoulder"].C0, l__Character__3.Torso["Left Hip"].C0, l__Character__3.Torso["Right Hip"].C0 }, { l__Stand__20:WaitForChild("Torso").CFrame, l__Stand__20:WaitForChild("Torso").Neck.C0, l__Stand__20:WaitForChild("Torso")["Left Shoulder"].C0, l__Stand__20:WaitForChild("Torso")["Right Shoulder"].C0, l__Stand__20:WaitForChild("Torso")["Left Hip"].C0, l__Stand__20:WaitForChild("Torso")["Right Hip"].C0 }, StandTorsoMain);
                else
                    l__sendjoints__14:FireServer({ l__Character__3.HumanoidRootPart.RootJoint.C0, l__Character__3.Torso.Neck.C0, l__Character__3.Torso["Left Shoulder"].C0, l__Character__3.Torso["Right Shoulder"].C0, l__Character__3.Torso["Left Hip"].C0, l__Character__3.Torso["Right Hip"].C0 }, { l__Stand__20:WaitForChild("Torso").CFrame, l__Stand__20:WaitForChild("Torso").Neck.C0, l__Stand__20:WaitForChild("Torso")["Left Shoulder"].C0, l__Stand__20:WaitForChild("Torso")["Right Shoulder"].C0, l__Stand__20:WaitForChild("Torso")["Left Hip"].C0, l__Stand__20:WaitForChild("Torso")["Right Hip"].C0, l__fakearm__91.CFrame, l__fakearm__91.Size, l__fakearmpart__92.CFrame, l__fakearmpart__92.Size }, StandTorsoMain);
                end;
            end;
            if l__Parent__1:WaitForChild("IsHamon").Value == true then
                if u13 > 0 and not u14 then
                    u13 = u13 - 0.1;
                    l__misc__17:FireServer(9, v37, u13 / 10);
                    ImageLabel1.Size = UDim2.new(0, u13 * 2, 0, 20);
                    if u13 <= 0 then
                        u13 = 0;
                        u15 = false;
                        l__misc__17:FireServer(0, v38, false);
                        l__misc__17:FireServer(0, v37, false);
                    end;
                elseif u14 and u13 < 100 then
                    if l__Parent__1:FindFirstChild("IsUltimate") and l__Parent__1:FindFirstChild("IsUltimate").Value == true then
                        u13 = u13 + 0.25;
                    else
                        u13 = u13 + 0.125;
                    end;
                    l__misc__17:FireServer(9, v37, u13 / 10);
                    ImageLabel1.Size = UDim2.new(0, u13 * 2, 0, 20);
                    if u13 >= 100 then
                        u14 = false;
                    end;
                end;
            end;
            if u16 then
                u17 = u17 + p31
                if u20 == 0 then
                    if u17 >= 0.8 then
                        u17 = 0;
                        u20 = 1;
                    end;
                    if not u9 then
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new((0.1 - math.sin(u17 * 2) / 1.5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 + math.cos(u17 * 2) / 1.5, (0.1 + math.sin(u17 * 2) / 5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(-23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(-43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z - 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), u18 * 1.95);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new((0.1 - math.sin(u17 * 2) / 1.5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 - math.cos(u17 * 2) / 1.5, (0.1 + math.sin(u17 * 2) / 5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(-23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(-43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z - 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), u18 * 1.95);
                    else
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new((0.1 - math.sin(u17 * 2) / 1.15) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 + math.cos(u17 * 2) / 1.15, (0.1 + math.sin(u17 * 2) / 4.65) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(-23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(-43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z - 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), u18 * 1.95);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new((0.1 - math.sin(u17 * 2) / 1.15) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 - math.cos(u17 * 2) / 1.15, (0.1 + math.sin(u17 * 2) / 4.65) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(-23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(-43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z - 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), u18 * 1.95);
                    end;
                elseif u20 == 1 then
                    if u17 >= 0.8 then
                        u17 = 0;
                        u20 = 0;
                    end;
                    if not u9 then
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new((0.1 + math.sin(u17 * 2) / 1.5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 - math.cos(u17 * 2) / 1.5, (0.1 - math.sin(u17 * 2) / 5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z + 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), u18 * 1.95);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new((0.1 + math.sin(u17 * 2) / 1.5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 + math.cos(u17 * 2) / 1.5, (0.1 - math.sin(u17 * 2) / 5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z + 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), u18 * 1.95);
                    else
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new((0.1 + math.sin(u17 * 2) / 1.15) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 - math.cos(u17 * 2) / 1.15, (0.1 - math.sin(u17 * 2) / 4.65) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z + 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), u18 * 1.95);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new((0.1 + math.sin(u17 * 2) / 1.15) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 + math.cos(u17 * 2) / 1.15, (0.1 - math.sin(u17 * 2) / 4.65) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z + 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), u18 * 1.95);
                    end;
                end;
            end;
            u6 = u6 + ((Speed * u19 * 60 * _G.truespeedmult) * p31);

            if l__Character__3.HumanoidRootPart.Velocity.Y > 5 and not AttackingValue and not u23 and u24 then
                u23 = true;
                u16 = false;
                Speed = 0.02;
                u24 = false;
                AnimValue = 2;
                AnimKeyframe = 0;
                if u6 >= 0.5 then
                    u6 = 0;
                end;
            elseif l__Character__3.HumanoidRootPart.Velocity.Y < -5 and not AttackingValue and not u23 and u24 then
                u23 = true;
                u16 = false;
                Speed = 0.02;
                u24 = false;
                AnimValue = 2;
                AnimKeyframe = 1;
                if u6 >= 1 then
                    u6 = 0;
                end;
            else

            end;
            if not u23 then
                if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) and not AttackingValue and AnimValue ~= 0 then
                    AnimValue = 0;
                    Speed = 0.02;
                    if AnimKeyframe > 1 then
                        AnimKeyframe = 0;
                    end;
                    if u6 >= 1.5 then
                        u6 = 0;
                    end;
                    u16 = false;
                    return;
                end;
                if l__Humanoid__6.MoveDirection ~= Vector3.new(0, 0, 0) and not AttackingValue and AnimValue ~= 1 then
                    AnimValue = 1;
                    u6 = u17;
                    if u9 then
                        Speed = 0.04;
                    else
                        Speed = 0.03;
                    end;
                    if AnimKeyframe > 1 then
                        AnimKeyframe = 0;
                    end;
                    if u6 >= 0.8 then
                        u6 = 0;
                    end;
                    u16 = false;
                    return;
                end;
            elseif u23 then
                for v93, v94 in pairs(CastRegion(l__Character__3, math.huge, (NewRegion(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(0, -4.1, 0), Vector3.new(2, 1, 1))))) do
                    if v94 and v94.CanCollide then
                        coroutine.wrap(function()
                            u23 = false;
                            wait(0.15);
                            u24 = true;
                        end)();
                        return;
                    end;
                end;
            end;
        end;
    end);
    local StandHeadOrig = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0);
    local StandLeftArmOrig = CFrame.new(-1, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0);
    local StandRightArmOrig = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0);
    local StandLeftLegOrig = CFrame.new(-1, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0);
    local StandRightLegOrig = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0);

    local standIsSummoned = false;
    local u31 = false;
    local u32 = nil;
    local u33 = 0;
    local u34 = 1;
    local u35 = nil;
    local u37 = true;
    local u38 = true;
    local u39 = false;
    local u40 = 0;
    local u41 = 0;

    local ohGODYOUREGONNADIE = nil

    local standFloatTimer = 0
    local tweenSpeedMod = 4
    game:GetService("RunService").Heartbeat:connect(function(p32)
        standFloatTimer = math.fmod(standFloatTimer + p32, 360)

        if l__Humanoid__6.Health > 0 then
            if AnimValue == 0 or AnimValue == 1 or AnimValue == 2 then
                tweenSpeedMod = 30
                Speed = 0.05
            end

            local Accel = 1
            local secretmult2 = 1

            local deltaTime = p32
            local secondSpeed = 2
            local juan, twoo, tree, fow = 2.5, 3, 4, 6
            local flatSpeed = math.clamp(1-math.exp((-juan/Accel)*deltaTime), 0, 1)
            local flatSpeed2 = math.clamp(1-math.exp((-twoo/Accel)*deltaTime), 0, 1)
            local flatSpeed3 = math.clamp(1-math.exp((-tree/Accel)*deltaTime), 0, 1)
            local flatSpeed4 = math.clamp(1-math.exp((-fow/Accel)*deltaTime), 0, 1)

            local tweenSpeed = math.clamp(1-math.exp((-secondSpeed*(tweenSpeedMod/Accel*Speed))*deltaTime), 0, 1)

            if AnimValue == 0 then
                if math.cos(standFloatTimer) >= 0 then

                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, -0.212, -0.18) * CFrame.Angles(math.rad(6.538), math.rad(-0.001), math.rad(0)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.new(0.221, -0.197, -0.001) * CFrame.Angles(math.rad(-6.484), math.rad(54.515), math.rad(-39.875)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.082, -0.182, -0.013) * CFrame.Angles(math.rad(8.612), math.rad(10.231), math.rad(-24.479)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-6.879), math.rad(0), math.rad(-0)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.new(-0.222, -0.197, -0.001) * CFrame.Angles(math.rad(-6.038), math.rad(-39.778), math.rad(42.184)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new(-0.025, -0.137, -0.01) * CFrame.Angles(math.rad(1.305), math.rad(-13.741), math.rad(-15.641)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.205, -0.784, -0.437) * CFrame.Angles(math.rad(-57.714), math.rad(-77.154), math.rad(-132.379)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(17.925), math.rad(-4.745), math.rad(-38.405)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-14.254), math.rad(15.427), math.rad(18.431)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.17, -0.273, -0.671) * CFrame.Angles(math.rad(-18.308), math.rad(76.717), math.rad(100.04)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(-0.001, 0, 0) * CFrame.Angles(math.rad(-12.763), math.rad(-26.13), math.rad(-21)), math.clamp(tweenSpeed * 1, 0, 1))
                    if standIsSummoned then
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-2.527, 0.693 + (math.cos(standFloatTimer) / 2), 2.295) * CFrame.Angles(math.rad(14.752), math.rad(37.209), math.rad(-11.117)), math.clamp(tweenSpeed * 1, 0, 1))
                        return;
                    else
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                        return;
                    end;
                elseif math.cos(standFloatTimer) < 0 then

                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, -0.212, -0.079) * CFrame.Angles(math.rad(1.756), math.rad(-0.001), math.rad(0)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.new(0.221, -0.197, -0.001) * CFrame.Angles(math.rad(-25.757), math.rad(59.769), math.rad(-27.353)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.026, -0.278, -0.036) * CFrame.Angles(math.rad(6.44), math.rad(11.148), math.rad(-18.112)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-0.358), math.rad(0), math.rad(-0)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.new(-0.222, -0.197, -0.001) * CFrame.Angles(math.rad(-19.812), math.rad(-46.487), math.rad(38.276)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new(-0.08, -0.269, -0.014) * CFrame.Angles(math.rad(0.712), math.rad(-13.429), math.rad(-21.997)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.205, -0.784, -0.437) * CFrame.Angles(math.rad(30.419), math.rad(-83.139), math.rad(-45.565)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(19.296), math.rad(-5.825), math.rad(-38.278)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-14.254), math.rad(15.427), math.rad(30.561)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.17, -0.273, -0.671) * CFrame.Angles(math.rad(-30.375), math.rad(74.897), math.rad(110.764)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0.054, 0.168, -0.007) * CFrame.Angles(math.rad(-18.409), math.rad(-24.215), math.rad(-23.417)), math.clamp(tweenSpeed * 1, 0, 1))
                    if standIsSummoned then
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-2.527, 0.693 + (math.cos(standFloatTimer) / 2), 2.295) * CFrame.Angles(math.rad(22.38), math.rad(35.748), math.rad(-15.657)), math.clamp(tweenSpeed * 1, 0, 1))
                        return;
                    else
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                        return;
                    end;
                end;
            elseif AnimValue == 1 then
                if AnimKeyframe == 0 then
                    if u6 >= 0.8 then
                        u6 = 0;
                        AnimKeyframe = 1;
                    end;
                    if not u9 then
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u6 * 1.5) / 1.5) * CFrame.Angles(math.rad(4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), math.rad(-l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X * 3), 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(math.rad(-4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), 0, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(-0.12217304763960307, 0, math.rad(53 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z)), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(-0.12217304763960307, 0, math.rad(53 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z)), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new((0.1 - math.sin(u6 * 2) / 1.5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 + math.cos(u6 * 2) / 1.5, (0.1 + math.sin(u6 * 2) / 5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(-23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(-43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z - 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), math.clamp(tweenSpeed * 1.95, 0, 1));
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new((0.1 - math.sin(u6 * 2) / 1.5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 - math.cos(u6 * 2) / 1.5, (0.1 + math.sin(u6 * 2) / 5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(-23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(-43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z - 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), math.clamp(tweenSpeed * 1.95, 0, 1));
                        StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.205, -0.784, -0.437) * CFrame.Angles(math.rad(30.419), math.rad(-83.139), math.rad(-45.565)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(19.296), math.rad(-5.825), math.rad(-38.278)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-14.254), math.rad(15.427), math.rad(30.561)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.17, -0.273, -0.671) * CFrame.Angles(math.rad(-30.375), math.rad(74.897), math.rad(110.764)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0.054, 0.168, -0.007) * CFrame.Angles(math.rad(-18.409), math.rad(-24.215), math.rad(-23.417)), math.clamp(tweenSpeed * 1, 0, 1))
                        if standIsSummoned then
                            StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-2.527, 0.693 + (math.cos(standFloatTimer) / 2), 2.295) * CFrame.Angles(math.rad(22.38), math.rad(35.748), math.rad(-15.657)), math.clamp(tweenSpeed * 1, 0, 1))
                            return;
                        else
                            StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                            return;
                        end;
                    else
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u6 * 1.5) / 1.15) * CFrame.Angles(math.rad(12 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), math.rad(-l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X * 7), 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(math.rad(-4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), 0, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(-0.15707963267948966, 0, math.rad(57 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z)), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(-0.15707963267948966, 0, math.rad(57 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z)), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new((0.1 - math.sin(u6 * 2) / 1.15) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 + math.cos(u6 * 2) / 1.15, (0.1 + math.sin(u6 * 2) / 4.65) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(-23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(-43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z - 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), math.clamp(tweenSpeed * 1.95, 0, 1));
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new((0.1 - math.sin(u6 * 2) / 1.15) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 - math.cos(u6 * 2) / 1.15, (0.1 + math.sin(u6 * 2) / 4.65) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(-23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(-43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z - 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), math.clamp(tweenSpeed * 1.95, 0, 1));
                        StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.205, -0.784, -0.437) * CFrame.Angles(math.rad(30.419), math.rad(-83.139), math.rad(-45.565)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(19.296), math.rad(-5.825), math.rad(-38.278)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-14.254), math.rad(15.427), math.rad(30.561)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.17, -0.273, -0.671) * CFrame.Angles(math.rad(-30.375), math.rad(74.897), math.rad(110.764)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0.054, 0.168, -0.007) * CFrame.Angles(math.rad(-18.409), math.rad(-24.215), math.rad(-23.417)), math.clamp(tweenSpeed * 1, 0, 1))
                        if standIsSummoned then
                            StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-2.527, 0.693 + (math.cos(standFloatTimer) / 2), 2.295) * CFrame.Angles(math.rad(22.38), math.rad(35.748), math.rad(-15.657)), math.clamp(tweenSpeed * 1, 0, 1))
                            return;
                        else
                            StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                            return;
                        end;
                    end;
                end;
                if AnimKeyframe == 1 then
                    if u6 >= 0.8 then
                        u6 = 0;
                        AnimKeyframe = 0;
                    end;
                    if not u9 then
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u6 * 1.5) / 1.5) * CFrame.Angles(math.rad(4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), math.rad(-l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X * 3), 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(math.rad(-4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), 0, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(-0.12217304763960307, 0, math.rad(-53 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z)), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(-0.12217304763960307, 0, math.rad(-53 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z)), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new((0.1 + math.sin(u6 * 2) / 1.5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 - math.cos(u6 * 2) / 1.5, (0.1 - math.sin(u6 * 2) / 5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z + 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), math.clamp(tweenSpeed * 1.95, 0, 1));
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new((0.1 + math.sin(u6 * 2) / 1.5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 + math.cos(u6 * 2) / 1.5, (0.1 - math.sin(u6 * 2) / 5) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z + 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), math.clamp(tweenSpeed * 1.95, 0, 1));
                        StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.205, -0.784, -0.437) * CFrame.Angles(math.rad(30.419), math.rad(-83.139), math.rad(-45.565)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(19.296), math.rad(-5.825), math.rad(-38.278)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-14.254), math.rad(15.427), math.rad(30.561)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.17, -0.273, -0.671) * CFrame.Angles(math.rad(-30.375), math.rad(74.897), math.rad(110.764)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0.054, 0.168, -0.007) * CFrame.Angles(math.rad(-18.409), math.rad(-24.215), math.rad(-23.417)), math.clamp(tweenSpeed * 1, 0, 1))
                        if standIsSummoned then
                            StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-2.527, 0.693 + (math.cos(standFloatTimer) / 2), 2.295) * CFrame.Angles(math.rad(22.38), math.rad(35.748), math.rad(-15.657)), math.clamp(tweenSpeed * 1, 0, 1))
                            return;
                        else
                            StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                            return;
                        end;
                    else
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u6 * 1.5) / 1.15) * CFrame.Angles(math.rad(12 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), math.rad(-l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X * 7), 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(math.rad(-4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), 0, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(-0.15707963267948966, 0, math.rad(-57 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z)), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(-0.15707963267948966, 0, math.rad(-57 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z)), math.clamp(tweenSpeed * 1.75, 0, 1));
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new((0.1 + math.sin(u6 * 2) / 1.15) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 - math.cos(u6 * 2) / 1.15, (0.1 - math.sin(u6 * 2) / 4.65) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z + 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), math.clamp(tweenSpeed * 1.95, 0, 1));
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new((0.1 + math.sin(u6 * 2) / 1.15) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z, 0.1 + math.cos(u6 * 2) / 1.15, (0.1 - math.sin(u6 * 2) / 4.65) * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X) * CFrame.Angles(math.rad(23 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), -0.05235987755982989, math.rad(43 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z + 14 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X)), math.clamp(tweenSpeed * 1.95, 0, 1));
                        StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.205, -0.784, -0.437) * CFrame.Angles(math.rad(30.419), math.rad(-83.139), math.rad(-45.565)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(19.296), math.rad(-5.825), math.rad(-38.278)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-14.254), math.rad(15.427), math.rad(30.561)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.17, -0.273, -0.671) * CFrame.Angles(math.rad(-30.375), math.rad(74.897), math.rad(110.764)), math.clamp(tweenSpeed * 1, 0, 1))
                        StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0.054, 0.168, -0.007) * CFrame.Angles(math.rad(-18.409), math.rad(-24.215), math.rad(-23.417)), math.clamp(tweenSpeed * 1, 0, 1))
                        if standIsSummoned then
                            StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-2.527, 0.693 + (math.cos(standFloatTimer) / 2), 2.295) * CFrame.Angles(math.rad(22.38), math.rad(35.748), math.rad(-15.657)), math.clamp(tweenSpeed * 1, 0, 1))
                            return;
                        else
                            StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                            return;
                        end;
                    end;
                end;
            elseif AnimValue == 2 then

                if AnimKeyframe == 0 then
                    if u6 >= 0.5 then
                        u6 = 0;
                        AnimKeyframe = 1;
                    end;
                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(math.rad(4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), math.rad(3 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(math.rad(-5 + -4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), 0, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(-0.19198621771937624, 0.06981317007977318, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(-0.19198621771937624, 0.06981317007977318, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.5, 0.2, 0) * CFrame.Angles(-0.026179938779914945, 0, -0.03490658503988659), math.clamp(tweenSpeed * 2, 0, 1));
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(0, 0, -0.9075712110370514), math.clamp(tweenSpeed * 2, 0, 1));
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.205, -0.784, -0.437) * CFrame.Angles(math.rad(30.419), math.rad(-83.139), math.rad(-45.565)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(19.296), math.rad(-5.825), math.rad(-38.278)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-14.254), math.rad(15.427), math.rad(30.561)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.17, -0.273, -0.671) * CFrame.Angles(math.rad(-30.375), math.rad(74.897), math.rad(110.764)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0.054, 0.168, -0.007) * CFrame.Angles(math.rad(-18.409), math.rad(-24.215), math.rad(-23.417)), math.clamp(tweenSpeed * 1, 0, 1))
                    if standIsSummoned then
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-2.527, 0.693 + (math.cos(standFloatTimer) / 2), 2.295) * CFrame.Angles(math.rad(22.38), math.rad(35.748), math.rad(-15.657)), math.clamp(tweenSpeed * 1, 0, 1))
                        return;
                    else
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                        return;
                    end;
                end;
                if AnimKeyframe == 1 then
                    if u6 >= 1 then
                        AnimKeyframe = 2;
                    end;
                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(math.rad(4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), math.rad(3 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).X), 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(math.rad(12 + -4 * -l__Character__3.HumanoidRootPart.CFrame:vectorToObjectSpace(l__Humanoid__6.MoveDirection).Z), 0, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(-0.19198621771937624, 0.06981317007977318, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(-0.19198621771937624, 0.06981317007977318, 0), math.clamp(tweenSpeed * 1.75, 0, 1));
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.5, 0.2, 0) * CFrame.Angles(-0.026179938779914945, 0, -0.19198621771937624), math.clamp(tweenSpeed * 2, 0, 1));
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(0, 0, -1.0297442586766545), math.clamp(tweenSpeed * 2, 0, 1));
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.205, -0.784, -0.437) * CFrame.Angles(math.rad(30.419), math.rad(-83.139), math.rad(-45.565)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(19.296), math.rad(-5.825), math.rad(-38.278)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-14.254), math.rad(15.427), math.rad(30.561)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.17, -0.273, -0.671) * CFrame.Angles(math.rad(-30.375), math.rad(74.897), math.rad(110.764)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0.054, 0.168, -0.007) * CFrame.Angles(math.rad(-18.409), math.rad(-24.215), math.rad(-23.417)), math.clamp(tweenSpeed * 1, 0, 1))
                    if standIsSummoned then
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-2.527, 0.693 + (math.cos(standFloatTimer) / 2), 2.295) * CFrame.Angles(math.rad(22.38), math.rad(35.748), math.rad(-15.657)), math.clamp(tweenSpeed * 1, 0, 1))
                        return;
                    else
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                        return;
                    end;
                end;

            elseif AnimValue == 3 then
                standTimer = standTimer + deltaTime
                local swTime = 1/Speed
                local torsomult = 1.5
                local armsmult = 1.3

                local random1 = nil
                local random2 = nil
                local function newrandom()
                    random1 = CFrame.Angles(math.rad(math.random(-300,300)/50),math.rad(math.random(-300,300)/50),math.rad(math.random(-300,300)/50))
                    random2 = CFrame.Angles(math.rad(math.random(-300,300)/50),math.rad(math.random(-300,300)/50),math.rad(math.random(-300,300)/50))
                end
                newrandom()

                if AnimKeyframe == 0 then
                    if standTimer >= swTime then
                        standTimer = standTimer - swTime;
                        AnimKeyframe = 1;
                        u31 = false;
                        newrandom()
                        u32 = StandLeftArmOrig * CFrame.new(math.random(-55, -35) / 30, 0, 0) * CFrame.Angles(math.rad(math.random(-300, 300) / 100), math.rad(math.random(-100, 3700) / 100), math.rad(math.random(-10800, -9700) / 100));
                    end;
                    u33 = u33 + 1;
                    if u33 % 3 == 0 then
                        if not u31 then
							local hum;
							for _,v in pairs (CastRegion(l__Character__3,math.huge,NewRegion(l__Stand__20["Right Arm"].CFrame, l__Stand__20["Right Arm"].Size))) do
								if not hum then if v.Parent and v.Parent:FindFirstChildOfClass("Humanoid") and (v.Parent:FindFirstChild("Torso") or v.Parent:FindFirstChild("UpperTorso")) then hum = v.Parent:FindFirstChildOfClass("Humanoid") end end
								if not hum then if v.Parent and v.Parent.Name == "Stand" then hum = v.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") end end
							end
                            if hum and hum.Health > 0 then
                                u31 = true
                                local result = l__hitbox__16:InvokeServer(72, l__Stand__20["Right Arm"], l__Stand__20["Right Arm"].CFrame, barragedmg, l__voiceline__10, hum, false, false, false)
                                if not result then
                                    u31 = false;
                                end
                            end;
                        end;
                        local v101 = l__Stand__20:WaitForChild("Right Arm"):Clone();
                        v101.Parent = l__Container__7;
                        v101:ClearAllChildren();
                        v101.Anchored = true;
                        v101.Transparency = 0.5;
                        coroutine.wrap(function()
                            for v102 = 1, 10 do
                                v101.Transparency = v101.Transparency + 0.05;
                                wait();
                            end;
                            v101:Remove();
                        end)();
                    end;
                    if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) then
                        u16 = false;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, 0, 0.5759586531581288), flatSpeed2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), flatSpeed2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), flatSpeed2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), flatSpeed2);
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.23, 0, 0) * CFrame.Angles(-0.06981317007977318, 0.3839724354387525, -0.15707963267948966), flatSpeed2);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.06981317007977318, -0.3839724354387525, 0.12217304763960307), flatSpeed2);
                    else
                        if not u16 then
                            u16 = true;
                            if u9 then
                                u18 = 0.04;
                            else
                                u18 = 0.03;
                            end;
                            if u20 > 1 then
                                u20 = 0;
                            end;
                            if u17 >= 0.8 then
                                u17 = 0;
                            end;
                        end;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u17 * 1.5) / 1.5) * CFrame.Angles(0, 0, 0.5759586531581288), flatSpeed2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), flatSpeed2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), flatSpeed2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), flatSpeed2);
                    end;
                    if standIsSummoned then
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(-0.001, -0.001, -3.094) * CFrame.Angles(math.rad(-25.065), math.rad(60.091), math.rad(7.055)), math.clamp(tweenSpeed * torsomult, 0, 1))
                    else
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                    end
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(0.062, -0.383, 0.511) * CFrame.Angles(math.rad(-41.927), math.rad(-22.935), math.rad(-125.386)) * random1, math.clamp(tweenSpeed * armsmult, 0, 1))
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(-0.001, 0, -0.001) * CFrame.Angles(math.rad(-5.873), math.rad(14.686), math.rad(-60.902)), math.clamp(tweenSpeed * torsomult, 0, 1))
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(-0.424, 0.236, -0.505) * CFrame.Angles(math.rad(-36.006), math.rad(-18.748), math.rad(23.858)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(1.475, 0.28, 0.711) * CFrame.Angles(math.rad(-38.378), math.rad(-33.233), math.rad(96.457)) * random2, math.clamp(tweenSpeed * armsmult, 0, 1))
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0.649, 0.353, 0.649) * CFrame.Angles(math.rad(0), math.rad(-45.001), math.rad(-45)), math.clamp(tweenSpeed * 1, 0, 1))
                end;
                if AnimKeyframe == 1 then
                    if standTimer >= swTime then
                        standTimer = standTimer - swTime
                        AnimKeyframe = 0;
                        u31 = false;
                        newrandom()
                        u35 = StandRightArmOrig * CFrame.new(math.random(35, 55) / 30, 0, 0) * CFrame.Angles(math.rad(math.random(-300, 300) / 100), math.rad(math.random(-100, 3700) / 100), math.rad(math.random(8600, 9400) / 100));
                    end;
                    u33 = u33 + 1;
                    if u33 % 3 == 0 then
                        if not u31 then
							local hum;
							for _,v in pairs (CastRegion(l__Character__3,math.huge,NewRegion(l__Stand__20["Right Arm"].CFrame, l__Stand__20["Right Arm"].Size))) do
								if not hum then if v.Parent and v.Parent:FindFirstChildOfClass("Humanoid") and (v.Parent:FindFirstChild("Torso") or v.Parent:FindFirstChild("UpperTorso")) then hum = v.Parent:FindFirstChildOfClass("Humanoid") end end
								if not hum then if v.Parent and v.Parent.Name == "Stand" then hum = v.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") end end
							end
                            if hum and hum.Health > 0 then
                                u31 = true
                                local result = l__hitbox__16:InvokeServer(72, l__Stand__20["Left Arm"], l__Stand__20["Left Arm"].CFrame, barragedmg, l__voiceline__10, hum, false, false, false)
                                if not result then
                                    u31 = false;
                                end
                            end;
                        end;
                        local v109 = l__Stand__20:WaitForChild("Left Arm"):Clone();
                        v109.Parent = l__Container__7;
                        v109:ClearAllChildren();
                        v109.Anchored = true;
                        v109.Transparency = 0.5;
                        coroutine.wrap(function()
                            for v110 = 1, 10 do
                                v109.Transparency = v109.Transparency + 0.05;
                                wait();
                            end;
                            v109:Remove();
                        end)();
                    end;
                    if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) then
                        u16 = false;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, 0, 0.5759586531581288), flatSpeed2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), flatSpeed2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), flatSpeed2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), flatSpeed2);
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.23, 0, 0) * CFrame.Angles(-0.06981317007977318, 0.3839724354387525, -0.15707963267948966), flatSpeed2);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.06981317007977318, -0.3839724354387525, 0.12217304763960307), flatSpeed2);
                    else
                        if not u16 then
                            u16 = true;
                            if u9 then
                                u18 = 0.04;
                            else
                                u18 = 0.03;
                            end;
                            if u20 > 1 then
                                u20 = 0;
                            end;
                            if u17 >= 0.8 then
                                u17 = 0;
                            end;
                        end;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u17 * 1.5) / 1.5) * CFrame.Angles(0, 0, 0.5759586531581288), flatSpeed2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), flatSpeed2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), flatSpeed2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), flatSpeed2);
                    end;
                    if standIsSummoned then
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(0, -0.001, -3.094) * CFrame.Angles(math.rad(-25.065), math.rad(-60.092), math.rad(-7.056)), math.clamp(tweenSpeed * torsomult, 0, 1))
                    else
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame, math.clamp(tweenSpeed * 1, 0, 1))
                    end
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-1.476, 0.28, 0.711) * CFrame.Angles(math.rad(-38.378), math.rad(33.232), math.rad(-96.458)) * random1, math.clamp(tweenSpeed * armsmult, 0, 1))
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(-5.873), math.rad(-14.687), math.rad(60.901)), math.clamp(tweenSpeed * torsomult, 0, 1))
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(-0.114, -0.376, 0.08) * CFrame.Angles(math.rad(13.099), math.rad(20.834), math.rad(50.291)), math.clamp(tweenSpeed * 1, 0, 1))
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(-0.138, -0.391, 0.444) * CFrame.Angles(math.rad(-41.927), math.rad(22.934), math.rad(125.385)) * random2, math.clamp(tweenSpeed * armsmult, 0, 1))
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(1.25, 0.1, -0.562) * CFrame.Angles(math.rad(-37.903), math.rad(4.557), math.rad(-44.896)), math.clamp(tweenSpeed * 1, 0, 1))
                end;
            elseif AnimValue == 4 then
                if AnimKeyframe == 0 then
                    if u6 >= 1.2 then
                        AnimKeyframe = 1;
                        u6 = 0;
                        Speed = 0.12 * l__Parent__1:WaitForChild("Speed").Value * u34;
                        u35 = StandRightArmOrig * CFrame.new(math.random(55, 75) / 20, 0, 0) * CFrame.Angles(math.rad(math.random(-100, 500) / 50), 0.8901179185171081, math.rad(math.random(9100, 9500) / 100));
                    end;
                    if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) then
                        u16 = false;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 3);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 3);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 3);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 3);
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.23, 0, 0) * CFrame.Angles(-0.06981317007977318, 0.3839724354387525, -0.15707963267948966), Speed * 3);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.06981317007977318, -0.3839724354387525, 0.12217304763960307), Speed * 2);
                    else
                        if not u16 then
                            u16 = true;
                            if u9 then
                                u18 = 0.04;
                            else
                                u18 = 0.03;
                            end;
                            if u20 > 1 then
                                u20 = 0;
                            end;
                            if u17 >= 0.8 then
                                u17 = 0;
                            end;
                        end;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u17 * 1.5) / 1.5) * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 3);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 3);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 3);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 3);
                    end;
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, 0) * CFrame.Angles(0.17453292519943295, 0.17453292519943295, 1.0471975511965976), Speed * 2);
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(-0.22222222222222, 0, 0.22222222222222) * CFrame.Angles(-0.17453292519943123, 0.5235987755982988, -1.7453292519943122), Speed * 2);
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(-0.44444444444444, 0, -0.44444444444444) * CFrame.Angles(-0.5235987755982988, -0.8726646259971648, 1.2217304763960306), Speed * 2);
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, 0.22222222222222, 0.22222222222222) * CFrame.Angles(-0.17453292519943123, 0.17453292519943295, 0), Speed * 2);
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(-0.3490658503988659, 0, 0), Speed * 2);
                    StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(0, 0.22222222222222, -3.5) * CFrame.Angles(0.17453292519943295, math.rad(-70 - u6 * 25), 0), Speed * 4);
                    return;
                end;
                if AnimKeyframe == 1 then
                    if u6 >= 1.2 then
                        u6 = 0;
                        AttackingValue = false;
                        coroutine.wrap(function()
                            _G.indicatecooldown("ORA!", strongPunchCoolLength);
                            wait(strongPunchCoolLength);
                            strongPunchCool = true;
                        end)();
                        AnimValue = -1;
                        AnimKeyframe = 0;
                        l__misc__17:FireServer(7, l__Humanoid__6, 50);
                        Speed = 0.02;
                    end;
                    u33 = u33 + 1;
                    if u33 % 2 == 0 then
                        if not u31 then
							local hum;
							for _,v in pairs (CastRegion(l__Character__3,math.huge,NewRegion(l__Stand__20["Right Arm"].CFrame, l__Stand__20["Right Arm"].Size))) do
								if not hum then if v.Parent and v.Parent:FindFirstChildOfClass("Humanoid") and (v.Parent:FindFirstChild("Torso") or v.Parent:FindFirstChild("UpperTorso")) then hum = v.Parent:FindFirstChildOfClass("Humanoid") end end
								if not hum then if v.Parent and v.Parent.Name == "Stand" then hum = v.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") end end
							end
                            if hum and hum.Health > 0 then
                                u31 = true
                                local result = l__hitbox__16:InvokeServer(71, l__Stand__20["Right Arm"], l__Stand__20["Right Arm"].CFrame, strongPunchDmg, l__voiceline__10, hum, false, false, false)
                                if not result then
                                    u31 = false;
                                end
                            end;
                        end;
                        local v117 = l__Stand__20:WaitForChild("Right Arm"):Clone();
                        v117.Parent = l__Container__7;
                        v117:ClearAllChildren();
                        v117.Anchored = true;
                        v117.Transparency = 0.5;
                        coroutine.wrap(function()
                            for v118 = 1, 5 do
                                v117.Transparency = v117.Transparency + 0.1;
                                wait();
                            end;
                            v117:Remove();
                        end)();
                    end;
                    if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) then
                        u16 = false;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, 0, 0.5759586531581288), Speed);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed);
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.23, 0, 0) * CFrame.Angles(-0.06981317007977318, 0.3839724354387525, -0.15707963267948966), Speed);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.06981317007977318, -0.3839724354387525, 0.12217304763960307), Speed);
                    else
                        if not u16 then
                            u16 = true;
                            if u9 then
                                u18 = 0.04;
                            else
                                u18 = 0.03;
                            end;
                            if u20 > 1 then
                                u20 = 0;
                            end;
                            if u17 >= 0.8 then
                                u17 = 0;
                            end;
                        end;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u17 * 1.5) / 1.5) * CFrame.Angles(0, 0, 0.5759586531581288), Speed);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed);
                    end;
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.new(0, 0, 0) * CFrame.Angles(0.17453292519943295, 1.736183430119852E-15, -1.3962634015954463), Speed * 3);
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.new(0, 0, 0.22222222222222) * CFrame.Angles(-0.17453292519943123, 0.6981317007977318, 0), Speed * 3);
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.new(0.66666666666666, 0.22222222222222, 0.22222222222222) * CFrame.Angles(0.17453292519942598, -1.0471975511965976, 2.0943951023931953), Speed * 3);
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(-0.44444444444444, -0.22222222222222, 0.22222222222222) * CFrame.Angles(-0.17453292519943123, 1.736183430119852E-15, 0.6981317007977318), Speed * 3);
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0, 0, 0) * CFrame.Angles(-0.17453292519943123, -0.3490658503988659, -0.17453292519943123), Speed * 3);
                    StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(0, 0.22222222222222, -4.5) * CFrame.Angles(-0.5235987755982988, math.rad(79.999999999999 + u6 * 20), 0.17453292519943123), Speed * 4);
                    return;
                end;
            elseif AnimValue == 5 then
                if AnimKeyframe == 0 then
                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, -0.17453292519943295, 1.0471975511965976), Speed * 3);
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(0, 0, -0.8726646259971648), Speed * 3);
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0, 0.6981317007977318, -0.3490658503988659), Speed * 3);
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0, -0.6981317007977318, 1.5707963267948966), Speed * 3);
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.Angles(-0.08726646259971647, 0.3490658503988659, 0.17453292519943295), Speed * 3);
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.17453292519943295, -0.17453292519943295, -0.17453292519943295), Speed * 2);
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.Angles(0.2617993877991494, 0, -0.6981317007977318), Speed * 1.2);
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.Angles(-0.3490658503988659, 0.5235987755982988, -0.6981317007977318), Speed * 1.2);
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.Angles(-0.3490658503988659, -0.5235987755982988, 0.6981317007977318), Speed * 1.5);
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(-0.5, 0, 0) * CFrame.Angles(-0.17453292519943295, -0.3490658503988659, 0), Speed * 1.5);
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.Angles(-0.17453292519943295, -0.3490658503988659, 0), Speed * 1.2);
                    if standIsSummoned then
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(1.4, 3, 3) * CFrame.Angles(0, 0.6981317007977318, 0), Speed * 3);
                        return;
                    else
                        StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.Angles(0, 0.6981317007977318, 0), Speed * 5);
                        return;
                    end;
                end;
            elseif AnimValue == 6 then
                standTimer = standTimer + deltaTime
                local swTime = 1/Speed
                local torsomult = 1.4
                local armsmult = 1.65
                if AnimKeyframe == 0 then
                    AnimKeyframe = 1
                end
                if AnimKeyframe == 0 then
                    AnimKeyframe = 1
                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, -0.4, -0.301) * CFrame.Angles(math.rad(19.999), math.rad(-0.001), math.rad(0)), 1)
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(-0.001), math.rad(-0.001), math.rad(-20)), 1)
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.949, -0.026, 0.3) * CFrame.Angles(math.rad(-4.7), math.rad(-1.709), math.rad(19.929)), 1)
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(54.999), math.rad(0), math.rad(-0)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(-0.001), math.rad(-0.001), math.rad(19.999)), 1)
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new(0.657, 0.239, 0.2) * CFrame.Angles(math.rad(6.881), math.rad(-24.093), math.rad(-3.53)), 1)
                        
                elseif AnimKeyframe == 1 then

                    if standTimer >= 3 then
                        standTimer = standTimer - 3
                        AnimKeyframe = 2
                    end;

                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, -0.4, -0.4) * CFrame.Angles(math.rad(15), math.rad(-0.001), math.rad(0)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-43.22), math.rad(13.995), math.rad(-14.433)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.949, -0.026, 0.3) * CFrame.Angles(math.rad(-4.7), math.rad(-1.709), math.rad(24.929)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(69.999), math.rad(0), math.rad(-0)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.new(-0.001, 0, -0.001) * CFrame.Angles(math.rad(-38.256), math.rad(-12.701), math.rad(15.579)), math.clamp(tweenSpeed * 1, 0, 1))
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new(0.657, 0.239, 0.2) * CFrame.Angles(math.rad(1.498), math.rad(-23.258), math.rad(-10.693)), math.clamp(tweenSpeed * 1, 0, 1))
                        
                elseif AnimKeyframe == 2 then
                    AnimKeyframe = 3

                    if ohGODYOUREGONNADIE ~= nil then
                        local rootThing = ohGODYOUREGONNADIE:FindFirstChild("HumanoidRootPart")
                        if not rootThing then
                            rootThing = ohGODYOUREGONNADIE:FindFirstChild("Torso")
                        end
                        local humthing = ohGODYOUREGONNADIE:FindFirstChildOfClass("Humanoid")

                        if rootThing ~= nil then
                            l__Character__3.HumanoidRootPart.CFrame = rootThing.CFrame + rootThing.CFrame.lookVector * -3
                        end
                        if humthing ~= nil and rootThing ~= nil then
                            local cor15 = coroutine.wrap(function ()
                                l__hitbox__16:InvokeServer(1, rootThing, rootThing.CFrame, mysteryDmg, l__voiceline__10, humthing, false, false, false)
                            end)
                            cor15()
                        end
                    end

                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(18.218), math.rad(3.828), math.rad(-40.108)), 1)
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.new(-0.937, 0.15, -0.331) * CFrame.Angles(math.rad(-16.502), math.rad(-26.829), math.rad(-113.9)), 1)
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.97, 0.479, -0.001) * CFrame.Angles(math.rad(-13.617), math.rad(3.719), math.rad(29.567)), 1)
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-0), math.rad(0), math.rad(39.999)), 1)
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-40), math.rad(-30), math.rad(19.999)), 1)
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new(0.362, -0.17, 0) * CFrame.Angles(math.rad(0), math.rad(-0.001), math.rad(-45)), 1)
                        
                elseif AnimKeyframe == 3 then
                    if standTimer >= 0.5 then
                        standTimer = standTimer - 0.5
                        AnimValue = 0
                        AnimKeyframe = 0
                        AttackingValue = false
                        if u9 then
                            l__Humanoid__6.WalkSpeed = 20
                        else
                            l__Humanoid__6.WalkSpeed = 16
                        end
                        l__misc__17:FireServer(7, l__Humanoid__6, 50);
                        coroutine.wrap(function()
                            _G.indicatecooldown("???", mysteryCoolLength);
                            task.wait(mysteryCoolLength);
                            mysteryCool = true;
                        end)();
                    end;

                    PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(-0.33, 0.131, 0.066) * CFrame.Angles(math.rad(20.814), math.rad(-10.948), math.rad(-104.946)), math.clamp(tweenSpeed * 3, 0, 1))
                    PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.new(-0.378, -0.067, -0.322) * CFrame.Angles(math.rad(-52.71), math.rad(-78.705), math.rad(-124.22)), math.clamp(tweenSpeed * 3, 0, 1))
                    PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.97, 0.479, 0) * CFrame.Angles(math.rad(-13.617), math.rad(3.719), math.rad(54.567)), math.clamp(tweenSpeed * 3, 0, 1))
                    PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-0), math.rad(0), math.rad(-20.001)), math.clamp(tweenSpeed * 3, 0, 1))
                    PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.new(0, 0, -0.001) * CFrame.Angles(math.rad(-81.536), math.rad(-21.357), math.rad(-35.681)), math.clamp(tweenSpeed * 3, 0, 1))
                    PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.new(0.362, -0.17, 0) * CFrame.Angles(math.rad(0), math.rad(-0.001), math.rad(-30)), math.clamp(tweenSpeed * 3, 0, 1))
                        
                end

            elseif AnimValue == 7 then
                if AnimKeyframe == 0 then
                    if u6 >= 0.75 then
                        AnimKeyframe = 1;
                        u6 = 0;
                        Speed = 0.05 * l__Parent__1:WaitForChild("Speed").Value * u34;
                        l__misc__17:FireServer(2, l__woosh__9, math.random(110, 120) / 100);
                        l__misc__17:FireServer(1, l__woosh__9, 0);
                        u32 = StandLeftArmOrig * CFrame.new(math.random(15, 35) / 40, 0, 0) * CFrame.Angles(math.rad(math.random(-500, -100) / 100), math.rad(math.random(-1200, 2500) / 100), math.rad(math.random(8600, 9400) / 100));
                    end;
                    if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) then
                        u16 = false;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 2);
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.23, 0, 0) * CFrame.Angles(-0.06981317007977318, 0.3839724354387525, -0.15707963267948966), Speed * 2);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.06981317007977318, -0.3839724354387525, 0.12217304763960307), Speed * 2);
                    else
                        if not u16 then
                            u16 = true;
                            if u9 then
                                u18 = 0.04;
                            else
                                u18 = 0.03;
                            end;
                            if u20 > 1 then
                                u20 = 0;
                            end;
                            if u17 >= 0.8 then
                                u17 = 0;
                            end;
                        end;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u17 * 1.5) / 1.5) * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 2);
                    end;
                    StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4.5) * CFrame.Angles(-0.03490658503988659, -1.3962634015954636, 0), Speed * 2);
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.Angles(0.03490658503988659, 0, 1.3962634015954636), Speed * 2);
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.Angles(-0.24434609527920614, 0.12217304763960307, 0), Speed * 2);
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(u35, Speed * 2);
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, -0.07, 0) * CFrame.Angles(-0.13962634015954636, 0.12217304763960307, -0.06981317007977318), Speed * 2);
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0, -0.07, 0) * CFrame.Angles(-0.05235987755982989, 0.05235987755982989, 0.05235987755982989), Speed * 2);
                    return;
                end;
                if AnimKeyframe == 1 then
                    if u6 >= 0.75 then
                        u6 = 0;
                        AnimKeyframe = 0;
                        AttackingValue = false;
                        AnimValue = -1;
                        AnimKeyframe = 0;
                        Speed = 0.02;
                        l__misc__17:FireServer(7, l__Humanoid__6, 50);
                        coroutine.wrap(function()
                            wait(0.2 * v19);
                            u38 = true;
                        end)();
                    end;
                    if not u31 then
                        local hum;
                        for _,v in pairs (CastRegion(l__Character__3,math.huge,NewRegion(l__Stand__20["Right Arm"].CFrame, l__Stand__20["Right Arm"].Size))) do
                            if not hum then if v.Parent and v.Parent:FindFirstChildOfClass("Humanoid") and (v.Parent:FindFirstChild("Torso") or v.Parent:FindFirstChild("UpperTorso")) then hum = v.Parent:FindFirstChildOfClass("Humanoid") end end
                            if not hum then if v.Parent and v.Parent.Name == "Stand" then hum = v.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") end end
                        end
                        if hum and hum.Health > 0 then
                            u31 = true
                            local result = l__hitbox__16:InvokeServer(72, l__Stand__20["Right Arm"], l__Stand__20["Right Arm"].CFrame, clickDmg, l__voiceline__10, hum, false, false, false)
                            if not result then
                                u31 = false;
                            end
                        end;
                    end;
                    if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) then
                        u16 = false;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 2);
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.23, 0, 0) * CFrame.Angles(-0.06981317007977318, 0.3839724354387525, -0.15707963267948966), Speed * 2);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.06981317007977318, -0.3839724354387525, 0.12217304763960307), Speed * 2);
                    else
                        if not u16 then
                            u16 = true;
                            if u9 then
                                u18 = 0.04;
                            else
                                u18 = 0.03;
                            end;
                            if u20 > 1 then
                                u20 = 0;
                            end;
                            if u17 >= 0.8 then
                                u17 = 0;
                            end;
                        end;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u17 * 1.5) / 1.5) * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 2);
                    end;
                    StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4.5) * CFrame.Angles(0, 0.6981317007977318, 0), Speed * 4);
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.Angles(0, 0, -0.5235987755982988), Speed * 4);
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(StandLeftArmOrig * CFrame.Angles(-0.20943951023931956, 0.08726646259971647, 0), Speed * 2);
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(u35, Speed * 2);
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, -0.07, 0) * CFrame.Angles(-0.13962634015954636, 0.12217304763960307, -0.06981317007977318), Speed * 2);
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0, -0.07, 0) * CFrame.Angles(-0.05235987755982989, 0.05235987755982989, 0.05235987755982989), Speed * 2);
                    return;
                end;
            elseif AnimValue == 8 then
                if AnimKeyframe == 0 then
                    if u6 >= 0.75 then
                        AnimKeyframe = 1;
                        u6 = 0;
                        Speed = 0.05 * l__Parent__1:WaitForChild("Speed").Value * u34;
                        l__misc__17:FireServer(2, l__woosh__9, math.random(110, 120) / 100);
                        l__misc__17:FireServer(1, l__woosh__9, 0);
                        u32 = StandLeftArmOrig * CFrame.new(math.random(-35, -15) / 40, 0, 0) * CFrame.Angles(math.rad(math.random(-500, -100) / 100), math.rad(math.random(-1200, 2500) / 100), math.rad(math.random(-9400, -8600) / 100));
                    end;
                    if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) then
                        u16 = false;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 2);
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.23, 0, 0) * CFrame.Angles(-0.06981317007977318, 0.3839724354387525, -0.15707963267948966), Speed * 2);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.06981317007977318, -0.3839724354387525, 0.12217304763960307), Speed * 2);
                    else
                        if not u16 then
                            u16 = true;
                            if u9 then
                                u18 = 0.04;
                            else
                                u18 = 0.03;
                            end;
                            if u20 > 1 then
                                u20 = 0;
                            end;
                            if u17 >= 0.8 then
                                u17 = 0;
                            end;
                        end;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u17 * 1.5) / 1.5) * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 2);
                    end;
                    StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4.5) * CFrame.Angles(-0.03490658503988659, 1.3962634015954636, 0), Speed * 2);
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.Angles(0.03490658503988659, 0, -1.3962634015954636), Speed * 2);
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(u32, Speed * 2);
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.Angles(-0.24434609527920614, -0.12217304763960307, 0), Speed * 2);
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, -0.07, 0) * CFrame.Angles(-0.13962634015954636, 0.12217304763960307, -0.06981317007977318), Speed * 2);
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0, -0.07, 0) * CFrame.Angles(-0.05235987755982989, 0.05235987755982989, 0.05235987755982989), Speed * 2);
                    return;
                end;
                if AnimKeyframe == 1 then
                    if u6 >= 0.75 then
                        u6 = 0;
                        AnimKeyframe = 0;
                        AttackingValue = false;
                        AnimValue = -1;
                        AnimKeyframe = 0;
                        Speed = 0.02;
                        l__misc__17:FireServer(7, l__Humanoid__6, 50);
                        coroutine.wrap(function()
                            wait(0.2 * v19);
                            u38 = true;
                        end)();
                    end;
                    if not u31 then
                        local hum;
                        for _,v in pairs (CastRegion(l__Character__3,math.huge,NewRegion(l__Stand__20["Left Arm"].CFrame, l__Stand__20["Left Arm"].Size))) do
                            if not hum then if v.Parent and v.Parent:FindFirstChildOfClass("Humanoid") and (v.Parent:FindFirstChild("Torso") or v.Parent:FindFirstChild("UpperTorso")) then hum = v.Parent:FindFirstChildOfClass("Humanoid") end end
                            if not hum then if v.Parent and v.Parent.Name == "Stand" then hum = v.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") end end
                        end
                        if hum and hum.Health > 0 then
                            u31 = true
                            local result = l__hitbox__16:InvokeServer(72, l__Stand__20["Left Arm"], l__Stand__20["Left Arm"].CFrame, clickDmg, l__voiceline__10, hum, false, false, false)
                            if not result then
                                u31 = false;
                            end
                        end;
                    end;
                    if l__Humanoid__6.MoveDirection == Vector3.new(0, 0, 0) then
                        u16 = false;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 2);
                        PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.new(-0.23, 0, 0) * CFrame.Angles(-0.06981317007977318, 0.3839724354387525, -0.15707963267948966), Speed * 2);
                        PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.06981317007977318, -0.3839724354387525, 0.12217304763960307), Speed * 2);
                    else
                        if not u16 then
                            u16 = true;
                            if u9 then
                                u18 = 0.04;
                            else
                                u18 = 0.03;
                            end;
                            if u20 > 1 then
                                u20 = 0;
                            end;
                            if u17 >= 0.8 then
                                u17 = 0;
                            end;
                        end;
                        PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.new(0, 0, 0.4 - math.cos(-u17 * 1.5) / 1.5) * CFrame.Angles(0, 0, 0.5759586531581288), Speed * 2);
                        PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.05235987755982989, 0, -0.5759586531581288), Speed * 2);
                        PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.15707963267948966, 0.4014257279586958, 0.4014257279586958), Speed * 2);
                        PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.15707963267948966, -0.4014257279586958, 1.5707963267948966), Speed * 2);
                    end;
                    StandTorsoMain.CFrame = StandTorsoMain.CFrame:lerp(l__Character__3.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4.5) * CFrame.Angles(0, -0.6981317007977318, 0), Speed * 4);
                    StandJoints[1].C0 = StandJoints[1].C0:lerp(StandHeadOrig * CFrame.Angles(0, 0, 0.5235987755982988), Speed * 4);
                    StandJoints[2].C0 = StandJoints[2].C0:lerp(u32, Speed * 2);
                    StandJoints[3].C0 = StandJoints[3].C0:lerp(StandRightArmOrig * CFrame.Angles(-0.20943951023931956, -0.08726646259971647, 0), Speed * 2);
                    StandJoints[4].C0 = StandJoints[4].C0:lerp(StandLeftLegOrig * CFrame.new(0, -0.09, 0) * CFrame.Angles(-0.12217304763960307, 0.20943951023931956, -0.05235987755982989), Speed * 2);
                    StandJoints[5].C0 = StandJoints[5].C0:lerp(StandRightLegOrig * CFrame.new(0, -0.09, 0) * CFrame.Angles(-0.08726646259971647, 0.13962634015954636, 0.06981317007977318), Speed * 2);
                    return;
                end;
            elseif AnimValue == 9 then

            end;
        end;
    end);
    local u42 = false;
    l__UserInputService__13.TextBoxFocused:connect(function()
        u42 = true;
    end);
    l__UserInputService__13.TextBoxFocusReleased:connect(function()
        u42 = false;
    end);
    local u44 = 0;
    local u45 = true;
    local u46 = true;
    local u47 = true;
    local u48 = true;
    local u49 = false;
    l__UserInputService__13.InputBegan:connect(function(p33)
        if true == true then
            if not u42 then
                if (p33.KeyCode == Enum.KeyCode.E or p33.KeyCode == Enum.KeyCode.ButtonR2) and not AttackingValue and not u14 and barrageCool and l__Humanoid__6.Health > 0 then
                    _G.attacktarget = nil;

                    AttackingValue = true;
                    if not standIsSummoned then
                        l__misc__17:FireServer(2, l__summonstand__12, math.random(90, 110) / 100);
                        l__misc__17:FireServer(1, l__summonstand__12, 0);
                        local descendants = l__Stand__20:GetDescendants()
                        for i,v in pairs(descendants) do
                            if v ~= nil then
                                if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "RootPart" and v.Name ~= "finger" and v.Name ~= "Torso" and v.Name ~= "Head" and v.Name ~= "Left Arm" and v.Name ~= "Right Arm" and v.Name ~= "Left Leg" and v.Name ~= "Right Leg" then
                                    l__misc__17:FireServer(3, v, 0);
                                end
                            end
                        end
                        standIsSummoned = true;
                    end;
                    barrageCool = false;
                    AnimValue = 3;
                    tweenSpeedMod = 0.75
                    Speed = 22
                    AnimKeyframe = 0;
                    standTimer = 0;
                    u44 = u44 + 1;
                    coroutine.wrap(function()
                        local currentTick = 0
                        local barrageLengthLocal = 0
                        local stop = false
                        repeat
                            task.wait(0.1)
                            currentTick = currentTick + 1
                            if barrageLength > 0 then
                                if currentTick > barrageLength then
                                    stop = true
                                end
                            end
                            if AnimValue ~= 3 then
                                stop = true
                            end
                        until stop == true

                        if AnimValue == 3 then
                            u6 = 0;
                            AttackingValue = false;
                            coroutine.wrap(function()
                                _G.indicatecooldown("Ora Barrage", barrageCoolLength);
                                wait(barrageCoolLength);
                                barrageCool = true;
                            end)();
                            AnimValue = -1;
                            stopSound()
                            AnimKeyframe = 0;
                            l__misc__17:FireServer(7, l__Humanoid__6, 50);
                            Speed = 0.02;
                        end;
                    end)();
                    u17 = u6;
                    u33 = 0;
                    l__misc__17:FireServer(7, l__Humanoid__6, 0);

                    u31 = false;
                    u35 = StandRightArmOrig * CFrame.new(math.random(35, 55) / 30, 0, 0) * CFrame.Angles(math.rad(math.random(-300, 300) / 100), math.rad(math.random(-100, 3700) / 100), math.rad(math.random(9700, 10800) / 100));
                    l__misc__17:FireServer(2, l__woosh__9, math.random(90, 110) / 100);
                    l__misc__17:FireServer(1, l__woosh__9, 0);
                    startSound(5985331892, 2, false)
                    tweenSpeedMod = 1
                elseif (p33.KeyCode == Enum.KeyCode.R or p33.KeyCode == Enum.KeyCode.ButtonR1) and not AttackingValue and not u14 and strongPunchCool and l__Humanoid__6.Health > 0 then
                    AttackingValue = true;
                    if not standIsSummoned then
                        l__misc__17:FireServer(2, l__summonstand__12, math.random(90, 110) / 100);
                        l__misc__17:FireServer(1, l__summonstand__12, 0);
                        local descendants = l__Stand__20:GetDescendants()
                        for i,v in pairs(descendants) do
                            if v ~= nil then
                                if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "RootPart" and v.Name ~= "finger" and v.Name ~= "Torso" and v.Name ~= "Head" and v.Name ~= "Left Arm" and v.Name ~= "Right Arm" and v.Name ~= "Left Leg" and v.Name ~= "Right Leg" then
                                    l__misc__17:FireServer(3, v, 0);
                                end
                            end
                        end
                        standIsSummoned = true;
                    end;
                    standTimer = 0
                    strongPunchCool = false;
                    AnimValue = 4;
                    AnimKeyframe = 0;
                    u6 = 0;
                    u17 = u6;
                    u33 = 0;
                    l__misc__17:FireServer(7, l__Humanoid__6, 0);
                    u35 = StandRightArmOrig * CFrame.new(-math.random(15, 20) / 30, 0, 0) * CFrame.Angles(-math.rad(math.random(-800, 200) / 100), math.rad(math.random(-7100, -1200) / 100), math.rad(math.random(8600, 9400) / 100));
                    Speed = 0.05 * l__Parent__1:WaitForChild("Speed").Value * u34;
                    u31 = false;
                    l__misc__17:FireServer(2, l__woosh__9, math.random(90, 110) / 100);
                    l__misc__17:FireServer(1, l__woosh__9, 0);
                    startSound(5873885300, 1, false)

                elseif (p33.KeyCode == Enum.KeyCode.T or p33.KeyCode == Enum.KeyCode.ButtonR1) and not AttackingValue and not u14 and mysteryCool and l__Humanoid__6.Health > 0 then
                    local hum;
                    for _,v in pairs (CastRegion(l__Character__3,math.huge,NewRegion(CFrame.new(l__mouse__2.Hit.Position), Vector3.new(5,5,5)))) do
                        if not hum then if v.Parent and v.Parent:FindFirstChildOfClass("Humanoid") and (v.Parent:FindFirstChild("Torso") or v.Parent:FindFirstChild("UpperTorso")) then hum = v.Parent:FindFirstChildOfClass("Humanoid") end end
                        if not hum then if v.Parent and v.Parent.Name == "Stand" then hum = v.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") end end
                    end
                    
                    if hum then
                        AttackingValue = true;
                        l__Humanoid__6.WalkSpeed = 0
                        standTimer = 0
                        ohGODYOUREGONNADIE = hum.Parent
                        mysteryCool = false;
                        AnimValue = 6;
                        AnimKeyframe = 0;
                        u6 = 0;
                        u17 = u6;
                        u33 = 0;
                        l__misc__17:FireServer(7, l__Humanoid__6, 0);
                        Speed = 0.05 * l__Parent__1:WaitForChild("Speed").Value * u34;
                        u31 = false;
                        l__misc__17:FireServer(2, l__woosh__9, math.random(90, 110) / 100);
                        l__misc__17:FireServer(1, l__woosh__9, 0);
                        startSound(5873885300, 1, false)
                    end

                elseif (p33.KeyCode == Enum.KeyCode.Z or p33.KeyCode == Enum.KeyCode.ButtonB) and not AttackingValue and not u14 and standJumpCool and l__Humanoid__6.Health > 0 then
                    standJumpCool = false;
                    if not standIsSummoned then
                        l__misc__17:FireServer(2, l__summonstand__12, math.random(90, 110) / 100);
                        l__misc__17:FireServer(1, l__summonstand__12, 0);
                        local descendants = l__Stand__20:GetDescendants()
                        for i,v in pairs(descendants) do
                            if v ~= nil then
                                if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "RootPart" and v.Name ~= "finger" and v.Name ~= "Torso" and v.Name ~= "Head" and v.Name ~= "Left Arm" and v.Name ~= "Right Arm" and v.Name ~= "Left Leg" and v.Name ~= "Right Leg" then
                                    l__misc__17:FireServer(3, v, 0);
                                end
                            end
                        end
                        standIsSummoned = true;
                    end;
                    local l__lookVector__219 = l__Character__3.HumanoidRootPart.CFrame.lookVector;
                    local v220 = 150;
                    if v220 > 200 then
                        v220 = 200;
                    end;
                    l__misc__17:FireServer(16, l__Character__3.HumanoidRootPart, Vector3.new(l__lookVector__219.X * (30 + v220 / 1.5), 30 + v220 / 2, l__lookVector__219.Z * (30 + v220 / 1.5)));
                    coroutine.wrap(function()
                        _G.indicatecooldown("Stand Jump", StandJumpCoolLength);
                        wait(StandJumpCoolLength);
                        standJumpCool = true;
                    end)();
                elseif (p33.KeyCode == Enum.KeyCode.Q or p33.KeyCode == Enum.KeyCode.ButtonY) and not u14 and ((not AttackingValue or AnimValue == 5) and l__Humanoid__6.Health > 0) then
                    if not standIsSummoned then
                        l__misc__17:FireServer(2, l__summonstand__12, 1);
                        l__misc__17:FireServer(1, l__summonstand__12, 0);
                        local descendants = l__Stand__20:GetDescendants()
                        for i,v in pairs(descendants) do
                            if v ~= nil then
                                if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "RootPart" and v.Name ~= "finger" and v.Name ~= "Torso" and v.Name ~= "Head" and v.Name ~= "Left Arm" and v.Name ~= "Right Arm" and v.Name ~= "Left Leg" and v.Name ~= "Right Leg" then
                                    l__misc__17:FireServer(3, v, 0);
                                end
                            end
                        end
                        standIsSummoned = true;
                    elseif standIsSummoned then
                        local descendants = l__Stand__20:GetDescendants()
                        for i,v in pairs(descendants) do
                            if v ~= nil then
                                if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "RootPart" and v.Name ~= "finger" and v.Name ~= "Torso" and v.Name ~= "Head" and v.Name ~= "Left Arm" and v.Name ~= "Right Arm" and v.Name ~= "Left Leg" and v.Name ~= "Right Leg" then
                                    l__misc__17:FireServer(3, v, 1);
                                end
                            end
                        end
                        standIsSummoned = false;
                    end;
                elseif (p33.KeyCode == Enum.KeyCode.G or p33.KeyCode == Enum.KeyCode.DPadDown) and not AttackingValue and l__Humanoid__6.Health > 0 then
                    AttackingValue = true;
                    u6 = 0;
                    Speed = 0.04;
                    l__misc__17:FireServer(0, l__Menacing__11, true);
                    l__misc__17:FireServer(5, l__Humanoid__6, 0);
                    l__misc__17:FireServer(7, l__Humanoid__6, 0);
                    AnimValue = 5;
                    AnimKeyframe = 0;
                elseif (p33.KeyCode == Enum.KeyCode.G or p33.KeyCode == Enum.KeyCode.DPadDown) and AnimValue == 5 and l__Humanoid__6.Health > 0 then
                    AnimValue = -1;
                    AnimKeyframe = 0;
                    AttackingValue = false;
                    l__misc__17:FireServer(0, l__Menacing__11, false);
                    if u9 then
                        l__misc__17:FireServer(5, l__Humanoid__6, 20);
                    else
                        l__misc__17:FireServer(5, l__Humanoid__6, 16);
                    end;
                    l__misc__17:FireServer(7, l__Humanoid__6, 50);
                elseif (p33.KeyCode == Enum.KeyCode.X or p33.KeyCode == Enum.KeyCode.DPadUp) and not AttackingValue and l__Humanoid__6.Health > 0 and not u14 and u13 == 0 and u48 and l__Parent__1:WaitForChild("IsHamon").Value == true then

                    u14 = true;
                    u15 = true;
                    u48 = false;
                    l__misc__17:FireServer(0, v38, true);
                    l__misc__17:FireServer(0, v37, true);
                    coroutine.wrap(function()
                        _G.indicatecooldown("Hamon Breathing", 15 * v19);
                        wait(15 * v19);
                        u48 = true;
                    end)();
                elseif p33.KeyCode == Enum.KeyCode.C then
                    u49 = true;
                elseif (p33.KeyCode == Enum.KeyCode.LeftControl or p33.KeyCode == Enum.KeyCode.ButtonL3) and not AttackingValue and l__Humanoid__6.Health > 0 then
                    if u9 then
                        u9 = false;
                        l__misc__17:FireServer(5, l__Humanoid__6, 16);

                    else
                        u9 = true;
                        l__misc__17:FireServer(5, l__Humanoid__6, 20);
                        if AnimValue == 1 then
                            Speed = 0.04;
                        end;
                    end;
                end;
            end;
            if (p33.UserInputType == Enum.UserInputType.MouseButton1 or p33.KeyCode == Enum.KeyCode.ButtonX) and not u42 and (l__PlayerGui__5:WaitForChild("statUI"):FindFirstChild("background").Position ~= UDim2.new(0.7, 0, 0.06, 0) and u38 and not AttackingValue and not u14 and l__Humanoid__6.Health > 0) then
                if not standIsSummoned then
                    l__misc__17:FireServer(2, l__summonstand__12, math.random(90, 110) / 100);
                    l__misc__17:FireServer(1, l__summonstand__12, 0);
                    local descendants = l__Stand__20:GetDescendants()
                    for i,v in pairs(descendants) do
                        if v ~= nil then
                            if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "RootPart" and v.Name ~= "finger" and v.Name ~= "Torso" and v.Name ~= "Head" and v.Name ~= "Left Arm" and v.Name ~= "Right Arm" and v.Name ~= "Left Leg" and v.Name ~= "Right Leg" then
                                l__misc__17:FireServer(3, v, 0);
                            end
                        end
                    end
                    standIsSummoned = true;
                end;
                local v242 = math.random(0, 1);
                if v242 == 0 then
                    if not u31 then
                        local hum;
                        for _,v in pairs (CastRegion(l__Character__3,math.huge,NewRegion(l__Stand__20["Right Arm"].CFrame, l__Stand__20["Right Arm"].Size))) do
                            if not hum then if v.Parent and v.Parent:FindFirstChildOfClass("Humanoid") and (v.Parent:FindFirstChild("Torso") or v.Parent:FindFirstChild("UpperTorso")) then hum = v.Parent:FindFirstChildOfClass("Humanoid") end end
                            if not hum then if v.Parent and v.Parent.Name == "Stand" then hum = v.Parent.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid") end end
                        end
                        if hum and hum.Health > 0 then
                            local result = l__hitbox__16:InvokeServer(72, l__Stand__20["Right Arm"], l__Stand__20["Right Arm"].CFrame, barragedmg, l__voiceline__10, hum, false, false, false)
                            if result then
                                u31 = true;
                            end
                        end;
                    end;

                    AttackingValue = true;
                    u38 = false;
                    AnimValue = 7;
                    AnimKeyframe = 0;
                    u6 = 0;
                    l__misc__17:FireServer(7, l__Humanoid__6, 0);
                    u33 = 0;
                    u17 = u6;
                    Speed = 0.025 * l__Parent__1:WaitForChild("Speed").Value * u34;
                    u31 = false;
                    u35 = StandRightArmOrig * CFrame.new(math.random(15, 35) / 70, 0, 0) * CFrame.Angles(math.rad(math.random(-500, -100) / 100), math.rad(math.random(-3100, 1200) / 100), math.rad(math.random(8600, 9400) / 100));
                elseif v242 == 1 then
                    AttackingValue = true;
                    u38 = false;
                    AnimValue = 8;
                    AnimKeyframe = 0;
                    u6 = 0;
                    l__misc__17:FireServer(7, l__Humanoid__6, 0);
                    u33 = 0;
                    u17 = u6;
                    Speed = 0.025 * l__Parent__1:WaitForChild("Speed").Value * u34;
                    u31 = false;
                    u32 = StandLeftArmOrig * CFrame.new(math.random(-35, -15) / 70, 0, 0) * CFrame.Angles(math.rad(math.random(-500, -100) / 100), math.rad(math.random(1200, 3100) / 100), math.rad(math.random(-9400, -8600) / 100));
                end;
            end;
        end;
    end);
    l__UserInputService__13.InputEnded:connect(function(p34)
        if (p34.KeyCode == Enum.KeyCode.E or p34.KeyCode == Enum.KeyCode.ButtonR2) and AnimValue == 3 then
            u6 = 0;
            AttackingValue = false;
            coroutine.wrap(function()
                _G.indicatecooldown("Ora Barrage", barrageCoolLength);
                wait(barrageCoolLength);
                barrageCool = true;
            end)();
            stopSound()
            AnimValue = -1;
            AnimKeyframe = 0;
            l__misc__17:FireServer(7, l__Humanoid__6, 50);
            Speed = 0.02;
            return;
        end;
        if p34.KeyCode == Enum.KeyCode.C then
            u49 = false;
            return;
        end;
    end);
    l__Humanoid__6.Died:connect(function()
        if standIsSummoned then
            local descendants = l__Stand__20:GetDescendants()
            for i,v in pairs(descendants) do
                if v ~= nil then
                    if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "RootPart" and v.Name ~= "finger" and v.Name ~= "Torso" and v.Name ~= "Head" and v.Name ~= "Left Arm" and v.Name ~= "Right Arm" and v.Name ~= "Left Leg" and v.Name ~= "Right Leg" then
                        l__misc__17:FireServer(3, v, 1);
                    end
                end
            end
            standIsSummoned = false;
        end;
    end);
    local AnimValue0 = l__Humanoid__6.Health;
    local AnimValue1 = true;
    l__Humanoid__6.HealthChanged:connect(function(p35)
        if p35 < AnimValue0 and AnimValue1 then
            AnimValue1 = false;
            AnimValue0 = p35;
            local v249 = math.random(0, 1);
            if v249 == 0 then
                PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(0.3839724354387525, 0, -0.13962634015954636), 0.5);
                PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(0.08726646259971647, -0.03490658503988659, 0.08726646259971647), 0.5);
                PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(0.3839724354387525, 0.08726646259971647, -0.5585053606381855), 0.5);
                PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(0.3665191429188092, 0.08726646259971647, 0.5759586531581288), 0.5);
                PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.Angles(-0.03490658503988659, 0.03490658503988659, 0.3839724354387525), 0.5);
                PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(-0.03490658503988659, -0.03490658503988659, -0.3839724354387525), 0.5);
            elseif v249 == 1 then
                PlayerJoints[1].C0 = PlayerJoints[1].C0:lerp(TorsoOrig * CFrame.Angles(-0.3839724354387525, 0, 0.13962634015954636), 0.5);
                PlayerJoints[2].C0 = PlayerJoints[2].C0:lerp(HeadOrig * CFrame.Angles(-0.08726646259971647, 0.03490658503988659, -0.08726646259971647), 0.5);
                PlayerJoints[3].C0 = PlayerJoints[3].C0:lerp(LeftArmOrig * CFrame.Angles(-0.3839724354387525, -0.08726646259971647, 0.5585053606381855), 0.5);
                PlayerJoints[4].C0 = PlayerJoints[4].C0:lerp(RightArmOrig * CFrame.Angles(-0.3665191429188092, -0.08726646259971647, -0.5759586531581288), 0.5);
                PlayerJoints[5].C0 = PlayerJoints[5].C0:lerp(LeftLegOrig * CFrame.Angles(0.03490658503988659, -0.03490658503988659, -0.3839724354387525), 0.5);
                PlayerJoints[6].C0 = PlayerJoints[6].C0:lerp(RightLegOrig * CFrame.Angles(0.03490658503988659, 0.03490658503988659, 0.3839724354387525), 0.5);
            end;
            wait(0.2);
            AnimValue1 = true;
        end;
    end);
    local AnimValue2 = v36;
    workspace.timestopped.Changed:connect(function(p36)

    end);
    workspace.timeaccelerated.Changed:connect(function(p37)

    end);
    l__Character__3:WaitForChild("weakened").Changed:connect(function(p38)

    end);
    local l__isattacking__53 = l__Parent__1:WaitForChild("isattacking");
    local l__forceattacking__54 = l__Parent__1:WaitForChild("forceattacking");
    spawn(function()
        while wait() do
            l__isattacking__53.Value = AttackingValue;
            if not standIsSummoned then
                l__isattacking__53.Value = true;
            end;
            if l__forceattacking__54.Value == true and AnimValue ~= -1337 then
                AttackingValue = true;
                AnimValue = -1337;
            end;
            if l__forceattacking__54.Value == false and AnimValue == -1337 then
                AttackingValue = false;
                AnimValue = 0;
            end;	
        end;
    end);
end)
coroutine.resume(totalWrap)
l__Character__3.Destroying:Connect(function ()
    coroutine.yield(totalWrap)
end)


