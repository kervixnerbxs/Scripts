local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")

local Tween = TweenService
local UIS = UserInputService
local WS = Workspace
local Camera = WS.CurrentCamera
local RS = RunService

local IconsModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()
IconsModule.SetIconsType("lucide")

local function GetIcon(name)
    local success, result = pcall(function()
        return IconsModule.Icon2(name)
    end)
    if success and result then
        return result
    end
    return nil
end

local AccentColor = Color3.fromRGB(255, 255, 255)
local MainColor = Color3.fromRGB(8, 8, 13)
local SecondaryColor = Color3.fromRGB(20, 22, 27)
local BorderColor = Color3.fromRGB(45, 48, 58)
local ContentColor = Color3.fromRGB(160, 160, 160)
local GrayColor = Color3.fromRGB(100, 100, 100)

-- Watermark
local WatermarkGui = Instance.new("ScreenGui")
WatermarkGui.Name = "Watermark"
WatermarkGui.Parent = CoreGui
WatermarkGui.ResetOnSpawn = false
WatermarkGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local WatermarkFrame = Instance.new("Frame")
WatermarkFrame.Parent = WatermarkGui
WatermarkFrame.Position = UDim2.new(0.5, 0, 0, -50)
WatermarkFrame.AnchorPoint = Vector2.new(0.5, 0)
WatermarkFrame.Size = UDim2.new(0, 200, 0, 32)
WatermarkFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
WatermarkFrame.BackgroundTransparency = 0.3
WatermarkFrame.BorderSizePixel = 0
WatermarkFrame.ClipsDescendants = true

local WatermarkCorner = Instance.new("UICorner")
WatermarkCorner.Parent = WatermarkFrame
WatermarkCorner.CornerRadius = UDim.new(0, 99999)

local Stroke = Instance.new("UIStroke")
Stroke.Parent = WatermarkFrame
Stroke.Thickness = 2
Stroke.Transparency = 0
Stroke.Color = Color3.fromRGB(255, 255, 255)

local WatermarkLayout = Instance.new("UIListLayout")
WatermarkLayout.Parent = WatermarkFrame
WatermarkLayout.FillDirection = Enum.FillDirection.Horizontal
WatermarkLayout.Padding = UDim.new(0, 2)
WatermarkLayout.VerticalAlignment = Enum.VerticalAlignment.Center
WatermarkLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateWatermarkItem(icon, text, color)
    local item = Instance.new("Frame")
    item.Size = UDim2.new(0, 0, 1, 0)
    item.BackgroundTransparency = 1
    item.AutomaticSize = Enum.AutomaticSize.X
    
    local iconLabel = Instance.new("ImageLabel")
    iconLabel.Parent = item
    iconLabel.Size = UDim2.new(0, 14, 0, 14)
    iconLabel.Position = UDim2.new(0, 0, 0.5, -7)
    iconLabel.BackgroundTransparency = 1
    local iconData = GetIcon(icon)
    if iconData then
        if typeof(iconData) == "table" then
            iconLabel.Image = iconData[1]
            iconLabel.ImageRectSize = iconData[2].ImageRectSize
            iconLabel.ImageRectOffset = iconData[2].ImageRectPosition
        else
            iconLabel.Image = iconData
        end
    end
    iconLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.ImageTransparency = 0.5
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = item
    textLabel.Size = UDim2.new(0, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 18, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 13
    textLabel.TextTransparency = 0.15
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.AutomaticSize = Enum.AutomaticSize.X
    
    return item, textLabel
end

local injectorItem, injectorText = CreateWatermarkItem("cpu", "Real", Color3.fromRGB(255, 255, 255))
injectorItem.Parent = WatermarkFrame

local fpsItem, fpsText = CreateWatermarkItem("zap", "0", Color3.fromRGB(255, 255, 255))
fpsItem.Parent = WatermarkFrame

local cataclysmItem, cataclysmText = CreateWatermarkItem("link-2", "| Cataclysm", Color3.fromRGB(255, 255, 255))
cataclysmItem.Parent = WatermarkFrame

local function UpdateWatermark()
    local fps = math.floor(1 / RunService.Heartbeat:Wait())
    local fpsColor
    if fps < 60 then
        fpsColor = Color3.fromRGB(255, 50, 50)
    elseif fps < 120 then
        fpsColor = Color3.fromRGB(255, 200, 50)
    else
        fpsColor = Color3.fromRGB(50, 255, 50)
    end
    fpsText.Text = tostring(fps)
    fpsText.TextColor3 = fpsColor
end

spawn(function()
    while true do
        task.wait(0.2)
        pcall(UpdateWatermark)
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Cataclysm"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 780, 0, 650)
MainFrame.BackgroundColor3 = MainColor
MainFrame.BackgroundTransparency = 0.055
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 10)

for i = 1, 4 do
    local Shadow = Instance.new("UIStroke")
    Shadow.Parent = MainFrame
    Shadow.Thickness = 6 - i
    Shadow.Transparency = 0.9
    Shadow.Color = Color3.fromRGB(0, 0, 0)
end

local LeftPanel = Instance.new("Frame")
LeftPanel.Parent = MainFrame
LeftPanel.Size = UDim2.new(0, 175, 1, 0)
LeftPanel.BackgroundTransparency = 1

local Header = Instance.new("Frame")
Header.Parent = LeftPanel
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1

local Logo = Instance.new("ImageLabel")
Logo.Parent = Header
Logo.Size = UDim2.new(0, 35, 0, 35)
Logo.Position = UDim2.new(0, 10, 0.5, -17.5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://97390365793981"

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.Size = UDim2.new(0, 120, 0, 25)
TitleLabel.Position = UDim2.new(0, 55, 0, 4)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Cataclysm"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = Header
SubTitle.Size = UDim2.new(0, 120, 0, 15)
SubTitle.Position = UDim2.new(0, 55, 0, 25)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Best Evade HUB + Shaders"
SubTitle.TextColor3 = ContentColor
SubTitle.TextSize = 9
SubTitle.Font = Enum.Font.GothamBold
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

local HeaderLine = Instance.new("Frame")
HeaderLine.Parent = Header
HeaderLine.Size = UDim2.new(1, -10, 0, 1)
HeaderLine.Position = UDim2.new(0.5, 0, 1, 0)
HeaderLine.AnchorPoint = Vector2.new(0.5, 1)
HeaderLine.BackgroundColor3 = BorderColor
HeaderLine.BackgroundTransparency = 0.65

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Parent = LeftPanel
TabScroll.Size = UDim2.new(1, -10, 1, -115)
TabScroll.Position = UDim2.new(0.5, 0, 0, 60)
TabScroll.AnchorPoint = Vector2.new(0.5, 0)
TabScroll.BackgroundTransparency = 1
TabScroll.ScrollBarThickness = 0
TabScroll.Active = true

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabScroll
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TabScroll.CanvasSize = UDim2.fromOffset(0, TabLayout.AbsoluteContentSize.Y + 1)
end)

local BottomPanel = Instance.new("Frame")
BottomPanel.Parent = LeftPanel
BottomPanel.Size = UDim2.new(1, 0, 0, 50)
BottomPanel.Position = UDim2.new(0, 0, 1, -50)
BottomPanel.BackgroundTransparency = 1

local BottomLine = Instance.new("Frame")
BottomLine.Parent = BottomPanel
BottomLine.Size = UDim2.new(1, -10, 0, 1)
BottomLine.Position = UDim2.new(0.5, 0, 0, 0)
BottomLine.AnchorPoint = Vector2.new(0.5, 0)
BottomLine.BackgroundColor3 = BorderColor
BottomLine.BackgroundTransparency = 0.65

local Avatar = Instance.new("ImageLabel")
Avatar.Parent = BottomPanel
Avatar.Size = UDim2.new(0, 35, 0, 35)
Avatar.Position = UDim2.new(0, 10, 0.5, -17.5)
Avatar.BackgroundTransparency = 1
Avatar.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.Parent = Avatar
AvatarCorner.CornerRadius = UDim.new(1, 0)

local Username = Instance.new("TextLabel")
Username.Parent = BottomPanel
Username.Size = UDim2.new(0, 100, 0, 25)
Username.Position = UDim2.new(0, 55, 0, 5)
Username.BackgroundTransparency = 1
Username.Text = LocalPlayer.DisplayName
Username.TextColor3 = Color3.fromRGB(255, 255, 255)
Username.TextSize = 14
Username.Font = Enum.Font.GothamBold
Username.TextXAlignment = Enum.TextXAlignment.Left
Username.TextTruncate = Enum.TextTruncate.SplitWord

local Expire = Instance.new("TextLabel")
Expire.Parent = BottomPanel
Expire.Size = UDim2.new(0, 100, 0, 15)
Expire.Position = UDim2.new(0, 55, 0, 25)
Expire.BackgroundTransparency = 1
Expire.Text = "never"
Expire.TextColor3 = ContentColor
Expire.TextSize = 10
Expire.Font = Enum.Font.GothamBold
Expire.TextXAlignment = Enum.TextXAlignment.Left

local RightPanel = Instance.new("Frame")
RightPanel.Parent = MainFrame
RightPanel.Size = UDim2.new(1, -176, 1, 0)
RightPanel.Position = UDim2.new(0, 176, 0, 0)
RightPanel.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
RightPanel.BackgroundTransparency = 0.6
RightPanel.ClipsDescendants = true

local RightCorner = Instance.new("UICorner")
RightCorner.Parent = RightPanel
RightCorner.CornerRadius = UDim.new(0, 13)

local RightStroke = Instance.new("UIStroke")
RightStroke.Parent = RightPanel
RightStroke.Transparency = 0.65
RightStroke.Color = BorderColor

local RightHeader = Instance.new("Frame")
RightHeader.Parent = RightPanel
RightHeader.Size = UDim2.new(1, 0, 0, 50)
RightHeader.BackgroundTransparency = 1

local RightHeaderLine = Instance.new("Frame")
RightHeaderLine.Parent = RightHeader
RightHeaderLine.Size = UDim2.new(1, -10, 0, 1)
RightHeaderLine.Position = UDim2.new(0.5, 0, 1, 0)
RightHeaderLine.AnchorPoint = Vector2.new(0.5, 1)
RightHeaderLine.BackgroundColor3 = BorderColor
RightHeaderLine.BackgroundTransparency = 0.65

local SearchFrame = Instance.new("Frame")
SearchFrame.Parent = RightHeader
SearchFrame.Size = UDim2.new(0, 30, 0, 30)
SearchFrame.Position = UDim2.new(1, -40, 0.5, -7)
SearchFrame.AnchorPoint = Vector2.new(1, 0.5)
SearchFrame.BackgroundTransparency = 1
SearchFrame.ClipsDescendants = true

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Parent = SearchFrame
SearchIcon.Size = UDim2.new(0, 20, 0, 20)
SearchIcon.Position = UDim2.new(0, 5, 0.5, -10)
SearchIcon.BackgroundTransparency = 1
local searchIconData = GetIcon("search")
if searchIconData then
    if typeof(searchIconData) == "table" then
        SearchIcon.Image = searchIconData[1]
        SearchIcon.ImageRectSize = searchIconData[2].ImageRectSize
        SearchIcon.ImageRectOffset = searchIconData[2].ImageRectPosition
    else
        SearchIcon.Image = searchIconData
    end
end
SearchIcon.ImageColor3 = ContentColor
SearchIcon.ImageTransparency = 0.5

local SearchBox = Instance.new("TextBox")
SearchBox.Parent = SearchFrame
SearchBox.Size = UDim2.new(1, -35, 0, 25)
SearchBox.Position = UDim2.new(0, 35, 0.5, -12.5)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "Search"
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 13
SearchBox.TextTransparency = 1
SearchBox.Font = Enum.Font.GothamMedium
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false

local SearchOpen = false
SearchIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        SearchOpen = not SearchOpen
        if SearchOpen then
            TweenService:Create(SearchFrame, TweenInfo.new(0.5), {
                Size = UDim2.new(0, 220, 0, 30)
            }):Play()
            TweenService:Create(SearchBox, TweenInfo.new(0.5), {
                TextTransparency = 0.35
            }):Play()
        else
            TweenService:Create(SearchFrame, TweenInfo.new(0.5), {
                Size = UDim2.new(0, 30, 0, 30)
            }):Play()
            TweenService:Create(SearchBox, TweenInfo.new(0.5), {
                TextTransparency = 1
            }):Play()
            SearchBox.Text = ""
        end
    end
end)

