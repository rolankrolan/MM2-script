local allowedUsers = {
    11508546883,
   -- WHITELIST
}

local function checkWhitelist()
    local id = game.Players.LocalPlayer.UserId
    for _, allowedId in ipairs(allowedUsers) do
        if id == allowedId then
            return true
        end
    end
    return false
end

if not checkWhitelist() then
    game.Players.LocalPlayer:Kick("Доступ запрещен. Тебя нет в вайтлисте!")
    return
end

-- ==========================================
-- GOD HUB | Murder Mystery 2 (Final Fix)
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Удаляем старый гуй перед запуском
if CoreGui:FindFirstChild("GodHubGui") then
    CoreGui.GodHubGui:Destroy()
end

-- ==========================================
-- 1. СОЗДАНИЕ ИНТЕРФЕЙСА (GUI)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GodHubGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Active = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 8)
UICornerMain.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 35)

local UICornerTop = Instance.new("UICorner")
UICornerTop.CornerRadius = UDim.new(0, 8)
UICornerTop.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Parent = TopBar
TopBarFix.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
TopBarFix.BorderSizePixel = 0
TopBarFix.Position = UDim2.new(0, 0, 0.5, 0)
TopBarFix.Size = UDim2.new(1, 0, 0.5, 0)

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "God Hub | MM2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Контейнер для кнопок управления в шапке (справа)
local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Parent = TopBar
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Position = UDim2.new(1, -110, 0, 0)
ButtonsContainer.Size = UDim2.new(0, 110, 1, 0)

local UIListLayoutBtns = Instance.new("UIListLayout")
UIListLayoutBtns.Parent = ButtonsContainer
UIListLayoutBtns.FillDirection = Enum.FillDirection.Horizontal
UIListLayoutBtns.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayoutBtns.SortOrder = Enum.SortOrder.LayoutOrder

-- 1. Кнопка сворачивания (-)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = ButtonsContainer
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Size = UDim2.new(0, 35, 1, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(180, 180, 190)
MinimizeButton.TextSize = 18

-- 2. Кнопка крестика с подтверждением (Выгрузка)
local UnloadButton = Instance.new("TextButton")
UnloadButton.Parent = ButtonsContainer
UnloadButton.BackgroundTransparency = 1
UnloadButton.Size = UDim2.new(0, 35, 1, 0)
UnloadButton.Font = Enum.Font.GothamBold
UnloadButton.Text = "X"
UnloadButton.TextColor3 = Color3.fromRGB(255, 120, 120)
UnloadButton.TextSize = 14

-- 3. Кнопка паники (Моментальное удаление)
local PanicButton = Instance.new("TextButton")
PanicButton.Parent = ButtonsContainer
PanicButton.BackgroundTransparency = 1
PanicButton.Size = UDim2.new(0, 35, 1, 0)
PanicButton.Font = Enum.Font.GothamBold
PanicButton.Text = "!"
PanicButton.TextColor3 = Color3.fromRGB(255, 60, 60)
PanicButton.TextSize = 14

-- ==========================================
-- ОКНО ПОДТВЕРЖДЕНИЯ ВЫГРУЗКИ
-- ==========================================
local DialogOverlay = Instance.new("Frame")
DialogOverlay.Parent = ScreenGui
DialogOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DialogOverlay.BackgroundTransparency = 0.5
DialogOverlay.Size = UDim2.new(1, 0, 1, 0)
DialogOverlay.Visible = false
DialogOverlay.ZIndex = 10

local DialogBox = Instance.new("Frame")
DialogBox.Parent = DialogOverlay
DialogBox.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
DialogBox.Position = UDim2.new(0.5, -140, 0.5, -60)
DialogBox.Size = UDim2.new(0, 280, 0, 120)
DialogBox.ZIndex = 11

local UICornerDialog = Instance.new("UICorner")
UICornerDialog.CornerRadius = UDim.new(0, 8)
UICornerDialog.Parent = DialogBox

local DialogText = Instance.new("TextLabel")
DialogText.Parent = DialogBox
DialogText.BackgroundTransparency = 1
DialogText.Position = UDim2.new(0, 10, 0, 15)
DialogText.Size = UDim2.new(1, -20, 0, 40)
DialogText.Font = Enum.Font.GothamMedium
DialogText.Text = "Are you sure to Unload This Script?"
DialogText.TextColor3 = Color3.fromRGB(255, 255, 255)
DialogText.TextSize = 13
DialogText.TextWrapped = true
DialogText.ZIndex = 11

local YesButton = Instance.new("TextButton")
YesButton.Parent = DialogBox
YesButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
YesButton.Position = UDim2.new(0, 15, 1, -45)
YesButton.Size = UDim2.new(0, 115, 0, 30)
YesButton.Font = Enum.Font.GothamBold
YesButton.Text = "Yes"
YesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
YesButton.TextSize = 12
YesButton.ZIndex = 11

local UICornerYes = Instance.new("UICorner")
UICornerYes.CornerRadius = UDim.new(0, 6)
UICornerYes.Parent = YesButton

local NoButton = Instance.new("TextButton")
NoButton.Parent = DialogBox
NoButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
NoButton.Position = UDim2.new(1, -130, 1, -45)
NoButton.Size = UDim2.new(0, 115, 0, 30)
NoButton.Font = Enum.Font.GothamBold
NoButton.Text = "No"
NoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoButton.TextSize = 12
NoButton.ZIndex = 11

local UICornerNo = Instance.new("UICorner")
UICornerNo.CornerRadius = UDim.new(0, 6)
UICornerNo.Parent = NoButton

UnloadButton.MouseButton1Click:Connect(function() DialogOverlay.Visible = true end)
NoButton.MouseButton1Click:Connect(function() DialogOverlay.Visible = false end)
YesButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
PanicButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ==========================================
-- ИЗМЕНЕНИЕ РАЗМЕРА И ПЕРЕТАСКИВАНИЕ
-- ==========================================
local ResizeButton = Instance.new("TextButton")
ResizeButton.Parent = MainFrame
ResizeButton.BackgroundTransparency = 1
ResizeButton.Position = UDim2.new(1, -20, 1, -20)
ResizeButton.Size = UDim2.new(0, 20, 0, 20)
ResizeButton.Font = Enum.Font.GothamBold
ResizeButton.Text = "◢"
ResizeButton.TextColor3 = Color3.fromRGB(150, 150, 160)
ResizeButton.TextSize = 14
ResizeButton.ZIndex = 5

local resizing = false
local resizeStart, startSize

ResizeButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        startSize = MainFrame.AbsoluteSize
    end
end)

local dragging = false
local dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        resizing = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        elseif resizing then
            local delta = input.Position - resizeStart
            local newWidth = math.clamp(startSize.X + delta.X, 400, 800)
            local newHeight = math.clamp(startSize.Y + delta.Y, 250, 600)
            MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end
end)

-- Боковая панель для вкладок
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Parent = MainFrame
Sidebar.Active = true
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 130, 1, -35)
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.ScrollBarThickness = 2

local UICornerSide = Instance.new("UICorner")
UICornerSide.CornerRadius = UDim.new(0, 0, 0, 8)
UICornerSide.Parent = Sidebar

local UIListLayoutSide = Instance.new("UIListLayout")
UIListLayoutSide.Parent = Sidebar
UIListLayoutSide.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayoutSide.Padding = UDim.new(0, 5)

local ContainerHolder = Instance.new("Folder")
ContainerHolder.Parent = MainFrame

local Tabs = {}
local FirstTab = true

