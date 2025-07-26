local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Name = "LemonKeyGui"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Основной фрейм с градиентом
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 220)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 140)
frame.BackgroundTransparency = 0

-- Градиент
local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 220, 50)),
}
grad.Rotation = 45

-- Скругление углов
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 20)

-- Тень под фреймом
local shadow = Instance.new("Frame", gui)
shadow.Size = frame.Size + UDim2.new(0, 10, 0, 10)
shadow.Position = frame.Position + UDim2.new(0, 5, 0, 5)
shadow.AnchorPoint = frame.AnchorPoint
shadow.BackgroundColor3 = Color3.new(0,0,0)
shadow.BackgroundTransparency = 0.7
shadow.ZIndex = frame.ZIndex - 1
local shadowCorner = Instance.new("UICorner", shadow)
shadowCorner.CornerRadius = corner.CornerRadius

-- Заголовок
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "🍋 Enter your Lemon Key"

-- Текстовое поле ввода
local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8, 0, 0, 40)
box.Position = UDim2.new(0.1, 0, 0, 70)
box.PlaceholderText = "Type your key here..."
box.Font = Enum.Font.Gotham
box.TextSize = 22
box.TextColor3 = Color3.fromRGB(60, 60, 60)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 180)
box.BackgroundTransparency = 0
box.ClearTextOnFocus = false
box.TextStrokeTransparency = 0.8
box.AutoLocalize = false
local boxCorner = Instance.new("UICorner", box)
boxCorner.CornerRadius = UDim.new(0, 15)

-- Кнопка Submit
local buttonSubmit = Instance.new("TextButton", frame)
buttonSubmit.Size = UDim2.new(0.35, 0, 0, 45)
buttonSubmit.Position = UDim2.new(0.1, 0, 0, 130)
buttonSubmit.BackgroundColor3 = Color3.fromRGB(255, 200, 30)
buttonSubmit.Font = Enum.Font.GothamBold
buttonSubmit.TextSize = 22
buttonSubmit.TextColor3 = Color3.fromRGB(50, 50, 50)
buttonSubmit.Text = "Submit"
local submitCorner = Instance.new("UICorner", buttonSubmit)
submitCorner.CornerRadius = UDim.new(0, 20)

-- Кнопка Get Key
local buttonGetKey = Instance.new("TextButton", frame)
buttonGetKey.Size = UDim2.new(0.45, 0, 0, 45)
buttonGetKey.Position = UDim2.new(0.55, 0, 0, 130)
buttonGetKey.BackgroundColor3 = Color3.fromRGB(255, 230, 80)
buttonGetKey.Font = Enum.Font.GothamBold
buttonGetKey.TextSize = 22
buttonGetKey.TextColor3 = Color3.fromRGB(50, 50, 50)
buttonGetKey.Text = "Get Key"
local getKeyCorner = Instance.new("UICorner", buttonGetKey)
getKeyCorner.CornerRadius = UDim.new(0, 20)

-- Сообщение о статусе
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
soundSuccess.SoundId = "rbxassetid://9118820942" -- пример звука "Yea"
soundSuccess.Volume = 0.6

local soundFail = Instance.new("Sound", frame)
soundFail.SoundId = "rbxassetid://138186576" -- пример звука "Error beep"
soundFail.Volume = 0.6

-- Анимация появления интерфейса
frame.Position = UDim2.new(0.5, 0, 0.3, 0)
frame.BackgroundTransparency = 1
shadow.Position = frame.Position + UDim2.new(0, 5, 0, 5)
shadow.BackgroundTransparency = 1

local tweenIn = TweenService:Create(frame, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)})
local shadowTweenIn = TweenService:Create(shadow, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 5, 0.5, 5)})

tweenIn:Play()
shadowTweenIn:Play()

-- Ключ и логика
local validKey = "Lemon"

buttonSubmit.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$")
    if input == validKey then
        feedback.TextColor3 = Color3.fromRGB(20, 150, 0)
        feedback.Text = "✅ Success! Key accepted."
        soundSuccess:Play()
        wait(2)
        gui:Destroy()
        -- Запуск основного скрипта сюда, например:
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/ffdfeadf0af798741806ea404682a938.lua"))()
    else
        feedback.TextColor3 = Color3.fromRGB(180, 20, 20)
        feedback.Text = "❌ Invalid Key."
        soundFail:Play()
        wait(2)
        feedback.Text = ""
    end
end)

buttonGetKey.MouseButton1Click:Connect(function()
    setclipboard("https://linkget.ru/jEri")
    feedback.TextColor3 = Color3.fromRGB(180, 140, 20)
    feedback.Text = "🔗 Link copied to clipboard!"
    wait(2)
    feedback.Text = ""
end)

-- Убрать GUI при нажатии Esc
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.Escape then
            gui:Destroy()
        end
    end
end)
