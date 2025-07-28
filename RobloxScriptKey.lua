local correctKey = "Playerok MILEDI STORE"

local function checkKey(input)
    -- Убираем лишние пробелы по краям, сравниваем строго по содержимому и регистру
    local trimmedInput = input:match("^%s*(.-)%s*$")
    return trimmedInput == correctKey
end

-- Создаем UI под стиль Playerok

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlayerokKeyUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 420, 0, 240)
Frame.Position = UDim2.new(0.5, -210, 0.5, -120)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Parent = ScreenGui

local Logo = Instance.new("TextLabel")
Logo.Text = "Playerok"
Logo.Size = UDim2.new(1, 0, 0, 60)
Logo.Position = UDim2.new(0, 0, 0, 10)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 44
Logo.TextColor3 = Color3.fromRGB(44, 181, 230)
Logo.BackgroundTransparency = 1
Logo.Parent = Frame

local Desc = Instance.new("TextLabel")
Desc.Text = "Введите ключ от MILEDI STORE:"
Desc.Size = UDim2.new(1, -40, 0, 40)
Desc.Position = UDim2.new(0, 20, 0, 80)
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 20
Desc.TextWrapped = true
Desc.TextColor3 = Color3.fromRGB(170, 200, 220)
Desc.BackgroundTransparency = 1
Desc.TextXAlignment = Enum.TextXAlignment.Left
Desc.Parent = Frame

local Input = Instance.new("TextBox")
Input.PlaceholderText = "Введите ключ здесь..."
Input.Size = UDim2.new(1, -40, 0, 45)
Input.Position = UDim2.new(0, 20, 0, 130)
Input.Font = Enum.Font.Gotham
Input.TextSize = 20
Input.TextColor3 = Color3.fromRGB(220, 220, 255)
Input.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
Input.BorderSizePixel = 0
Input.ClearTextOnFocus = false
Input.Parent = Frame

local Button = Instance.new("TextButton")
Button.Text = "Подтвердить ключ"
Button.Size = UDim2.new(1, -40, 0, 50)
Button.Position = UDim2.new(0, 20, 0, 190)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 22
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.BackgroundColor3 = Color3.fromRGB(44, 181, 230)
Button.BorderSizePixel = 0
Button.Parent = Frame

local ErrorLabel = Instance.new("TextLabel")
ErrorLabel.Text = ""
ErrorLabel.Size = UDim2.new(1, -40, 0, 30)
ErrorLabel.Position = UDim2.new(0, 20, 0, 245)
ErrorLabel.Font = Enum.Font.Gotham
ErrorLabel.TextSize = 16
ErrorLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
ErrorLabel.BackgroundTransparency = 1
ErrorLabel.TextXAlignment = Enum.TextXAlignment.Left
ErrorLabel.Parent = Frame

Button.MouseButton1Click:Connect(function()
    if checkKey(Input.Text) then
        ScreenGui:Destroy()
        -- Здесь запускаем твои скрипты:
        -- loadstring(game:HttpGet("https://твоя-ссылка-на-скрипт.lua", true))()
    else
        ErrorLabel.Text = "❌ Неверный ключ. Получите его на Playerok (MILEDI STORE)"
    end
end)
