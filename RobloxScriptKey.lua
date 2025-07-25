-- RobloxScriptKey – Secure Key Input UI with Sound + Script Loader

-- Key stored as ASCII codes
local keyData = {76, 101, 109, 111, 110}
local function decodeKey(tbl)
	local result = ""
	for _, v in ipairs(tbl) do
		result = result .. string.char(v)
	end
	return result
end
local validKey = decodeKey(keyData)

-- Luarmor encrypted loader URL
local encodedURL = {
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

-- GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, -160, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🍋 Enter your key to continue"
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.BorderSizePixel = 0

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.9, 0, 0, 35)
input.Position = UDim2.new(0.05, 0, 0, 60)
input.PlaceholderText = "Enter key from bot"
input.Font = Enum.Font.SourceSans
input.TextSize = 18
input.Text = ""
input.TextColor3 = Color3.new(1, 1, 1)
input.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9, 0, 0, 35)
button.Position = UDim2.new(0.05, 0, 0, 105)
button.Text = "✅ Submit"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 1, -25)
status.BackgroundTransparency = 1
status.Text = ""
status.Font = Enum.Font.SourceSansItalic
status.TextSize = 16
status.TextColor3 = Color3.fromRGB(255, 80, 80)

-- Sound on success
local successSound = Instance.new("Sound", frame)
successSound.SoundId = "rbxassetid://9118823102"
successSound.Volume = 1

-- Submit logic
button.MouseButton1Click:Connect(function()
	local userInput = input.Text:match("^%s*(.-)%s*$")
	if userInput == validKey then
		status.TextColor3 = Color3.fromRGB(0, 255, 0)
		status.Text = "✅ Success! Key accepted."
		successSound:Play()
		wait(2)
		gui:Destroy()
		local scriptURL = decodeURL(encodedURL)
		loadstring(game:HttpGet(scriptURL))()
	else
		status.TextColor3 = Color3.fromRGB(255, 80, 80)
		status.Text = "❌ Invalid Key!"
		wait(2)
		status.Text = ""
	end
end)
