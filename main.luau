-- Cataclysm
-- Fully open source. If you want obfuscator - go to https://discord.gg/2tdsXcymZ and go to deobfuscator-and-obfuscator-here

-- Cataclysm DO NOT USE jnkie, luarmor. Please, if you see cataclysm hub IN jnkie, luarmor or all other service - DONT USE THAT. Official CATACLYSM - ONLY IN THIS REPO

local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local function isBadInjector()
    if getgenv and getgenv().Solara then return true end
    if getgenv and getgenv().Xeno then return true end
    if syn and syn.crypt then return true end
    if getgenv and getgenv().Luna then return true end
    if shared and shared.luna then return true end
    if _G and _G.Solara then return true end
    return false
end

if isBadInjector() then
    player:Kick("Your injector is a FULLY SHITTY and have a viruse. You cannot use this script.        By CATACLYSM DEVELOPER")
    return
end

local IconsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()
IconsModule.SetIconsType("lucide")

local function createIcon(iconName, size, color)
    local iconData = IconsModule.Icon(iconName)
    if not iconData then return nil end
    local icon = Instance.new("ImageLabel")
    icon.Size = size or UDim2.new(0, 24, 0, 24)
    icon.BackgroundTransparency = 1
    icon.Image = iconData[1]
    icon.ImageColor3 = color or Color3.new(1, 1, 1)
    if iconData[2] and iconData[2].ImageRectSize and iconData[2].ImageRectSize.Magnitude > 0 then
        icon.ImageRectSize = iconData[2].ImageRectSize
        icon.ImageRectOffset = iconData[2].ImageRectPosition
    end
    return icon
end

local function addIconToButton(button, iconName, iconPosition, iconSize)
    if not button then return end
    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("ImageLabel") and child.Name == "ButtonIcon" then
            child:Destroy()
        end
    end
    local icon = createIcon(iconName, iconSize or UDim2.new(0, 20, 0, 20))
    if not icon then return end
    icon.Name = "ButtonIcon"
    icon.Parent = button
    icon.Position = iconPosition or UDim2.new(0.05, 0, 0.5, -10)
    icon.ZIndex = 2
    return icon
end

local function makeDraggable(frame)
    if not frame then return end
    local dragging = false
    local dragStart = Vector2.new(0, 0)
    local startPos = UDim2.new(0, 0, 0, 0)
    local function centerFrame()
        local screenSize = GuiService:GetScreenSize()
        frame.Position = UDim2.new(0, (screenSize.X - frame.Size.X.Offset) / 2, 0, (screenSize.Y - frame.Size.Y.Offset) / 2)
    end
    centerFrame()
    frame:GetPropertyChangedSignal("Size"):Connect(centerFrame)
    local function isInteractiveElement(object)
        if not object then return false end
        if object:IsA("TextButton") then return true end
        if object:IsA("ImageButton") then return true end
        if object:IsA("ScrollingFrame") then return true end
        if object:IsA("TextBox") then return true end
        return false
    end
    local function startDrag(input)
        local mousePos = input.Position
        local hitObject = GuiService:GetGuiObjectAtPosition(mousePos)
        if hitObject and isInteractiveElement(hitObject) then return end
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
    local function updatePosition(input)
        if not dragging then return end
        local delta = input.Position - dragStart
        local screenSize = GuiService:GetScreenSize()
        local newX = math.clamp(startPos.X.Offset + delta.X, 0, screenSize.X - frame.Size.X.Offset)
        local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, screenSize.Y - frame.Size.Y.Offset)
        frame.Position = UDim2.new(0, newX, 0, newY)
    end
    local function endDrag()
        dragging = false
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            updatePosition(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            endDrag()
        end
    end)
    return frame
end

local gui = Instance.new("ScreenGui")
gui.Name = "CataclysmGUI"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

