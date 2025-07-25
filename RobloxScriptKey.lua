--// RobloxScriptKey - Encrypted Key GUI + GitHub Loader

-- Зашифрованный ключ: "Lemon"
local encodedKey = {109, 102, 128, 132, 124}

local function decodeKey(tbl)
    local result = ""
    for i, v in ipairs(tbl) do
        local c = ((v ~ i) - 5)
        result = result .. string.char(c)
    end
    return result
end

local validKey = decodeKey(encodedKey)

-- GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "RobloxScriptKeyGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local label = Instance.new("TextLabel", frame)
label.Text = "🔑 Enter your key:"
label.Size = UDim2.new(1, 0, 0, 30)
label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 20

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your key"
box.Size = UDim2.new(0.9, 0, 0, 30)
box.Position = UDim2.new(0.05, 0, 0, 40)
box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Font = Enum.Font.SourceSans
box.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Text = "✅ Submit"
button.Size = UDim2.new(0.9, 0, 0, 30)
button.Position = UDim2.new(0.05, 0, 0, 80)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -20)
feedback.TextColor3 = Color3.fromRGB(255, 80, 80)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.SourceSansItalic
feedback.TextSize = 16

-- GitHub Loader (замени на свой URL)
local githubURL = "https://raw.githubusercontent.com/RobloxScriptKey/RobloxScriptKey/main/script.lua"

button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$")

    if input == validKey then
        feedback.Text = ""
        gui:Destroy()

        local success, result = pcall(function()
            return game:HttpGet(githubURL)
        end)

        if success then
            local func, err = loadstring(result)
            if func then
                func()
            else
                warn("❌ Error loading script:", err)
            end
        else
            warn("❌ Failed to get script:", result)
        end
    else
        feedback.Text = "❌ Invalid Key"
        wait(2)
        feedback.Text = ""
        box.Text = ""
    end
end)
