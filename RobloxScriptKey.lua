--// RobloxScriptKey – Key System with GUI, Sound, Encrypted Key and Loader

-- Hidden Key as ASCII values
local keyData = {76, 101, 109, 111, 110} -- "Lemon"
local function decodeKey(data)
	local result = ""
	for _, v in ipairs(data) do
		result = result .. string.char(v)
	end
	return result
end
local validKey = decodeKey(keyData)

-- GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 160)
frame.Position = UDim2.new(0.5, -160, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Text = "🍋 Enter the key you got in the Telegram bot"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 18

local textbox = Instance.new("TextBox", frame)
textbox.PlaceholderText = "Type your key here"
textbox.Size = UDim2.new(0.9, 0, 0, 30)
textbox.Position = UDim2.new(0.05, 0, 0, 50)
textbox.Text = ""
textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
textbox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
textbox.TextSize = 18
textbox.Font = Enum.Font.Gotham

local button = Instance.new("TextButton", frame)
button.Text = "✅ Submit"
button.Size = UDim2.new(0.9, 0, 0, 30)
button.Position = UDim2.new(0.05, 0, 0, 90)
button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 18

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -20)
feedback.BackgroundTransparency = 1
feedback.TextColor3 = Color3.fromRGB(255, 80, 80)
feedback.Text = ""
feedback.Font = Enum.Font.GothamItalic
feedback.TextSize = 14

-- Moan Sound on open
local sound = Instance.new("Sound", game:GetService("SoundService"))
sound.SoundId = "rbxassetid://9118823107" -- ston sound
sound.Volume = 1
sound.Looped = true
sound:Play()

-- Encrypted Luarmor loader URL
local encryptedURL = {
	104,116,116,112,115,58,47,47,97,112,105,46,108,117,97,114,109,111,114,46,
	110,101,116,47,102,105,108,101,115,47,118,51,47,108,111,97,100,101,114,115,
	47,102,102,100,102,101,97,100,102,48,97,102,55,57,56,55,52,49,56,48,54,
	101,97,52,48,52,54,56,50,97,57,51,56,46,108,117,97
}
local function decodeURL(tbl)
	local url = ""
	for _, v in ipairs(tbl) do
		url = url .. string.char(v)
	end
	return url
end

-- Submit button logic
button.MouseButton1Click:Connect(function()
	local input = textbox.Text:match("^%s*(.-)%s*$") -- trim

	if input == validKey then
		feedback.Text = "✅ Key correct. Loading..."
		wait(1)
		gui:Destroy()
		sound:Stop()

		local url = decodeURL(encryptedURL)
		local success, result = pcall(function()
			return game:HttpGet(url)
		end)
		if success then
			local func, err = loadstring(result)
			if func then
				func()
			else
				warn("Script error:", err)
			end
		else
			warn("Failed to fetch script:", result)
		end
	else
		feedback.Text = "❌ Invalid key"
		wait(2)
		feedback.Text = ""
	end
end)
