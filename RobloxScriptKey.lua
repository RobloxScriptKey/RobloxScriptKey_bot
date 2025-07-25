-- RobloxScriptKey – Key system with sound loop and Luarmor loader

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer

-- Зашифрованный ключ "Lemon"
local keyData = {76, 101, 109, 111, 110}
local function decodeKey(tbl)
	local result = ""
	for _, v in ipairs(tbl) do
		result = result .. string.char(v)
	end
	return result
end
local validKey = decodeKey(keyData)

-- GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "LemonKeyGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, -160, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(255, 235, 59)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.05

local title = Instance.new("TextLabel", frame)
title.Text = "🍋 Enter the key you got from the bot"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(50, 50, 50)
title.Font = Enum.Font.FredokaOne
title.TextSize = 20

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your key here..."
box.Size = UDim2.new(0.9, 0, 0, 35)
box.Position = UDim2.new(0.05, 0, 0, 50)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
box.TextColor3 = Color3.fromRGB(0, 0, 0)
box.Font = Enum.Font.SourceSansBold
box.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Text = "✅ Submit"
button.Size = UDim2.new(0.9, 0, 0, 35)
button.Position = UDim2.new(0.05, 0, 0, 95)
button.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, 0, 0, 20)
status.Position = UDim2.new(0, 0, 1, -25)
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 80, 80)
status.BackgroundTransparency = 1
status.Font = Enum.Font.SourceSansItalic
status.TextSize = 16

-- Звук стона (в цикле пока открыт интерфейс)
local stonSound = Instance.new("Sound", SoundService)
stonSound.Name = "LoopSton"
stonSound.SoundId = "rbxassetid://9118823102"
stonSound.Looped = true
stonSound.Volume = 1
stonSound:Play()

-- Зашифрованная ссылка на Luarmor
local encodedURL = {
	104,116,116,112,115,58,47,47,97,112,105,46,108,117,97,114,109,111,114,46,110,101,116,
	47,102,105,108,101,115,47,118,51,47,108,111,97,100,101,114,115,47,
	102,102,100,102,101,97,100,102,48,97,102,55,57,56,55,52,49,56,48,54,101,97,
	52,48,52,54,56,50,97,57,51,56,46,108,117,97
}
local function decodeURL(tbl)
	local result = ""
	for _, b in ipairs(tbl) do
		result = result .. string.char(b)
	end
	return result
end

-- Обработка кнопки
button.MouseButton1Click:Connect(function()
	local userInput = box.Text:match("^%s*(.-)%s*$") -- trim

	if userInput == validKey then
		status.TextColor3 = Color3.fromRGB(0, 200, 0)
		status.Text = "✅ Success! Key accepted."

		wait(1.5)
		stonSound:Stop()
		gui:Destroy()

		-- загрузка скрипта
		local url = decodeURL(encodedURL)
		local scriptCode = game:HttpGet(url)
		local success, func = pcall(loadstring, scriptCode)
		if success and func then
			func()
		else
			warn("❌ Failed to load script from Luarmor.")
		end
	else
		status.TextColor3 = Color3.fromRGB(255, 0, 0)
		status.Text = "❌ Invalid key"
		wait(2)
		status.Text = ""
	end
end)
