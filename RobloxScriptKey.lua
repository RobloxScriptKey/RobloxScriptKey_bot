-- RobloxScriptKey – Key System with Encrypted Luarmor Loader

-- Шифрованный ключ "Lemon"
local validKey = "Lemon"

-- Encrypted URL
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

-- GUI
local gui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 160)
frame.Position = UDim2.new(0.5, -175, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 128)

local label = Instance.new("TextLabel", frame)
label.Text = "🍋 Enter the key from Telegram: @RobloxScriptKey_bot"
label.Size = UDim2.new(1, 0, 0, 50)
label.Position = UDim2.new(0, 0, 0, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(50, 50, 50)
label.Font = Enum.Font.GothamBold
label.TextSize = 18
label.TextWrapped = true

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your key"
box.Size = UDim2.new(0.9, 0, 0, 30)
box.Position = UDim2.new(0.05, 0, 0, 60)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 200)
box.TextColor3 = Color3.fromRGB(50, 50, 50)
box.Font = Enum.Font.Gotham
box.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Text = "✅ Submit"
button.Size = UDim2.new(0.9, 0, 0, 35)
button.Position = UDim2.new(0.05, 0, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 20

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -25)
feedback.TextColor3 = Color3.fromRGB(200, 0, 0)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.GothamItalic
feedback.TextSize = 16

-- Проверка и запуск
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- remove spaces
    if input == validKey then
        feedback.Text = "✅ Key valid! Loading..."
        local url = decodeURL(encryptedURL)
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        if success then
            local f = loadstring(result)
            if f then
                gui:Destroy()
                f()
            else
                feedback.Text = "❌ Error loading script"
            end
        else
            feedback.Text = "❌ Error fetching script"
        end
    else
        feedback.Text = "❌ Invalid Key"
    end
end)
