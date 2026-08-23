-- Cataclysm

-- Fully open source. If you want obfuscator - go to https://discord.gg/2tdsXcymZ and go to deobfuscator-and-obfuscator-here

-- Cataclysm DO NOT USED jnkie, luarmor. Please, if you see cataclysm hub IN jnkie, luarmor or all other service - DONT USE THAT. Official CATACLYSM - ONLY IN THIS REPO
local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera

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

local function createIcon(iconName, size, color, imageId)
    if imageId then
        local icon = Instance.new("ImageLabel")
        icon.Size = size or UDim2.new(0, 24, 0, 24)
        icon.BackgroundTransparency = 1
        icon.Image = "rbxassetid://" .. imageId
        icon.ImageColor3 = color or Color3.new(1, 1, 1)
        return icon
    end
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

local function addIconToButton(button, iconName, iconPosition, iconSize, imageId)
    if not button then return end
    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("ImageLabel") and child.Name == "ButtonIcon" then
            child:Destroy()
        end
    end
    local icon = createIcon(iconName, iconSize or UDim2.new(0, 20, 0, 20), nil, imageId)
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
        local viewportSize = Camera.ViewportSize
        frame.Position = UDim2.new(0, (viewportSize.X - frame.Size.X.Offset) / 2, 0, (viewportSize.Y - frame.Size.Y.Offset) / 2)
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
        local viewportSize = Camera.ViewportSize
        local newX = math.clamp(startPos.X.Offset + delta.X, 0, viewportSize.X - frame.Size.X.Offset)
        local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, viewportSize.Y - frame.Size.Y.Offset)
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
gui.Parent = CoreGui

