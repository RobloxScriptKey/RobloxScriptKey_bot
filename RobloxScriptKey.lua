local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Удаляем старый GUI, если есть
local oldGui = game:GetService("CoreGui"):FindFirstChild("LemonKeyGui")
if oldGui then oldGui:Destroy() end

-- Новый GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LemonKeyGui"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 220)
frame.Position = UDim2.new(0.5, 0, 0.3, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 140)
frame.BackgroundTransparency = 1

local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 220, 50)),
}
grad.Rotation = 45

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

local shadow = Instance.new("Frame", gui)
shadow.Size = frame.Size + UDim2.new(0, 10, 0, 10)
shadow.Position = frame.Position + UDim2.new(0, 5, 0, 5)
shadow.AnchorPoint = frame.AnchorPoint
shadow.BackgroundColor3 = Color3.new(0,0,0)
shadow.BackgroundTransparency = 1
shadow.ZIndex = frame.ZIndex - 1
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "🍋 Enter your Lemon Key"

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8, 0, 0, 40)
box.Position = UDim2.new(0.1, 0, 0, 70)
box.PlaceholderText = "Type your key here..."
box.Font = Enum.Font.Gotham
box.TextSize = 22
box.TextColor3 = Color3.fromRGB(60, 60, 60)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 180)
box.ClearTextOnFocus = false
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 15)

local buttonSubmit = Instance.new("TextButton", frame)
buttonSubmit.Size = UDim2.new(0.35, 0, 0, 45)
buttonSubmit.Position = UDim2.new(0.1, 0, 0, 130)
buttonSubmit.BackgroundColor3 = Color3.fromRGB(255, 200, 30)
buttonSubmit.Font = Enum.Font.GothamBold
buttonSubmit.TextSize = 22
buttonSubmit.TextColor3 = Color3.fromRGB(50, 50, 50)
buttonSubmit.Text = "Submit"
Instance.new("UICorner", buttonSubmit).CornerRadius = UDim.new(0, 20)

local buttonGetKey = Instance.new("TextButton", frame)
buttonGetKey.Size = UDim2.new(0.45, 0, 0, 45)
buttonGetKey.Position = UDim2.new(0.55, 0, 0, 130)
buttonGetKey.BackgroundColor3 = Color3.fromRGB(255, 230, 80)
buttonGetKey.Font = Enum.Font.GothamBold
buttonGetKey.TextSize = 22
buttonGetKey.TextColor3 = Color3.fromRGB(50, 50, 50)
buttonGetKey.Text = "Get Key"
Instance.new("UICorner", buttonGetKey).CornerRadius = UDim.new(0, 20)

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 30)
feedback.Position = UDim2.new(0, 0, 0, 185)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.TextColor3 = Color3.fromRGB(40, 40, 40)
feedback.Font = Enum.Font.GothamBold
feedback.TextSize = 20

-- Звуки
local soundSuccess = Instance.new("Sound", frame)
soundSuccess.SoundId = "rbxassetid://9118820942"
soundSuccess.Volume = 0.7

local soundFail = Instance.new("Sound", frame)
soundFail.SoundId = "rbxassetid://138186576"
soundFail.Volume = 0.7

-- Анимация появления GUI
TweenService:Create(frame, TweenInfo.new(0.6), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
TweenService:Create(shadow, TweenInfo.new(0.6), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 5, 0.5, 5)}):Play()

-- Проверка ключа
local validKey = "Lemon"
buttonSubmit.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$")
    if input == validKey then
        feedback.Text = "✅ Success! Key accepted."
        feedback.TextColor3 = Color3.fromRGB(30, 160, 30)
        soundSuccess:Play()
        wait(1)
        gui:Destroy()
        -- Новый скрипт с Luarmor
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/d4268c6811e5c532d2e91caa3d145760.lua"))()
    else
        feedback.Text = "❌ Invalid Key."
        feedback.TextColor3 = Color3.fromRGB(200, 30, 30)
        soundFail:Play()
        wait(1.5)
        feedback.Text = ""
    end
end)

-- Копирование ссылки
buttonGetKey.MouseButton1Click:Connect(function()
    setclipboard("https://linkget.ru/jEri")
    feedback.Text = "🔗 Link copied to clipboard!"
    feedback.TextColor3 = Color3.fromRGB(200, 150, 0)
    wait(2)
    feedback.Text = ""
end)

-- Закрытие интерфейса на ESC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
        gui:Destroy()
    end
end)
