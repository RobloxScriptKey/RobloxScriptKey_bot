-- GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 200)
frame.Position = UDim2.new(0.5, -175, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Visible = true

local label = Instance.new("TextLabel", frame)
label.Text = "🔑 Enter your Lemon key:"
label.Size = UDim2.new(1, 0, 0, 30)
label.Position = UDim2.new(0, 0, 0, 10)
label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 20

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your key"
box.Size = UDim2.new(0.9, 0, 0, 30)
box.Position = UDim2.new(0.05, 0, 0, 50)
box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Font = Enum.Font.SourceSans
box.TextSize = 18
box.ClearTextOnFocus = false

local buttonSubmit = Instance.new("TextButton", frame)
buttonSubmit.Text = "✅ Submit"
buttonSubmit.Size = UDim2.new(0.9, 0, 0, 30)
buttonSubmit.Position = UDim2.new(0.05, 0, 0, 90)
buttonSubmit.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
buttonSubmit.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonSubmit.Font = Enum.Font.SourceSansBold
buttonSubmit.TextSize = 18

local buttonGetKey = Instance.new("TextButton", frame)
buttonGetKey.Text = "🔗 Get Key"
buttonGetKey.Size = UDim2.new(0.9, 0, 0, 30)
buttonGetKey.Position = UDim2.new(0.05, 0, 0, 130)
buttonGetKey.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
buttonGetKey.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonGetKey.Font = Enum.Font.SourceSansBold
buttonGetKey.TextSize = 18

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 25)
feedback.Position = UDim2.new(0, 0, 1, -25)
feedback.TextColor3 = Color3.fromRGB(255, 255, 255)
feedback.BackgroundTransparency = 0.5
feedback.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
feedback.Text = ""
feedback.Font = Enum.Font.SourceSansItalic
feedback.TextSize = 16
feedback.TextStrokeTransparency = 0.8

-- Sounds
local soundSuccess = Instance.new("Sound", frame)
soundSuccess.SoundId = "rbxassetid://9118820942" -- пример звука 'Yea'
soundSuccess.Volume = 0.5

local soundFail = Instance.new("Sound", frame)
soundFail.SoundId = "rbxassetid://138186576" -- пример звука 'Error beep'
soundFail.Volume = 0.5

-- Key setup
local validKey = "Lemon"

-- Submit button logic
buttonSubmit.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- trim spaces
    if input == validKey then
        feedback.TextColor3 = Color3.fromRGB(0, 255, 0)
        feedback.Text = "✅ Success! Key accepted."
        soundSuccess:Play()
        wait(2)
        gui:Destroy()
        -- Здесь можно добавить запуск основного скрипта
    else
        feedback.TextColor3 = Color3.fromRGB(255, 0, 0)
        feedback.Text = "❌ Invalid Key."
        soundFail:Play()
        wait(2)
        feedback.Text = ""
    end
end)

-- Get Key button logic (copy link)
buttonGetKey.MouseButton1Click:Connect(function()
    setclipboard("https://linkget.ru/jEri")
    feedback.TextColor3 = Color3.fromRGB(255, 255, 0)
    feedback.Text = "🔗 Link copied to clipboard!"
    wait(2)
    feedback.Text = ""
end)
