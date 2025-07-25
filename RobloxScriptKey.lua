local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Звуки
local soundSuccess = Instance.new("Sound")
soundSuccess.SoundId = "rbxassetid://138186576" -- веселый звук "Yea!"
soundSuccess.Volume = 0.7
soundSuccess.Parent = player:WaitForChild("PlayerGui")

local soundFail = Instance.new("Sound")
soundFail.SoundId = "rbxassetid://911882698" -- звук "вэ-вэ-вэ" (buzzer)
soundFail.Volume = 0.7
soundFail.Parent = player:WaitForChild("PlayerGui")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LemonKeyGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 200)
frame.Position = UDim2.new(0.5, -180, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(255, 242, 90)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundTransparency = 0.1
frame.ClipsDescendants = true
frame.AutoLocalize = false

local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 8, 1, 8)
shadow.Position = UDim2.new(0, -4, 0, -4)
shadow.BackgroundColor3 = Color3.fromRGB(180, 180, 0)
shadow.BorderSizePixel = 0
shadow.ZIndex = 0
shadow.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🍋 Enter your lemon key 🍋"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(40, 40, 40)
title.TextSize = 28
title.Parent = frame

local textbox = Instance.new("TextBox")
textbox.Size = UDim2.new(0.85, 0, 0, 35)
textbox.Position = UDim2.new(0.075, 0, 0, 55)
textbox.PlaceholderText = "Type your key here"
textbox.Font = Enum.Font.Gotham
textbox.TextSize = 22
textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 150)
textbox.TextColor3 = Color3.fromRGB(30, 30, 30)
textbox.BorderSizePixel = 0
textbox.ClearTextOnFocus = false
textbox.Parent = frame
textbox.Text = ""

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.85, 0, 0, 40)
submitBtn.Position = UDim2.new(0.075, 0, 0, 100)
submitBtn.BackgroundColor3 = Color3.fromRGB(255, 230, 50)
submitBtn.BorderSizePixel = 0
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 24
submitBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
submitBtn.Text = "Submit"
submitBtn.Parent = frame

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0.85, 0, 0, 30)
getKeyBtn.Position = UDim2.new(0.075, 0, 0, 150)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 210, 0)
getKeyBtn.BorderSizePixel = 0
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 20
getKeyBtn.TextColor3 = Color3.fromRGB(30, 30, 30)
getKeyBtn.Text = "Get Key (Telegram)"
getKeyBtn.Parent = frame

local feedback = Instance.new("TextLabel")
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -22)
feedback.BackgroundTransparency = 1
feedback.TextColor3 = Color3.fromRGB(60, 0, 0)
feedback.Font = Enum.Font.GothamBold
feedback.TextSize = 18
feedback.Text = ""
feedback.Parent = frame

local VALID_KEY = "Lemon"

submitBtn.MouseEnter:Connect(function()
	submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
end)
submitBtn.MouseLeave:Connect(function()
	submitBtn.BackgroundColor3 = Color3.fromRGB(255, 230, 50)
end)
submitBtn.MouseButton1Down:Connect(function()
	submitBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
end)
submitBtn.MouseButton1Up:Connect(function()
	submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
end)

submitBtn.MouseButton1Click:Connect(function()
	local enteredKey = textbox.Text:gsub("%s+", ""):lower()
	if enteredKey == VALID_KEY:lower() then
		feedback.TextColor3 = Color3.fromRGB(0, 100, 0)
		feedback.Text = "✅ Key correct! Loading..."
		soundSuccess:Play()
		wait(1)
		screenGui:Destroy()

		local success, result = pcall(function()
			return game:HttpGet("https://api.luarmor.net/files/v3/loaders/ffdfeadf0af798741806ea404682a938.lua")
		end)

		if success and result then
			local func, err = loadstring(result)
			if func then
				func()
			else
				warn("Error loading external script:", err)
			end
		else
			warn("Failed to get external script:", result)
		end
	else
		feedback.TextColor3 = Color3.fromRGB(150, 0, 0)
		feedback.Text = "❌ Invalid key, try again!"
		if not soundFail.IsPlaying then
			soundFail:Play()
		end
		wait(2)
		feedback.Text = ""
	end
end)

-- Функция копирования ссылки
local function copyToClipboard(text)
	-- Roblox не имеет встроенной функции копирования в буфер, 
	-- но можно использовать SetClipboard, если у игрока включена консоль разработчика
	pcall(function()
		setclipboard(text)
	end)
end

getKeyBtn.MouseButton1Click:Connect(function()
	local link = "https://t.me/RobloxScriptKey_bot?start=RobloxScriptKey_bot"
	copyToClipboard(link)
	feedback.TextColor3 = Color3.fromRGB(0, 80, 255)
	feedback.Text = "🔗 Link copied to clipboard!"
	wait(2)
	feedback.Text = ""
end)