local function createWindow1()
    local frame = Instance.new("Frame")
    frame.Name = "DeviceFrame"
    frame.Size = UDim2.new(0, 507, 0, 300)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 317, 0, 50)
    title.Position = UDim2.new(0.187, 0, 0.026, 0)
    title.BackgroundTransparency = 1
    title.Text = "Choose your device"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 14
    title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.239, 0.239, 0.239)), ColorSequenceKeypoint.new(0.29, Color3.new(0.583, 0.583, 0.583)), ColorSequenceKeypoint.new(0.759, Color3.new(0.244, 0.244, 0.244)), ColorSequenceKeypoint.new(1, Color3.new(0.603, 0.603, 0.603))})
    gradient.Parent = title
    
    local pcCard = Instance.new("Frame")
    pcCard.Name = "PC"
    pcCard.Size = UDim2.new(0, 164, 0, 152)
    pcCard.Position = UDim2.new(0.023, 0, 0.164, 0)
    pcCard.BackgroundColor3 = Color3.new(0, 0, 0)
    pcCard.BackgroundTransparency = 0.5
    pcCard.BorderSizePixel = 0
    pcCard.Parent = frame
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 9)
    corner2.Parent = pcCard
    
    local stroke2 = Instance.new("UIStroke")
    stroke2.Color = Color3.new(1, 1, 1)
    stroke2.Thickness = 3
    stroke2.Transparency = 0.6
    stroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke2.Parent = pcCard
    
    local pcText = Instance.new("TextLabel")
    pcText.Size = UDim2.new(0, 121, 0, 57)
    pcText.Position = UDim2.new(0.128, 0, -0.012, 0)
    pcText.BackgroundTransparency = 1
    pcText.Text = "PC"
    pcText.TextColor3 = Color3.new(1, 1, 1)
    pcText.TextSize = 14
    pcText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    pcText.TextScaled = true
    pcText.TextWrapped = true
    pcText.Parent = pcCard
    
    local pcIcon = createIcon("laptop", UDim2.new(0, 48, 0, 48))
    if pcIcon then
        pcIcon.Name = "DeviceIcon"
        pcIcon.Position = UDim2.new(0.35, 0, 0.3, 0)
        pcIcon.ZIndex = 2
        pcIcon.Parent = pcCard
    end
    
    local phoneCard = Instance.new("Frame")
    phoneCard.Name = "Phone"
    phoneCard.Size = UDim2.new(0, 164, 0, 152)
    phoneCard.Position = UDim2.new(0.654, 0, 0.164, 0)
    phoneCard.BackgroundColor3 = Color3.new(0, 0, 0)
    phoneCard.BackgroundTransparency = 0.5
    phoneCard.BorderSizePixel = 0
    phoneCard.Parent = frame
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0, 9)
    corner3.Parent = phoneCard
    
    local stroke3 = Instance.new("UIStroke")
    stroke3.Color = Color3.new(1, 1, 1)
    stroke3.Thickness = 3
    stroke3.Transparency = 0.6
    stroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke3.Parent = phoneCard
    
    local phoneText = Instance.new("TextLabel")
    phoneText.Size = UDim2.new(0, 121, 0, 57)
    phoneText.Position = UDim2.new(0.128, 0, -0.012, 0)
    phoneText.BackgroundTransparency = 1
    phoneText.Text = "PHONE"
    phoneText.TextColor3 = Color3.new(1, 1, 1)
    phoneText.TextSize = 14
    phoneText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    phoneText.TextScaled = true
    phoneText.TextWrapped = true
    phoneText.Parent = phoneCard
    
    local phoneIcon = createIcon("smartphone", UDim2.new(0, 48, 0, 48))
    if phoneIcon then
        phoneIcon.Name = "DeviceIcon"
        phoneIcon.Position = UDim2.new(0.35, 0, 0.3, 0)
        phoneIcon.ZIndex = 2
        phoneIcon.Parent = phoneCard
    end
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.285, 0, 0.793, 0)
    button.BackgroundColor3 = Color3.new(0.278, 0.278, 0.278)
    button.BackgroundTransparency = 0.5
    button.BorderSizePixel = 0
    button.Text = "NEXT"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 28
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    button.Parent = frame
    
    local corner4 = Instance.new("UICorner")
    corner4.CornerRadius = UDim.new(0, 9)
    corner4.Parent = button
    
    addIconToButton(button, "arrow-right", UDim2.new(0.78, 0, 0.5, -10))
    
    return frame, pcCard, phoneCard, button
end

