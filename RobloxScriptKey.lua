--// 🤡 Public Key System by RobloxScriptKey
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Зашифрованный ключ "Lemon"
local encrypted = {109, 102, 128, 132, 124}
local function decode(tbl)
	local s = ""
	for i, v in ipairs(tbl) do
		s = s .. string.char((v ~ i) - 5)
	end
	return s
end
local key = decode(encrypted)

-- Clown-style GUI 🎪
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "ClownKeyGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(255, 204, 0)
frame.BorderSizePixel = 8
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🎪 Welcome Clown!"
title.TextColor3 = Color3.fromRGB(0, 0, 255)
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.Arcade
title.TextSize = 28

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.9, 0, 0, 35)
box.Position = UDim2.new(0.05, 0, 0, 55)
box.PlaceholderText = "🤡 Type the magic word"
box.BackgroundColor3 = Color3.fromRGB(255, 230, 230)
box.TextColor3 = Color3.fromRGB(0, 0, 0)
box.Font = Enum.Font.SciFi
box.TextSize = 20

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9, 0, 0, 35)
button.Position = UDim2.new(0.05, 0, 0, 100)
button.Text = "🎉 Let me in!"
button.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 22

local msg = Instance.new("TextLabel", frame)
msg.Size = UDim2.new(1, 0, 0, 20)
msg.Position = UDim2.new(0, 0, 1, -20)
msg.BackgroundTransparency = 1
msg.TextColor3 = Color3.fromRGB(255, 0, 0)
msg.Font = Enum.Font.SourceSansItalic
msg.TextSize = 16
msg.Text = ""

-- GitHub script
local githubURL = "https://raw.githubusercontent.com/RobloxScriptKey/RobloxScriptKey/main/script.lua"

button.MouseButton1Click:Connect(function()
	local input = box.Text:match("^%s*(.-)%s*$")
	if input == key then
		msg.Text = "🎊 Correct! Launching..."
		gui:Destroy()
		local success, response = pcall(function()
			return game:HttpGet(githubURL)
		end)
		if success then
			local func, err = loadstring(response)
			if func then func() else warn("❌ Script error:", err) end
		else
			warn("❌ Failed to load:", response)
		end
	else
		msg.Text = "❌ Wrong key, silly clown!"
		wait(2)
		msg.Text = ""
		box.Text = ""
	end
end)
