
-- OMA FAMILY | Anime Dice Hub
-- Ventana móvil, minimizable y restaurable.
-- Pega este bloque después de cargar Players y crear el GUI.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Sustituye este ID por una imagen de Roblox subida
-- a tu cuenta o grupo y autorizada para usarla.
local LOGO_IMAGE = "rbxassetid://0"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OmaFamilyAnimeDice"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(320, 390)
Main.Position = UDim2.new(0.5, -160, 0.5, -195)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(255, 184, 35)
Border.Thickness = 2
Border.Parent = Main

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundColor3 = Color3.fromRGB(32, 26, 12)
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.fromOffset(10, 0)
Title.BackgroundTransparency = 1
Title.Text = "OMA FAMILY | ANIME DICE"
Title.TextColor3 = Color3.fromRGB(255, 195, 45)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(38, 34)
Minimize.Position = UDim2.new(1, -44, 0, 7)
Minimize.Text = "—"
Minimize.TextSize = 22
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.BackgroundColor3 = Color3.fromRGB(65, 50, 20)
Minimize.Parent = Header
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 8)

local Body = Instance.new("ScrollingFrame")
Body.Name = "Options"
Body.Position = UDim2.fromOffset(10, 58)
Body.Size = UDim2.new(1, -20, 1, -68)
Body.BackgroundTransparency = 1
Body.BorderSizePixel = 0
Body.ScrollBarThickness = 4
Body.CanvasSize = UDim2.fromOffset(0, 400)
Body.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Body

local function AddButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -5, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(36, 36, 40)
    Button.TextColor3 = Color3.fromRGB(255, 210, 90)
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = text
    Button.Parent = Body
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
    Button.Activated:Connect(callback)
    return Button
end

AddButton("Auto-Roll (integración pendiente)", function()
    print("Auto-Roll: conectar con la mecánica real del juego.")
end)

AddButton("Farm de torre (integración pendiente)", function()
    print("Farm: requiere una implementación compatible con el juego.")
end)

AddButton("Recolección (integración pendiente)", function()
    print("Recolección: módulo pendiente.")
end)

AddButton("Auto-Grade (integración pendiente)", function()
    print("Mejoras: módulo pendiente.")
end)

-- Arrastrar la ventana usando el encabezado.
local dragging = false
local dragInput
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- Botón flotante con el emblema para restaurar.
local Restore = Instance.new("ImageButton")
Restore.Name = "Restore"
Restore.Size = UDim2.fromOffset(58, 58)
Restore.Position = UDim2.new(0, 18, 0.5, -29)
Restore.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Restore.Image = LOGO_IMAGE
Restore.ScaleType = Enum.ScaleType.Crop
Restore.Visible = false
Restore.Active = true
Restore.Parent = ScreenGui
Instance.new("UICorner", Restore).CornerRadius = UDim.new(1, 0)

local RestoreBorder = Instance.new("UIStroke")
RestoreBorder.Color = Color3.fromRGB(255, 184, 35)
RestoreBorder.Thickness = 2
RestoreBorder.Parent = Restore

Minimize.Activated:Connect(function()
    Main.Visible = false
    Restore.Visible = true
end)

Restore.Activated:Connect(function()
    Restore.Visible = false
    Main.Visible = true
end)

print("OMA FAMILY | Interfaz cargada")