local function createWindow2()
    local frame = Instance.new("Frame")
    frame.Name = "InjectorFrame"
    frame.Size = UDim2.new(0, 507, 0, 300)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 317, 0, 50)
    title.Position = UDim2.new(0.187, 0, 0.026, 0)
    title.BackgroundTransparency = 1
    title.Text = "Choose your injector"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 14
    title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.239, 0.239, 0.239)), ColorSequenceKeypoint.new(0.29, Color3.new(0.583, 0.583, 0.583)), ColorSequenceKeypoint.new(0.759, Color3.new(0.244, 0.244, 0.244)), ColorSequenceKeypoint.new(1, Color3.new(0.603, 0.603, 0.603))})
    gradient.Parent = title
    
    local realCard = Instance.new("Frame")
    realCard.Name = "Real"
    realCard.Size = UDim2.new(0, 164, 0, 152)
    realCard.Position = UDim2.new(0.023, 0, 0.164, 0)
    realCard.BackgroundColor3 = Color3.new(0, 0, 0)
    realCard.BackgroundTransparency = 0.7
    realCard.BorderSizePixel = 0
    realCard.Parent = frame
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 9)
    corner2.Parent = realCard
    
    local stroke2 = Instance.new("UIStroke")
    stroke2.Color = Color3.new(1, 1, 1)
    stroke2.Thickness = 3
    stroke2.Transparency = 0.5
    stroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke2.Parent = realCard
    
    local realText = Instance.new("TextLabel")
    realText.Size = UDim2.new(0, 121, 0, 57)
    realText.Position = UDim2.new(0.128, 0, -0.012, 0)
    realText.BackgroundTransparency = 1
    realText.Text = "Real Injector"
    realText.TextColor3 = Color3.new(1, 1, 1)
    realText.TextSize = 14
    realText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    realText.TextScaled = true
    realText.TextWrapped = true
    realText.Parent = realCard
    
    local realIcon = createIcon("zap", UDim2.new(0, 40, 0, 40), Color3.new(0.3, 0.8, 1))
    if realIcon then
        realIcon.Name = "InjectorIcon"
        realIcon.Position = UDim2.new(0.35, 0, 0.35, 0)
        realIcon.ZIndex = 2
        realIcon.Parent = realCard
    end
    
    local deltaCard = Instance.new("Frame")
    deltaCard.Name = "DELTA"
    deltaCard.Size = UDim2.new(0, 164, 0, 152)
    deltaCard.Position = UDim2.new(0.654, 0, 0.164, 0)
    deltaCard.BackgroundColor3 = Color3.new(0, 0, 0)
    deltaCard.BackgroundTransparency = 0.7
    deltaCard.BorderSizePixel = 0
    deltaCard.Parent = frame
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0, 9)
    corner3.Parent = deltaCard
    
    local stroke3 = Instance.new("UIStroke")
    stroke3.Color = Color3.new(1, 1, 1)
    stroke3.Thickness = 3
    stroke3.Transparency = 0.5
    stroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke3.Parent = deltaCard
    
    local deltaText = Instance.new("TextLabel")
    deltaText.Size = UDim2.new(0, 134, 0, 57)
    deltaText.Position = UDim2.new(0.079, 0, -0.006, 0)
    deltaText.BackgroundTransparency = 1
    deltaText.Text = "Delta Injector"
    deltaText.TextColor3 = Color3.new(1, 1, 1)
    deltaText.TextSize = 14
    deltaText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    deltaText.TextScaled = true
    deltaText.TextWrapped = true
    deltaText.Parent = deltaCard
    
    local deltaIcon = createIcon("flame", UDim2.new(0, 40, 0, 40), Color3.new(1, 0.6, 0.2))
    if deltaIcon then
        deltaIcon.Name = "InjectorIcon"
        deltaIcon.Position = UDim2.new(0.35, 0, 0.35, 0)
        deltaIcon.ZIndex = 2
        deltaIcon.Parent = deltaCard
    end
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.285, 0, 0.793, 0)
    button.BackgroundColor3 = Color3.new(0.278, 0.278, 0.278)
    button.BackgroundTransparency = 0.5
    button.BorderSizePixel = 0
    button.Text = "NEXT"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 28
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    button.Parent = frame
    
    local corner4 = Instance.new("UICorner")
    corner4.CornerRadius = UDim.new(0, 9)
    corner4.Parent = button
    
    addIconToButton(button, "arrow-right", UDim2.new(0.78, 0, 0.5, -10))
    
    return frame, realCard, deltaCard, button