local function createWindow1()
    local frame = Instance.new("Frame")
    frame.Name = "DeviceFrame"
    frame.Size = UDim2.new(0, 480, 0, 320)
    frame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.1)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Color3.new(0.4, 0.4, 0.45)
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 300, 0, 45)
    title.Position = UDim2.new(0.19, 0, 0.02, 0)
    title.BackgroundTransparency = 1
    title.Text = "SELECT DEVICE"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 14
    title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    
    local pcCard = Instance.new("Frame")
    pcCard.Name = "PC"
    pcCard.Size = UDim2.new(0, 180, 0, 150)
    pcCard.Position = UDim2.new(0.06, 0, 0.22, 0)
    pcCard.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
    pcCard.BackgroundTransparency = 0.3
    pcCard.BorderSizePixel = 0
    pcCard.Parent = frame
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 10)
    corner2.Parent = pcCard
    
    local stroke2 = Instance.new("UIStroke")
    stroke2.Color = Color3.new(0.3, 0.3, 0.35)
    stroke2.Thickness = 1.5
    stroke2.Transparency = 0.5
    stroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke2.Parent = pcCard
    
    local pcText = Instance.new("TextLabel")
    pcText.Size = UDim2.new(0, 100, 0, 35)
    pcText.Position = UDim2.new(0.22, 0, 0.73, 0)
    pcText.BackgroundTransparency = 1
    pcText.Text = "PC"
    pcText.TextColor3 = Color3.new(1, 1, 1)
    pcText.TextSize = 14
    pcText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    pcText.TextScaled = true
    pcText.TextWrapped = true
    pcText.Parent = pcCard
    
    local pcIcon = createIcon("laptop", UDim2.new(0, 56, 0, 56))
    if pcIcon then
        pcIcon.Name = "DeviceIcon"
        pcIcon.Position = UDim2.new(0.34, 0, 0.25, 0)
        pcIcon.ZIndex = 2
        pcIcon.Parent = pcCard
    end
    
    local pcCheck = Instance.new("Frame")
    pcCheck.Name = "Checkmark"
    pcCheck.Size = UDim2.new(0, 26, 0, 26)
    pcCheck.Position = UDim2.new(0.82, 0, 0.04, 0)
    pcCheck.BackgroundColor3 = Color3.new(0.3, 0.8, 0.3)
    pcCheck.BackgroundTransparency = 1
    pcCheck.BorderSizePixel = 0
    pcCheck.Visible = false
    pcCheck.Parent = pcCard
    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(1, 0)
    checkCorner.Parent = pcCheck
    local checkIcon = createIcon("check", UDim2.new(0, 16, 0, 16), Color3.new(1, 1, 1))
    if checkIcon then
        checkIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
        checkIcon.Parent = pcCheck
    end
    
    local phoneCard = Instance.new("Frame")
    phoneCard.Name = "Phone"
    phoneCard.Size = UDim2.new(0, 180, 0, 150)
    phoneCard.Position = UDim2.new(0.56, 0, 0.22, 0)
    phoneCard.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
    phoneCard.BackgroundTransparency = 0.3
    phoneCard.BorderSizePixel = 0
    phoneCard.Parent = frame
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0, 10)
    corner3.Parent = phoneCard
    
    local stroke3 = Instance.new("UIStroke")
    stroke3.Color = Color3.new(0.3, 0.3, 0.35)
    stroke3.Thickness = 1.5
    stroke3.Transparency = 0.5
    stroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke3.Parent = phoneCard
    
    local phoneText = Instance.new("TextLabel")
    phoneText.Size = UDim2.new(0, 100, 0, 35)
    phoneText.Position = UDim2.new(0.22, 0, 0.73, 0)
    phoneText.BackgroundTransparency = 1
    phoneText.Text = "PHONE"
    phoneText.TextColor3 = Color3.new(1, 1, 1)
    phoneText.TextSize = 14
    phoneText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    phoneText.TextScaled = true
    phoneText.TextWrapped = true
    phoneText.Parent = phoneCard
    
    local phoneIcon = createIcon("smartphone", UDim2.new(0, 56, 0, 56))
    if phoneIcon then
        phoneIcon.Name = "DeviceIcon"
        phoneIcon.Position = UDim2.new(0.34, 0, 0.25, 0)
        phoneIcon.ZIndex = 2
        phoneIcon.Parent = phoneCard
    end
    
    local phoneCheck = Instance.new("Frame")
    phoneCheck.Name = "Checkmark"
    phoneCheck.Size = UDim2.new(0, 26, 0, 26)
    phoneCheck.Position = UDim2.new(0.82, 0, 0.04, 0)
    phoneCheck.BackgroundColor3 = Color3.new(0.3, 0.8, 0.3)
    phoneCheck.BackgroundTransparency = 1
    phoneCheck.BorderSizePixel = 0
    phoneCheck.Visible = false
    phoneCheck.Parent = phoneCard
    local checkCorner2 = Instance.new("UICorner")
    checkCorner2.CornerRadius = UDim.new(1, 0)
    checkCorner2.Parent = phoneCheck
    local checkIcon2 = createIcon("check", UDim2.new(0, 16, 0, 16), Color3.new(1, 1, 1))
    if checkIcon2 then
        checkIcon2.Position = UDim2.new(0.2, 0, 0.2, 0)
        checkIcon2.Parent = phoneCheck
    end
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 45)
    button.Position = UDim2.new(0.29, 0, 0.83, 0)
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.25)
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = "CONTINUE"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 24
    button.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    button.Parent = frame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    addIconToButton(button, "arrow-right", UDim2.new(0.8, 0, 0.5, -10), UDim2.new(0, 20, 0, 20))
    
    return frame, pcCard, phoneCard, button, pcCheck, phoneCheck
end

