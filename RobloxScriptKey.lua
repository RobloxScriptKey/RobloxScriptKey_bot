-- RobloxScriptKey – Key system with animated clown, sound, and fade effect

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Скрытый ключ "Lemon"
local keyData = {76, 101, 109, 111, 110}
local function decodeKey(tbl)
	local str = ""
	for _, v in ipairs(tbl) do
		str = str .. string.char(v)
	end
	return str
end
local validKey = decodeKey(keyData)

-- GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

local label = Instance.new("TextLabel", frame)
label.Text = "🤡 Enter the clown key:"
label.Size = UDim2.new(1, 0, 0, 30)
label.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.FredokaOne
label.TextSize = 22

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type it here..."
box.Size = UDim2.new(0.9, 0, 0, 30)
box.Position = UDim2.new(0.05, 0, 0, 40)
box.BackgroundColor3 = Color3.fromRGB(255, 230, 80)
box.TextColor3 = Color3.fromRGB(0, 0, 0)
box.Font = Enum.Font.GothamBlack
box.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Text = "🎪 Enter"
button.Size = UDim2.new(0.9, 0, 0, 30)
button.Position = UDim2.new(0.05, 0, 0, 85)
button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Arcade
button.TextSize = 20

-- Encrypted loader URL
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

-- Создание клоуна
local function spawnClown(position)
	local model = Instance.new("Model", workspace)
	model.Name = "Clown"

	local function makePart(name, size, pos, color)
		local part = Instance.new("Part")
		part.Name = name
		part.Size = size
		part.Position = pos
		part.Anchored = true
		part.CanCollide = false
		part.BrickColor = BrickColor.new(color)
		part.Parent = model
		return part
	end

	local root = makePart("Torso", Vector3.new(2, 2, 1), position + Vector3.new(0, 3, 0), "Bright yellow")
	local head = makePart("Head", Vector3.new(2, 1, 1), root.Position + Vector3.new(0, 1.5, 0), "Bright red")
	local leg1 = makePart("Leg1", Vector3.new(1, 2, 1), root.Position + Vector3.new(-0.5, -2, 0), "Bright blue")
	local leg2 = makePart("Leg2", Vector3.new(1, 2, 1), root.Position + Vector3.new(0.5, -2, 0), "Bright green")
	local arm1 = makePart("Arm1", Vector3.new(1, 2, 1), root.Position + Vector3.new(-1.5, 0.5, 0), "Bright orange")
	local arm2 = makePart("Arm2", Vector3.new(1, 2, 1), root.Position + Vector3.new(1.5, 0.5, 0), "Bright violet")

	-- Шляпа
	local hat = makePart("Hat", Vector3.new(2, 0.3, 2), head.Position + Vector3.new(0, 0.8, 0), "Really black")

	-- Звук смеха
	local laugh = Instance.new("Sound", head)
	laugh.SoundId = "rbxassetid://9118823104" -- клоунский смех
	laugh.Volume = 2
	laugh:Play()

	-- Анимация исчезновения
	delay(5, function()
		for _, part in ipairs(model:GetChildren()) do
			if part:IsA("BasePart") then
				TweenService:Create(part, TweenInfo.new(2), {Transparency = 1}):Play()
			end
		end
		wait(2.5)
		model:Destroy()
	end)

	return model
end

-- Логика
button.MouseButton1Click:Connect(function()
	local input = box.Text:match("^%s*(.-)%s*$")
	if input == validKey then
		gui:Destroy()

		local pos = character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position or Vector3.new(0, 5, 0)
		spawnClown(pos + Vector3.new(5, 0, 0))

		wait(4)

		local url = decodeURL(encryptedURL)
		loadstring(game:HttpGet(url))()
	else
		button.Text = "🤡 Wrong Key!"
		wait(2)
		button.Text = "🎪 Enter"
	end
end)