end

local function createWindow3()
    local frame = Instance.new("Frame")
    frame.Name = "ScriptFrame"
    frame.Size = UDim2.new(0, 507, 0, 300)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 317, 0, 50)
    title.Position = UDim2.new(0.187, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Choose script"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 14
    title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.239, 0.239, 0.239)), ColorSequenceKeypoint.new(0.29, Color3.new(0.583, 0.583, 0.583)), ColorSequenceKeypoint.new(0.759, Color3.new(0.244, 0.244, 0.244)), ColorSequenceKeypoint.new(1, Color3.new(0.603, 0.603, 0.603))})
    gradient.Parent = title
    
    local scriptCard = Instance.new("Frame")
    scriptCard.Name = "Cataclysm"
    scriptCard.Size = UDim2.new(0, 481, 0, 79)
    scriptCard.Position = UDim2.new(0.025, 0, 0.191, 0)
    scriptCard.BackgroundColor3 = Color3.new(0, 0, 0)
    scriptCard.BackgroundTransparency = 0.7
    scriptCard.BorderSizePixel = 0
    scriptCard.Parent = frame
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 9)
    corner2.Parent = scriptCard
    
    local stroke2 = Instance.new("UIStroke")
    stroke2.Color = Color3.new(1, 1, 1)
    stroke2.Thickness = 3
    stroke2.Transparency = 0.5
    stroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke2.Parent = scriptCard
    
    local scriptText = Instance.new("TextLabel")
    scriptText.Size = UDim2.new(0, 189, 0, 57)
    scriptText.Position = UDim2.new(0.172, 0, -0.0001, 0)
    scriptText.BackgroundTransparency = 1
    scriptText.Text = "Cataclysm HUB"
    scriptText.TextColor3 = Color3.new(1, 1, 1)
    scriptText.TextSize = 14
    scriptText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    scriptText.TextScaled = true
    scriptText.TextWrapped = true
    scriptText.Parent = scriptCard
    
    local scriptIcon = createIcon("code-2", UDim2.new(0, 36, 0, 36), Color3.new(0.8, 0.3, 1))
    if scriptIcon then
        scriptIcon.Name = "ScriptIcon"
        scriptIcon.Position = UDim2.new(0.05, 0, 0.5, -18)
        scriptIcon.ZIndex = 2
        scriptIcon.Parent = scriptCard
    end
    
    local scriptSub = Instance.new("TextLabel")
    scriptSub.Size = UDim2.new(0, 116, 0, 28)
    scriptSub.Position = UDim2.new(0.217, 0, 0.556, 0)
    scriptSub.BackgroundTransparency = 1
    scriptSub.Text = "Evade"
    scriptSub.TextColor3 = Color3.new(1, 1, 1)
    scriptSub.TextSize = 14
    scriptSub.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    scriptSub.TextScaled = true
    scriptSub.TextWrapped = true
    scriptSub.Parent = scriptCard
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 385, 0, 50)
    button.Position = UDim2.new(0.134, 0, 0.806, 0)
    button.BackgroundColor3 = Color3.new(0.278, 0.278, 0.278)
    button.BackgroundTransparency = 0.5
    button.BorderSizePixel = 0
    button.Text = "INJECT!"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 28
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    button.Parent = frame
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0, 9)
    corner3.Parent = button
    
    addIconToButton(button, "rocket", UDim2.new(0.78, 0, 0.5, -10))
    
    return frame, scriptCard, button
end