local TabContainer = Instance.new("Frame")
TabContainer.Parent = RightPanel
TabContainer.Size = UDim2.new(1, 0, 1, -50)
TabContainer.Position = UDim2.new(0, 0, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.ClipsDescendants = true

local Tabs = {}
local CurrentTabIndex = 1
local Flags = {}
local AllItems = {}

-- ===== КОНФИГ =====
local Config = {
    -- Cataclysm
    SpeedEnabled = false,
    SpeedValue = 16,
    TpEnabled = false,
    TpHeight = 10,
    SpinEnabled = false,
    SpinSpeed = 15,
    SpinMode = "Spin",
    SkipMapEnabled = false,
    SkipMapPlatform = nil,
    SkipMapPos = Vector3.new(0, 5000, 0),
    SkipMapConnection = nil,
    TpWalkEnabled = false,
    TpWalkValue = 1,
    SuperBounceEnabled = false,
    SuperBounceHeight = 190,
    DefibAura = false,
    DefibRange = 20,
    DefibConnection = nil,
    BuildOffsetEnabled = false,
    BuildOffsetX = 0,
    BuildOffsetY = 0,
    BuildOffsetZ = 0,
    AutoWhistleEnabled = false,
    WhistleConnection = nil,
    GodModeEnabled = false,
    GodModeConnection = nil,
    SelfReviveEnabled = false,
    ReviveConnection = nil,
    GravityEnabled = false,
    GravityValue = 196.2,
    JumpPadEnabled = false,
    JumpPadValue = 360,
    MagicAura = false,
    MagicAuraCount = 3,
    MagicAuraRadius = 3,
    MagicAuraSpeed = 2,
    
    -- RTX Shaders
    ShaderRTX = false,
    BloomIntensity = 0.3,
    BloomSize = 10,
    BlurSize = 5,
    ShadersBrightness = 0.1,
    ShadersContrast = 0.5,
    ShadersSaturation = -0.3,
    SunRaysIntensity = 0.075,
    ShadersTime = 14,
    ShadersFog = 0.364,
    ShadersVignette = 0.3,
    FullBrightEnabled = false,
    NoFogEnabled = false,
    NoRenderEnabled = false,
    NoRenderColor = Color3.fromRGB(0, 0, 0),
    
    -- Ultimate Shaders
    UltimateShaders = false,
    UltimateTechnology = "ShadowMap",
    UltimateGlobalIllum = false,
    UltimateReflectance = 0.3,
    UltimateWaterSpeed = 10,
    UltimateWaterTrans = 0.3,
    UltimateWaterSize = 5,
    UltimateClockTime = 14,
    UltimateLatitude = 45,
    UltimateCloudCover = 0,
    UltimateCloudDensity = 0,
    UltimateCloudColor = Color3.fromRGB(255, 255, 255),
    UltimateAtmoDensity = 0.364,
    UltimateAtmoOffset = 0.556,
    UltimateAtmoColor = Color3.fromRGB(199, 175, 166),
    UltimateAtmoDecay = Color3.fromRGB(44, 39, 33),
    UltimateAtmoGlare = 0.36,
    UltimateAtmoHaze = 1.72,
    UltimateDOFEnabled = false,
    UltimateDOFFarIntensity = 0.5,
    UltimateDOFFocusDist = 50,
    UltimateDOFInFocus = 5,
    UltimateDOFNearIntensity = 0.3,
    UltimateSunRaysEnabled = false,
    UltimateSunRaysIntensity = 0.075,
    UltimateSunRaysSpread = 0.727,
    UltimateColorCorEnabled = true,
    UltimateColorBrightness = 0.1,
    UltimateColorContrast = 0.5,
    UltimateColorSaturation = -0.3,
    UltimateColorTint = Color3.fromRGB(255, 235, 203),
    UltimateBlurEnabled = false,
    UltimateBlurSize = 5,
    UltimateBloomEnabled = true,
    UltimateBloomIntensity = 0.3,
    UltimateBloomSize = 10,
    UltimateBloomThreshold = 0.8,
    UltimateSunFlare = false,
    UltimateMotionBlur = false,
    UltimateMotionBlurSize = 26,
    UltimateSkybox = "default",
    UltimateShadersOn = true,
    
    -- ===== BUNNY HOP =====
    BHopEnabled = false,
    IsHoldingJump = false,
}

-- ===== ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ =====
local function CreateIconLabel(icon, size, color, transparency)
    if not icon then return nil end
    local IconLabel = Instance.new("ImageLabel")
    IconLabel.Size = UDim2.new(0, size or 16, 0, size or 16)
    IconLabel.BackgroundTransparency = 1
    if typeof(icon) == "table" then
        IconLabel.Image = icon[1]
        IconLabel.ImageRectSize = icon[2].ImageRectSize
        IconLabel.ImageRectOffset = icon[2].ImageRectPosition
    else
        IconLabel.Image = icon
    end
    IconLabel.ImageColor3 = color or AccentColor
    IconLabel.ImageTransparency = transparency or 0.35
    return IconLabel
end

local CharacterService = require(ReplicatedStorage:WaitForChild("Services"):WaitForChild("Asset"):WaitForChild("CharacterService"))
local Movement = require(ReplicatedStorage:WaitForChild("Objects"):WaitForChild("Game"):WaitForChild("Character"):WaitForChild("Client"):WaitForChild("Movement"))
local ServerStateRegistryService = require(ReplicatedStorage:WaitForChild("Services"):WaitForChild("Data"):WaitForChild("ServerStateRegistryService"))
local ToolAction = ReplicatedStorage.Events.ToolAction
local changePlayerMode = ReplicatedStorage.Events.SetPlayerMode
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character, Humanoid, HumanoidRootPart, CharacterTag

local function GetCharacterTag(Character)
    if not Character then return nil end
    return Character:GetAttribute("Tag")
end

local function setupCharacter(character)
    Character = character
    Humanoid = character:FindFirstChildOfClass("Humanoid")
    HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    CharacterTag = GetCharacterTag(character)
end

if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(character)
    setupCharacter(character)
end)

function MovementValueSet(MovementType, value)
    if not CharacterTag then
        CharacterTag = GetCharacterTag(LocalPlayer.Character)
    end
    if not CharacterTag then return end
    pcall(function()
        ReplicatedStorage.Events.CharacterTask:FireServer(CharacterTag, "ModifyMovement", {MovementType, value})
    end)
end

function isPlayerDowned(player)
    if not player or not player.Character then return false end
    local char = player.Character
    if char:GetAttribute("Downed") == true then return true end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health <= 0 then return true end
    return false
end

function isPlayerRagdolled(player)
    if not player or not player.Character then return false end
    local char = player.Character
    if char:FindFirstChild("RagdollConstraints") then return true end
    return false
end

function getDistanceFromPlayer(targetPosition)
    if not Character or not HumanoidRootPart then return 0 end
    return (targetPosition - HumanoidRootPart.Position).Magnitude
end

function teleportToCFrame(cframeOffset)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = cframeOffset
    end
end

