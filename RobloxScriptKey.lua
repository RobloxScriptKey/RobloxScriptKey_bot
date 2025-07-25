local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Создаем GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "KeyGui"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Enter your key"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24

local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(0.9, 0, 0, 30)
textbox.Position = UDim2.new(0.05, 0, 0, 50)
textbox.PlaceholderText = "Type your key here"
textbox.TextColor3 = Color3.new(1,1,1)
textbox.BackgroundColor3 = Color3.fromRGB(60,60,60)
textbox.Font = Enum.Font.SourceSans
textbox.TextSize = 20

local submitBtn = Instance.new("TextButton", frame)
submitBtn.Size = UDim2.new(0.9, 0, 0, 35)
submitBtn.Position = UDim2.new(0.05, 0, 0, 90)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.SourceSansBold
submitBtn.TextSize = 22
submitBtn.TextColor3 = Color3.new(1,1,1)

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -20)
feedback.BackgroundTransparency = 1
feedback.TextColor3 = Color3.fromRGB(255, 100, 100)
feedback.Font = Enum.Font.SourceSansItalic
feedback.TextSize = 18
feedback.Text = ""

local VALID_KEY = "Lemon"

submitBtn.MouseButton1Click:Connect(function()
	local enteredKey = textbox.Text:gsub("%s+", ""):lower()
	if enteredKey == VALID_KEY:lower() then
		feedback.TextColor3 = Color3.fromRGB(0, 255, 0)
		feedback.Text = "✅ Key correct! Loading script..."
		wait(1)
		screenGui:Destroy()

		-- Попытка загрузить внешний скрипт
		local success, response = pcall(function()
			return game:HttpGet("https://api.luarmor.net/files/v3/loaders/ffdfeadf0af798741806ea404682a938.lua")
		end)

		if success and response then
			local func, err = loadstring(response)
			if func then
				func()
			else
				warn("Error loading script:", err)
			end
		else
			warn("Failed to get script:", response)
		end
	else
		feedback.TextColor3 = Color3.fromRGB(255, 0, 0)
		feedback.Text = "❌ Invalid key. Try again."
		wait(2)
		feedback.Text = ""
	end
end)