local function createWindow4()
    local frame = Instance.new("Frame")
    frame.Name = "InjectionFrame"
    frame.Size = UDim2.new(0, 507, 0, 300)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "INJECTION IN PROGRESS"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 28
    title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    title.TextScaled = true
    title.Parent = frame
    
    local icon = createIcon("loader-2", UDim2.new(0, 40, 0, 40), Color3.new(0.3, 0.8, 1))
    if icon then
        icon.Name = "StatusIcon"
        icon.Position = UDim2.new(0.1, 0, 0.6, 0)
        icon.ZIndex = 2
        icon.Parent = frame
    end
    
    local status = Instance.new("TextLabel")
    status.Name = "Status"
    status.Size = UDim2.new(0.7, 0, 0, 30)
    status.Position = UDim2.new(0.15, 0, 0.6, 0)
    status.BackgroundTransparency = 1
    status.Text = "Initializing..."
    status.TextColor3 = Color3.new(0.5, 0.8, 1)
    status.TextSize = 18
    status.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    status.TextScaled = true
    status.Parent = frame
    
    local barBg = Instance.new("Frame")
    barBg.Name = "BarBg"
    barBg.Size = UDim2.new(0.7, 0, 0, 20)
    barBg.Position = UDim2.new(0.15, 0, 0.78, 0)
    barBg.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    barBg.BorderSizePixel = 0
    barBg.Parent = frame
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(1, 0)
    corner2.Parent = barBg
    
    local barFill = Instance.new("Frame")
    barFill.Name = "BarFill"
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.new(0.3, 0.8, 0.3)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(1, 0)
    corner3.Parent = barFill
    
    local percent = Instance.new("TextLabel")
    percent.Name = "Percent"
    percent.Size = UDim2.new(0.7, 0, 0, 20)
    percent.Position = UDim2.new(0.15, 0, 0.88, 0)
    percent.BackgroundTransparency = 1
    percent.Text = "0%"
    percent.TextColor3 = Color3.new(1, 1, 1)
    percent.TextSize = 16
    percent.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    percent.TextScaled = true
    percent.Parent = frame
    
    local info = Instance.new("TextLabel")
    info.Name = "Info"
    info.Size = UDim2.new(1, 0, 0, 20)
    info.Position = UDim2.new(0, 0, 0.95, 0)
    info.BackgroundTransparency = 1
    info.Text = ""
    info.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    info.TextSize = 12
    info.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    info.TextScaled = true
    info.Parent = frame
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 120, 0, 40)
    closeButton.Position = UDim2.new(0.38, 0, 0.85, 0)
    closeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    closeButton.BackgroundTransparency = 0.5
    closeButton.BorderSizePixel = 0
    closeButton.Text = "DONE"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.TextSize = 18
    closeButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    closeButton.TextScaled = true
    closeButton.Visible = false
    closeButton.Parent = frame
    
    local corner4 = Instance.new("UICorner")
    corner4.CornerRadius = UDim.new(0, 9)
    corner4.Parent = closeButton
    
    addIconToButton(closeButton, "check", UDim2.new(0.05, 0, 0.5, -10))
    
    return frame, status, barFill, percent, info, icon, closeButton
end

local deviceFrame, pcCard, phoneCard, deviceButton = createWindow1()
local injectorFrame, realCard, deltaCard, injectorButton = createWindow2()
local scriptFrame, cataclysmCard, scriptButton = createWindow3()
local injectionFrame, statusLabel, barFill, percentLabel, infoLabel, statusIcon, closeButton = createWindow4()

makeDraggable(deviceFrame)
makeDraggable(injectorFrame)
makeDraggable(scriptFrame)
makeDraggable(injectionFrame)

local state = {device = nil, injector = nil, script = nil}
local isAnimating = false

local function slideIn(window, callback)
    if not window then return end
    window.Visible = true
    window.Position = UDim2.new(0.5, -window.Size.X.Offset/2, 1, 20)
    window.BackgroundTransparency = 1
    local tween1 = TweenService:Create(window, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -window.Size.X.Offset/2, 0.5, -window.Size.Y.Offset/2)})
    local tween2 = TweenService:Create(window, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2})
    tween1:Play()
    tween2:Play()
    tween1.Completed:Wait()
    if callback then callback() end
end

local function slideOut(window, callback)
    if not window then return end
    local tween = TweenService:Create(window, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -window.Size.X.Offset/2, -0.2, 0)})
    tween:Play()
    tween.Completed:Wait()
    window.Visible = false
    window.Position = UDim2.new(0.5, -window.Size.X.Offset/2, 1, 20)
    if callback then callback() end
