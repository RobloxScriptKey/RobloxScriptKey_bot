-- RobloxScriptKey 🍋 Lemon GUI with encrypted key + loader
local keyData = {76, 101, 109, 111, 110} -- ASCII for "Lemon"

local function decodeKey(tbl)
	local result = ""
	for _, v in ipairs(tbl) do
		result = result .. string.char(v)
	end
	return result
end

local validKey = decodeKey(keyData)

-- 🍋 GUI Elements
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "LemonKeyGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 160)
frame.Position = UDim2.new(0.5, -160, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(255, 244, 79)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🍋 Enter the Lemon Key:"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(60, 50, 20)
title.BackgroundColor3 = Color3.fromRGB(255, 233, 50)

local input = Instance.new("TextBox", frame)
input.PlaceholderText = "Type your 🍋 key"
input.Size = UDim2.new(0.9, 0, 0, 30)
input.Position = UDim2.new(0.05, 0, 0, 45)
input.BackgroundColor3 = Color3.fromRGB(255, 250, 170)
input.TextColor3 = Color3.fromRGB(50, 40, 20)
input.Font = Enum.Font.Gotham
input.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Text = "🍋 Submit"
button.Size = UDim2.new(0.9, 0, 0, 30)
button.Position = UDim2.new(0.05, 0, 0, 90)
button.BackgroundColor3 = Color3.fromRGB(255, 209, 0)
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 18

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -20)
feedback.TextColor3 = Color3.fromRGB(200, 50, 50)
feedback.BackgroundTransparency = 1
feedback.Font = Enum.Font.GothamItalic
feedback.Text = ""
feedback.TextSize = 16

-- 🍋 Encrypted Luarmor Loader
local encryptedURL = {
    104,116,116,112,115,58,47,47,97,112,105,46,108,117,97,114,109,111,114,46,110,101,116,
    47,102,105,108,101,115,47,118,51,47,108,111,97,100,101,114,115,47,
    102,102,100,102,101,97,100,102,48,97,102,55,57,56,55,52,49,56,48,54,101,97,
    52,48,52,54,56,50,97,57,51,56,46,108,117,97
}

local function decodeURL(tbl)
	local s = ""
	for _, v in ipairs(tbl) do
		s = s .. string.char(v)
	end
	return s
end

-- 🍋 Key Logic
button.MouseButton1Click:Connect(function()
	local inputKey = input.Text:match("^%s*(.-)%s*$") -- trim spaces

	if inputKey == validKey then
		feedback.Text = ""
		gui:Destroy()

		local url = decodeURL(encryptedURL)
		print("🍋 Loading script from:", url)

		local success, result = pcall(function()
			return game:HttpGet(url)
		end)

		if success then
			local func, err = loadstring(result)
			if func then
				func()
			else
				warn("❌ Script Error:", err)
			end
		else
			warn("❌ Failed to load script:", result)
		end
	else
		feedback.Text = "❌ Invalid Lemon Key"
		wait(2)
		feedback.Text = ""
	end
end)
