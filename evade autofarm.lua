-- https://t.me/thescr1ptscracks
-- lite edition. translate: мне стало слишком лень делать самому поэтому я накалякал через дипсика

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ticketsFolder = Workspace:WaitForChild("Effects"):WaitForChild("Tickets")

print("✅ Tickets найден:", ticketsFolder)

local State = {
    ESP = true,
    AutoFarm = false,
    AntiAFK = false,
    MenuOpen = true,
    SafeZonePos = Vector3.new(0, 5000, 0),
    SafePlatform = nil
}

local ESP_Table = {}
local AntiAfkConnection = nil
local FarmThread = nil
local RenderConnection = nil
local DescendantConnection = nil
local ScreenGui = nil

-- ==========================================
--   SAFE ZONE
-- ==========================================
local function CreateSafePlatform()
    if State.SafePlatform then return end
    local part = Instance.new("Part")
    part.Name = "SafeZonePlatform"
    part.Size = Vector3.new(50, 2, 50)
    part.Position = State.SafeZonePos - Vector3.new(0, 4, 0)
    part.Anchored = true
    part.CanCollide = true
    part.Transparency = 0.5
    part.Color = Color3.fromRGB(0, 255, 255)
    part.Material = Enum.Material.Neon
    part.Parent = Workspace
    State.SafePlatform = part
end

local function DestroySafePlatform()
    if State.SafePlatform then
        State.SafePlatform:Destroy()
        State.SafePlatform = nil
    end
end

-- ==========================================
--   ANTI-AFK
-- ==========================================
local function ToggleAntiAFK(bool)
    if bool then
        if AntiAfkConnection then AntiAfkConnection:Disconnect() end
        AntiAfkConnection = LocalPlayer.Idled:Connect(function()
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end)
    else
        if AntiAfkConnection then
            AntiAfkConnection:Disconnect()
            AntiAfkConnection = nil
        end
    end
end

-- ==========================================
--   UNLOAD FUNCTION
-- ==========================================
local function Unload()
    print("🔄 Выгружаем скрипт...")
    
    -- Отключаем Anti-AFK
    ToggleAntiAFK(false)
    
    -- Отключаем рендер ESP
    if RenderConnection then
        RenderConnection:Disconnect()
        RenderConnection = nil
    end
    
    -- Отключаем DescendantAdded
    if DescendantConnection then
        DescendantConnection:Disconnect()
        DescendantConnection = nil
    end
    
    -- Удаляем ESP линии и хайлайты
    for obj, d in pairs(ESP_Table) do
        if d.Line then 
            pcall(function() d.Line:Remove() end)
        end
        if d.Highlight then 
            pcall(function() d.Highlight:Destroy() end)
        end
        if d.Billboard then 
            pcall(function() d.Billboard:Destroy() end)
        end
    end
    ESP_Table = {}
    
    -- Останавливаем фарм
    if FarmThread then
        pcall(function() coroutine.close(FarmThread) end)
        FarmThread = nil
    end
    
    -- Удаляем платформу
    DestroySafePlatform()
    
    -- Удаляем GUI
    if ScreenGui then
        pcall(function() ScreenGui:Destroy() end)
        ScreenGui = nil
    end
    
    print("❌ TICKET FARM ВЫГРУЖЕН")
end

-- ==========================================
--   GUI
-- ==========================================
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TicketFarm"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 270)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BackgroundTransparency = 0.5
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- ФОН
local Background = Instance.new("ImageLabel")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.BackgroundTransparency = 1
Background.Image = "rbxassetid://89390170485449"
Background.ScaleType = Enum.ScaleType.Slice
Background.SliceCenter = Rect.new(4, 4, 4, 4)
Background.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 200, 200)
Stroke.Thickness = 2
Stroke.Parent = MainFrame

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "TICKET FARM"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local function CreateButton(name, text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = 0.3
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = MainFrame
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        local newState = callback()
        if newState then
            btn.TextColor3 = Color3.fromRGB(0, 255, 100)
            btn.Text = text:gsub("OFF", "ON")
        else
            btn.TextColor3 = Color3.fromRGB(255, 60, 60)
            btn.Text = text:gsub("ON", "OFF")
        end
    end)
    return btn
end

-- КНОПКИ
local BtnESP = CreateButton("BtnESP", "Visuals: ON", 50, function()
    State.ESP = not State.ESP
    if not State.ESP then
        for _, d in pairs(ESP_Table) do
            if d.Line then d.Line.Visible = false end
        end
    end
    return State.ESP
end)
BtnESP.TextColor3 = Color3.fromRGB(0, 255, 100)

local BtnFarm = CreateButton("BtnFarm", "Safe Farm: OFF", 95, function()
    State.AutoFarm = not State.AutoFarm
    if State.AutoFarm then CreateSafePlatform() end
    return State.AutoFarm
end)

local BtnAFK = CreateButton("BtnAFK", "Anti-AFK: OFF", 140, function()
    State.AntiAFK = not State.AntiAFK
    ToggleAntiAFK(State.AntiAFK)
    return State.AntiAFK
end)

-- КНОПКА UNLOAD
local UnloadBtn = Instance.new("TextButton")
UnloadBtn.Name = "UnloadBtn"
UnloadBtn.Size = UDim2.new(0.9, 0, 0, 35)
UnloadBtn.Position = UDim2.new(0.05, 0, 0, 185)
UnloadBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
UnloadBtn.BackgroundTransparency = 0.3
UnloadBtn.Text = "UNLOAD"
UnloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnloadBtn.Font = Enum.Font.GothamSemibold
UnloadBtn.Parent = MainFrame

local UnloadCorner = Instance.new("UICorner")
UnloadCorner.CornerRadius = UDim.new(0, 6)
UnloadCorner.Parent = UnloadBtn