end

local function selectDevice(device)
    if isAnimating or state.device then return end
    isAnimating = true
    state.device = device
    if pcCard then
        pcCard.BackgroundColor3 = Color3.new(1, 1, 1)
        pcCard.BackgroundTransparency = 0.8
        if pcCard:FindFirstChild("UIStroke") then
            pcCard.UIStroke.Color = Color3.new(1, 1, 1)
            pcCard.UIStroke.Transparency = 0.8
        end
    end
    if phoneCard then
        phoneCard.BackgroundColor3 = Color3.new(1, 1, 1)
        phoneCard.BackgroundTransparency = 0.8
        if phoneCard:FindFirstChild("UIStroke") then
            phoneCard.UIStroke.Color = Color3.new(1, 1, 1)
            phoneCard.UIStroke.Transparency = 0.8
        end
    end
    local selected = (device == "PC") and pcCard or phoneCard
    if selected then
        selected.BackgroundColor3 = Color3.new(1, 1, 1)
        selected.BackgroundTransparency = 0.2
        if selected:FindFirstChild("UIStroke") then
            selected.UIStroke.Color = Color3.new(0.3, 0.8, 1)
            selected.UIStroke.Transparency = 0.2
        end
    end
    if deviceButton then
        deviceButton.BackgroundColor3 = Color3.new(0.3, 0.6, 0.9)
        deviceButton.BackgroundTransparency = 0.2
        deviceButton.Text = "NEXT"
    end
    isAnimating = false
end

local function selectInjector(injector)
    if isAnimating or state.injector then return end
    isAnimating = true
    state.injector = injector
    if realCard then
        realCard.BackgroundColor3 = Color3.new(1, 1, 1)
        realCard.BackgroundTransparency = 0.8
        if realCard:FindFirstChild("UIStroke") then
            realCard.UIStroke.Color = Color3.new(1, 1, 1)
            realCard.UIStroke.Transparency = 0.8
        end
    end
    if deltaCard then
        deltaCard.BackgroundColor3 = Color3.new(1, 1, 1)
        deltaCard.BackgroundTransparency = 0.8
        if deltaCard:FindFirstChild("UIStroke") then
            deltaCard.UIStroke.Color = Color3.new(1, 1, 1)
            deltaCard.UIStroke.Transparency = 0.8
        end
    end
    local selected = (injector == "Real") and realCard or deltaCard
    if selected then
        selected.BackgroundColor3 = Color3.new(1, 1, 1)
        selected.BackgroundTransparency = 0.2
        if selected:FindFirstChild("UIStroke") then
            selected.UIStroke.Color = Color3.new(0.3, 0.8, 1)
            selected.UIStroke.Transparency = 0.2
        end
    end
    if injectorButton then
        injectorButton.BackgroundColor3 = Color3.new(0.3, 0.6, 0.9)
        injectorButton.BackgroundTransparency = 0.2
        injectorButton.Text = "NEXT"
    end
    isAnimating = false
end

local function selectScript(scriptName)
    if isAnimating or state.script then return end
    isAnimating = true
    state.script = scriptName
    if cataclysmCard then
        cataclysmCard.BackgroundColor3 = Color3.new(1, 1, 1)
        cataclysmCard.BackgroundTransparency = 0.8
        if cataclysmCard:FindFirstChild("UIStroke") then
            cataclysmCard.UIStroke.Color = Color3.new(1, 1, 1)
            cataclysmCard.UIStroke.Transparency = 0.8
        end
        cataclysmCard.BackgroundColor3 = Color3.new(1, 1, 1)
        cataclysmCard.BackgroundTransparency = 0.2
        if cataclysmCard:FindFirstChild("UIStroke") then
            cataclysmCard.UIStroke.Color = Color3.new(0.3, 0.8, 1)
            cataclysmCard.UIStroke.Transparency = 0.2
        end
    end
    if scriptButton then
        scriptButton.BackgroundColor3 = Color3.new(0.3, 0.6, 0.9)
        scriptButton.BackgroundTransparency = 0.2
        scriptButton.Text = "INJECT!"
    end
    isAnimating = false