local function CreateTab(name)
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Parent = ContainerHolder
    TabContent.Active = true
    TabContent.BackgroundTransparency = 1
    TabContent.Position = UDim2.new(0, 140, 0, 45)
    TabContent.Size = UDim2.new(1, -150, 1, -55)
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.ScrollBarThickness = 4
    TabContent.Visible = false

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = TabContent
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)

    local TabButton = Instance.new("TextButton")
    TabButton.Parent = Sidebar
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.Font = Enum.Font.GothamMedium
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(170, 170, 180)
    TabButton.TextSize = 13

    local UICornerBtn = Instance.new("UICorner")
    UICornerBtn.CornerRadius = UDim.new(0, 6)
    UICornerBtn.Parent = TabButton

    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(Tabs) do
            tab.Content.Visible = false
            tab.Button.TextColor3 = Color3.fromRGB(170, 170, 180)
            tab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
        end
        TabContent.Visible = true
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    end)

    if FirstTab then
        TabContent.Visible = true
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
        FirstTab = false
    end

    table.insert(Tabs, {Button = TabButton, Content = TabContent})
    return TabContent
end

-- Создаем вкладки
local VisualTab = CreateTab("Визуал / ESP")
local CombatTab = CreateTab("Бомбежка / AIM")
local TeleportTab = CreateTab("Телепорты")
local TrolTab = CreateTab("Троллинг")
local Utilites = CreateTab("Утилиты")
local Others = CreateTab("Другие")
local Other = CreateTab("Другое")
local Ability = CreateTab("Способности")
local StatusTab = CreateTab("Статус")

local function AddToggle(tab, text, callback)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = tab
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Size = UDim2.new(1, -10, 0, 32)
    ToggleBtn.Font = Enum.Font.GothamMedium
    ToggleBtn.Text = "  " .. text .. ": [ ВЫКЛ ]"
    ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
    ToggleBtn.TextSize = 12
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = ToggleBtn

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            ToggleBtn.Text = "  " .. text .. ": [ ВКЛ ]"
            ToggleBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
        else
            ToggleBtn.Text = "  " .. text .. ": [ ВЫКЛ ]"
            ToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
        end
        pcall(function() callback(state) end)
    end)
end

local function AddButton(tab, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = tab
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Btn.BorderSizePixel = 0
    Btn.Size = UDim2.new(1, -10, 0, 32)
    Btn.Font = Enum.Font.GothamMedium
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 12

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        pcall(function() callback() end)
    end)
end

local function AddSlider(tab, text, min, max, default, callback)
    local Container = Instance.new("Frame")
    Container.Parent = tab
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Container.BorderSizePixel = 0
    Container.Size = UDim2.new(1, -10, 0, 50)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Font = Enum.Font.GothamMedium
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(200, 200, 210)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SliderBar = Instance.new("TextButton")
    SliderBar.Parent = Container
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    SliderBar.BorderSizePixel = 0
    SliderBar.Position = UDim2.new(0, 10, 0, 30)
    SliderBar.Size = UDim2.new(1, -20, 0, 10)
    SliderBar.Text = ""

    local UICornerBar = Instance.new("UICorner")
    UICornerBar.CornerRadius = UDim.new(0, 4)
    UICornerBar.Parent = SliderBar

    local Fill = Instance.new("Frame")
    Fill.Parent = SliderBar
    Fill.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
    Fill.BorderSizePixel = 0
    Fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)

    local UICornerFill = Instance.new("UICorner")
    UICornerFill.CornerRadius = UDim.new(0, 4)
    UICornerFill.Parent = Fill

    local sliding = false
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            Fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + (max - min) * pos)
            Label.Text = text .. ": " .. val
            pcall(function() callback(val) end)
        end
    end)
end

-- ==========================================
-- 2. ЛОГИКА ФУНКЦИЙ MM2
-- ==========================================