function teleportToRandomSpawn(offset)
    local spawnsFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Parts") and workspace.Map.Parts:FindFirstChild("Spawns")
    if not spawnsFolder then
        spawnsFolder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Map") and workspace.Game.Map:FindFirstChild("Parts") and workspace.Game.Map.Parts:FindFirstChild("Spawns")
    end
    if spawnsFolder then
        local spawns = spawnsFolder:GetChildren()
        if #spawns > 0 then
            local target = spawns[math.random(1, #spawns)]
            teleportToCFrame(target.CFrame + offset)
        end
    end
end

function teleportToRandomPlayer(offset)
    local players = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(players, player)
        end
    end
    if #players > 0 then
        local target = players[math.random(1, #players)]
        teleportToCFrame(target.Character.HumanoidRootPart.CFrame + offset)
    end
end

function teleportToRandomDowned(offset)
    local downed = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isPlayerDowned(player) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(downed, player.Character)
        end
    end
    if #downed > 0 then
        local target = downed[math.random(1, #downed)]
        local hrp = target:FindFirstChild("HumanoidRootPart")
        if hrp then
            teleportToCFrame(hrp.CFrame + offset)
        end
    end
end

function teleportToRandomTicket(offset)
    local ticketsFolder = workspace:FindFirstChild("Effects") and workspace.Effects:FindFirstChild("Tickets")
    if ticketsFolder then
        local tickets = ticketsFolder:GetChildren()
        if #tickets > 0 then
            local target = tickets[math.random(1, #tickets)]
            local part = target:FindFirstChild("HumanoidRootPart") or target:FindFirstChildWhichIsA("BasePart")
            if part then
                teleportToCFrame(part.CFrame + offset)
            end
        end
    end
end

function teleportToSecurityPart(offset)
    local securityPart = workspace:FindFirstChild("SecurityPart")
    if not securityPart then
        securityPart = Instance.new("Part")
        securityPart.Name = "SecurityPart"
        securityPart.Size = Vector3.new(10, 1, 10)
        securityPart.Position = Vector3.new(50000, 50000, 50000)
        securityPart.Anchored = true
        securityPart.CanCollide = true
        securityPart.Parent = workspace
    end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(securityPart.Position + offset)
    end
end

function getObjectives()
    local objectives = {}
    local objectivesFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Parts") and workspace.Map.Parts:FindFirstChild("Objectives")
    if not objectivesFolder then
        objectivesFolder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Map") and workspace.Game.Map:FindFirstChild("Parts") and workspace.Game.Map.Parts:FindFirstChild("Objectives")
    end
    if objectivesFolder then
        for _, obj in ipairs(objectivesFolder:GetChildren()) do
            if obj:IsA("Model") then
                local primaryPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if primaryPart then
                    table.insert(objectives, {Name = obj.Name, Part = primaryPart, Position = primaryPart.Position})
                end
            end
        end
    end
    return objectives
end

-- ===== ФУНКЦИЯ СОЗДАНИЯ ВКЛАДОК =====
function CreateTab(icon, name)
    local tabIndex = #Tabs + 1
    
    local Button = Instance.new("Frame")
    Button.Parent = TabScroll
    Button.Size = UDim2.new(1, -1, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(41, 45, 49)
    Button.BackgroundTransparency = 1
    Button.BorderSizePixel = 0
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.Parent = Button
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    
    if icon then
        local IconLabel = CreateIconLabel(icon, 18, GrayColor, 0)
        IconLabel.Parent = Button
        IconLabel.Position = UDim2.new(0, 8, 0.5, -9)
        IconLabel.Size = UDim2.new(0, 18, 0, 18)
    end
    
    local ButtonLabel = Instance.new("TextLabel")
    ButtonLabel.Parent = Button
    ButtonLabel.Size = UDim2.new(1, -37, 0, 15)
    ButtonLabel.Position = UDim2.new(0, 35, 0.5, -7.5)
    ButtonLabel.BackgroundTransparency = 1
    ButtonLabel.Text = name
    ButtonLabel.TextColor3 = GrayColor
    ButtonLabel.TextSize = 12
    ButtonLabel.Font = Enum.Font.GothamMedium
    ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local Content = Instance.new("Frame")
    Content.Parent = TabContainer
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.Visible = false
    
    local LeftScroll = Instance.new("ScrollingFrame")
    LeftScroll.Parent = Content
    LeftScroll.Size = UDim2.new(0.5, 0, 1, -5)
    LeftScroll.Position = UDim2.new(0.25, 0, 0.5, 0)
    LeftScroll.AnchorPoint = Vector2.new(0.5, 0.5)
    LeftScroll.BackgroundTransparency = 1
    LeftScroll.ScrollBarThickness = 0
    LeftScroll.Active = true
    LeftScroll.ClipsDescendants = false
    
    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.Parent = LeftScroll
    LeftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LeftLayout.Padding = UDim.new(0, 5)
    
    LeftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        LeftScroll.CanvasSize = UDim2.fromOffset(0, LeftLayout.AbsoluteContentSize.Y + 1)
    end)
    
    local RightScroll = Instance.new("ScrollingFrame")
    RightScroll.Parent = Content
    RightScroll.Size = UDim2.new(0.5, 0, 1, -5)
    RightScroll.Position = UDim2.new(0.75, 0, 0.5, 0)
    RightScroll.AnchorPoint = Vector2.new(0.5, 0.5)
    RightScroll.BackgroundTransparency = 1
    RightScroll.ScrollBarThickness = 0
    RightScroll.Active = true
    RightScroll.ClipsDescendants = false
    
    local RightLayout = Instance.new("UIListLayout")
    RightLayout.Parent = RightScroll
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    RightLayout.Padding = UDim.new(0, 5)
    
    RightLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        RightScroll.CanvasSize = UDim2.fromOffset(0, RightLayout.AbsoluteContentSize.Y + 1)
    end)
    
    local function ShowTab()
        for i, tab in ipairs(Tabs) do
            tab.Content.Visible = (i == tabIndex)
            if i == tabIndex then
                TweenService:Create(tab.Button, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.5
                }):Play()
                TweenService:Create(tab.ButtonLabel, TweenInfo.new(0.2), {
                    TextColor3 = AccentColor
                }):Play()
                if tab.ButtonIcon then
                    TweenService:Create(tab.ButtonIcon, TweenInfo.new(0.2), {
                        ImageColor3 = AccentColor
                    }):Play()
                end
            else
                TweenService:Create(tab.Button, TweenInfo.new(0.2), {
                    BackgroundTransparency = 1
                }):Play()
                TweenService:Create(tab.ButtonLabel, TweenInfo.new(0.2), {
                    TextColor3 = GrayColor
                }):Play()
                if tab.ButtonIcon then
                    TweenService:Create(tab.ButtonIcon, TweenInfo.new(0.2), {
                        ImageColor3 = GrayColor
                    }):Play()
                end
            end
        end
        CurrentTabIndex = tabIndex
    end
    
    local ButtonInput = Instance.new("ImageButton")
    ButtonInput.Parent = Button
    ButtonInput.Size = UDim2.new(1, 0, 1, 0)
    ButtonInput.BackgroundTransparency = 1
    ButtonInput.ImageTransparency = 1
    
    ButtonInput.MouseButton1Click:Connect(ShowTab)
    
    ButtonInput.MouseEnter:Connect(function()
        if CurrentTabIndex ~= tabIndex then
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.8
            }):Play()
        end
    end)
    
    ButtonInput.MouseLeave:Connect(function()
        if CurrentTabIndex ~= tabIndex then
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundTransparency = 1
            }):Play()
        end
    end)
    
    local tabData = {
        Button = Button,
        ButtonLabel = ButtonLabel,
        ButtonIcon = icon and Button:FindFirstChildOfClass("ImageLabel") or nil,
        Content = Content,
        LeftScroll = LeftScroll,
        RightScroll = RightScroll,
        LeftLayout = LeftLayout,
        RightLayout = RightLayout,
        Show = ShowTab
    }
    table.insert(Tabs, tabData)
    
    if tabIndex == 1 then
        ShowTab()
    end
    
    function tabData:AddSection(config)
        config = config or {}
        local sectionName = config.Name or "SECTION"
        local position = config.Position or "left"
        local sectionIcon = config.Icon
        
        local target = position == "left" and LeftScroll or RightScroll
        
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Parent = target
        SectionFrame.Size = UDim2.new(1, 0, 0, 0)
        SectionFrame.BackgroundTransparency = 1
        SectionFrame.ClipsDescendants = true
        
        local SectionHeader = Instance.new("Frame")
        SectionHeader.Parent = SectionFrame
        SectionHeader.Size = UDim2.new(1, 0, 0, 20)
        SectionHeader.Position = UDim2.new(0, 0, 0, 0)
        SectionHeader.BackgroundTransparency = 1
        
        if sectionIcon then
            local IconLabel = CreateIconLabel(sectionIcon, 14, ContentColor, 0.5)
            IconLabel.Parent = SectionHeader
            IconLabel.Position = UDim2.new(0, 5, 0.5, -7)
            IconLabel.Size = UDim2.new(0, 14, 0, 14)
        end
        
        local SectionLabel = Instance.new("TextLabel")
        SectionLabel.Parent = SectionHeader
        SectionLabel.Size = UDim2.new(1, -(sectionIcon and 30 or 10), 0, 15)
        SectionLabel.Position = UDim2.new(0, sectionIcon and 25 or 10, 0.5, -7.5)
        SectionLabel.BackgroundTransparency = 1
        SectionLabel.Text = sectionName
        SectionLabel.TextColor3 = ContentColor
        SectionLabel.TextSize = 11
        SectionLabel.Font = Enum.Font.GothamMedium
        SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        table.insert(AllItems, {Root = SectionLabel, Name = sectionName})
        
        local SectionHandler = Instance.new("Frame")
        SectionHandler.Parent = SectionFrame
        SectionHandler.Size = UDim2.new(1, -10, 1, -26)
        SectionHandler.Position = UDim2.new(0.5, 0, 0, 22)
        SectionHandler.AnchorPoint = Vector2.new(0.5, 0)
        SectionHandler.BackgroundColor3 = SecondaryColor
        SectionHandler.BackgroundTransparency = 0.5
        SectionHandler.ClipsDescendants = true
        
        local SectionCorner = Instance.new("UICorner")
        SectionCorner.Parent = SectionHandler
        SectionCorner.CornerRadius = UDim.new(0, 10)
        
        local SectionStroke = Instance.new("UIStroke")
        SectionStroke.Parent = SectionHandler
        SectionStroke.Transparency = 0.65
        SectionStroke.Color = BorderColor
        
        local SectionLayout = Instance.new("UIListLayout")
        SectionLayout.Parent = SectionHandler
        SectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SectionLayout.Padding = UDim.new(0, 2)
        
        SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if SectionLayout.AbsoluteContentSize.Y <= 1 then
                SectionFrame.Size = UDim2.new(1, -5, 0, 0)
            else
                SectionFrame.Size = UDim2.new(1, -5, 0, SectionLayout.AbsoluteContentSize.Y + 26)
            end
        end)
        
        local sectionData = {
            Root = SectionHandler,
            Layout = SectionLayout,
            Frame = SectionFrame,
            Label = SectionLabel
        }

        function sectionData:AddToggle(config)
            config = config or {}
            local defaultValue = config.Default or false
            local callback = config.Callback or function() end
            local flag = config.Flag or nil
            local icon = config.Icon
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Parent = SectionHandler
            ToggleFrame.Size = UDim2.new(1, 0, 0, 24)
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.LayoutOrder = 1
            
            local Row = Instance.new("Frame")
            Row.Parent = ToggleFrame
            Row.Size = UDim2.new(1, 0, 1, 0)
            Row.BackgroundTransparency = 1
            
            local iconOffset = 0
            
            if icon then
                local IconLabel = CreateIconLabel(icon, 16, AccentColor, 0.35)
                IconLabel.Parent = Row
                IconLabel.Position = UDim2.new(0, 10, 0.5, -8)
                IconLabel.Size = UDim2.new(0, 16, 0, 16)
                iconOffset = 35
            end
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Row
            Label.Size = UDim2.new(0, 0, 1, 0)
            Label.Position = UDim2.new(0, iconOffset or 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = config.Name or "Toggle"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 13
            Label.TextTransparency = 0.35
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextTruncate = Enum.TextTruncate.AtEnd
            
            local textSize = TextService:GetTextSize(Label.Text, 13, Enum.Font.GothamMedium, Vector2.new(999, 999))
            Label.Size = UDim2.new(0, textSize.X + 5, 1, 0)
            
            table.insert(AllItems, {Root = Label, Name = config.Name or "Toggle"})
            
            local ToggleBtn = Instance.new("Frame")
            ToggleBtn.Parent = Row
            ToggleBtn.Size = UDim2.new(0, 30, 0, 18)
            ToggleBtn.Position = UDim2.new(0, textSize.X + 13 + (iconOffset or 0), 0.5, -9)
            ToggleBtn.BackgroundColor3 = GrayColor
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.ClipsDescendants = true
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.Parent = ToggleBtn
            ToggleCorner.CornerRadius = UDim.new(1, 0)
            
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Parent = ToggleBtn
            ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
            ToggleCircle.Position = UDim2.new(0.7, 0, 0.5, 0)
            ToggleCircle.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
            ToggleCircle.BackgroundTransparency = 0.5
            ToggleCircle.BorderSizePixel = 0
            
            local ToggleCircleCorner = Instance.new("UICorner")
            ToggleCircleCorner.Parent = ToggleCircle
            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            
            local ToggleState = defaultValue
            
            local function UpdateToggle()
                if ToggleState then
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.175), {
                        BackgroundColor3 = AccentColor,
                        BackgroundTransparency = 0
                    }):Play()
                    TweenService:Create(ToggleCircle, TweenInfo.new(0.175), {
                        Position = UDim2.new(0.7, 0, 0.5, 0),
                        BackgroundTransparency = 0,
                        BackgroundColor3 = Color3.fromRGB(210, 210, 210)
                    }):Play()
                else
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.175), {
                        BackgroundColor3 = GrayColor,
                        BackgroundTransparency = 0
                    }):Play()
                    TweenService:Create(ToggleCircle, TweenInfo.new(0.175), {
                        Position = UDim2.new(0.3, 0, 0.5, 0),
                        BackgroundTransparency = 0.5,
                        BackgroundColor3 = Color3.fromRGB(210, 210, 210)
                    }):Play()
                end
            end
            
            UpdateToggle()
            
            local Input = Instance.new("ImageButton")
            Input.Parent = ToggleBtn
            Input.Size = UDim2.new(1, 0, 1, 0)
            Input.BackgroundTransparency = 1
            Input.ImageTransparency = 1
            
            Input.MouseButton1Click:Connect(function()
                ToggleState = not ToggleState
                UpdateToggle()
                callback(ToggleState)
            end)
            
            local toggleLib = {
                GetValue = function() return ToggleState end,
                SetValue = function(v)
                    ToggleState = v
                    UpdateToggle()
                    callback(v)
                end,
                Root = ToggleFrame,
                Button = ToggleBtn,
                Circle = ToggleCircle
            }
            
            if flag then
                Flags[flag] = toggleLib
            end
            
            return toggleLib
        end
        
        function sectionData:AddSlider(config)
            config = config or {}
            local defaultValue = config.Default or 50
            local min = config.Min or 0
            local max = config.Max or 100
            local rounding = config.Rounding or 0
            local suffix = config.Type or ""
            local callback = config.Callback or function() end
            local flag = config.Flag or nil
            local icon = config.Icon
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Parent = SectionHandler
            SliderFrame.Size = UDim2.new(1, 0, 0, 35)
            SliderFrame.BackgroundTransparency = 1
            SliderFrame.LayoutOrder = 2
            
            local HeaderRow = Instance.new("Frame")
            HeaderRow.Parent = SliderFrame
            HeaderRow.Size = UDim2.new(1, 0, 0, 20)
            HeaderRow.BackgroundTransparency = 1
            
            local iconOffset = 0
            
            if icon then
                local IconLabel = CreateIconLabel(icon, 14, AccentColor, 0.35)
                IconLabel.Parent = HeaderRow
                IconLabel.Position = UDim2.new(0, 10, 0.5, -7)
                IconLabel.Size = UDim2.new(0, 14, 0, 14)
                iconOffset = 30
            end
            
            local Label = Instance.new("TextLabel")
            Label.Parent = HeaderRow
            Label.Size = UDim2.new(1, -(iconOffset + 65), 0, 15)
            Label.Position = UDim2.new(0, iconOffset or 10, 0.5, -7.5)
            Label.BackgroundTransparency = 1
            Label.Text = config.Name or "Slider"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 13
            Label.TextTransparency = 0.35
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            table.insert(AllItems, {Root = Label, Name = config.Name or "Slider"})
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Parent = HeaderRow
            ValueLabel.Size = UDim2.new(0, 60, 0, 15)
            ValueLabel.Position = UDim2.new(1, -5, 0.5, -7.5)
            ValueLabel.AnchorPoint = Vector2.new(1, 0.5)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(defaultValue) .. suffix
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 12
            ValueLabel.TextTransparency = 0.35
            ValueLabel.Font = Enum.Font.GothamMedium
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Parent = SliderFrame
            SliderBar.Size = UDim2.new(1, -10, 0, 6)
            SliderBar.Position = UDim2.new(0, 5, 0, 26)
            SliderBar.BackgroundColor3 = Color3.fromRGB(30, 29, 36)
            SliderBar.BorderSizePixel = 0
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.Parent = SliderBar
            SliderCorner.CornerRadius = UDim.new(1, 0)
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Parent = SliderBar
            SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
            SliderFill.BackgroundColor3 = AccentColor
            SliderFill.BorderSizePixel = 0
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.Parent = SliderFill
            FillCorner.CornerRadius = UDim.new(1, 0)
            
            local SliderValue = defaultValue
            
            local function GetPercent()
                return (SliderValue - min) / (max - min)
            end
            
            local function UpdateSlider()
                SliderFill.Size = UDim2.new(GetPercent(), 0, 1, 0)
                ValueLabel.Text = tostring(SliderValue) .. suffix
            end
            
            UpdateSlider()
            
            local isDragging = false
            
            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = true
                    local pos = Mouse.X - SliderBar.AbsolutePosition.X
                    local percent = math.clamp(pos / SliderBar.AbsoluteSize.X, 0, 1)
                    SliderValue = min + (max - min) * percent
                    SliderValue = tonumber(string.format("%." .. rounding .. "f", SliderValue))
                    UpdateSlider()
                    callback(SliderValue)
                end
            end)
            
            SliderBar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = false
                end
            end)
            
            UIS.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local pos = Mouse.X - SliderBar.AbsolutePosition.X
                    local percent = math.clamp(pos / SliderBar.AbsoluteSize.X, 0, 1)
                    SliderValue = min + (max - min) * percent
                    SliderValue = tonumber(string.format("%." .. rounding .. "f", SliderValue))
                    UpdateSlider()
                    callback(SliderValue)
                end
            end)
            
            local sliderLib = {
                GetValue = function() return SliderValue end,
                SetValue = function(v)
                    SliderValue = math.clamp(v, min, max)
                    SliderValue = tonumber(string.format("%." .. rounding .. "f", SliderValue))
                    UpdateSlider()
                    callback(SliderValue)
                end,
                Root = SliderFrame
            }
            
            if flag then
                Flags[flag] = sliderLib
            end
            
            return sliderLib
        end
        
        function sectionData:AddButton(config)
            config = config or {}
            local callback = config.Callback or function() end
            local icon = config.Icon
            
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Parent = SectionHandler
            ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.LayoutOrder = 3
            
            local iconOffset = 0
            
            if icon then
                local IconLabel = CreateIconLabel(icon, 16, AccentColor, 0.2)
                IconLabel.Parent = ButtonFrame
                IconLabel.Position = UDim2.new(0, 10, 0.5, -8)
                IconLabel.Size = UDim2.new(0, 16, 0, 16)
                iconOffset = 35
            end
            
            local Label = Instance.new("TextLabel")
            Label.Parent = ButtonFrame
            Label.Size = UDim2.new(1, -(iconOffset or 20), 0, 15)
            Label.Position = UDim2.new(0, iconOffset or 10, 0.5, -7.5)
            Label.BackgroundTransparency = 1
            Label.Text = config.Name or "Button"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 13
            Label.TextTransparency = 0.2
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            table.insert(AllItems, {Root = Label, Name = config.Name or "Button"})
            
            local Line = Instance.new("Frame")
            Line.Parent = ButtonFrame
            Line.Size = UDim2.new(1, -20, 0, 1)
            Line.Position = UDim2.new(0.5, 0, 1, 0)
            Line.AnchorPoint = Vector2.new(0.5, 1)
            Line.BackgroundColor3 = BorderColor
            Line.BackgroundTransparency = 0.65
            
            local Input = Instance.new("ImageButton")
            Input.Parent = ButtonFrame
            Input.Size = UDim2.new(1, 0, 1, 0)
            Input.BackgroundTransparency = 1
            Input.ImageTransparency = 1
            
            Input.MouseButton1Click:Connect(callback)
            
            Input.MouseEnter:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.35
                }):Play()
            end)
            
            Input.MouseLeave:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
                    BackgroundTransparency = 1
                }):Play()
            end)
            
            return {
                Root = ButtonFrame,
                SetText = function(t) Label.Text = t end
            }
        end
        
        function sectionData:AddLabel(config)
            config = config or {}
            local icon = config.Icon
            
            local LabelFrame = Instance.new("Frame")
            LabelFrame.Parent = SectionHandler
            LabelFrame.Size = UDim2.new(1, 0, 0, 30)
            LabelFrame.BackgroundTransparency = 1
            LabelFrame.LayoutOrder = 4
            
            local iconOffset = 0
            
            if icon then
                local IconLabel = CreateIconLabel(icon, 14, ContentColor, 0.35)
                IconLabel.Parent = LabelFrame
                IconLabel.Position = UDim2.new(0, 10, 0.5, -7)
                IconLabel.Size = UDim2.new(0, 14, 0, 14)
                iconOffset = 30
            end
            
            local Label = Instance.new("TextLabel")
            Label.Parent = LabelFrame
            Label.Size = UDim2.new(1, -(iconOffset or 20), 1, 0)
            Label.Position = UDim2.new(0, iconOffset or 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = config.Name or "Label"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 13
            Label.TextTransparency = 0.35
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            table.insert(AllItems, {Root = Label, Name = config.Name or "Label"})
            
            local Line = Instance.new("Frame")
            Line.Parent = LabelFrame
            Line.Size = UDim2.new(1, -20, 0, 1)
            Line.Position = UDim2.new(0.5, 0, 1, 0)
            Line.AnchorPoint = Vector2.new(0.5, 1)
            Line.BackgroundColor3 = BorderColor
            Line.BackgroundTransparency = 0.65
            
            return {
                Root = LabelFrame,
                SetText = function(t) Label.Text = t end
            }
        end
        
        function sectionData:AddTextInput(config)
            config = config or {}
            local defaultValue = config.Default or ""
            local placeholder = config.Placeholder or "Enter text..."
            local callback = config.Callback or function() end
            local flag = config.Flag or nil
            local size = config.Size or 150
            local icon = config.Icon
            
            local TextFrame = Instance.new("Frame")
            TextFrame.Parent = SectionHandler
            TextFrame.Size = UDim2.new(1, 0, 0, 30)
            TextFrame.BackgroundTransparency = 1
            TextFrame.LayoutOrder = 5
            
            local iconOffset = 0
            
            if icon then
                local IconLabel = CreateIconLabel(icon, 14, AccentColor, 0.35)
                IconLabel.Parent = TextFrame
                IconLabel.Position = UDim2.new(0, 10, 0.5, -7)
                IconLabel.Size = UDim2.new(0, 14, 0, 14)
                iconOffset = 30
            end
            
            local Label = Instance.new("TextLabel")
            Label.Parent = TextFrame
            Label.Size = UDim2.new(0, 0, 1, 0)
            Label.Position = UDim2.new(0, iconOffset or 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = config.Name or "Text"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 13
            Label.TextTransparency = 0.35
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local textSize = TextService:GetTextSize(Label.Text, 13, Enum.Font.GothamMedium, Vector2.new(999, 999))
            Label.Size = UDim2.new(0, textSize.X + 5, 1, 0)
            
            local Input = Instance.new("TextBox")
            Input.Parent = TextFrame
            Input.Size = UDim2.new(0, size, 1, -4)
            Input.Position = UDim2.new(0, textSize.X + (iconOffset or 0) + 15, 0.5, 0)
            Input.AnchorPoint = Vector2.new(0, 0.5)
            Input.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
            Input.BorderSizePixel = 0
            Input.Text = tostring(defaultValue)
            Input.TextColor3 = Color3.fromRGB(255, 255, 255)
            Input.TextSize = 12
            Input.TextTransparency = 0.35
            Input.Font = Enum.Font.GothamMedium
            Input.TextXAlignment = Enum.TextXAlignment.Left
            Input.PlaceholderText = placeholder
            Input.ClearTextOnFocus = false
            
            local InputCorner = Instance.new("UICorner")
            InputCorner.Parent = Input
            InputCorner.CornerRadius = UDim.new(0, 4)
            
            local InputStroke = Instance.new("UIStroke")
            InputStroke.Parent = Input
            InputStroke.Transparency = 0.65
            InputStroke.Color = BorderColor
            
            Input:GetPropertyChangedSignal("Text"):Connect(function()
                callback(Input.Text)
            end)
            
            table.insert(AllItems, {Root = Label, Name = config.Name or "Text"})
            
            local textLib = {
                GetValue = function() return Input.Text end,
                SetValue = function(v) Input.Text = tostring(v) end,
                Root = TextFrame
            }
            
            if flag then
                Flags[flag] = textLib
            end
            
            return textLib
        end

        function sectionData:AddCycleButton(config)
            config = config or {}
            local options = config.Options or {}
            local default = config.Default or options[1] or "Spin"
            local callback = config.Callback or function() end
            local flag = config.Flag or nil
            local icon = config.Icon
            
            local CycleFrame = Instance.new("Frame")
            CycleFrame.Parent = SectionHandler
            CycleFrame.Size = UDim2.new(1, 0, 0, 50)
            CycleFrame.BackgroundTransparency = 1
            CycleFrame.LayoutOrder = 6
            
            local iconOffset = 0
            
            if icon then
                local IconLabel = CreateIconLabel(icon, 14, AccentColor, 0.35)
                IconLabel.Parent = CycleFrame
                IconLabel.Position = UDim2.new(0, 10, 0.5, -7)
                IconLabel.Size = UDim2.new(0, 14, 0, 14)
                iconOffset = 30
            end
            
            local Label = Instance.new("TextLabel")
            Label.Parent = CycleFrame
            Label.Size = UDim2.new(1, -(iconOffset or 20), 0, 18)
            Label.Position = UDim2.new(0, iconOffset or 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = config.Name or "Spin Mode"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 13
            Label.TextTransparency = 0.35
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            table.insert(AllItems, {Root = Label, Name = config.Name or "Spin Mode"})
            
            local CurrentIndex = 1
            for i, v in ipairs(options) do
                if v == default then
                    CurrentIndex = i
                    break
                end
            end
            
            local ModeValue = default
            
            local Btn = Instance.new("TextButton")
            Btn.Parent = CycleFrame
            Btn.Size = UDim2.new(0, 80, 0, 26)
            Btn.Position = UDim2.new(0, iconOffset or 10, 0, 22)
            Btn.BackgroundColor3 = AccentColor
            Btn.Text = default
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 12
            Btn.Font = Enum.Font.GothamMedium
            Btn.BorderSizePixel = 0
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.Parent = Btn
            BtnCorner.CornerRadius = UDim.new(0, 4)
            
            Btn.MouseButton1Click:Connect(function()
                CurrentIndex = CurrentIndex % #options + 1
                ModeValue = options[CurrentIndex]
                Btn.Text = ModeValue
                callback(ModeValue)
            end)
            
            local modeLib = {
                GetValue = function() return ModeValue end,
                SetValue = function(v)
                    for i, opt in ipairs(options) do
                        if opt == v then
                            CurrentIndex = i
                            ModeValue = v
                            Btn.Text = v
                            callback(v)
                            break
                        end
                    end
                end,
                Root = CycleFrame
            }
            
            if flag then
                Flags[flag] = modeLib
            end
            
            return modeLib
        end
        
        return sectionData
    end
    return tabData
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchBox.Text)
    if query == "" then
        for _, item in ipairs(AllItems) do
            if item.Root then
                local parent = item.Root.Parent
                while parent and parent ~= TabContainer do
                    if parent:IsA("Frame") and parent.Parent then
                        parent.Visible = true
                    end
                    parent = parent.Parent
                end
                item.Root.Parent.Visible = true
            end
        end
        return
    end
    
    for _, item in ipairs(AllItems) do
        local visible = string.find(string.lower(item.Name or ""), query, 1, true) ~= nil
        if item.Root then
            local parent = item.Root.Parent
            while parent and parent ~= TabContainer do
                if parent:IsA("Frame") and parent.Parent then
                    parent.Visible = visible
                end
                parent = parent.Parent
            end
            item.Root.Parent.Visible = visible
        end
    end
end)

task.wait(3)
local MainTab = CreateTab(GetIcon("house"), "Main")

local BHopSection = MainTab:AddSection({
    Name = "BUNNY HOP",
    Position = "left",
    Icon = GetIcon("arrow-up")
})

BHopSection:AddToggle({
    Name = "Auto BunnyHop",
    Icon = GetIcon("arrow-up"),
    Default = false,
    Callback = function(v) 
        Config.BHopEnabled = v 
    end,
    Flag = "BHopEnabled"
})

-- MOVEMENT
local MovementSection = MainTab:AddSection({
    Name = "MOVEMENT",
    Position = "left",
    Icon = GetIcon("zap")
})

MovementSection:AddToggle({
    Name = "CFrame Speed",
    Icon = GetIcon("gauge"),
    Default = false,
    Callback = function(v) Config.SpeedEnabled = v end,
    Flag = "SpeedEnabled"
})

MovementSection:AddSlider({
    Name = "Speed Value",
    Icon = GetIcon("arrow-up-circle"),
    Default = 16,
    Min = 1,
    Max = 300,
    Type = "",
    Callback = function(v) Config.SpeedValue = v end,
    Flag = "SpeedValue"
})

MovementSection:AddToggle({
    Name = "CTRL + Click TP",
    Icon = GetIcon("mouse-pointer"),
    Default = false,
    Callback = function(v) Config.TpEnabled = v end,
    Flag = "TpEnabled"
})

MovementSection:AddSlider({
    Name = "TP Height",
    Icon = GetIcon("arrow-up"),
    Default = 10,
    Min = 1,
    Max = 1000,
    Type = "",
    Callback = function(v) Config.TpHeight = v end,
    Flag = "TpHeight"
})

MovementSection:AddToggle({
    Name = "Skip Map",
    Icon = GetIcon("map-pin"),
    Default = false,
    Callback = function(v)
        Config.SkipMapEnabled = v
        if v then
            Config.SkipMapPos = Vector3.new(0, 5000, 0)
            local platform = Instance.new("Part")
            platform.Name = "SkipMapPlatform"
            platform.Size = Vector3.new(50, 2, 50)
            platform.Position = Config.SkipMapPos - Vector3.new(0, 4, 0)
            platform.Anchored = true
            platform.CanCollide = true
            platform.Transparency = 0.9
            platform.Color = Color3.fromRGB(0, 0, 0)
            platform.Material = Enum.Material.SmoothPlastic
            platform.Parent = WS
            Config.SkipMapPlatform = platform
            
            Config.SkipMapConnection = RS.Heartbeat:Connect(function()
                if not Config.SkipMapEnabled then
                    Config.SkipMapConnection:Disconnect()
                    Config.SkipMapConnection = nil
                    return
                end
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        if (hrp.Position - Config.SkipMapPos).Magnitude > 50 then
                            hrp.CFrame = CFrame.new(Config.SkipMapPos)
                        end
                    end
                end
            end)
        else
            if Config.SkipMapConnection then
                Config.SkipMapConnection:Disconnect()
                Config.SkipMapConnection = nil
            end
            if Config.SkipMapPlatform then
                Config.SkipMapPlatform:Destroy()
                Config.SkipMapPlatform = nil
            end
        end
    end,
    Flag = "SkipMapEnabled"
})

MovementSection:AddToggle({
    Name = "TP Walk",
    Icon = GetIcon("zap"),
    Default = false,
    Callback = function(v) Config.TpWalkEnabled = v end,
    Flag = "TpWalkEnabled"
})

MovementSection:AddSlider({
    Name = "TP Walk Speed",
    Icon = GetIcon("arrow-up-circle"),
    Default = 1,
    Min = 1,
    Max = 200,
    Type = "",
    Callback = function(v) Config.TpWalkValue = v end,
    Flag = "TpWalkValue"
})

MovementSection:AddToggle({
    Name = "Super Bounce",
    Icon = GetIcon("arrow-up"),
    Default = false,
    Callback = function(v) Config.SuperBounceEnabled = v end,
    Flag = "SuperBounceEnabled"
})

MovementSection:AddTextInput({
    Name = "Bounce Height",
    Icon = GetIcon("arrow-up"),
    Default = "190",
    Placeholder = "190",
    Size = 100,
    Callback = function(v)
        local num = tonumber(v)
        if num then Config.SuperBounceHeight = num end
    end
})

MovementSection:AddButton({
    Name = "Bounce!",
    Icon = GetIcon("arrow-up"),
    Callback = function()
        if not LocalPlayer.Character then return end
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoid and rootPart then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, Config.SuperBounceHeight, rootPart.Velocity.Z)
        end
    end
})