UnloadBtn.MouseButton1Click:Connect(function()
    Unload()
end)

local Credits = Instance.new("TextLabel")
Credits.Text = ""
Credits.Size = UDim2.new(1, 0, 0, 20)
Credits.Position = UDim2.new(0, 0, 1, -25)
Credits.BackgroundTransparency = 1
Credits.TextColor3 = Color3.fromRGB(100, 100, 100)
Credits.Font = Enum.Font.Gotham
Credits.TextSize = 10
Credits.Parent = MainFrame

-- ОТКРЫТИЕ ПО КНОПКЕ 1
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.One then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ==========================================
--   ESP
-- ==========================================
local function GetScreenEdgePosition(center, dir, vpSize, offset)
    local halfX = (vpSize.X / 2) - offset
    local halfY = (vpSize.Y / 2) - offset
    local factor = math.min(halfX / math.abs(dir.X), halfY / math.abs(dir.Y))
    return center + (dir * factor)
end

local function removeESP(obj)
    if ESP_Table[obj] then
        if ESP_Table[obj].Line then 
            pcall(function() ESP_Table[obj].Line:Remove() end)
        end
        if ESP_Table[obj].Highlight then 
            pcall(function() ESP_Table[obj].Highlight:Destroy() end)
        end
        if ESP_Table[obj].Billboard then 
            pcall(function() ESP_Table[obj].Billboard:Destroy() end)
        end
        ESP_Table[obj] = nil
    end
end

local function createESP(obj)
    if ESP_Table[obj] then return end
    local h = Instance.new("Highlight")
    h.FillColor = Color3.fromRGB(255, 0, 0)
    h.Parent = obj
    
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 50, 0, 15)
    bb.AlwaysOnTop = true
    bb.Parent = obj
    bb.StudsOffset = Vector3.new(0, 2, 0)
    
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 1, 0)
    t.BackgroundTransparency = 1
    t.Text = "TICKET"
    t.TextColor3 = Color3.fromRGB(255, 0, 0)
    t.TextScaled = true
    t.Parent = bb
    
    local l = Drawing.new("Line")
    l.Visible = false
    l.Color = Color3.fromRGB(255, 0, 0)
    l.Thickness = 1
    
    ESP_Table[obj] = {Line = l, Highlight = h, Billboard = bb, Part = obj}
    obj.AncestryChanged:Connect(function(_, p)
        if not p then removeESP(obj) end
    end)
end

RenderConnection = RunService.RenderStepped:Connect(function()
    if not State.ESP then return end
    local vp = Camera.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)
    for obj, d in pairs(ESP_Table) do
        if not d.Part or not d.Part.Parent then
            removeESP(obj)
        else
            local pos, onScreen = Camera:WorldToViewportPoint(d.Part.Position)
            d.Line.Visible = true
            d.Line.From = center
            if onScreen then
                d.Line.To = Vector2.new(pos.X, pos.Y)
            else
                local dir = (Vector2.new(pos.X, pos.Y) - center)
                if pos.Z < 0 then dir = -dir end
                d.Line.To = GetScreenEdgePosition(center, dir.Unit, vp, 25)
            end
        end
    end
end)

for _, v in ipairs(ticketsFolder:GetDescendants()) do
    if v:IsA("BasePart") then createESP(v) end
end
DescendantConnection = ticketsFolder.DescendantAdded:Connect(function(v)
    if v:IsA("BasePart") then createESP(v) end
end)

-- ==========================================
--   AUTO FARM (СТОИТ 2 СЕКУНДЫ НА ТИКЕТЕ)
-- ==========================================
FarmThread = coroutine.create(function()
    while true do
        task.wait(0.1)
        if State.AutoFarm then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                
                -- Ищем первый попавшийся тикет
                local targetTicket = nil
                for _, v in ipairs(ticketsFolder:GetDescendants()) do
                    if v:IsA("BasePart") and v.Parent then
                        targetTicket = v
                        break
                    end
                end
                
                if targetTicket then
                    -- Телепорт на тикет
                    hrp.CFrame = targetTicket.CFrame + Vector3.new(0, 2, 0)
                    task.wait(0.5)  -- Стоим 0.5 сек
                    
                    -- ДВИГАЕМСЯ ВНУТРИ ТИКЕТА ЧТОБЫ ПОДОБРАТЬ
                    hrp.CFrame = targetTicket.CFrame + Vector3.new(1, 2, 0)
                    task.wait(0.3)
                    hrp.CFrame = targetTicket.CFrame + Vector3.new(-1, 2, 0)
                    task.wait(0.3)
                    hrp.CFrame = targetTicket.CFrame + Vector3.new(0, 2, 1)
                    task.wait(0.3)
                    hrp.CFrame = targetTicket.CFrame + Vector3.new(0, 2, -1)
                    task.wait(0.3)
                    
                    -- ЕЩЕ РАЗ ПО КРУГУ ДЛЯ НАДЕЖНОСТИ
                    hrp.CFrame = targetTicket.CFrame + Vector3.new(1, 2, 1)
                    task.wait(0.3)
                    hrp.CFrame = targetTicket.CFrame + Vector3.new(-1, 2, -1)
                    task.wait(0.3)
                    
                    -- Возврат на базу
                    if State.SafePlatform then
                        hrp.CFrame = CFrame.new(State.SafeZonePos + Vector3.new(0, 3, 0))
                    end
                    task.wait(0.2)
                elseif State.SafePlatform then
                    if (hrp.Position - State.SafeZonePos).Magnitude > 50 then
                        hrp.CFrame = CFrame.new(State.SafeZonePos + Vector3.new(0, 3, 0))
                    end
                end
            end
        end
    end
end)

coroutine.resume(FarmThread)