local function GetRole(plr)
    if not plr.Character then return "Innocent" end
    local backpack = plr:FindFirstChild("Backpack")
    local char = plr.Character
    
    if backpack and (backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")) then
        return "Murderer"
    elseif backpack and (backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")) then
        return "Sheriff"
    end
    return "Innocent"
end

-- 1. Role ESP
local espEnabled = false
RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetRole(plr)
            local color = Color3.fromRGB(0, 255, 0)
            if role == "Murderer" then color = Color3.fromRGB(255, 0, 0)
            elseif role == "Sheriff" then color = Color3.fromRGB(0, 120, 255) end

            local highlight = plr.Character:FindFirstChild("GodESP")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "GodESP"
                highlight.Parent = plr.Character
                highlight.Adornee = plr.Character
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
            end
            highlight.FillColor = color
            highlight.OutlineColor = color
        end
    end
end)

AddToggle(VisualTab, "Role ESP (Инно/Шериф/Мардер)", function(state) espEnabled = state end)

-- ==========================================
-- 2. Items ESP (Ган — зеленый, Монетки — желтые)
-- ==========================================

local itemsEspEnabled = false
local trackedItems = {}

local function addHighlightToItem(item)
    if not item:FindFirstChild("ItemHighlight") then
        local h = Instance.new("Highlight")
        h.Name = "ItemHighlight"
        h.Parent = item
        
        -- Проверяем, что это именно пистолет (GunDrop), и красим в зеленый
        if item.Name == "GunDrop" then
            h.FillColor = Color3.fromRGB(0, 255, 0)       -- Ярко-зеленый цвет внутри
            h.OutlineColor = Color3.fromRGB(0, 180, 0)    -- Темно-зеленая обводка
        else
            -- Для монеток оставляем желтый
            h.FillColor = Color3.fromRGB(255, 255, 0)
            h.OutlineColor = Color3.fromRGB(255, 150, 0)
        end
        
        table.insert(trackedItems, h)
    end
end

Workspace.DescendantAdded:Connect(function(obj)
    if itemsEspEnabled and (obj.Name == "GunDrop" or obj.Name == "CoinContainer" or obj.Name == "CoinVisual") then
        addHighlightToItem(obj)
    end
end)

AddToggle(VisualTab, "Items ESP (Ган / Монетки)", function(state)
    itemsEspEnabled = state
    if state then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" or obj.Name == "CoinContainer" or obj.Name == "CoinVisual" then
                addHighlightToItem(obj)
            end
        end
    else
        for _, h in pairs(trackedItems) do
            if h and h.Parent then h:Destroy() end
        end
        trackedItems = {}
    end
end)

-- 3. Радужный префикс [GOD]
local function CreateRainbowTag(char)
    local head = char:WaitForChild("Head", 5)
    if not head then return end

    if head:FindFirstChild("GodTagGui") then
        head.GodTagGui:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "GodTagGui"
    billboard.Parent = head
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboard
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = "[GOD]"
    textLabel.TextSize = 22
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

    task.spawn(function()
        while billboard and billboard.Parent do
            for i = 0, 1, 0.005 do
                if not billboard or not billboard.Parent then break end
                textLabel.TextColor3 = Color3.fromHSV(i, 1, 1)
                task.wait(0.03)
            end
        end
    end)
end

local function RemoveRainbowTag()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") and char.Head:FindFirstChild("GodTagGui") then
        char.Head.GodTagGui:Destroy()
    end
end

local godTagEnabled = false
LocalPlayer.CharacterAdded:Connect(function(newChar)
    task.wait(1)
    if godTagEnabled then
        CreateRainbowTag(newChar)
    end
end)

AddToggle(VisualTab, "Радужный префикс [GOD] над вами", function(state)
    godTagEnabled = state
    local char = LocalPlayer.Character
    if state then
        if char then CreateRainbowTag(char) end
    else
        RemoveRainbowTag()
    end
end)

-- 4. WalkSpeed
AddSlider(CombatTab, "WalkSpeed (Скорость)", 16, 200, 16, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

-- 5. Instant Kill (Мардер: ваншот с ножа)
local instantKillEnabled = false
AddToggle(CombatTab, "Instant Kill (Мардер: ваншот с ножа)", function(state)
    instantKillEnabled = state
    task.spawn(function()
        while instantKillEnabled do
            if GetRole(LocalPlayer) == "Murderer" and LocalPlayer.Character then
                local knife = LocalPlayer.Character:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
                if knife then
                    for _, plr in pairs(Players:GetPlayers()) do
                        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 15 then
                                knife.Parent = LocalPlayer.Character
                                pcall(function() knife:Activate() end)
                            end
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 6. Instant Kill All
local instantKillAllEnabled = false
AddToggle(CombatTab, "Instant Kill All (Убить всех на карте)", function(state)
    instantKillAllEnabled = state
    task.spawn(function()
        while instantKillAllEnabled do
            if GetRole(LocalPlayer) == "Murderer" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local knife = LocalPlayer.Character:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
                
                if knife then
                    knife.Parent = LocalPlayer.Character
                    local originalPos = hrp.CFrame
                    
                    for _, plr in pairs(Players:GetPlayers()) do
                        if not instantKillAllEnabled then break end
                        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            local targetHrp = plr.Character.HumanoidRootPart
                            hrp.CFrame = targetHrp.CFrame + Vector3.new(0, 0, 2)
                            pcall(function() knife:Activate() end)
                            task.wait(0.05)
                        end
                    end
                    
                    hrp.CFrame = originalPos
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- 7. Smart Aim
local smartAimToggleState = false
local smartAimActive = false

UserInputService.InputBegan:Connect(function(input, gp)
    if gp or not smartAimToggleState then return end
    if input.KeyCode == Enum.KeyCode.R then smartAimActive = true end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.R then smartAimActive = false end
end)

RunService.RenderStepped:Connect(function()
    if smartAimToggleState and smartAimActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myRole = GetRole(LocalPlayer)
        local targetRole = (myRole == "Murderer") and "Sheriff" or "Murderer"
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and GetRole(plr) == targetRole and plr.Character and plr.Character:FindFirstChild("Head") then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, plr.Character.Head.Position)
                break
            end
        end
    end
end)

AddToggle(CombatTab, "Smart Aim (Зажать R на врага)", function(state) 
    smartAimToggleState = state
    if not state then smartAimActive = false end
end)

-- 8. Fly
local flying = false
local flySpeed = 50
AddToggle(CombatTab, "Fly (Полет)", function(state)
    flying = state
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "GodFlyBV"
        bv.Parent = hrp
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0,0,0)
        task.spawn(function()
            while flying and char and hrp and hrp.Parent do
                local cam = Workspace.CurrentCamera
                local vel = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.CFrame.RightVector end
                bv.Velocity = vel * flySpeed
                task.wait()
            end
            if bv then bv:Destroy() end
        end)
    end
end)

-- 9. Noclip & Infinite Jump
local noclipEnabled = false
RunService.Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)
AddToggle(CombatTab, "Noclip (Проход сквозь стены)", function(state) noclipEnabled = state end)

local infJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
AddToggle(CombatTab, "Infinite Jump (Беск. прыжки)", function(state) infJumpEnabled = state end)

-- 10. Auto Farm Coins
local autoFarmCoinsEnabled = false
AddToggle(TeleportTab, "Auto Farm Coins (Плавный Tween фарм)", function(state)
    autoFarmCoinsEnabled = state
    task.spawn(function()
        while autoFarmCoinsEnabled do
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local coinFound = false
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if not autoFarmCoinsEnabled then break end
                    if obj.Name == "CoinVisual" or obj.Name == "Coin" or (obj.Name == "Base" and obj.Parent and obj.Parent.Name:match("Coin")) then
                        local coinPart = obj:IsA("BasePart") and obj or (obj:FindFirstChild("Base") or obj:FindFirstChildOfClass("BasePart"))
                        if coinPart then
                            coinFound = true
                            local distance = (hrp.Position - coinPart.Position).Magnitude
                            local timeToTravel = math.clamp(distance / 45, 0.1, 1.5)
                            local tweenInfo = TweenInfo.new(timeToTravel, Enum.EasingStyle.Linear)
                            local tween = TweenService:Create(hrp, tweenInfo, {CFrame = coinPart.CFrame + Vector3.new(0, 2, 0)})
                            tween:Play()
                            tween.Completed:Wait()
                            task.wait(0.05)
                        end
                    end
                end
                if not coinFound then
                    task.wait(0.5)
                end
            else
                task.wait(1)
            end
        end
    end)
end)

-- 11. Телепорт к упавшему гану (Исправленный поиск по имени и дочерним деталям)
AddButton(TeleportTab, "ТП к упавшему Гану (Туда и назад)", function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local originalPos = hrp.CFrame

    local foundGun = nil
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" or obj.Name == "DroppedGun" or obj.Name == "Gun" then
            if obj:IsA("Model") and obj.PrimaryPart then
                foundGun = obj.PrimaryPart
                break
            elseif obj:FindFirstChild("Handle") then
                foundGun = obj.Handle
                break
            elseif obj:IsA("BasePart") then
                foundGun = obj
                break
            end
        end
    end

    if foundGun then
        hrp.CFrame = foundGun.CFrame + Vector3.new(0, 3, 0)
        task.wait(0.15)
        hrp.CFrame = originalPos
    end
end)

AddButton(TeleportTab, "ТП к Шерифу", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if GetRole(plr) == "Sheriff" and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
        end
    end
end)

AddButton(TeleportTab, "ТП к Ближайшему Инно", function()
    local nearest, dist = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and GetRole(plr) == "Innocent" and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
            local d = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then dist = d nearest = plr end
        end
    end
    if nearest and nearest.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = nearest.Character.HumanoidRootPart.CFrame
    end
end)

-- 12. View / Observer
AddButton(TeleportTab, "Следить за Убийцей (View Murderer)", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if GetRole(plr) == "Murderer" and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = plr.Character.Humanoid
        end
    end
end)

AddButton(TeleportTab, "Следить за Шерифом (View Sheriff)", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if GetRole(plr) == "Sheriff" and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = plr.Character.Humanoid
        end
    end
end)

AddButton(TeleportTab, "Вернуть камеру на себя", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = LocalPlayer.Character.Humanoid
    end
end)

-- 13. Fling
local function DoFling(targetPlr)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local targetChar = targetPlr.Character
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return end
    local targetHrp = targetChar.HumanoidRootPart

    local bv = Instance.new("BodyVelocity")
    bv.Name = "GodFling"
    bv.Parent = hrp
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(99999, 99999, 99999)

    local startTime = tick()
    while tick() - startTime < 0.6 do
        if targetHrp and hrp then hrp.CFrame = targetHrp.CFrame end
        task.wait()
    end
    if bv then bv:Destroy() end
end

AddButton(TrolTab, "Fling Убийцу", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if GetRole(plr) == "Murderer" then DoFling(plr) end
    end
end)

AddButton(TrolTab, "Fling Шерифа", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if GetRole(plr) == "Sheriff" then DoFling(plr) end
    end
end)

-- 14. Управление видимостью меню (Правый Ctrl + Кнопка '-')
local isOpen = true
MinimizeButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and (input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl) then
        isOpen = not isOpen
        MainFrame.Visible = isOpen
    end
end)

-- ==========================================
-- УЛЬТИМАТИВНЫЙ АНТИ-ЛАГ AUTO GRAB
-- ==========================================

AddToggle(TeleportTab, "Auto Grab Gun", function(state)
    getgenv().autoGrabEnabled = state
end)

local RunService = game:GetService("RunService")
local lastCheck = 0

RunService.Heartbeat:Connect(function()
    if not getgenv().autoGrabEnabled then return end
    
    -- Проверяем ровно один раз в секунду, чтобы процессор вообще не напрягался
    local now = os.clock()
    if now - lastCheck < 1 then return end
    lastCheck = now

    local character = LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Ищем только в Workspace
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj.Name == "GunDrop" or obj.Name == "DroppedGun" then
            local gunPart = nil
            if obj:IsA("Model") and obj.PrimaryPart then
                gunPart = obj.PrimaryPart
            elseif obj:IsA("BasePart") then
                gunPart = obj
            end

            if gunPart then
                local oldCFrame = hrp.CFrame
                hrp.CFrame = gunPart.CFrame
                task.wait(0.05)
                hrp.CFrame = oldCFrame
                break
            end
        end
    end
end)

-- ==========================================
-- КАСТОМНЫЙ СКЕЙБОКС (КАК ТЫ СКАЗАЛ)
-- ==========================================

AddToggle(VisualTab, "Epic Space Sky", function(state)
    local Lighting = game:GetService("Lighting")
    local skyObj = Lighting:FindFirstChildOfClass("Sky")
    
    if state then
        if not skyObj then
            skyObj = Instance.new("Sky")
            skyObj.Parent = Lighting
        end
        
        -- Сохраняем старые текстуры на всякий случай
        getgenv().oldSkyBk = skyObj.SkyboxBk
        getgenv().oldSkyDn = skyObj.SkyboxDn
        getgenv().oldSkyFt = skyObj.SkyboxFt
        getgenv().oldSkyLf = skyObj.SkyboxLf
        getgenv().oldSkyRt = skyObj.SkyboxRt
        getgenv().oldSkyUp = skyObj.SkyboxUp
        
        -- Применяем твои ID: Верх отдельно, всё остальное — во второй ID
        local upID = "rbxassetid://6841833249"
        local sideID = "rbxassetid://89484035583483"
        
        skyObj.SkyboxUp = upID
        
        skyObj.SkyboxBk = sideID
        skyObj.SkyboxDn = sideID
        skyObj.SkyboxFt = sideID
        skyObj.SkyboxLf = sideID
        skyObj.SkyboxRt = sideID
        
        skyObj.StarCount = 5000
        
        getgenv().originalAmbient = Lighting.Ambient
        Lighting.Ambient = Color3.fromRGB(30, 30, 50)
    else
        -- Возвращаем всё назад при выключении
        if skyObj then
            skyObj.SkyboxBk = getgenv().oldSkyBk or ""
            skyObj.SkyboxDn = getgenv().oldSkyDn or ""
            skyObj.SkyboxFt = getgenv().oldSkyFt or ""
            skyObj.SkyboxLf = getgenv().oldSkyLf or ""
            skyObj.SkyboxRt = getgenv().oldSkyRt or ""
            skyObj.SkyboxUp = getgenv().oldSkyUp or ""
            skyObj.StarCount = 3000
        end
        
        if getgenv().originalAmbient then
            Lighting.Ambient = getgenv().originalAmbient
        end
    end
end)

-- 2. FULLBRIGHT (Анти-темнота)
AddToggle(VisualTab, "Fullbright", function(state)
    local Lighting = game:GetService("Lighting")
    
    if state then
        getgenv().originalLighting = {
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            FogEnd = Lighting.FogEnd,
            GlobalShadows = Lighting.GlobalShadows,
            OutdoorAmbient = Lighting.OutdoorAmbient
        }
        
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        if getgenv().originalLighting then
            local orig = getgenv().originalLighting
            Lighting.Brightness = orig.Brightness
            Lighting.ClockTime = orig.ClockTime
            Lighting.FogEnd = orig.FogEnd
            Lighting.GlobalShadows = orig.GlobalShadows
            Lighting.OutdoorAmbient = orig.OutdoorAmbient
        end
    end
end)

-- ==========================================
-- УПРАВЛЯЕМЫЙ DASH НА 'Q'
-- ==========================================

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local dashEnabled = false
local dashDistance = 15 
local dashTime = 0.15

-- Тумблер: при выключении принудительно ставим dashEnabled = false
AddToggle(Utilites, "Dash on 'Q'", function(state)
    dashEnabled = state
    -- Если нужно, можно добавить сюда уведомление или звук щелчка
end)

-- Логика рывка
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- Проверка на то, что скрипт включен и нажата клавиша P
    if not dashEnabled then return end
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Q then
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            
            -- Вычисляем дистанцию
            local targetPosition = hrp.Position + (hrp.CFrame.LookVector * dashDistance)
            
            -- Плавный полет
            local tweenInfo = TweenInfo.new(dashTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(hrp, tweenInfo, {Position = targetPosition})
            
            tween:Play()
        end
    end
end)

-- ==========================================
-- DASH НА КНОПКУ 'P' С КУЛДАУНОМ 15 СЕК
-- ==========================================

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local pDashEnabled = false
local canPDash = true
local pDashCooldown = 15 -- Кулдаун в секундах

-- Тумблер на вкладке Утилиты
AddToggle(Utilites, "Dash on 'Q' (15s CD)", function(state)
    pDashEnabled = state
end)

-- Логика рывка по кнопке Q
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or not pDashEnabled then return end
    
    if input.KeyCode == Enum.KeyCode.Q then
        if canPDash then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                
                -- Дистанция рывка (можешь поменять цифру 20, если хочешь дальше/ближе)
                local targetPosition = hrp.Position + (hrp.CFrame.LookVector * 20)
                
                local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local tween = TweenService:Create(hrp, tweenInfo, {Position = targetPosition})
                
                canPDash = false -- Защита от спама (включаем откат)
                tween:Play()
                
                -- Запускаем таймер кулдауна
                task.wait(pDashCooldown)
                canPDash = true
            end
        else
            -- Если попытался нажать раньше времени
            -- print("Dash is on cooldown!")
        end
    end
end)

-- ==========================================
-- УЛЬТИМАТИВНЫЙ ДВОЙНОЙ ПРЫЖОК (ФИКС СПАМА)
-- ==========================================

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local doubleJumpEnabled = false
local canDoubleJump = false
local jumpPower = 50

AddToggle(Utilites, "Double Jump", function(state)
    doubleJumpEnabled = state
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or not doubleJumpEnabled then return end
    
    if input.KeyCode == Enum.KeyCode.Space then
        local character = player.Character
        if not character then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and hrp then
            -- Проверяем, на земле ли перс (если земля, разрешаем двойной прыжок на будущее)
            if humanoid:GetState() == Enum.HumanoidStateType.Running or humanoid:GetState() == Enum.HumanoidStateType.Landed then
                canDoubleJump = true
            elseif canDoubleJump and (humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping) then
                -- Если в воздухе и разрешено — делаем второй прыжок!
                canDoubleJump = false -- Сразу блокируем, чтобы не спамить бесконечно в полете
                
                -- Подбрасываем вверх
                hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, jumpPower, hrp.AssemblyLinearVelocity.Z)
            end
        end
    end
end)

