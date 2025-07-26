local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Удаляем старый GUI, если есть
local oldGui = game:GetService("CoreGui"):FindFirstChild("LemonKeyGui")
if oldGui then oldGui:Destroy() end

-- Зашифрованный ключ "Lemon"
local keyData = {76, 101, 109, 111, 110}
local function decodeKey(tbl)
	local s = ""
	for _, v in ipairs(tbl) do
		s = s .. string.char(v)
	end
	return s
end
local validKey = decodeKey(keyData)

-- Зашифрованный URL Luarmor (https://api.luarmor.net/files/v3/loaders/d4268c6811e5c532d2e91caa3d145760.lua)
local urlData = {
	104,116,116,112,115,58,47,47,97,112,105,46,108,117,97,114,109,111,114,46,110,101,116,
	47,102,105,108,101,115,47,118,51,47,108,111,97,100,101,114,115,47,
	100,52,50,54,56,99,54,56,49,49,101,53,99,53,51,50,100,50,101,57,
	49,99,97,97,51,100,49,52,53,55,54,48,46,108,117,97
}
local function decodeURL(tbl)
	local s = ""
	for _, v in ipairs(tbl) do
		s = s .. string.char(v)
	end
	return s
end

-- Создание GUI
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
title.Text = "🍋 Enter your key"

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8, 0, 0, 40)
box.Position = UDim2.new(0.1, 0, 0, 70)
box.PlaceholderText = "Type here..."
box.Font = Enum.Font.Gotham
box.TextSize = 22
box.TextColor3 = Color3.fromRGB(60, 60, 60)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 180)
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

local successSound = Instance.new("Sound", frame)
successSound.SoundId = "rbxassetid://9118820942"
successSound.Volume = 0.7

local failSound = Instance.new("Sound", frame)
failSound.SoundId = "rbxassetid://138186576"
failSound.Volume = 0.7

-- Анимация появления
TweenService:Create(frame, TweenInfo.new(0.6), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
TweenService:Create(shadow, TweenInfo.new(0.6), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 5, 0.5, 5)}):Play()

-- Проверка
buttonSubmit.MouseButton1Click:Connect(function()
	local input = box.Text:match("^%s*(.-)%s*$")
	if input == validKey then
		feedback.Text = "✅ Success!"
		feedback.TextColor3 = Color3.fromRGB(30, 160, 30)
		successSound:Play()
		wait(1)
		gui:Destroy()
		loadstring(game:HttpGet(decodeURL(urlData)))()
	else
		feedback.Text = "❌ Invalid Key"
		feedback.TextColor3 = Color3.fromRGB(200, 40, 40)
		failSound:Play()
		wait(2)
		feedback.Text = ""
	end
end)

buttonGetKey.MouseButton1Click:Connect(function()
	setclipboard("https://linkget.ru/jEri")
	feedback.Text = "🔗 Link copied!"
	feedback.TextColor3 = Color3.fromRGB(180, 140, 20)
	wait(2)
	feedback.Text = ""
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
		gui:Destroy()
	end
end)