-- SPIN BOT
local SpinSection = MainTab:AddSection({
    Name = "SPIN BOT",
    Position = "right",
    Icon = GetIcon("rotate-cw")
})

SpinSection:AddToggle({
    Name = "Spin Bot",
    Icon = GetIcon("rotate-cw"),
    Default = false,
    Callback = function(v) Config.SpinEnabled = v end,
    Flag = "SpinEnabled"
})

SpinSection:AddCycleButton({
    Name = "Spin Mode",
    Icon = GetIcon("list"),
    Options = {"Spin", "Jitter", "Slide", "Random", "Down", "Up", "Left", "Right"},
    Default = "Spin",
    Callback = function(v) Config.SpinMode = v end,
    Flag = "SpinMode"
})

SpinSection:AddSlider({
    Name = "Spin Speed",
    Icon = GetIcon("speedometer"),
    Default = 15,
    Min = 1,
    Max = 50,
    Type = "",
    Callback = function(v) Config.SpinSpeed = v end,
    Flag = "SpinSpeed"
})

-- COMBAT
local CombatSection = MainTab:AddSection({
    Name = "COMBAT",
    Position = "left",
    Icon = GetIcon("sword")
})

CombatSection:AddToggle({
    Name = "Defibrillator Aura",
    Icon = GetIcon("heart"),
    Default = false,
    Callback = function(state)
        Config.DefibAura = state
        if state then
            if Config.DefibConnection then Config.DefibConnection:Disconnect() end
            local defibEquipped = false
            
            Config.DefibConnection = RS.RenderStepped:Connect(function()
                if not Config.DefibAura then
                    Config.DefibConnection:Disconnect()
                    return
                end
                local char = LocalPlayer.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and isPlayerDowned(player) then
                        local targetChar = player.Character
                        if targetChar then
                            local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
                            if targetHRP then
                                local dist = (hrp.Position - targetHRP.Position).Magnitude
                                if dist <= Config.DefibRange then
                                    local tag = targetChar:GetAttribute("Tag")
                                    if tag then
                                        if not defibEquipped then
                                            ReplicatedStorage.Events.UpdateCharacterDataRegistry:FireServer({buffer.fromstring("\008\000"), buffer.fromstring("\003")})
                                            defibEquipped = true
                                        end
                                        ToolAction:FireServer(buffer.fromstring("\001\001\001\001"), tag)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            if Config.DefibConnection then
                Config.DefibConnection:Disconnect()
                Config.DefibConnection = nil
            end
        end
    end,
    Flag = "DefibAura"
})

CombatSection:AddTextInput({
    Name = "Aura Range",
    Icon = GetIcon("target"),
    Default = "20",
    Placeholder = "20 or inf",
    Size = 100,
    Callback = function(v)
        if v == "inf" then
            Config.DefibRange = math.huge
        else
            local num = tonumber(v)
            if num then Config.DefibRange = num end
        end
    end
})

CombatSection:AddButton({
    Name = "Infinite Range",
    Icon = GetIcon("target"),
    Callback = function()
        local function setInfiniteRange(data)
            if type(data) ~= "table" then return end
            for key, value in pairs(data) do
                if (key == "Range" or key == "LungeRange" or key == "HearingRange") and type(value) == "number" then
                    data[key] = math.huge
                elseif key == "DamageDistanceInterval" and type(value) == "table" and #value >= 2 then
                    value[2] = math.huge
                elseif type(value) == "table" then
                    setInfiniteRange(value)
                end
            end
        end
        
        for _, tool in ipairs(ReplicatedStorage.Tools:GetChildren()) do
            if tool:IsA("ModuleScript") then
                local success, toolData = pcall(require, tool)
                if success and type(toolData) == "table" and toolData.Tasks then
                    for _, task in ipairs(toolData.Tasks) do
                        for _, func in ipairs(task.Functions or {}) do
                            for _, activation in ipairs(func.Activations or {}) do
                                for _, method in ipairs(activation.Methods or {}) do
                                    if method.Info then setInfiniteRange(method.Info) end
                                end
                            end
                        end
                        for _, autoFunc in ipairs(task.AutomaticFunctions or {}) do
                            for _, method in ipairs(autoFunc.Methods or {}) do
                                if method.Info then setInfiniteRange(method.Info) end
                            end
                        end
                    end
                end
            end
        end
    end
})

CombatSection:AddButton({
    Name = "Portal Bypass",
    Icon = GetIcon("link"),
    Callback = function()
        local methodModule = getrenv().require(ReplicatedStorage.Objects.Game.Tool.Tasks.Types.Portal)
        methodModule.IsPortalPossible = function(...) return true end
    end
})

CombatSection:AddToggle({
    Name = "Build Offset",
    Icon = GetIcon("move"),
    Default = false,
    Callback = function(state)
        Config.BuildOffsetEnabled = state
        if state then
            local buildModule = getrenv().require(ReplicatedStorage.Objects.Game.Tool.Tasks.Types.Build)
            local oldGetClientPosition = buildModule.GetClientPosition
            buildModule.GetClientPosition = function(self, ...)
                local valid, cframe = oldGetClientPosition(self, ...)
                if cframe then
                    cframe = cframe * CFrame.new(Config.BuildOffsetX or 0, Config.BuildOffsetY or 0, Config.BuildOffsetZ or 0)
                end
                return valid, cframe
            end
        end
    end
})

CombatSection:AddTextInput({
    Name = "Offset X",
    Icon = GetIcon("arrow-right"),
    Default = "0",
    Placeholder = "0",
    Size = 80,
    Callback = function(v)
        local num = tonumber(v) or 0
        Config.BuildOffsetX = num
    end
})

CombatSection:AddTextInput({
    Name = "Offset Y",
    Icon = GetIcon("arrow-up"),
    Default = "0",
    Placeholder = "0",
    Size = 80,
    Callback = function(v)
        local num = tonumber(v) or 0
        Config.BuildOffsetY = num
    end
})

CombatSection:AddTextInput({
    Name = "Offset Z",
    Icon = GetIcon("arrow-left"),
    Default = "0",
    Placeholder = "0",
    Size = 80,
    Callback = function(v)
        local num = tonumber(v) or 0
        Config.BuildOffsetZ = num
    end
})

CombatSection:AddButton({
    Name = "No Weapon Spread",
    Icon = GetIcon("crosshair"),
    Callback = function()
        for _, tool in ipairs(ReplicatedStorage.Tools:GetChildren()) do
            if tool:IsA("ModuleScript") then
                local success, module = pcall(require, tool)
                if success and module and module.Tasks then
                    for _, task in ipairs(module.Tasks) do
                        if task.MethodReferences and task.MethodReferences.Projectile and task.MethodReferences.Projectile.Info and task.MethodReferences.Projectile.Info.SpreadInfo then
                            task.MethodReferences.Projectile.Info.SpreadInfo.MaxSpread = 0
                            task.MethodReferences.Projectile.Info.SpreadInfo.MinSpread = 0
                        end
                    end
                end
            end
        end
    end
})

CombatSection:AddButton({
    Name = "No Tool Delay",
    Icon = GetIcon("zap"),
    Callback = function()
        local function setFastShoot(data)
            if type(data) ~= "table" then return end
            for key, value in pairs(data) do
                if key == "Cooldown" and type(value) == "number" then
                    data[key] = 1/65536
                elseif type(value) == "table" then
                    setFastShoot(value)
                end
            end
        end
        
        for _, tool in ipairs(ReplicatedStorage.Tools:GetChildren()) do
            if tool:IsA("ModuleScript") then
                local success, toolData = pcall(require, tool)
                if success and type(toolData) == "table" and toolData.Tasks then
                    for _, task in ipairs(toolData.Tasks) do
                        for _, func in ipairs(task.Functions or {}) do
                            for _, activation in ipairs(func.Activations or {}) do
                                for _, method in ipairs(activation.Methods or {}) do
                                    if method.Info then setFastShoot(method.Info) end
                                end
                            end
                        end
                        for _, autoFunc in ipairs(task.AutomaticFunctions or {}) do
                            for _, method in ipairs(autoFunc.Methods or {}) do
                                if method.Info then setFastShoot(method.Info) end
                            end
                        end
                    end
                end
            end
        end
    end
})

CombatSection:AddToggle({
    Name = "Auto Whistle",
    Icon = GetIcon("music"),
    Default = false,
    Callback = function(state)
        Config.AutoWhistleEnabled = state
        if state then
            if Config.WhistleConnection then Config.WhistleConnection:Disconnect() end
            local lastWhistle = 0
            Config.WhistleConnection = RS.Heartbeat:Connect(function()
                if not Config.AutoWhistleEnabled then
                    Config.WhistleConnection:Disconnect()
                    return
                end
                local now = tick()
                if now - lastWhistle >= 1 then
                    lastWhistle = now
                    pcall(function()
                        ReplicatedStorage:WaitForChild("Services"):WaitForChild("Client"):WaitForChild("KeybindService"):WaitForChild("SendKeybindEvent"):Fire({Key = "Whistle", Down = true})
                    end)
                end
            end)
        else
            if Config.WhistleConnection then
                Config.WhistleConnection:Disconnect()
                Config.WhistleConnection = nil
            end
        end
    end,
    Flag = "AutoWhistleEnabled"
})

CombatSection:AddToggle({
    Name = "God Mode",
    Icon = GetIcon("shield"),
    Default = false,
    Callback = function(state)
        Config.GodModeEnabled = state
        if state then
            if Config.GodModeConnection then Config.GodModeConnection:Disconnect() end
            local timer = 0
            Config.GodModeConnection = RS.Heartbeat:Connect(function(dt)
                if not Config.GodModeEnabled then
                    Config.GodModeConnection:Disconnect()
                    return
                end
                timer = timer + dt
                if timer >= 2 then
                    timer = 0
                    local char = LocalPlayer.Character
                    if char then
                        local tag = char:GetAttribute("Tag")
                        if tag then
                            ReplicatedStorage.Events.Interact:FireServer("Revive", tag)
                            ReplicatedStorage.Events.Interact:FireServer("Revive", tag, true)
                        end
                    end
                end
            end)
        else
            if Config.GodModeConnection then
                Config.GodModeConnection:Disconnect()
                Config.GodModeConnection = nil
            end
        end
    end,
    Flag = "GodModeEnabled"
})

CombatSection:AddToggle({
    Name = "Self Revive",
    Icon = GetIcon("heart"),
    Default = false,
    Callback = function(state)
        Config.SelfReviveEnabled = state
        if state then
            if Config.ReviveConnection then Config.ReviveConnection:Disconnect() end
            local hasRevived = false
            Config.ReviveConnection = RS.Heartbeat:Connect(function()
                if not Config.SelfReviveEnabled then
                    Config.ReviveConnection:Disconnect()
                    return
                end
                local char = LocalPlayer.Character
                if not char then return end
                local charData = CharacterService:GetCharacterFromPlayer(LocalPlayer)
                if charData and charData.DataRegistry:Get("Downed") then
                    if not hasRevived then
                        hasRevived = true
                        pcall(function()
                            changePlayerMode:FireServer(true)
                        end)
                        task.delay(10, function()
                            hasRevived = false
                        end)
                    end
                end
            end)
        else
            if Config.ReviveConnection then
                Config.ReviveConnection:Disconnect()
                Config.ReviveConnection = nil
            end
        end
    end,
    Flag = "SelfReviveEnabled"
})

-- UTILITY
local UtilitySection = MainTab:AddSection({
    Name = "UTILITY",
    Position = "left",
    Icon = GetIcon("wrench")
})

UtilitySection:AddToggle({
    Name = "Custom Gravity",
    Icon = GetIcon("arrow-down"),
    Default = false,
    Callback = function(state)
        Config.GravityEnabled = state
        if state then
            WS.Gravity = Config.GravityValue
        else
            WS.Gravity = 196.2
        end
    end,
    Flag = "GravityEnabled"
})

UtilitySection:AddTextInput({
    Name = "Gravity Value",
    Icon = GetIcon("hash"),
    Default = "196.2",
    Placeholder = "196.2",
    Size = 80,
    Callback = function(v)
        local num = tonumber(v)
        if num then
            Config.GravityValue = num
            if Config.GravityEnabled then
                WS.Gravity = num
            end
        end
    end
})

UtilitySection:AddToggle({
    Name = "Jump Pad Boost",
    Icon = GetIcon("arrow-up"),
    Default = false,
    Callback = function(state)
        Config.JumpPadEnabled = state
        if state then
            local jumpPadModule = require(ReplicatedStorage.Items.BaseItems.Loadout.Deployables.JumpPad.Modules.Client)
            local originalUse = jumpPadModule.Use
            jumpPadModule.Use = function(p1, p2)
                if p2 == nil or p2 ~= LocalPlayer.Character then
                    return originalUse(p1, p2)
                end
                p1.Model.AnimationController:LoadAnimation(p1.Model.Animations.Use):Play(0.1)
                p1.Model.BoundingBox.Launch:Play()
                LocalPlayer.Character.HumanoidRootPart:ApplyImpulse(Vector3.new(0, Config.JumpPadValue or 360, 0))
                return
            end
        end
    end,
    Flag = "JumpPadEnabled"
})

UtilitySection:AddTextInput({
    Name = "Jump Power",
    Icon = GetIcon("arrow-up"),
    Default = "360",
    Placeholder = "360",
    Size = 80,
    Callback = function(v)
        local num = tonumber(v)
        if num then Config.JumpPadValue = num end
    end
})

-- MINI TELEPORT
local TeleportSection = MainTab:AddSection({
    Name = "MINI TELEPORT",
    Position = "right",
    Icon = GetIcon("navigation")
})

TeleportSection:AddButton({
    Name = "Teleport to Spawn",
    Icon = GetIcon("home"),
    Callback = function()
        teleportToRandomSpawn(Vector3.new(0, 3, 0))
    end
})

TeleportSection:AddButton({
    Name = "Teleport to Random Player",
    Icon = GetIcon("users"),
    Callback = function()
        teleportToRandomPlayer(Vector3.new(0, 3, 0))
    end
})

TeleportSection:AddButton({
    Name = "Teleport to Downed Player",
    Icon = GetIcon("heart"),
    Callback = function()
        teleportToRandomDowned(Vector3.new(0, 3, 0))
    end
})

TeleportSection:AddButton({
    Name = "Teleport to Ticket",
    Icon = GetIcon("ticket"),
    Callback = function()
        teleportToRandomTicket(Vector3.new(0, 3, 0))
    end
})

TeleportSection:AddButton({
    Name = "Teleport to Security Part",
    Icon = GetIcon("shield"),
    Callback = function()
        teleportToSecurityPart(Vector3.new(0, 3, 0))
    end
})

TeleportSection:AddTextInput({
    Name = "Coordinates X Y Z",
    Icon = GetIcon("hash"),
    Default = "",
    Placeholder = "0 0 0",
    Size = 120,
    Callback = function(v)
        Config.TeleportCoords = v
    end
})

TeleportSection:AddButton({
    Name = "Teleport to Coordinates",
    Icon = GetIcon("target"),
    Callback = function()
        if not Config.TeleportCoords then return end
        local x, y, z = Config.TeleportCoords:match("([%d.-]+)%s+([%d.-]+)%s+([%d.-]+)")
        if x and y and z then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(tonumber(x) or 0, tonumber(y) or 0, tonumber(z) or 0)
            end
        end
    end
})

local VisualsTab = CreateTab(GetIcon("eye"), "Visuals")

local RTXSection = VisualsTab:AddSection({
    Name = "RTX SHADERS",
    Position = "left",
    Icon = GetIcon("camera")
})

RTXSection:AddToggle({
    Name = "RTX Shaders",
    Icon = GetIcon("film"),
    Default = false,
    Callback = function(v) Config.ShaderRTX = v end,
    Flag = "ShaderRTX"
})

RTXSection:AddSlider({
    Name = "Bloom Intensity",
    Icon = GetIcon("sun"),
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.BloomIntensity = v end,
    Flag = "BloomIntensity"
})

RTXSection:AddSlider({
    Name = "Bloom Size",
    Icon = GetIcon("maximize"),
    Default = 10,
    Min = 0,
    Max = 20,
    Type = "",
    Callback = function(v) Config.BloomSize = v end,
    Flag = "BloomSize"
})

RTXSection:AddSlider({
    Name = "Blur Size",
    Icon = GetIcon("eye-off"),
    Default = 5,
    Min = 0,
    Max = 15,
    Type = "",
    Callback = function(v) Config.BlurSize = v end,
    Flag = "BlurSize"
})

RTXSection:AddSlider({
    Name = "Brightness",
    Icon = GetIcon("sun"),
    Default = 0.1,
    Min = -0.5,
    Max = 0.5,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.ShadersBrightness = v end,
    Flag = "ShadersBrightness"
})

RTXSection:AddSlider({
    Name = "Contrast",
    Icon = GetIcon("contrast"),
    Default = 0.5,
    Min = -0.5,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.ShadersContrast = v end,
    Flag = "ShadersContrast"
})

RTXSection:AddSlider({
    Name = "Saturation",
    Icon = GetIcon("droplet"),
    Default = -0.3,
    Min = -1,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.ShadersSaturation = v end,
    Flag = "ShadersSaturation"
})

RTXSection:AddSlider({
    Name = "SunRays Intensity",
    Icon = GetIcon("sun"),
    Default = 0.075,
    Min = 0,
    Max = 0.5,
    Rounding = 3,
    Type = "",
    Callback = function(v) Config.SunRaysIntensity = v end,
    Flag = "SunRaysIntensity"
})

RTXSection:AddSlider({
    Name = "Day / Night (0-24h)",
    Icon = GetIcon("clock"),
    Default = 14,
    Min = 0,
    Max = 24,
    Type = "h",
    Callback = function(v) Config.ShadersTime = v end,
    Flag = "ShadersTime"
})

RTXSection:AddSlider({
    Name = "Fog Density",
    Icon = GetIcon("cloud"),
    Default = 0.364,
    Min = 0,
    Max = 1,
    Rounding = 3,
    Type = "",
    Callback = function(v) Config.ShadersFog = v end,
    Flag = "ShadersFog"
})

RTXSection:AddSlider({
    Name = "Vignette Opacity",
    Icon = GetIcon("circle"),
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.ShadersVignette = v end,
    Flag = "ShadersVignette"
})

-- ===== ULTIMATE SHADERS MAIN =====
local UltimateMainSection = VisualsTab:AddSection({
    Name = "ULTIMATE SHADERS",
    Position = "left",
    Icon = GetIcon("layers")
})

UltimateMainSection:AddToggle({
    Name = "Ultimate Shaders",
    Icon = GetIcon("layers"),
    Default = true,
    Callback = function(v) Config.UltimateShadersOn = v end,
    Flag = "UltimateShadersOn"
})

UltimateMainSection:AddCycleButton({
    Name = "Technology",
    Icon = GetIcon("cpu"),
    Options = {"Future", "ShadowMap", "Compatibility", "Legacy", "Voxel"},
    Default = "ShadowMap",
    Callback = function(v) Config.UltimateTechnology = v end,
    Flag = "UltimateTechnology"
})

UltimateMainSection:AddToggle({
    Name = "Global Illumination",
    Icon = GetIcon("sun"),
    Default = false,
    Callback = function(v) Config.UltimateGlobalIllum = v end,
    Flag = "UltimateGlobalIllum"
})

UltimateMainSection:AddSlider({
    Name = "Reflectance",
    Icon = GetIcon("droplet"),
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateReflectance = v end,
    Flag = "UltimateReflectance"
})

-- ===== SKYBOX =====
local SkyboxSection = VisualsTab:AddSection({
    Name = "SKYBOX",
    Position = "left",
    Icon = GetIcon("cloud")
})

SkyboxSection:AddCycleButton({
    Name = "Skybox Preset",
    Icon = GetIcon("image"),
    Options = {"default", "morning", "midday", "afternoon", "evening", "rain", "cloudy", "game"},
    Default = "default",
    Callback = function(v) Config.UltimateSkybox = v end,
    Flag = "UltimateSkybox"
})

-- ===== ATMOSPHERE =====
local AtmosphereSection = VisualsTab:AddSection({
    Name = "ATMOSPHERE",
    Position = "left",
    Icon = GetIcon("cloud")
})

AtmosphereSection:AddSlider({
    Name = "Density",
    Icon = GetIcon("cloud"),
    Default = 0.364,
    Min = 0,
    Max = 1,
    Rounding = 3,
    Type = "",
    Callback = function(v) Config.UltimateAtmoDensity = v end,
    Flag = "UltimateAtmoDensity"
})

AtmosphereSection:AddSlider({
    Name = "Offset",
    Icon = GetIcon("arrow-right"),
    Default = 0.556,
    Min = 0,
    Max = 1,
    Rounding = 3,
    Type = "",
    Callback = function(v) Config.UltimateAtmoOffset = v end,
    Flag = "UltimateAtmoOffset"
})

AtmosphereSection:AddSlider({
    Name = "Glare",
    Icon = GetIcon("sun"),
    Default = 0.36,
    Min = 0,
    Max = 10,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateAtmoGlare = v end,
    Flag = "UltimateAtmoGlare"
})

AtmosphereSection:AddSlider({
    Name = "Haze",
    Icon = GetIcon("cloud"),
    Default = 1.72,
    Min = 0,
    Max = 10,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateAtmoHaze = v end,
    Flag = "UltimateAtmoHaze"
})

-- ===== CLOUDS =====
local CloudsSection = VisualsTab:AddSection({
    Name = "CLOUDS",
    Position = "right",
    Icon = GetIcon("cloud")
})

CloudsSection:AddSlider({
    Name = "Cloud Cover",
    Icon = GetIcon("cloud"),
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateCloudCover = v end,
    Flag = "UltimateCloudCover"
})

CloudsSection:AddSlider({
    Name = "Cloud Density",
    Icon = GetIcon("cloud"),
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateCloudDensity = v end,
    Flag = "UltimateCloudDensity"
})

-- ===== WATER =====
local WaterSection = VisualsTab:AddSection({
    Name = "WATER",
    Position = "right",
    Icon = GetIcon("droplet")
})

WaterSection:AddSlider({
    Name = "Water Speed",
    Icon = GetIcon("zap"),
    Default = 10,
    Min = 0,
    Max = 100,
    Type = "",
    Callback = function(v) Config.UltimateWaterSpeed = v end,
    Flag = "UltimateWaterSpeed"
})

WaterSection:AddSlider({
    Name = "Water Transparency",
    Icon = GetIcon("eye"),
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateWaterTrans = v end,
    Flag = "UltimateWaterTrans"
})

WaterSection:AddSlider({
    Name = "Water Wave Size",
    Icon = GetIcon("maximize"),
    Default = 5,
    Min = 0,
    Max = 40,
    Type = "",
    Callback = function(v) Config.UltimateWaterSize = v end,
    Flag = "UltimateWaterSize"
})

-- ===== TIME =====
local TimeSection = VisualsTab:AddSection({
    Name = "TIME",
    Position = "right",
    Icon = GetIcon("clock")
})

TimeSection:AddSlider({
    Name = "Clock Time",
    Icon = GetIcon("clock"),
    Default = 14,
    Min = 0,
    Max = 24,
    Type = "h",
    Callback = function(v) Config.UltimateClockTime = v end,
    Flag = "UltimateClockTime"
})

TimeSection:AddSlider({
    Name = "Latitude",
    Icon = GetIcon("compass"),
    Default = 45,
    Min = 0,
    Max = 180,
    Type = "°",
    Callback = function(v) Config.UltimateLatitude = v end,
    Flag = "UltimateLatitude"
})

-- ===== DEPTH OF FIELD =====
local DOFSection = VisualsTab:AddSection({
    Name = "DEPTH OF FIELD",
    Position = "left",
    Icon = GetIcon("focus")
})

DOFSection:AddToggle({
    Name = "DOF Enabled",
    Icon = GetIcon("focus"),
    Default = false,
    Callback = function(v) Config.UltimateDOFEnabled = v end,
    Flag = "UltimateDOFEnabled"
})

DOFSection:AddSlider({
    Name = "Far Intensity",
    Icon = GetIcon("arrow-right"),
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateDOFFarIntensity = v end,
    Flag = "UltimateDOFFarIntensity"
})

DOFSection:AddSlider({
    Name = "Focus Distance",
    Icon = GetIcon("target"),
    Default = 50,
    Min = 0,
    Max = 200,
    Type = "",
    Callback = function(v) Config.UltimateDOFFocusDist = v end,
    Flag = "UltimateDOFFocusDist"
})

DOFSection:AddSlider({
    Name = "In Focus Radius",
    Icon = GetIcon("circle"),
    Default = 5,
    Min = 0,
    Max = 50,
    Type = "",
    Callback = function(v) Config.UltimateDOFInFocus = v end,
    Flag = "UltimateDOFInFocus"
})

DOFSection:AddSlider({
    Name = "Near Intensity",
    Icon = GetIcon("arrow-left"),
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateDOFNearIntensity = v end,
    Flag = "UltimateDOFNearIntensity"
})

-- ===== SUN RAYS =====
local SunRaysSection = VisualsTab:AddSection({
    Name = "SUN RAYS",
    Position = "left",
    Icon = GetIcon("sun")
})

SunRaysSection:AddToggle({
    Name = "Sun Rays Enabled",
    Icon = GetIcon("sun"),
    Default = false,
    Callback = function(v) Config.UltimateSunRaysEnabled = v end,
    Flag = "UltimateSunRaysEnabled"
})

SunRaysSection:AddSlider({
    Name = "Sun Rays Intensity",
    Icon = GetIcon("sun"),
    Default = 0.075,
    Min = 0,
    Max = 1,
    Rounding = 3,
    Type = "",
    Callback = function(v) Config.UltimateSunRaysIntensity = v end,
    Flag = "UltimateSunRaysIntensity"
})

SunRaysSection:AddSlider({
    Name = "Sun Rays Spread",
    Icon = GetIcon("maximize"),
    Default = 0.727,
    Min = 0,
    Max = 1,
    Rounding = 3,
    Type = "",
    Callback = function(v) Config.UltimateSunRaysSpread = v end,
    Flag = "UltimateSunRaysSpread"
})

-- ===== COLOR CORRECTION =====
local ColorCorSection = VisualsTab:AddSection({
    Name = "COLOR CORRECTION",
    Position = "right",
    Icon = GetIcon("droplet")
})

ColorCorSection:AddToggle({
    Name = "Color Correction",
    Icon = GetIcon("droplet"),
    Default = true,
    Callback = function(v) Config.UltimateColorCorEnabled = v end,
    Flag = "UltimateColorCorEnabled"
})

ColorCorSection:AddSlider({
    Name = "Brightness",
    Icon = GetIcon("sun"),
    Default = 0.1,
    Min = -1,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateColorBrightness = v end,
    Flag = "UltimateColorBrightness"
})

ColorCorSection:AddSlider({
    Name = "Contrast",
    Icon = GetIcon("contrast"),
    Default = 0.5,
    Min = -1,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateColorContrast = v end,
    Flag = "UltimateColorContrast"
})

ColorCorSection:AddSlider({
    Name = "Saturation",
    Icon = GetIcon("droplet"),
    Default = -0.3,
    Min = -1,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateColorSaturation = v end,
    Flag = "UltimateColorSaturation"
})

-- ===== BLOOM (Ultimate) =====
local UltimateBloomSection = VisualsTab:AddSection({
    Name = "BLOOM (Ultimate)",
    Position = "right",
    Icon = GetIcon("sun")
})

UltimateBloomSection:AddToggle({
    Name = "Bloom Enabled",
    Icon = GetIcon("sun"),
    Default = true,
    Callback = function(v) Config.UltimateBloomEnabled = v end,
    Flag = "UltimateBloomEnabled"
})

UltimateBloomSection:AddSlider({
    Name = "Bloom Intensity",
    Icon = GetIcon("sun"),
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateBloomIntensity = v end,
    Flag = "UltimateBloomIntensity"
})

UltimateBloomSection:AddSlider({
    Name = "Bloom Size",
    Icon = GetIcon("maximize"),
    Default = 10,
    Min = 0,
    Max = 56,
    Type = "",
    Callback = function(v) Config.UltimateBloomSize = v end,
    Flag = "UltimateBloomSize"
})

UltimateBloomSection:AddSlider({
    Name = "Bloom Threshold",
    Icon = GetIcon("target"),
    Default = 0.8,
    Min = 0,
    Max = 4,
    Rounding = 2,
    Type = "",
    Callback = function(v) Config.UltimateBloomThreshold = v end,
    Flag = "UltimateBloomThreshold"
})

-- ===== BLUR (Ultimate) =====
local UltimateBlurSection = VisualsTab:AddSection({
    Name = "BLUR (Ultimate)",
    Position = "right",
    Icon = GetIcon("eye-off")
})

UltimateBlurSection:AddToggle({
    Name = "Blur Enabled",
    Icon = GetIcon("eye-off"),
    Default = false,
    Callback = function(v) Config.UltimateBlurEnabled = v end,
    Flag = "UltimateBlurEnabled"
})

UltimateBlurSection:AddSlider({
    Name = "Blur Size",
    Icon = GetIcon("eye-off"),
    Default = 5,
    Min = 0,
    Max = 56,
    Type = "",
    Callback = function(v) Config.UltimateBlurSize = v end,
    Flag = "UltimateBlurSize"
})

-- ===== EFFECTS =====
local EffectsSection = VisualsTab:AddSection({
    Name = "EFFECTS",
    Position = "left",
    Icon = GetIcon("zap")
})

EffectsSection:AddToggle({
    Name = "Sun Flare",
    Icon = GetIcon("sun"),
    Default = false,
    Callback = function(v) Config.UltimateSunFlare = v end,
    Flag = "UltimateSunFlare"
})

EffectsSection:AddToggle({
    Name = "Motion Blur",
    Icon = GetIcon("zap"),
    Default = false,
    Callback = function(v) Config.UltimateMotionBlur = v end,
    Flag = "UltimateMotionBlur"
})

EffectsSection:AddSlider({
    Name = "Motion Blur Size",
    Icon = GetIcon("maximize"),
    Default = 26,
    Min = 0,
    Max = 100,
    Type = "",
    Callback = function(v) Config.UltimateMotionBlurSize = v end,
    Flag = "UltimateMotionBlurSize"
})

-- ===== MISC VISUALS =====
local MiscVisualsSection = VisualsTab:AddSection({
    Name = "MISC VISUALS",
    Position = "left",
    Icon = GetIcon("eye")
})

MiscVisualsSection:AddToggle({
    Name = "Full Bright",
    Icon = GetIcon("sun"),
    Default = false,
    Callback = function(state)
        Config.FullBrightEnabled = state
        if state then
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
            Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
            Lighting.ColorShift_Top = Color3.new(1, 1, 1)
        else
            Lighting.Brightness = 0.5
            Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
            Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
            Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
            Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        end
    end,
    Flag = "FullBrightEnabled"
})

MiscVisualsSection:AddToggle({
    Name = "No Fog",
    Icon = GetIcon("eye"),
    Default = false,
    Callback = function(state)
        Config.NoFogEnabled = state
        if state then
            Lighting.FogEnd = 1000000
            for _, v in ipairs(Lighting:GetDescendants()) do
                if v:IsA("Atmosphere") then
                    v:Destroy()
                end
            end
        else
            Lighting.FogEnd = 10000
        end
    end,
    Flag = "NoFogEnabled"
})

MiscVisualsSection:AddToggle({
    Name = "No Render",
    Icon = GetIcon("eye-off"),
    Default = false,
    Callback = function(state)
        Config.NoRenderEnabled = state
        RS:Set3dRenderingEnabled(not state)
        if state then
            local gui = Instance.new("ScreenGui")
            gui.Name = "NoRenderBackground"
            gui.DisplayOrder = -99999
            gui.IgnoreGuiInset = true
            gui.ResetOnSpawn = false
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Config.NoRenderColor or Color3.fromRGB(0, 0, 0)
            frame.BorderSizePixel = 0
            frame.Parent = gui
            gui.Parent = PlayerGui
        else
            local gui = PlayerGui:FindFirstChild("NoRenderBackground")
            if gui then gui:Destroy() end
        end
    end,
    Flag = "NoRenderEnabled"
})

-- ===== MAGIC AURA =====
local MagicAuraSection = VisualsTab:AddSection({
    Name = "MAGIC AURA",
    Position = "right",
    Icon = GetIcon("sparkles")
})

MagicAuraSection:AddToggle({
    Name = "Magic Aura",
    Icon = GetIcon("sparkles"),
    Default = false,
    Callback = function(v) Config.MagicAura = v end,
    Flag = "MagicAura"
})

MagicAuraSection:AddSlider({
    Name = "Aura Count",
    Icon = GetIcon("hash"),
    Default = 3,
    Min = 1,
    Max = 6,
    Type = "",
    Callback = function(v) Config.MagicAuraCount = v end,
    Flag = "MagicAuraCount"
})

MagicAuraSection:AddSlider({
    Name = "Aura Radius",
    Icon = GetIcon("maximize"),
    Default = 3,
    Min = 1,
    Max = 8,
    Type = "",
    Callback = function(v) Config.MagicAuraRadius = v end,
    Flag = "MagicAuraRadius"
})

MagicAuraSection:AddSlider({
    Name = "Orbit Speed",
    Icon = GetIcon("rotate-cw"),
    Default = 2,
    Min = 0.5,
    Max = 6,
    Type = "",
    Callback = function(v) Config.MagicAuraSpeed = v end,
    Flag = "MagicAuraSpeed"
})

local ConfigTab = CreateTab(GetIcon("settings"), "Config")

local ConfigSection = ConfigTab:AddSection({
    Name = "CONFIG",
    Position = "left",
    Icon = GetIcon("settings")
})

local configLabel = ConfigSection:AddLabel({
    Name = "Current Config: Default",
    Icon = GetIcon("file-text")
})

local configInput = ConfigSection:AddTextInput({
    Name = "Config Name",
    Icon = GetIcon("edit-3"),
    Placeholder = "Enter name...",
    Default = "",
    Size = 150
})

local function SaveConfig(name)
    if not name or name == "" then return end
    local data = {}
    for flag, lib in pairs(Flags) do
        if lib and lib.GetValue then
            local val = lib:GetValue()
            data[flag] = val
        end
    end
    local json = HttpService:JSONEncode(data)
    if writefile then
        writefile("Cataclysm/" .. name .. ".json", json)
    end
    configLabel:SetText("Saved: " .. name)
end

local function LoadConfig(name)
    if not name or name == "" then return end
    if readfile then
        local json = readfile("Cataclysm/" .. name .. ".json")
        if json then
            local data = HttpService:JSONDecode(json)
            for flag, value in pairs(data) do
                if Flags[flag] and Flags[flag].SetValue then
                    Flags[flag]:SetValue(value)
                end
            end
            configLabel:SetText("Loaded: " .. name)
        end
    end
end

local function DeleteConfig(name)
    if not name or name == "" or name == "Default" then return end
    if delfile then
        delfile("Cataclysm/" .. name .. ".json")
        configLabel:SetText("Deleted: " .. name)
    end
end

if makefolder then
    makefolder("Cataclysm")
end

ConfigSection:AddButton({
    Name = "Save Config",
    Icon = GetIcon("save"),
    Callback = function()
        SaveConfig(configInput:GetValue())
    end
})

ConfigSection:AddButton({
    Name = "Load Config",
    Icon = GetIcon("folder-open"),
    Callback = function()
        LoadConfig(configInput:GetValue())
    end
})

ConfigSection:AddButton({
    Name = "Delete Config",
    Icon = GetIcon("trash-2"),
    Callback = function()
        DeleteConfig(configInput:GetValue())
    end
})

task.delay(1, function()
    if readfile and isfile then
        if isfile("CataclysmHUB/Default.json") then
            LoadConfig("Default")
        else
            SaveConfig("Default")
        end
    end
end)

-- =============================================
-- ===== BUNNY HOP INPUT HANDLERS =====
-- =============================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Space or input.UserInputType == Enum.UserInputType.Jump then
        Config.IsHoldingJump = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space or input.UserInputType == Enum.UserInputType.Jump then
        Config.IsHoldingJump = false
    end
end)