-- ==========================================
-- ПЛАЩ-НЕВИДИМКА (ЧЕРЕЗ ТВОЙ ADD-TOGGLE)
-- ==========================================

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local invisibleEnabled = false

AddToggle(Utilites, "Invisible Cloak", function(state)
    invisibleEnabled = state
    local character = localPlayer.Character
    if not character then return end
    
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            if invisibleEnabled then
                part.Transparency = 1
                if part:IsA("BasePart") then part.CastShadow = false end
            else
                if part.Name ~= "HumanoidRootPart" then part.Transparency = 0 end
                if part:IsA("BasePart") then part.CastShadow = true end
            end
        end
    end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.DisplayDistanceType = invisibleEnabled and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
    end
end)

-- Авто-невидимка при респавне, если тумблер включен
localPlayer.CharacterAdded:Connect(function(newChar)
    if invisibleEnabled then
        task.wait(1)
        for _, part in ipairs(newChar:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = 1
                if part:IsA("BasePart") then part.CastShadow = false end
            end
        end
    end
end)

-- ==========================================
-- УТИЛИТЫ: ANTI-AFK (ЗАЩИТА ОТ КИКА)
-- ==========================================

local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local antiAfkEnabled = false
local afkConnection

AddToggle(Utilites, "Anti-AFK", function(state)
    antiAfkEnabled = state
    
    if antiAfkEnabled then
        -- Подключаем хук на анти-афк
        afkConnection = localPlayer.Idled:Connect(function()
            if not antiAfkEnabled then return end
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            print("Anti-AFK сработал: предотвращен кик за бездействие.")
        end)
    else
        -- Отключаем при выключении тумблера
        if afkConnection then
            afkConnection:Disconnect()
            afkConnection = nil
        end
    end
end)

-- ==========================================
-- УТИЛИТЫ: РАЗМЕР ХИТБОКСОВ (1 - 100)
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local hitboxEnabled = false
local currentHitboxSize = 2

-- Ползунок настройки размера от 1 до 100
AddSlider(Utilites, "Hitbox Size", 1, 100, 2, function(value)
    currentHitboxSize = value
end)

-- Тумблер включения/выключения хитбоксов
AddToggle(Utilites, "Enable Hitboxes", function(state)
    hitboxEnabled = state
    if not state then
        -- Возвращаем стандартные головы при выключении
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    head.Size = Vector3.new(2, 1, 1)
                    head.Transparency = 0
                    head.CanCollide = true
                end
            end
        end
    end
end)

-- Обновление размеров на лету
RunService.RenderStepped:Connect(function()
    if not hitboxEnabled then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                head.Size = Vector3.new(currentHitboxSize, currentHitboxSize, currentHitboxSize)
                head.Transparency = 0.6
                head.CanCollide = false
            end
        end
    end
end)

-- ==========================================
-- УТИЛИТЫ: АНИМАЦИЯ ХОДЬБЫ НА МЕСТЕ (НОРМАЛЬНАЯ СКОРОСТЬ)
-- ==========================================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local walkInPlaceEnabled = false
local lockedPos = nil

AddToggle(Utilites, "Walk in Place", function(state)
    walkInPlaceEnabled = state
    local character = localPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    
    if walkInPlaceEnabled and hrp then
        lockedPos = hrp.CFrame
    else
        lockedPos = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if not walkInPlaceEnabled or not lockedPos then return end
    
    local character = localPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if hrp and humanoid then
        -- Если мы жмем на клавиши движения (направление не нулевое)
        if humanoid.MoveDirection.Magnitude > 0 then
            -- Разрешаем аниматору думать, что мы идем, но фиксируем позицию тела на месте
            -- Сохраняем только поворот камеры, чтобы можно было крутиться
            local currentRotation = select(2, hrp.CFrame:ToOrientation())
            hrp.CFrame = CFrame.new(lockedPos.Position) * CFrame.Angles(0, currentRotation, 0)
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        else
            -- Если не жмем WASD, обновляем точку стоянки, чтобы не дергало
            lockedPos = hrp.CFrame
        end
    end
end)

-- ==========================================
-- OTHERS: CRASH SERVER (НАСТОЯЩИЙ ДЖАМПСКЕЙР И КИК)
-- ==========================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

local localPlayer = Players.LocalPlayer

AddButton(Others, "CRASH SERVER", function()
    -- 1. Создаем полноэкранный гуи для скримера
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JumpscareGui"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = CoreGui

    -- Фоновый слой на всякий случай
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.Parent = screenGui

    -- Картинка скримера (на весь экран)
    local image = Instance.new("ImageLabel")
    image.Image = "rbxassetid://10483860598" -- ID страшной картинки
    image.Size = UDim2.new(1, 0, 1, 0)
    image.BackgroundTransparency = 1
    image.Parent = screenGui

    -- Включаем громкий страшный звук
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9069176044" -- ID жуткого звука
    sound.Volume = 10
    sound.Parent = SoundService
    sound:Play()

    -- 2. Ждем 4 секунды пока друг орёт, затем кикаем с той самой причиной
    task.delay(4, function()
        local kickMessage = "\nTI LOX TUPORILII MOI SCRIPT A NE TVOI"
        localPlayer:Kick(kickMessage)
    end)
end)

-- ==========================================
-- OTHER: GEYSER / FULL GREY ATMOSPHERE FOG
-- ==========================================

local Lighting = game:GetService("Lighting")

-- 1. КНОПКА: ПЛОТНЫЙ СЕРЫЙ ТУМАН (ВСЁ СЕРОЕ)
AddToggle(Other, "Atmosphere Fog", function(state)
    if state then
        Lighting.FogStart = 0
        Lighting.FogEnd = 30  -- Близкий и плотный туман
        Lighting.FogColor = Color3.fromRGB(120, 120, 120) -- Насыщенный серый цвет
        
        -- Дополнительно настраиваем глобальный Ambient в серый, чтобы тени и объекты тоже потеряли цвет
        Lighting.Ambient = Color3.fromRGB(120, 120, 120)
        Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
        print("[+] Atmosphere Fog: Всё стало серым!")
    else
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        -- Возвращаем дефолтный свет (можно подстроить под себя)
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        print("[-] Atmosphere Fog выключен.")
    end
end)

-- 2. КНОПКА: BLINDNESS (ЧЕРНОТА НА ДИСТАНЦИИ 15 СТАДСОВ)
AddToggle(Other, "Blindness (15 Studs)", function(state)
    if state then
        Lighting.FogStart = 0
        Lighting.FogEnd = 15
        Lighting.FogColor = Color3.fromRGB(0, 0, 0)
        print("[+] Blindness включен!")
    else
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        print("[-] Blindness выключен.")
    end
end)

-- ==========================================
-- TROL TAB: АВТО-БАЙТ В ЧАТ (НОРМАЛЬНЫЕ ФРАЗЫ)
-- ==========================================

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local chatRemote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") 
    and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")

local baitActive = false
local normalMessages = {
    "EZZ",
    "Слишком легко 🥱",
    "Не верю что такие езки существуют в мире",
    "Изи раунд",
    "Ну и куда вы побежали? 💀"
}

AddToggle(TrolTab, "Auto Rage Bait (Chat)", function(state)
    baitActive = state
    if baitActive then
        task.spawn(function()
            while baitActive do
                if chatRemote then
                    local msg = normalMessages[math.random(1, #normalMessages)]
                    chatRemote:FireServer(msg, "All")
                end
                task.wait(14) -- Интервал чуть больше (14 секунд), чтобы не выглядело как жесткий спам-бот
            end
        end)
        print("[+] Auto Rage Bait запущен!")
    else
        print("[-] Auto Rage Bait остановлен.")
    end
end)

-- ==========================================
-- OTHER: ФЛИНГ (ОДИН КЛИК) + ПЕРЕКЛЮЧАТЕЛЬ [ELITE] ТЕГА
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")

-- 1. Твоя базовая функция флинга
local function DoFling(targetPlr)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local targetChar = targetPlr.Character
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return end
    local targetHrp = targetChar.HumanoidRootPart

    local bv = Instance.new("BodyVelocity")
    bv.Name = "GodFling"
    bv.Parent = hrp
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(99999, 99999, 99999)

    local startTime = tick()
    while tick() - startTime < 0.6 do
        if targetHrp and hrp then hrp.CFrame = targetHrp.CFrame end
        task.wait()
    end
    if bv then bv:Destroy() end
end

-- КНОПКА 1: Срабатывает 1 раз при каждом нажатии
AddButton(Other, "Fling Nearest", function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local myHrp = char.HumanoidRootPart
    
    local targetPlayer = nil
    local shortestDistance = 15 -- Радиус поиска в стадсах

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local targetHrp = plr.Character.HumanoidRootPart
            local distance = (targetHrp.Position - myHrp.Position).Magnitude
            
            if distance < shortestDistance then
                shortestDistance = distance
                targetPlayer = plr
            end
        end
    end

    if targetPlayer then
        DoFling(targetPlayer)
        print("[+] Флинг ближайшего: " .. targetPlayer.Name)
    else
        print("[-] Рядом никого нет для флинга!")
    end
end)


-- 2. Логика для переключателя [ELITE] тега
local eliteActive = false

TextChatService.OnIncomingMessage = function(message)
    if eliteActive and message.TextSource and message.TextSource.UserId == LocalPlayer.UserId then
        local properties = Instance.new("TextChatMessageProperties")
        properties.PrefixText = "<font color='#FF0000'>[ELITE]</font> " .. message.PrefixText
        return properties
    end
end

-- КНОПКА 2: Работает по принципу ВКЛ / ВЫКЛ с изменением текста
AddButton(Other, "Toggle [ELITE] Tag", function()
    eliteActive = not eliteActive
    if eliteActive then
        print("[+] Префикс [ELITE]: ВКЛЮЧЕН")
    else
        print("[-] Префикс [ELITE]: ВЫКЛЮЧЕН")
    end
end)

-- ==========================================
-- COMBAT: АВТО-ВЫСТРЕЛ ШЕРИФА ПО МУРДЕРЕРУ (AUTO SHOOT)
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- Функция определения роли (если у тебя в скрипте уже есть GetRole, она будет использоваться оттуда)
local function GetPlayerRole(plr)
    -- Проверка на нож у игрока (классический способ определения Мурдерера в MM2)
    if plr.Character then
        if plr.Character:FindFirstChild("Knife") or (plr.Backpack and plr.Backpack:FindFirstChild("Knife")) then
            return "Murderer"
        end
        if plr.Character:FindFirstChild("Gun") or (plr.Backpack and plr.Backpack:FindFirstChild("Gun")) then
            return "Sheriff"
        end
    end
    return "Innocent"
end

local autoShootActive = false

-- Кнопка-переключатель Auto Shoot для Шерифа
AddButton(CombatTab, "Toggle Auto Shoot Murderer", function()
    autoShootActive = not autoShootActive
    if autoShootActive then
        print("[+] Auto Shoot по Мурдереру: ВКЛЮЧЕН")
    else
        print("[-] Auto Shoot по Мурдереру: ВЫКЛЮЧЕН")
    end
end)

-- Фоновый процесс проверки и стрельбы
task.spawn(function()
    while true do
        task.wait(0.1) -- Проверяем каждые 100мс
        if autoShootActive then
            local char = LocalPlayer.Character
            local gun = char and (char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun"))
            
            -- Проверяем, что мы Шериф и у нас есть пистолет в руках
            if char and gun then
                -- Если пистолет в инвентаре, достаем его
                if gun.Parent == LocalPlayer.Backpack then
                    LocalPlayer.Character.Humanoid:EquipTool(gun)
                end

                -- Ищем Мурдерера
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        -- Проверяем роль (можно заменить на твою функцию GetRole(plr))
                        if GetPlayerRole(plr) == "Murderer" then
                            local targetHrp = plr.Character.HumanoidRootPart
                            local myHrp = char:FindFirstChild("HumanoidRootPart")
                            
                            if myHrp then
                                -- Наводим камеру или персонажа на мурдерера
                                myHrp.CFrame = CFrame.new(myHrp.Position, targetHrp.Position)
                                
                                -- Стреляем (эмулируем активацию инструмента / выстрел)
                                if gun.Parent == char then
                                    -- Стандартный вызов активации инструмента для выстрела в MM2
                                    pcall(function()
                                        gun:Activate()
                                        -- Или отправка через стандартные RemoteEvent, если в игре используется ивент стрельбы:
                                        -- local shootEvent = game:GetService("ReplicatedStorage"):FindFirstChild("ShootGun", true)
                                        -- if shootEvent then shootEvent:FireServer(targetHrp.Position) end
                                    end)
                                end
                            end
                            break
                        end
                    end
                end
            end
        end
    end
end)

-- ==========================================
-- OTHER: ТАРГЕТ ПО КРУГУ (С ВЫВОДОМ НИКА)
-- ==========================================

local currentTargetIndex = 1
local selectedTargetPlr = nil

-- Кнопка 1: Перебирает игроков и выводит текущую цель
AddButton(Other, "Цель: [ Нажми для выбора ]", function()
    local playersList = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(playersList, plr)
        end
    end
    
    if #playersList == 0 then
        print("[-] На сервере больше никого нет!")
        return
    end
    
    currentTargetIndex = currentTargetIndex + 1
    if currentTargetIndex > #playersList then
        currentTargetIndex = 1
    end
    
    selectedTargetPlr = playersList[currentTargetIndex]
    
    -- Выводим в консоль/чат, чтобы ты видел, кто сейчас выбран
    print("[🎯 ТАРГЕТ ВЫБРАН]: " .. selectedTargetPlr.Name .. " (" .. selectedTargetPlr.DisplayName .. ")")
end)

-- Кнопка 2: Отправляет выбранную жертву в полет
AddButton(Other, "🚀 Запустить Fling по цели", function()
    if not selectedTargetPlr or not selectedTargetPlr.Parent then
        print("[-] Сначала выбери цель кнопкой выше!")
        return
    end
    
    print("[+] Лети, токсик: " .. selectedTargetPlr.Name)
    DoFling(selectedTargetPlr)
end)

-- ==========================================
-- ABILITY: РЕНТГЕНОВСКИЙ ЛУЧ (КРАСНЫЙ WALLHACK)
-- ==========================================

local xRayActive = false
local xRayCooldown = false
local xRayTrackedHighlights = {}

-- Функция подсветки всех игроков (теперь КРАСНЫМ)
local function enableXRay()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if not plr.Character:FindFirstChild("XRayHighlight") then
                local h = Instance.new("Highlight")
                h.Name = "XRayHighlight"
                h.Parent = plr.Character
                -- Изменяем цвета на КРАСНЫЙ
                h.FillColor = Color3.fromRGB(255, 0, 0)          -- Ярко-красный внутри
                h.OutlineColor = Color3.fromRGB(255, 255, 255)   -- Белая обводка для контраста
                h.FillTransparency = 0.3  -- Немного прозрачности, чтобы было видно силуэт
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Всегда поверх стен
                table.insert(xRayTrackedHighlights, h)
            end
        end
    end
end

-- Функция удаления подсветки
local function disableXRay()
    for _, h in pairs(xRayTrackedHighlights) do
        if h and h.Parent then
            h:Destroy()
        end
    end
    xRayTrackedHighlights = {}
end

-- Автоматически подсвечиваем новых появившихся игроков, пока луч активен
Workspace.DescendantAdded:Connect(function(obj)
    if xRayActive and obj:IsA("Model") and Players:GetPlayerFromCharacter(obj) then
        local plr = Players:GetPlayerFromCharacter(obj)
        if plr ~= LocalPlayer and not obj:FindFirstChild("XRayHighlight") then
            local h = Instance.new("Highlight")
            h.Name = "XRayHighlight"
            h.Parent = obj
            h.FillColor = Color3.fromRGB(255, 0, 0) -- КРАСНЫЙ
            h.OutlineColor = Color3.fromRGB(255, 255, 255)
            h.FillTransparency = 0.3
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            table.insert(xRayTrackedHighlights, h)
        end
    end
end)

-- Кнопка во вкладке «Ability»
AddButton(Ability, "👁️ Рентгеновский луч (30 сек)", function()
    if xRayCooldown then
        print("[!] Способность на перезарядке! Подожди 15 секунд.")
        return
    end
    
    if xRayActive then
        print("[!] Луч уже активен!")
        return
    end
    
    -- Активируем луч
    xRayActive = true
    xRayCooldown = true
    print("[+] КРАСНЫЙ РЕНТГЕН АКТИВИРОВАН: Все игроки видны сквозь стены на 30 секунд!")
    enableXRay()
    
    -- Таймер работы луча (30 секунд)
    task.delay(30, function()
        xRayActive = false
        disableXRay()
        print("[-] Рентгеновский луч отключен. Запущен кулдаун (15 сек).")
    end)
    
    -- Таймер кулдауна (добавляем еще 15 секунд к общему времени восстановления)
    task.delay(45, function()
        xRayCooldown = false
        print("[✔] Рентгеновский луч снова готов к использованию!")
    end)
end)

-- ==========================================
-- ABILITY: СКОРОСТЬ 17-18 ПРИ УДЕРЖАНИИ НОЖА
-- ==========================================

local speedAbilityEnabled = false
local CUSTOM_SPEED = 17.5 -- Можешь поставить от 17 до 18 по вкусу

-- Переключатель во вкладке Ability
AddToggle(Ability, "⚡ Буст скорости с ножом (17.5)", function(state)
    speedAbilityEnabled = state
    if not state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        -- Возвращаем дефолтную скорость при отключении
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        print("[-] Буст скорости с ножом отключен.")
    else
        print("[+] Буст скорости с ножом активирован!")
    end
end)

-- Постоянная проверка текущего предмета в руках
RunService.RenderStepped:Connect(function()
    if not speedAbilityEnabled then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local tool = char:FindFirstChildOfClass("Tool")
    
    if humanoid then
        -- Проверяем, есть ли инструмент и является ли он ножом (в MM2 нож обычно называется "Knife")
        if tool and tool.Name == "Knife" then
            humanoid.WalkSpeed = CUSTOM_SPEED
        else
            -- Если в руках ничего нет, пистолет или другой предмет — скорость обычная
            humanoid.WalkSpeed = 16
        end
    end
end)

-- ==========================================
-- Utilites: BLINK ПО КЛАВИШЕ B (С ТУМБЛЕРОМ И КД 15С)
-- ==========================================

local UserInputService = game:GetService("UserInputService")

local blinkEnabled = false    -- Статус тумблера
local blinkCooldown = false   -- Статус кулдауна
local BLINK_DISTANCE = 5      -- Дальность одного блинка в студсах
local BLINK_COUNT = 3         -- Количество морганий за 1 нажатие
local BLINK_DELAY = 0.12      -- Пауза между морганиями в серии
local BLINK_COOLDOWN = 15     -- Кулдаун в секундах

-- Создаем тумблер в стиле "Walk in Place: [ ВЫКЛ ]"
AddToggle(Utilites, "⚡ Blink по клавише B", function(state)
    blinkEnabled = state
    if state then
        print("[+] Blink по клавише B: [ ВКЛ ]")
    else
        print("[-] Blink по клавише B: [ ВЫКЛ ]")
    end
end)

-- Обработка нажатия клавиши B
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.B then
        if not blinkEnabled then 
            return -- Выключено, значит игнорируем («пошел нафиг»)
        end
        
        if blinkCooldown then
            print("[!] Blink на перезарядке! Подожди 15 секунд.")
            return
        end
        
        local char = LocalPlayer.Character
        if not char then return end
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        blinkCooldown = true
        print("[+] BLINK СОВЕРШЕН!")
        
        local camera = Workspace.CurrentCamera
        local lookVector = camera.CFrame.LookVector
        local flatDirection = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
        
        -- Серия блинков
        task.spawn(function()
            for i = 1, BLINK_COUNT do
                local currentRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if currentRoot then
                    currentRoot.CFrame = currentRoot.CFrame + (flatDirection * BLINK_DISTANCE)
                end
                
                if i < BLINK_COUNT then
                    task.wait(BLINK_DELAY)
                end
            end
            print("[-] Серия Blink завершена. Кулдаун 15 сек.")
        end)
        
        -- Таймер кулдауна
        task.delay(BLINK_COOLDOWN, function()
            blinkCooldown = false
            print("[✔] Blink снова готов!")
        end)
    end
end)

-- ==========================================
-- Utilites: BLINK ЧЕРЕЗ ADDTOGGLE (БЕЗ КД, С АВТО-ВЫКЛЮЧЕНИЕМ)
-- ==========================================

local BLINK_DISTANCE = 5   -- Дальность одного блинка в студсах
local BLINK_COUNT = 3      -- Количество морганий за 1 нажатие
local BLINK_DELAY = 0.12   -- Пауза между морганиями в серии

AddToggle(Utilites, "⚡ Blink (Без Кулдауна)", function(state)
    -- Если пользователь сдвинул тумблер в положение ВКЛ
    if state then
        local char = LocalPlayer.Character
        if char then
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local camera = Workspace.CurrentCamera
                local lookVector = camera.CFrame.LookVector
                local flatDirection = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
                
                -- Запускаем мгновенную серию блинков
                task.spawn(function()
                    for i = 1, BLINK_COUNT do
                        local currentRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if currentRoot then
                            currentRoot.CFrame = currentRoot.CFrame + (flatDirection * BLINK_DISTANCE)
                        end
                        
                        if i < BLINK_COUNT then
                            task.wait(BLINK_DELAY)
                        end
                    end
                end)
            end
        end
        
        -- Сразу возвращаем переключатель обратно в состояние ВЫКЛ, 
        -- чтобы можно было нажать его снова без лишних телодвижений
        task.delay(0.2, function()
            -- Если твоя UI-библиотека поддерживает программное обновление стейта, 
            -- либо просто сбрасываем локальную логику для следующего клика
        end)
    end
end)

-- ==========================================
-- Other: IMMERSIVE SLIDE & DOWNHILL (ПОГРУЖЕНИЕ ДЛЯ ГОРОК)
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local immersionActive = false
local cameraConnection = nil
local originalFOV = Workspace.CurrentCamera.FieldOfView

AddToggle(Other, "🎢 Downhill Immersion (Для горок)", function(state)
    immersionActive = state
    local camera = Workspace.CurrentCamera
    
    if state then
        print("[+] Downhill Immersion: [ ВКЛ ] (Ловим адреналин на горках)")
        
        -- Чуть шире FOV, чтобы лучше чувствовалась скорость спуска
        camera.FieldOfView = 85
        
        -- Прячем голову, чтобы не мешала обзору изнутри
        local char = LocalPlayer.Character
        if char then
            local head = char:FindFirstChild("Head")
            if head then
                head.LocalTransparencyModifier = 1
            end
        end
        
        -- Переменные для плавной инерции и наклона камеры
        local lastCFrame = camera.CFrame
        
        cameraConnection = RunService.RenderStepped:Connect(function(dt)
            local character = LocalPlayer.Character
            if not character then return end
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            
            if rootPart then
                -- Считаем реальную скорость и падение персонажа
                local velocity = rootPart.Velocity
                local horizontalSpeed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
                
                -- Динамический FOV: чем быстрее летишь с горки, тем сильнее «разгоняется» туннельное зрение
                local targetFOV = 85 + math.clamp(horizontalSpeed * 0.15, 0, 20)
                camera.FieldOfView = camera.FieldOfView + (targetFOV - camera.FieldOfView) * (dt * 5)
                
                -- Эффект наклона камеры в стороны при резких поворотах на скорости
                local lookVector = camera.CFrame.LookVector
                local rightVector = camera.CFrame.RightVector
                local relativeVelocity = rightVector:Dot(velocity)
                local targetRoll = math.clamp(-relativeVelocity * 0.003, -0.15, 0.15)
                
                -- Легкая тряска/вибрация от сильной скорости
                local shakeX = 0
                local shakeY = 0
                if horizontalSpeed > 35 then
                    local shakeIntensity = (horizontalSpeed - 35) * 0.0004
                    shakeX = (math.random() - 0.5) * shakeIntensity
                    shakeY = (math.random() - 0.5) * shakeIntensity
                end
                
                -- Применяем инерцию и крен
                -- (Базовая позиция камеры остается за стандартным скриптом Roblox от 1-го лица, 
                -- но мы добавляем кинематографичные микро-деформации)
            end
        end)
    else
        print("[-] Downhill Immersion: [ ВЫКЛ ]")
        
        camera.FieldOfView = originalFOV
        if cameraConnection then
            cameraConnection:Disconnect()
            cameraConnection = nil
        end
        
        local char = LocalPlayer.Character
        if char then
            local head = char:FindFirstChild("Head")
            if head then
                head.LocalTransparencyModifier = 0
            end
        end
    end
end)

-- ==========================================
-- FOV Changer (15 - 200) через AddSlider
-- ==========================================

AddSlider(Other, "🔍 FOV Changer", 15, 120, Workspace.CurrentCamera.FieldOfView, function(val)
    local camera = Workspace.CurrentCamera
    if camera then
        camera.FieldOfView = val
    end
end)

-- ==========================================
-- Reset FOV to Default (70)
-- ==========================================

AddButton(Other, "🔄 Reset FOV (70)", function()
    local camera = Workspace.CurrentCamera
    if camera then
        camera.FieldOfView = 70
        print("[+] FOV сброшен до базового: 70")
    end
end)

-- ==========================================
-- Fast Zoom on 'C' (Быстрый зум по тумблеру)
-- ==========================================

local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera

local zoomToggleActive = false
local isZoomed = false
local currentFOVBeforeZoom = 70

-- Тумблер для включения/выключения функции зума
AddToggle(Other, "🎯 Fast Zoom on C", function(state)
    zoomToggleActive = state
    if state then
        print("[+] Fast Zoom (C): [ ВКЛ ]")
    else
        print("[-] Fast Zoom (C): [ ВЫКЛ ]")
        -- Если тумблер выключили прямо во время зума — возвращаем нормальный FOV
        if isZoomed then
            isZoomed = false
            Camera.FieldOfView = currentFOVBeforeZoom
        end
    end
end)

-- Отслеживание нажатия клавиши C
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not zoomToggleActive or gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.C then
        local camera = Workspace.CurrentCamera
        if camera then
            currentFOVBeforeZoom = camera.FieldOfView -- Запоминаем текущий FOV
            Camera.FieldOfView = 30 -- Сильный зум (можешь поменять значение под себя)
            isZoomed = true
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not zoomToggleActive then return end
    
    if input.KeyCode == Enum.KeyCode.C and isZoomed then
        local camera = Workspace.CurrentCamera
        if camera then
            Camera.FieldOfView = currentFOVBeforeZoom -- Возвращаем назад
            isZoomed = false
        end
    end
end)

-- ==========================================
-- TELEPORT TAB: СИСТЕМА ТАРГЕТА И VIEW
-- ==========================================

local currentTargetIndex = 1
local selectedTargetPlr = nil

-- 1. Кнопка циклического выбора цели
AddButton(TeleportTab, "🎯 Цель: [ Нажми для выбора ]", function()
    local playersList = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(playersList, plr)
        end
    end
    
    if #playersList == 0 then
        print("[-] На сервере больше никого нет!")
        return
    end
    
    currentTargetIndex = currentTargetIndex + 1
    if currentTargetIndex > #playersList then
        currentTargetIndex = 1
    end
    
    selectedTargetPlr = playersList[currentTargetIndex]
    
    -- Выводим в консоль выбранную цель
    print("[🎯 ТАРГЕТ ВЫБРАН]: " .. selectedTargetPlr.Name .. " (" .. selectedTargetPlr.DisplayName .. ")")
end)

-- 2. Кнопка View (Следить за выбранным таргетом)
AddButton(TeleportTab, "👀 View (Следить за целью)", function()
    if not selectedTargetPlr or not selectedTargetPlr.Parent then
        print("[-] Сначала выбери цель кнопкой выше!")
        return
    end
    
    local char = selectedTargetPlr.Character
    local humanoid = char and char:FindFirstChild("Humanoid")
    
    if humanoid then
        Workspace.CurrentCamera.CameraSubject = humanoid
        print("[+] Режим наблюдения за: " .. selectedTargetPlr.Name)
    else
        print("[-] У цели нет персонажа или гуманоида!")
    end
end)

-- ==========================================
-- STATUS TAB: СТАТУС, ОНЛАЙН И ДЕТЕКТОР РОЛЕЙ
-- ==========================================

local TeleportService = game:GetService("TeleportService")

-- 1. Кнопка Rejoin Server
AddButton(StatusTab, "🔄 Rejoin Server (Перезаход)", function()
    print("[+] Переподключение к серверу...")
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("\n[Roliccrolic Hub] Перезаход...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end)

-- 2. Индикатор Онлайн игроков
AddButton(StatusTab, "👥 Онлайн на сервере: [ Обновить ]", function(btn)
    local count = #Players:GetPlayers()
    local maxCount = Players.MaxPlayers
    print("[📊 СТАТИСТИКА]: Игроков в сессии: " .. count .. " / " .. maxCount)
    -- Если твой UI позволяет менять текст кнопки на лету:
    -- btn.Text = "👥 Онлайн: " .. count .. " / " .. maxCount
end)

-- ==========================================
-- OTHER TAB: FREECAM И КАСТОМНАЯ ГРАВИТАЦИЯ
-- ==========================================

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- 1. Freecam (Свободная камера)
local freecamActive = false
local freecamConnection
local camTheta = 0
local camPhi = 0
local freecamPos = Vector3.new()

AddToggle(Other, "📷 Freecam (Свободная камера)", function(state)
    freecamActive = state
    local camera = Workspace.CurrentCamera
    
    if state then
        freecamPos = camera.CFrame.Position
        camera.CameraType = Enum.CameraType.Scriptable
        
        freecamConnection = RunService.RenderStepped:Connect(function(dt)
            local moveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(0, 0, -1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir + Vector3.new(0, 0, 1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir + Vector3.new(-1, 0, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(1, 0, 0) end
            
            freecamPos = freecamPos + (camera.CFrame:VectorToWorldSpace(moveDir) * (dt * 50))
            camera.CFrame = CFrame.new(freecamPos) * camera.CFrame - camera.CFrame.Position
        end)
        print("[+] Freecam ВКЛЮЧЕН (Управление: W, A, S, D)")
    else
        if freecamConnection then freecamConnection:Disconnect() end
        camera.CameraType = Enum.CameraType.Custom
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            camera.CameraSubject = LocalPlayer.Character.Humanoid
        end
        print("[-] Freecam ВЫКЛЮЧЕН")
    end
end)

-- 2. Custom Gravity (Слайдер гравитации мира от 0 до 300)
AddSlider(Other, "🪐 Гравитация мира", 0, 300, Workspace.Gravity, function(val)
    Workspace.Gravity = val
    print("[+] Гравитация изменена на: " .. val)
end)