local function createWindow2()
    local frame = Instance.new("Frame")
    frame.Name = "InjectorFrame"
    frame.Size = UDim2.new(0, 480, 0, 320)
    frame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.1)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Color3.new(0.4, 0.4, 0.45)
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 300, 0, 45)
    title.Position = UDim2.new(0.19, 0, 0.02, 0)
    title.BackgroundTransparency = 1
    title.Text = "SELECT INJECTOR"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 14
    title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    
    local realCard = Instance.new("Frame")
    realCard.Name = "Real"
    realCard.Size = UDim2.new(0, 180, 0, 150)
    realCard.Position = UDim2.new(0.06, 0, 0.22, 0)
    realCard.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
    realCard.BackgroundTransparency = 0.3
    realCard.BorderSizePixel = 0
    realCard.Parent = frame
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 10)
    corner2.Parent = realCard
    
    local stroke2 = Instance.new("UIStroke")
    stroke2.Color = Color3.new(0.3, 0.3, 0.35)
    stroke2.Thickness = 1.5
    stroke2.Transparency = 0.5
    stroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke2.Parent = realCard
    
    local realText = Instance.new("TextLabel")
    realText.Size = UDim2.new(0, 100, 0, 35)
    realText.Position = UDim2.new(0.22, 0, 0.73, 0)
    realText.BackgroundTransparency = 1
    realText.Text = "REAL"
    realText.TextColor3 = Color3.new(1, 1, 1)
    realText.TextSize = 14
    realText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    realText.TextScaled = true
    realText.TextWrapped = true
    realText.Parent = realCard
    
    local realIcon = createIcon(nil, UDim2.new(0, 56, 0, 56), Color3.new(255, 255, 255), "131086711884764")

    if realIcon then
        realIcon.Name = "InjectorIcon"
        realIcon.Position = UDim2.new(0.34, 0, 0.25, 0)
        realIcon.ZIndex = 2
        realIcon.Parent = realCard
    end
    
    local realCheck = Instance.new("Frame")
    realCheck.Name = "Checkmark"
    realCheck.Size = UDim2.new(0, 26, 0, 26)
    realCheck.Position = UDim2.new(0.82, 0, 0.04, 0)
    realCheck.BackgroundColor3 = Color3.new(0.3, 0.8, 0.3)
    realCheck.BackgroundTransparency = 1
    realCheck.BorderSizePixel = 0
    realCheck.Visible = false
    realCheck.Parent = realCard
    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(1, 0)
    checkCorner.Parent = realCheck
    local checkIcon = createIcon("check", UDim2.new(0, 16, 0, 16), Color3.new(1, 1, 1))
    if checkIcon then
        checkIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
        checkIcon.Parent = realCheck
    end
    
    local deltaCard = Instance.new("Frame")
    deltaCard.Name = "DELTA"
    deltaCard.Size = UDim2.new(0, 180, 0, 150)
    deltaCard.Position = UDim2.new(0.56, 0, 0.22, 0)
    deltaCard.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
    deltaCard.BackgroundTransparency = 0.3
    deltaCard.BorderSizePixel = 0
    deltaCard.Parent = frame
    
    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0, 10)
    corner3.Parent = deltaCard
    
    local stroke3 = Instance.new("UIStroke")
    stroke3.Color = Color3.new(0.3, 0.3, 0.35)
    stroke3.Thickness = 1.5
    stroke3.Transparency = 0.5
    stroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke3.Parent = deltaCard
    
    local deltaText = Instance.new("TextLabel")
    deltaText.Size = UDim2.new(0, 100, 0, 35)
    deltaText.Position = UDim2.new(0.22, 0, 0.73, 0)
    deltaText.BackgroundTransparency = 1
    deltaText.Text = "DELTA"
    deltaText.TextColor3 = Color3.new(1, 1, 1)
    deltaText.TextSize = 14
    deltaText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    deltaText.TextScaled = true
    deltaText.TextWrapped = true
    deltaText.Parent = deltaCard
    
    local deltaIcon = createIcon(nil, UDim2.new(0, 56, 0, 56), Color3.new(255, 255, 255), "103107545907156")

    if deltaIcon then
        deltaIcon.Name = "InjectorIcon"
        deltaIcon.Position = UDim2.new(0.34, 0, 0.25, 0)
        deltaIcon.ZIndex = 2
        deltaIcon.Parent = deltaCard
    end
    
    local deltaCheck = Instance.new("Frame")
    deltaCheck.Name = "Checkmark"
    deltaCheck.Size = UDim2.new(0, 26, 0, 26)
    deltaCheck.Position = UDim2.new(0.82, 0, 0.04, 0)
    deltaCheck.BackgroundColor3 = Color3.new(0.3, 0.8, 0.3)
    deltaCheck.BackgroundTransparency = 1
    deltaCheck.BorderSizePixel = 0
    deltaCheck.Visible = false
    deltaCheck.Parent = deltaCard
    local checkCorner2 = Instance.new("UICorner")
    checkCorner2.CornerRadius = UDim.new(1, 0)
    checkCorner2.Parent = deltaCheck
    local checkIcon2 = createIcon("check", UDim2.new(0, 16, 0, 16), Color3.new(1, 1, 1))
    if checkIcon2 then
        checkIcon2.Position = UDim2.new(0.2, 0, 0.2, 0)
        checkIcon2.Parent = deltaCheck
    end
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 45)
    button.Position = UDim2.new(0.29, 0, 0.83, 0)
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.25)
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = "CONTINUE"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 24
    button.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    button.Parent = frame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    addIconToButton(button, "arrow-right", UDim2.new(0.8, 0, 0.5, -10), UDim2.new(0, 20, 0, 20))
    
    return frame, realCard, deltaCard, button, realCheck, deltaCheck
