local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyInputGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 150)
frame.Position = UDim2.new(0.5, -175, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 20
title.Text = "Enter your key"
title.Parent = frame

local textbox = Instance.new("TextBox")
textbox.Size = UDim2.new(0.9, 0, 0, 30)
textbox.Position = UDim2.new(0.05, 0, 0, 50)
textbox.PlaceholderText = "Type your key here"
textbox.TextColor3 = Color3.fromRGB(255,255,255)
textbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textbox.Font = Enum.Font.Gotham
textbox.TextSize = 18
textbox.Parent = frame

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.9, 0, 0, 35)
submitBtn.Position = UDim2.new(0.05, 0, 0, 90)
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 18
submitBtn.TextColor3 = Color3.fromRGB(255,255,255)
submitBtn.Text = "Submit"
submitBtn.Parent = frame

local feedback = Instance.new("TextLabel")
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -20)
feedback.BackgroundTransparency = 1
feedback.TextColor3 = Color3.fromRGB(255, 80, 80)
feedback.Font = Enum.Font.GothamItalic
feedback.TextSize = 16
feedback.Text = ""
feedback.Parent = frame

-- Добавляем звук стона и запускаем его при открытии GUI
local moanSound = Instance.new("Sound")
moanSound.SoundId = "rbxassetid://9118823107"
moanSound.Volume = 0.7
moanSound.Looped = true
moanSound.Parent = SoundService
moanSound:Play()

local VALID_KEY = "Lemon"

submitBtn.MouseButton1Click:Connect(function()
	local enteredKey = textbox.Text:gsub("%s+", "") -- удаляем пробелы
	if enteredKey == VALID_KEY then
		feedback.TextColor3 = Color3.fromRGB(0, 255, 0)
		feedback.Text = "✅ Key correct! Loading script..."
		
		moanSound:Stop()
		wait(1)
		screenGui:Destroy()
		
		-- Загрузка внешнего скрипта (замени на свой URL если нужно)
		local success, response = pcall(function()
			return game:HttpGet("https://api.luarmor.net/files/v3/loaders/ffdfeadf0af798741806ea404682a938.lua")
		end)
		
		if success and response then
			local func, err = loadstring(response)
			if func then
				func()
			else
				warn("Loadstring error:", err)
			end
		else
			warn("Failed to get script:", response)
		end
	else
		feedback.TextColor3 = Color3.fromRGB(255, 0, 0)
		feedback.Text = "❌ Invalid key, try again."
		wait(2)
		feedback.Text = ""
	end
end)