task.spawn(function()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui", 5)
    if not playerGui then return end
    
    local touchGui = playerGui:FindFirstChild("TouchGui")
    if touchGui then
        local touchControlFrame = touchGui:FindFirstChild("TouchControlFrame")
        local jumpButton = touchControlFrame and touchControlFrame:FindFirstChild("JumpButton")
        
        if jumpButton then
            jumpButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    Config.IsHoldingJump = true
                end
            end)

            jumpButton.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    Config.IsHoldingJump = false
                end
            end)
        end
    end
end)

-- =============================================
-- ===== BUNNY HOP LOOP =====
-- =============================================

local bHopConnection = nil

local function setupBHop(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    if bHopConnection then
        bHopConnection:Disconnect()
        bHopConnection = nil
    end
    
    bHopConnection = humanoid.StateChanged:Connect(function(_, newState)
        if not Config.BHopEnabled then return end
        if newState == Enum.HumanoidStateType.Landed and Config.IsHoldingJump then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

if LocalPlayer.Character then
    setupBHop(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(character)
    setupBHop(character)
end)

-- =============================================
-- ===== ЛУПЫ CATACLYSM =====
-- =============================================

-- CFrame Speed
RS.Heartbeat:Connect(function()
    if Config.SpeedEnabled and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                hrp.CFrame = hrp.CFrame + humanoid.MoveDirection * (Config.SpeedValue / 50)
            end
        end
    end
end)

-- TP Walk
RS.Heartbeat:Connect(function()
    if Config.TpWalkEnabled and LocalPlayer.Character then
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                local moveDir = humanoid.MoveDirection
                if moveDir.Magnitude > 0 then
                    hrp.AssemblyLinearVelocity = Vector3.new(
                        moveDir.X * 10 * Config.TpWalkValue,
                        hrp.AssemblyLinearVelocity.Y,
                        moveDir.Z * 10 * Config.TpWalkValue
                    )
                end
            end
        end
    end
end)

-- Spin Bot
local spinAngle = 0
local spinRandom = 0

RS.Heartbeat:Connect(function()
    if not Config.SpinEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    spinAngle = spinAngle + Config.SpinSpeed
    local xAngle = 0
    local yAngle = 0
    local mode = Config.SpinMode
    
    if mode == "Spin" then
        yAngle = math.rad(spinAngle)
    elseif mode == "Jitter" then
        yAngle = math.rad(math.sin(spinAngle * 0.1) * 30)
        xAngle = math.rad(math.cos(spinAngle * 0.1) * 15)
    elseif mode == "Slide" then
        yAngle = math.rad(math.sin(spinAngle * 0.05) * 45)
    elseif mode == "Random" then
        if spinAngle % 10 == 0 then spinRandom = math.random(-180, 180) end
        yAngle = math.rad(spinRandom)
    elseif mode == "Down" then
        xAngle = math.rad(90)
    elseif mode == "Up" then
        xAngle = math.rad(-90)
    elseif mode == "Left" then
        yAngle = math.rad(-90)
    elseif mode == "Right" then
        yAngle = math.rad(90)
    end
    
    root.CFrame = CFrame.new(root.Position) * CFrame.Angles(xAngle, yAngle, 0)
end)

-- CTRL + Click TP
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if Config.TpEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        local myChar = LocalPlayer.Character
        if myChar then
            local myRoot = myChar:FindFirstChild("HumanoidRootPart")
            if myRoot then
                myRoot.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, Config.TpHeight, 0))
            end
        end
    end