end

local function createWindow3()
    local frame = Instance.new("Frame")
    frame.Name = "ScriptFrame"
    frame.Size = UDim2.new(0, 480, 0, 320)
    frame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.1)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Color3.new(0.4, 0.4, 0.45)
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 300, 0, 45)
    title.Position = UDim2.new(0.19, 0, 0.02, 0)
    title.BackgroundTransparency = 1
    title.Text = "SELECT SCRIPT"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 14
    title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame
    
    local scriptCard = Instance.new("Frame")
    scriptCard.Name = "Cataclysm"
    scriptCard.Size = UDim2.new(0, 420, 0, 90)
    scriptCard.Position = UDim2.new(0.06, 0, 0.23, 0)
    scriptCard.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
    scriptCard.BackgroundTransparency = 0.3
    scriptCard.BorderSizePixel = 0
    scriptCard.Parent = frame
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 10)
    corner2.Parent = scriptCard
    
    local stroke2 = Instance.new("UIStroke")
    stroke2.Color = Color3.new(0.3, 0.3, 0.35)
    stroke2.Thickness = 1.5
    stroke2.Transparency = 0.5
    stroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke2.Parent = scriptCard
    
    local scriptText = Instance.new("TextLabel")
    scriptText.Size = UDim2.new(0, 180, 0, 35)
    scriptText.Position = UDim2.new(0.22, 0, 0.05, 0)
    scriptText.BackgroundTransparency = 1
    scriptText.Text = "CATACLYSM HUB"
    scriptText.TextColor3 = Color3.new(1, 1, 1)
    scriptText.TextSize = 14
    scriptText.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    scriptText.TextScaled = true
    scriptText.TextWrapped = true
    scriptText.Parent = scriptCard
    
    local scriptIcon = createIcon(nil, UDim2.new(0, 44, 0, 44), Color3.new(0.8, 0.3, 1), "90288804217743")
    if scriptIcon then
        scriptIcon.Name = "ScriptIcon"
        scriptIcon.Position = UDim2.new(0.04, 0, 0.26, 0)
        scriptIcon.ZIndex = 2
        scriptIcon.Parent = scriptCard
    end
    
    local scriptSub = Instance.new("TextLabel")
    scriptSub.Size = UDim2.new(0, 120, 0, 25)
    scriptSub.Position = UDim2.new(0.24, 0, 0.6, 0.3)
    scriptSub.BackgroundTransparency = 1
    scriptSub.Text = "For Evade, v25.5"
    scriptSub.TextColor3 = Color3.new(0.5, 0.5, 0.6)
    scriptSub.TextSize = 14
    scriptSub.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Light, Enum.FontStyle.Normal)
    scriptSub.TextScaled = true
    scriptSub.TextWrapped = true
    scriptSub.Parent = scriptCard
    
    local scriptCheck = Instance.new("Frame")
    scriptCheck.Name = "Checkmark"
    scriptCheck.Size = UDim2.new(0, 26, 0, 26)
    scriptCheck.Position = UDim2.new(0.9, 0, 0.35, 0)
    scriptCheck.BackgroundColor3 = Color3.new(0.3, 0.8, 0.3)
    scriptCheck.BackgroundTransparency = 1
    scriptCheck.BorderSizePixel = 0
    scriptCheck.Visible = false
    scriptCheck.Parent = scriptCard
    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(1, 0)
    checkCorner.Parent = scriptCheck
    local checkIcon = createIcon("check", UDim2.new(0, 16, 0, 16), Color3.new(1, 1, 1))
    if checkIcon then
        checkIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
        checkIcon.Parent = scriptCheck
    end
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 45)
    button.Position = UDim2.new(0.29, 0, 0.83, 0)
    button.BackgroundColor3 = Color3.new(0.6, 0.15, 0.3)
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = "INJECT"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 24
    button.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    button.Parent = frame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    addIconToButton(button, "rocket", UDim2.new(0.8, 0, 0.5, -10), UDim2.new(0, 20, 0, 20))
    
    return frame, scriptCard, button, scriptCheck