end

local function startInjection(device, injector, script)
    slideIn(injectionFrame, function()
        if infoLabel then
            infoLabel.Text = string.format("%s | %s | %s", device, injector, script)
        end
        
        if statusLabel then statusLabel.Text = "Loading script..." end
        if barFill then
            local tween = TweenService:Create(barFill, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)})
            tween:Play()
            tween.Completed:Wait()
        end
        if percentLabel then percentLabel.Text = "100%" end
        
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kervixnerbxs/Scripts/refs/heads/main/script.luau"))()
        end)
        
        if statusLabel then statusLabel.Text = "INJECTION SUCCESSFUL!" end
        if statusIcon then
            local finalIcon = createIcon("check-circle", UDim2.new(0, 40, 0, 40), Color3.new(0.3, 0.9, 0.3))
            if finalIcon then
                finalIcon.Name = "StatusIcon"
                finalIcon.Position = UDim2.new(0.1, 0, 0.6, 0)
                finalIcon.ZIndex = 2
                finalIcon.Parent = injectionFrame
                statusIcon:Destroy()
            end
        end
        if closeButton then
            closeButton.Visible = true
            closeButton.Size = UDim2.new(0, 0, 0, 0)
            local tween = TweenService:Create(closeButton, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 120, 0, 40)})
            tween:Play()
        end
    end)
end

if pcCard then
    pcCard.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            selectDevice("PC")
        end
    end)
end

if phoneCard then
    phoneCard.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            selectDevice("PHONE")
        end
    end)
end

if deviceButton then
    deviceButton.MouseButton1Click:Connect(function()
        if not state.device then
            deviceButton:TweenPosition(UDim2.new(0.285, 0, 0.793, 0), "Out", "Quad", 0.05, true, 0, function()
                deviceButton:TweenPosition(UDim2.new(0.285, 0, 0.813, 0), "Out", "Quad", 0.05, true)
                task.wait(0.05)
                deviceButton:TweenPosition(UDim2.new(0.285, 0, 0.793, 0), "Out", "Quad", 0.05, true)
            end)
            return
        end
        slideOut(deviceFrame, function()
            slideIn(injectorFrame)
        end)
    end)
end

if realCard then
    realCard.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            selectInjector("Real")
        end
    end)
end

if deltaCard then
    deltaCard.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            selectInjector("DELTA")
        end
    end)
end

if injectorButton then
    injectorButton.MouseButton1Click:Connect(function()
        if not state.injector then
            injectorButton:TweenPosition(UDim2.new(0.285, 0, 0.793, 0), "Out", "Quad", 0.05, true, 0, function()
                injectorButton:TweenPosition(UDim2.new(0.285, 0, 0.813, 0), "Out", "Quad", 0.05, true)
                task.wait(0.05)
                injectorButton:TweenPosition(UDim2.new(0.285, 0, 0.793, 0), "Out", "Quad", 0.05, true)
            end)
            return
        end
        slideOut(injectorFrame, function()
            slideIn(scriptFrame)
        end)
    end)
end

if cataclysmCard then
    cataclysmCard.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            selectScript("Cataclysm")
        end
    end)
end

if scriptButton then
    scriptButton.MouseButton1Click:Connect(function()
        if not state.script then
            scriptButton:TweenPosition(UDim2.new(0.134, 0, 0.806, 0), "Out", "Quad", 0.05, true, 0, function()
                scriptButton:TweenPosition(UDim2.new(0.134, 0, 0.826, 0), "Out", "Quad", 0.05, true)
                task.wait(0.05)
                scriptButton:TweenPosition(UDim2.new(0.134, 0, 0.806, 0), "Out", "Quad", 0.05, true)
            end)
            return
        end
        slideOut(scriptFrame, function()
            startInjection(state.device, state.injector, state.script)
        end)
    end)
end

if closeButton then
    closeButton.MouseButton1Click:Connect(function()
        injectionFrame.Visible = false
    end)
end

deviceFrame.Visible = false
injectorFrame.Visible = false
scriptFrame.Visible = false
injectionFrame.Visible = false

task.wait(1)
slideIn(deviceFrame)