end)

-- ===== MAGIC AURA =====
local auraParts = {}

RS.RenderStepped:Connect(function()
    if not Config.MagicAura then
        for _, s in ipairs(auraParts) do s:Destroy() end
        auraParts = {}
        return
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local count = Config.MagicAuraCount or 3
    while #auraParts < count do
        local sphere = Instance.new("Part")
        sphere.Name = "AuraSphere"
        sphere.Anchored = true
        sphere.CanCollide = false
        sphere.Material = Enum.Material.Neon
        sphere.Shape = Enum.PartType.Ball
        sphere.Size = Vector3.new(0.6, 0.6, 0.6)
        sphere.Transparency = 0.3
        sphere.Parent = WS
        table.insert(auraParts, sphere)
    end
    while #auraParts > count do
        auraParts[#auraParts]:Destroy()
        table.remove(auraParts, #auraParts)
    end
    
    local t = tick()
    local radius = Config.MagicAuraRadius or 3
    local speed = Config.MagicAuraSpeed or 2
    local colors = {
        Color3.fromRGB(170, 90, 255),
        Color3.fromRGB(255, 90, 130),
        Color3.fromRGB(90, 255, 130),
        Color3.fromRGB(255, 255, 90),
        Color3.fromRGB(255, 130, 255),
        Color3.fromRGB(130, 255, 255),
    }
    
    for i, sphere in ipairs(auraParts) do
        local angleOffset = (i - 1) * (math.pi * 2 / count)
        local angle = t * speed + angleOffset
        local ox = math.cos(angle) * radius
        local oz = math.sin(angle) * radius
        local heightOsc = math.sin(t * 2 + angleOffset) * 1
        sphere.CFrame = CFrame.new(hrp.Position + Vector3.new(ox, heightOsc, oz))
        sphere.Color = colors[(i - 1) % #colors + 1]
        sphere.Transparency = 0.3
    end
end)

-- ===== RTX SHADERS =====
local shaderEffects = {}
local shaderActive = false
local vignetteGui = nil

local function applyShaders()
    if shaderActive then return end
    shaderActive = true
    
    for _, fx in ipairs(shaderEffects) do
        pcall(function() fx:Destroy() end)
    end
    shaderEffects = {}
    
    local bloom = Instance.new("BloomEffect")
    bloom.Intensity = Config.BloomIntensity or 0.3
    bloom.Size = Config.BloomSize or 10
    bloom.Threshold = 0.8
    bloom.Parent = Lighting
    table.insert(shaderEffects, bloom)
    
    local blur = Instance.new("BlurEffect")
    blur.Size = Config.BlurSize or 5
    blur.Parent = Lighting
    table.insert(shaderEffects, blur)
    
    local colorCor = Instance.new("ColorCorrectionEffect")
    colorCor.Brightness = Config.ShadersBrightness or 0.1
    colorCor.Contrast = Config.ShadersContrast or 0.5
    colorCor.Saturation = Config.ShadersSaturation or -0.3
    colorCor.TintColor = Color3.fromRGB(255, 235, 203)
    colorCor.Parent = Lighting
    table.insert(shaderEffects, colorCor)
    
    local sunRays = Instance.new("SunRaysEffect")
    sunRays.Intensity = Config.SunRaysIntensity or 0.075
    sunRays.Spread = 0.727
    sunRays.Parent = Lighting
    table.insert(shaderEffects, sunRays)
    
    local sky = Instance.new("Sky")
    sky.SkyboxBk = "http://www.roblox.com/asset/?id=151165214"
    sky.SkyboxDn = "http://www.roblox.com/asset/?id=151165197"
    sky.SkyboxFt = "http://www.roblox.com/asset/?id=151165224"
    sky.SkyboxLf = "http://www.roblox.com/asset/?id=151165191"
    sky.SkyboxRt = "http://www.roblox.com/asset/?id=151165206"
    sky.SkyboxUp = "http://www.roblox.com/asset/?id=151165227"
    sky.SunAngularSize = 10
    sky.Parent = Lighting
    table.insert(shaderEffects, sky)
    
    local atm = Instance.new("Atmosphere")
    atm.Density = Config.ShadersFog or 0.364
    atm.Offset = 0.556
    atm.Color = Color3.fromRGB(199, 175, 166)
    atm.Decay = Color3.fromRGB(44, 39, 33)
    atm.Glare = 0.36
    atm.Haze = 1.72
    atm.Parent = Lighting
    table.insert(shaderEffects, atm)
    
    Lighting.Ambient = Color3.fromRGB(2, 2, 2)
    Lighting.Brightness = 2.25
    Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
    Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
    Lighting.EnvironmentDiffuseScale = 0.2
    Lighting.EnvironmentSpecularScale = 0.2
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    Lighting.ShadowSoftness = 0.2
    Lighting.ClockTime = Config.ShadersTime or 14
    Lighting.GeographicLatitude = 45
    Lighting.ExposureCompensation = 0.5
    
    if vignetteGui then vignetteGui:Destroy() end
    vignetteGui = Instance.new("ScreenGui")
    vignetteGui.Name = "ShaderVignette"
    vignetteGui.IgnoreGuiInset = true
    vignetteGui.ResetOnSpawn = false
    vignetteGui.Parent = PlayerGui
    
    local shadow = Instance.new("ImageLabel", vignetteGui)
    shadow.AnchorPoint = Vector2.new(0.5, 1)
    shadow.Position = UDim2.new(0.5, 0, 1, 0)
    shadow.Size = UDim2.new(1, 0, 1.05, 0)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://4576475446"
    shadow.ImageTransparency = 1 - (Config.ShadersVignette or 0.3)
    shadow.ZIndex = 10
end

local function removeShaders()
    if not shaderActive then return end
    shaderActive = false
    
    for _, fx in ipairs(shaderEffects) do
        pcall(function() fx:Destroy() end)
    end
    shaderEffects = {}
    
    if vignetteGui then
        pcall(function() vignetteGui:Destroy() end)
        vignetteGui = nil
    end
    
    Lighting.Ambient = Color3.fromRGB(0, 0, 0)
    Lighting.Brightness = 1
    Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
    Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    Lighting.ShadowSoftness = 0.3
    Lighting.GeographicLatitude = 45
    Lighting.ExposureCompensation = 0
end

RS.Heartbeat:Connect(function()
    if Config.ShaderRTX then
        if not shaderActive then
            applyShaders()
        else
            for _, fx in ipairs(shaderEffects) do
                if fx:IsA("BloomEffect") then
                    fx.Intensity = Config.BloomIntensity or 0.3
                    fx.Size = Config.BloomSize or 10
                elseif fx:IsA("BlurEffect") then
                    fx.Size = Config.BlurSize or 5
                elseif fx:IsA("ColorCorrectionEffect") then
                    fx.Brightness = Config.ShadersBrightness or 0.1
                    fx.Contrast = Config.ShadersContrast or 0.5
                    fx.Saturation = Config.ShadersSaturation or -0.3
                elseif fx:IsA("SunRaysEffect") then
                    fx.Intensity = Config.SunRaysIntensity or 0.075
                elseif fx:IsA("Atmosphere") then
                    fx.Density = Config.ShadersFog or 0.364
                end
            end
            Lighting.ClockTime = Config.ShadersTime or 14
            if vignetteGui and vignetteGui:FindFirstChildOfClass("ImageLabel") then
                vignetteGui:FindFirstChildOfClass("ImageLabel").ImageTransparency = 1 - (Config.ShadersVignette or 0.3)
            end
        end
    else
        if shaderActive then
            removeShaders()
        end
    end
end)

-- =============================================
-- ===== ULTIMATE SHADERS =====
-- =============================================

local ultimateEffects = {}
local ultimateActive = false

local skyboxPresets = {
    default = {
        bk = "http://www.roblox.com/asset/?id=151165214",
        dn = "http://www.roblox.com/asset/?id=151165197",
        ft = "http://www.roblox.com/asset/?id=151165224",
        lt = "http://www.roblox.com/asset/?id=151165191",
        rt = "http://www.roblox.com/asset/?id=151165206",
        up = "http://www.roblox.com/asset/?id=151165227"
    },
    morning = {
        bk = "http://www.roblox.com/asset/?id=9544505500",
        dn = "http://www.roblox.com/asset/?id=9544547905",
        ft = "http://www.roblox.com/asset/?id=9544504852",
        lt = "http://www.roblox.com/asset/?id=9544547694",
        rt = "http://www.roblox.com/asset/?id=9544547542",
        up = "http://www.roblox.com/asset/?id=9544547398"
    },
    midday = {
        bk = "http://www.roblox.com/asset/?id=9544505500",
        dn = "http://www.roblox.com/asset/?id=9544547905",
        ft = "http://www.roblox.com/asset/?id=9544504852",
        lt = "http://www.roblox.com/asset/?id=9544547694",
        rt = "http://www.roblox.com/asset/?id=9544547542",
        up = "http://www.roblox.com/asset/?id=9544547398"
    },
    afternoon = {
        bk = "http://www.roblox.com/asset/?id=9544505500",
        dn = "http://www.roblox.com/asset/?id=9544547905",
        ft = "http://www.roblox.com/asset/?id=9544504852",
        lt = "http://www.roblox.com/asset/?id=9544547694",
        rt = "http://www.roblox.com/asset/?id=9544547542",
        up = "http://www.roblox.com/asset/?id=9544547398"
    },
    evening = {
        bk = "http://www.roblox.com/asset/?id=9544505500",
        dn = "http://www.roblox.com/asset/?id=9544547905",
        ft = "http://www.roblox.com/asset/?id=9544504852",
        lt = "http://www.roblox.com/asset/?id=9544547694",
        rt = "http://www.roblox.com/asset/?id=9544547542",
        up = "http://www.roblox.com/asset/?id=9544547398"
    },
    rain = {
        bk = "http://www.roblox.com/asset/?id=9544505500",
        dn = "http://www.roblox.com/asset/?id=9544547905",
        ft = "http://www.roblox.com/asset/?id=9544504852",
        lt = "http://www.roblox.com/asset/?id=9544547694",
        rt = "http://www.roblox.com/asset/?id=9544547542",
        up = "http://www.roblox.com/asset/?id=9544547398"
    },
    cloudy = {
        bk = "http://www.roblox.com/asset/?id=9544505500",
        dn = "http://www.roblox.com/asset/?id=9544547905",
        ft = "http://www.roblox.com/asset/?id=9544504852",
        lt = "http://www.roblox.com/asset/?id=9544547694",
        rt = "http://www.roblox.com/asset/?id=9544547542",
        up = "http://www.roblox.com/asset/?id=9544547398"
    },
    game = {
        bk = "http://www.roblox.com/asset/?id=151165214",
        dn = "http://www.roblox.com/asset/?id=151165197",
        ft = "http://www.roblox.com/asset/?id=151165224",
        lt = "http://www.roblox.com/asset/?id=151165191",
        rt = "http://www.roblox.com/asset/?id=151165206",
        up = "http://www.roblox.com/asset/?id=151165227"
    }
}

local function applyUltimateShaders()
    if ultimateActive then return end
    if not Config.UltimateShadersOn then return end
    ultimateActive = true
    
    for _, fx in ipairs(ultimateEffects) do
        pcall(function() fx:Destroy() end)
    end
    ultimateEffects = {}
    
    local sky = Instance.new("Sky")
    local preset = skyboxPresets[Config.UltimateSkybox] or skyboxPresets.default
    sky.SkyboxBk = preset.bk
    sky.SkyboxDn = preset.dn
    sky.SkyboxFt = preset.ft
    sky.SkyboxLf = preset.lt
    sky.SkyboxRt = preset.rt
    sky.SkyboxUp = preset.up
    sky.SunAngularSize = 10
    sky.Parent = Lighting
    table.insert(ultimateEffects, sky)
    
    local atm = Instance.new("Atmosphere")
    atm.Density = Config.UltimateAtmoDensity or 0.364
    atm.Offset = Config.UltimateAtmoOffset or 0.556
    atm.Color = Config.UltimateAtmoColor or Color3.fromRGB(199, 175, 166)
    atm.Decay = Config.UltimateAtmoDecay or Color3.fromRGB(44, 39, 33)
    atm.Glare = Config.UltimateAtmoGlare or 0.36
    atm.Haze = Config.UltimateAtmoHaze or 1.72
    atm.Parent = Lighting
    table.insert(ultimateEffects, atm)
    
    local clouds = Instance.new("Clouds")
    clouds.Cover = Config.UltimateCloudCover or 0
    clouds.Density = Config.UltimateCloudDensity or 0
    clouds.Color = Config.UltimateCloudColor or Color3.fromRGB(255, 255, 255)
    clouds.Parent = WS.Terrain
    table.insert(ultimateEffects, clouds)
    
    local colorCor = Instance.new("ColorCorrectionEffect")
    colorCor.Brightness = Config.UltimateColorBrightness or 0.1
    colorCor.Contrast = Config.UltimateColorContrast or 0.5
    colorCor.Saturation = Config.UltimateColorSaturation or -0.3
    colorCor.TintColor = Config.UltimateColorTint or Color3.fromRGB(255, 235, 203)
    colorCor.Enabled = Config.UltimateColorCorEnabled or true
    colorCor.Parent = Lighting
    table.insert(ultimateEffects, colorCor)
    
    local bloom = Instance.new("BloomEffect")
    bloom.Intensity = Config.UltimateBloomIntensity or 0.3
    bloom.Size = Config.UltimateBloomSize or 10
    bloom.Threshold = Config.UltimateBloomThreshold or 0.8
    bloom.Enabled = Config.UltimateBloomEnabled or true
    bloom.Parent = Lighting
    table.insert(ultimateEffects, bloom)
    
    local blur = Instance.new("BlurEffect")
    blur.Size = Config.UltimateBlurSize or 5
    blur.Enabled = Config.UltimateBlurEnabled or false
    blur.Parent = Lighting
    table.insert(ultimateEffects, blur)
    
    local sunRays = Instance.new("SunRaysEffect")
    sunRays.Intensity = Config.UltimateSunRaysIntensity or 0.075
    sunRays.Spread = Config.UltimateSunRaysSpread or 0.727
    sunRays.Enabled = Config.UltimateSunRaysEnabled or false
    sunRays.Parent = Lighting
    table.insert(ultimateEffects, sunRays)
    
    local dof = Instance.new("DepthOfFieldEffect")
    dof.FarIntensity = Config.UltimateDOFFarIntensity or 0.5
    dof.FocusDistance = Config.UltimateDOFFocusDist or 50
    dof.InFocusRadius = Config.UltimateDOFInFocus or 5
    dof.NearIntensity = Config.UltimateDOFNearIntensity or 0.3
    dof.Enabled = Config.UltimateDOFEnabled or false
    dof.Parent = Lighting
    table.insert(ultimateEffects, dof)
    
    Lighting.ClockTime = Config.UltimateClockTime or 14
    Lighting.GeographicLatitude = Config.UltimateLatitude or 45
    Lighting.EnvironmentDiffuseScale = 0.5
    Lighting.EnvironmentSpecularScale = 0.5
    Lighting.GlobalShadows = true
    Lighting.ShadowSoftness = 0.3
    Lighting.Brightness = 1
    
    local terrain = WS.Terrain
    if terrain then
        terrain.WaterWaveSpeed = Config.UltimateWaterSpeed or 10
        terrain.WaterTransparency = Config.UltimateWaterTrans or 0.3
        terrain.WaterWaveSize = Config.UltimateWaterSize or 5
    end
    
    for _, v in ipairs(WS:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Reflectance = Config.UltimateReflectance or 0.3
        end
    end
    
    if Config.UltimateSunFlare then
        local flare = Instance.new("ScreenGui")
        flare.Name = "UltimateFlare"
        flare.ResetOnSpawn = false
        flare.Parent = CoreGui
        
        local img = Instance.new("ImageLabel")
        img.Parent = flare
        img.Size = UDim2.new(0, 100, 0, 100)
        img.AnchorPoint = Vector2.new(0.5, 0.5)
        img.BackgroundTransparency = 1
        img.Image = "rbxassetid://277033149"
        img.ImageColor3 = Color3.fromRGB(255, 255, 200)
        img.ImageTransparency = 0.5
        img.ZIndex = 0
        
        table.insert(ultimateEffects, flare)
        
        local flareConn
        flareConn = RS.RenderStepped:Connect(function()
            if not Config.UltimateSunFlare or not Config.UltimateShadersOn then
                if flareConn then flareConn:Disconnect() end
                return
            end
            local sunPos, visible = Camera:WorldToScreenPoint(Camera.CFrame.Position + Lighting:GetSunDirection() * 1000)
            if visible then
                img.Visible = true
                img.Position = UDim2.new(0, sunPos.X, 0, sunPos.Y)
            else
                img.Visible = false
            end
        end)
        table.insert(ultimateEffects, flareConn)
    end
    
    if Config.UltimateMotionBlur then
        local mBlur = Instance.new("BlurEffect")
        mBlur.Size = Config.UltimateMotionBlurSize or 26
        mBlur.Parent = Camera
        table.insert(ultimateEffects, mBlur)
        
        local motionConn
        local lastLook = Camera.CFrame.LookVector
        motionConn = RS.RenderStepped:Connect(function()
            if not Config.UltimateMotionBlur or not Config.UltimateShadersOn then
                if motionConn then motionConn:Disconnect() end
                return
            end
            local currentLook = Camera.CFrame.LookVector
            local mag = (currentLook - lastLook).Magnitude
            mBlur.Size = math.min(mag * 50, Config.UltimateMotionBlurSize or 26)
            lastLook = currentLook
        end)
        table.insert(ultimateEffects, motionConn)
    end
    
    if Config.UltimateGlobalIllum then
        local giConn
        giConn = RS.Heartbeat:Connect(function()
            if not Config.UltimateGlobalIllum or not Config.UltimateShadersOn then
                if giConn then giConn:Disconnect() end
                return
            end
            local brightness = 0.7 + math.sin(tick() * 0.1) * 0.3
            Lighting.Brightness = brightness
        end)
        table.insert(ultimateEffects, giConn)
    end
    
    local tech = Config.UltimateTechnology or "ShadowMap"
    local shp = getrenv and getrenv().sethiddenproperty or sethiddenproperty or function() end
    pcall(function() shp(Lighting, "Technology", tech) end)
end

local function removeUltimateShaders()
    if not ultimateActive then return end
    ultimateActive = false
    
    for _, fx in ipairs(ultimateEffects) do
        pcall(function() fx:Destroy() end)
    end
    ultimateEffects = {}
    
    local terrain = WS.Terrain
    if terrain then
        terrain.WaterWaveSpeed = 10
        terrain.WaterTransparency = 0.3
        terrain.WaterWaveSize = 5
    end
    
    for _, v in ipairs(WS:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Reflectance = 0
        end
    end
    
    Lighting.ClockTime = 14
    Lighting.GeographicLatitude = 45
    Lighting.Brightness = 1
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
end

RS.Heartbeat:Connect(function()
    if Config.UltimateShadersOn then
        if not ultimateActive then
            applyUltimateShaders()
        else
            for _, fx in ipairs(ultimateEffects) do
                if fx:IsA("Atmosphere") then
                    fx.Density = Config.UltimateAtmoDensity or 0.364
                    fx.Offset = Config.UltimateAtmoOffset or 0.556
                    fx.Color = Config.UltimateAtmoColor or Color3.fromRGB(199, 175, 166)
                    fx.Decay = Config.UltimateAtmoDecay or Color3.fromRGB(44, 39, 33)
                    fx.Glare = Config.UltimateAtmoGlare or 0.36
                    fx.Haze = Config.UltimateAtmoHaze or 1.72
                elseif fx:IsA("Clouds") then
                    fx.Cover = Config.UltimateCloudCover or 0
                    fx.Density = Config.UltimateCloudDensity or 0
                    fx.Color = Config.UltimateCloudColor or Color3.fromRGB(255, 255, 255)
                elseif fx:IsA("ColorCorrectionEffect") then
                    fx.Brightness = Config.UltimateColorBrightness or 0.1
                    fx.Contrast = Config.UltimateColorContrast or 0.5
                    fx.Saturation = Config.UltimateColorSaturation or -0.3
                    fx.TintColor = Config.UltimateColorTint or Color3.fromRGB(255, 235, 203)
                    fx.Enabled = Config.UltimateColorCorEnabled or true
                elseif fx:IsA("BloomEffect") then
                    fx.Intensity = Config.UltimateBloomIntensity or 0.3
                    fx.Size = Config.UltimateBloomSize or 10
                    fx.Threshold = Config.UltimateBloomThreshold or 0.8
                    fx.Enabled = Config.UltimateBloomEnabled or true
                elseif fx:IsA("BlurEffect") then
                    fx.Size = Config.UltimateBlurSize or 5
                    fx.Enabled = Config.UltimateBlurEnabled or false
                elseif fx:IsA("SunRaysEffect") then
                    fx.Intensity = Config.UltimateSunRaysIntensity or 0.075
                    fx.Spread = Config.UltimateSunRaysSpread or 0.727
                    fx.Enabled = Config.UltimateSunRaysEnabled or false
                elseif fx:IsA("DepthOfFieldEffect") then
                    fx.FarIntensity = Config.UltimateDOFFarIntensity or 0.5
                    fx.FocusDistance = Config.UltimateDOFFocusDist or 50
                    fx.InFocusRadius = Config.UltimateDOFInFocus or 5
                    fx.NearIntensity = Config.UltimateDOFNearIntensity or 0.3
                    fx.Enabled = Config.UltimateDOFEnabled or false
                elseif fx:IsA("Sky") then
                    local preset = skyboxPresets[Config.UltimateSkybox] or skyboxPresets.default
                    fx.SkyboxBk = preset.bk
                    fx.SkyboxDn = preset.dn
                    fx.SkyboxFt = preset.ft
                    fx.SkyboxLf = preset.lt
                    fx.SkyboxRt = preset.rt
                    fx.SkyboxUp = preset.up
                end
            end
            
            local terrain = WS.Terrain
            if terrain then
                terrain.WaterWaveSpeed = Config.UltimateWaterSpeed or 10
                terrain.WaterTransparency = Config.UltimateWaterTrans or 0.3
                terrain.WaterWaveSize = Config.UltimateWaterSize or 5
            end
            
            for _, v in ipairs(WS:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Reflectance = Config.UltimateReflectance or 0.3
                end
            end
            
            Lighting.ClockTime = Config.UltimateClockTime or 14
            Lighting.GeographicLatitude = Config.UltimateLatitude or 45
        end
    else
        if ultimateActive then
            removeUltimateShaders()
        end
    end
end)

-- =============================================
-- ===== DRAG И ЗАКРЫТИЕ =====
-- =============================================

local DragToggle = false
local DragStart = Vector2.new()
local StartPos = UDim2.new()

local DragFrame = Instance.new("Frame")
DragFrame.Parent = MainFrame
DragFrame.Size = UDim2.new(1, 0, 0, 50)
DragFrame.BackgroundTransparency = 1
DragFrame.ZIndex = 10

DragFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        DragToggle = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

DragFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        DragToggle = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and DragToggle then
        local delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPos.X.Scale, StartPos.X.Offset + delta.X,
            StartPos.Y.Scale, StartPos.Y.Offset + delta.Y
        )
    end
end)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -10, 0, 5)
CloseBtn.AnchorPoint = Vector2.new(1, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextTransparency = 0.5

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    WatermarkGui:Destroy()
    removeUltimateShaders()
    removeShaders()
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Z and not gameProcessed then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)