end

local function createWindow4()
    local frame = Instance.new("Frame")
    frame.Name = "InjectionFrame"
    frame.Size = UDim2.new(0, 480, 0, 280)
    frame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.1)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Color = Color3.new(0.4, 0.4, 0.45)
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0.03, 0)
    title.BackgroundTransparency = 1
    title.Text = "INJECTING..."
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 24
    title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    title.TextScaled = true
    title.Parent = frame
    
    local status = Instance.new("TextLabel")
    status.Name = "Status"
    status.Size = UDim2.new(0.8, 0, 0, 30)
    status.Position = UDim2.new(0.1, 0, 0.3, 0)
    status.BackgroundTransparency = 1
    status.Text = "Initializing..."
    status.TextColor3 = Color3.new(0.6, 0.6, 0.8)
    status.TextSize = 16
    status.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    status.TextScaled = true
    status.Parent = frame
    
    local barBg = Instance.new("Frame")
    barBg.Name = "BarBg"
    barBg.Size = UDim2.new(0.7, 0, 0, 6)
    barBg.Position = UDim2.new(0.15, 0, 0.5, 0)
    barBg.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
    barBg.BorderSizePixel = 0
    barBg.Parent = frame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = barBg
    
    local barFill = Instance.new("Frame")
    barFill.Name = "BarFill"
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.new(0.3, 0.7, 0.3)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    
    local barFillCorner = Instance.new("UICorner")
    barFillCorner.CornerRadius = UDim.new(1, 0)
    barFillCorner.Parent = barFill
    
    local percent = Instance.new("TextLabel")
    percent.Name = "Percent"
    percent.Size = UDim2.new(0.7, 0, 0, 25)
    percent.Position = UDim2.new(0.15, 0, 0.6, 0)
    percent.BackgroundTransparency = 1
    percent.Text = "0%"
    percent.TextColor3 = Color3.new(1, 1, 1)
    percent.TextSize = 16
    percent.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    percent.TextScaled = true
    percent.Parent = frame
    
    local info = Instance.new("TextLabel")
    info.Name = "Info"
    info.Size = UDim2.new(1, 0, 0, 20)
    info.Position = UDim2.new(0, 0, 0.85, 0)
    info.BackgroundTransparency = 1
    info.Text = ""
    info.TextColor3 = Color3.new(0.4, 0.4, 0.5)
    info.TextSize = 12
    info.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    info.TextScaled = true
    info.Parent = frame
    
    return frame, status, barFill, percent, info
end

local deviceFrame, pcCard, phoneCard, deviceButton, pcCheck, phoneCheck = createWindow1()
local injectorFrame, realCard, deltaCard, injectorButton, realCheck, deltaCheck = createWindow2()
local scriptFrame, cataclysmCard, scriptButton, scriptCheck = createWindow3()
local injectionFrame, statusLabel, barFill, percentLabel, infoLabel = createWindow4()

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
    
    local tween1 = TweenService:Create(window, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -window.Size.X.Offset/2, 0.5, -window.Size.Y.Offset/2)})
    local tween2 = TweenService:Create(window, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.05})
    tween1:Play()
    tween2:Play()
    tween1.Completed:Wait()
    if callback then callback() end
end

local function slideOut(window, callback)
    if not window then return end
    local tween = TweenService:Create(window, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -window.Size.X.Offset/2, -0.2, 0)})
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
    
    local selected = (device == "PC") and pcCard or phoneCard
    local check = (device == "PC") and pcCheck or phoneCheck
    local otherCard = (device == "PC") and phoneCard or pcCard
    local otherCheck = (device == "PC") and phoneCheck or pcCheck
    
    if otherCard then
        otherCard.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
        if otherCard:FindFirstChild("UIStroke") then
            otherCard.UIStroke.Color = Color3.new(0.3, 0.3, 0.35)
        end
    end
    if otherCheck then
        otherCheck.BackgroundTransparency = 1
        otherCheck.Visible = false
    end
    
    if selected then
        selected.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
        if selected:FindFirstChild("UIStroke") then
            selected.UIStroke.Color = Color3.new(0.5, 0.5, 0.6)
        end
    end
    if check then
        check.BackgroundTransparency = 0
        check.Visible = true
    end
    
    if deviceButton then
        deviceButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.35)
        deviceButton.BackgroundTransparency = 0.1
        deviceButton.Text = "CONTINUE"
    end
    
    isAnimating = false
