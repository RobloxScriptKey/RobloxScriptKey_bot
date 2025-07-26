-- RobloxScriptKey – Lemon GUI + Luarmor loader

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "LemonKeyGui"
gui.ResetOnSpawn = false

-- Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 220)
frame.Position = UDim2.new(0.5, -200, 0.5, -110)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 140)
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 20)

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
box.PlaceholderText = "Lemon"
box.Font = Enum.Font.Gotham
box.TextSize = 22
box.TextColor3 = Color3.fromRGB(60, 60, 60)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 180)
box.TextStrokeTransparency = 0.8
local boxCorner = Instance.new("UICorner", box)
boxCorner.CornerRadius = UDim.new(0, 15)

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

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 30)
feedback.Position = UDim2.new(0, 0, 1, -30)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.TextColor3 = Color3.fromRGB(40, 40, 40)
feedback.Font = Enum.Font.GothamBold
feedback.TextSize = 20

-- Sounds
local soundSuccess = Instance.new("Sound", frame)
soundSuccess.SoundId = "rbxassetid://9118820942" -- yea
soundSuccess.Volume = 0.8

local soundFail = Instance.new("Sound", frame)
soundFail.SoundId = "rbxassetid://138186576" -- error/fail
soundFail.Volume = 0.8

gui.Parent = game:GetService("CoreGui")

-- Logic
local validKey = "Lemon"

buttonSubmit.MouseButton1Click:Connect(function()
	local input = box.Text:match("^%s*(.-)%s*$")

	if input == validKey then
		feedback.TextColor3 = Color3.fromRGB(20, 150, 0)
		feedback.Text = "✅ Success! Launching..."
		soundSuccess:Play()
		wait(1.5)
		gui:Destroy()
		loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/d4268c6811e5c532d2e91caa3d145760.lua"))()
	else
		feedback.TextColor3 = Color3.fromRGB(180, 20, 20)
		feedback.Text = "❌ Invalid Key"
		soundFail:Play()
		wait(1.5)
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

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
		gui:Destroy()
	end
end)