end

local function selectInjector(injector)
    if isAnimating or state.injector then return end
    isAnimating = true
    state.injector = injector
    
    local selected = (injector == "Real") and realCard or deltaCard
    local check = (injector == "Real") and realCheck or deltaCheck
    local otherCard = (injector == "Real") and deltaCard or realCard
    local otherCheck = (injector == "Real") and deltaCheck or realCheck
    
    if otherCard then
        otherCard.BackgroundColor3 = Color3.new(0.12, 0.12, 0.15)
        if otherCard:FindFirstChild("UIStroke") then
            otherCard.UIStroke.Color = Color3.new(0.3, 0.3, 0.35)
        end
    end
    if otherCheck then
        otherCheck.BackgroundTransparency = 1
        otherCheck.Visible = false
    end
    
    if selected then
        selected.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
        if selected:FindFirstChild("UIStroke") then
            selected.UIStroke.Color = Color3.new(0.5, 0.5, 0.6)
        end
    end
    if check then
        check.BackgroundTransparency = 0
        check.Visible = true
    end
    
    if injectorButton then
        injectorButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.35)
        injectorButton.BackgroundTransparency = 0.1
        injectorButton.Text = "CONTINUE"
    end
    
    isAnimating = false
end

local function selectScript(scriptName)
    if isAnimating or state.script then return end
    isAnimating = true
    state.script = scriptName
    
    if cataclysmCard then
        cataclysmCard.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
        if cataclysmCard:FindFirstChild("UIStroke") then
            cataclysmCard.UIStroke.Color = Color3.new(0.5, 0.5, 0.6)
        end
    end
    if scriptCheck then
        scriptCheck.BackgroundTransparency = 0
        scriptCheck.Visible = true
    end
    
    if scriptButton then
        scriptButton.BackgroundColor3 = Color3.new(0.6, 0.15, 0.3)
        scriptButton.BackgroundTransparency = 0.1
        scriptButton.Text = "INJECT"
    end
    
    isAnimating = false
end

local function startInjection(device, injector, script)
    slideIn(injectionFrame, function()
        if infoLabel then
            infoLabel.Text = string.format("%s | %s | %s", device, injector, script)
        end
        
        local steps = {
            {text = "Connecting...", progress = 15},
            {text = "Loading modules...", progress = 30},
            {text = "Bypassing...", progress = 50},
            {text = "Initializing...", progress = 70},
            {text = "Injecting...", progress = 90},
            {text = "Done!", progress = 100}
        }
        
        for i, step in ipairs(steps) do
            if statusLabel then statusLabel.Text = step.text end
            
            if barFill then
                local targetSize = UDim2.new(step.progress / 100, 0, 1, 0)
                local tween = TweenService:Create(barFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize})
                tween:Play()
                tween.Completed:Wait()
            end
            
            if percentLabel then percentLabel.Text = step.progress .. "%" end
            task.wait(0.2)
        end
        
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kervixnerbxs/Scripts/refs/heads/main/script.luau"))()
        end)
        
        -- Сразу удаляем GUI
        gui:Destroy()
        if blurEffect then
            blurEffect:Destroy()
        end
    end)
end

-- Device selection
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
            return
        end
        slideOut(deviceFrame, function()
            slideIn(injectorFrame)
        end)
    end)
end

-- Injector selection
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
            return
        end
        slideOut(injectorFrame, function()
            slideIn(scriptFrame)
        end)
    end)
end

-- Script selection
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
            return
        end
        slideOut(scriptFrame, function()
            startInjection(state.device, state.injector, state.script)
        end)
    end)
end

deviceFrame.Visible = false
injectorFrame.Visible = false
scriptFrame.Visible = false
injectionFrame.Visible = false

task.wait(0.5)
slideIn(deviceFrame)
