-- RobloxScriptKey – Key system with hidden numeric key + encrypted Luarmor loader

-- Encrypted key ("Lemon")
local keyData = {76, 101, 109, 111, 110}
local function decodeKey(tbl)
    local result = ""
    for _, v in ipairs(tbl) do
        result = result .. string.char(v)
    end
    return result
end
local validKey = decodeKey(keyData)

-- Create GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "LemonKeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 170)
frame.Position = UDim2.new(0.5, -160, 0.5, -85)
frame.BackgroundColor3 = Color3.fromRGB(255, 233, 127)
frame.BorderSizePixel = 0

local label = Instance.new("TextLabel", frame)
label.Text = "🍋 Enter the key you got from Telegram bot:\nhttps://t.me/RobloxScriptKey_bot"
label.Size = UDim2.new(1, 0, 0, 50)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(50, 50, 50)
label.TextWrapped = true
label.Font = Enum.Font.FredokaOne
label.TextSize = 16

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your Lemon key"
box.Size = UDim2.new(0.9, 0, 0, 35)
box.Position = UDim2.new(0.05, 0, 0, 60)
box.BackgroundColor3 = Color3.fromRGB(255, 245, 160)
box.TextColor3 = Color3.fromRGB(30, 30, 30)
box.Font = Enum.Font.Gotham
box.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Text = "🍋 Submit"
button.Size = UDim2.new(0.9, 0, 0, 35)
button.Position = UDim2.new(0.05, 0, 0, 105)
button.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
button.TextColor3 = Color3.fromRGB(20, 20, 20)
button.Font = Enum.Font.GothamBold
button.TextSize = 18

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -20)
feedback.TextColor3 = Color3.fromRGB(255, 60, 60)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.Gotham
feedback.TextSize = 14

-- Encrypted Luarmor URL
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

-- Submit handler
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- trim
    if input == validKey then
        feedback.Text = ""
        gui:Destroy()

        -- Load and run the Luarmor script
        local url = decodeURL(encryptedURL)
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)

        if success then
            local func, err = loadstring(result)
            if func then
                func()
            else
                warn("❌ Script compile error:", err)
            end
        else
            warn("❌ Failed to load script:", result)
        end
    else
        feedback.Text = "❌ Invalid Key"
        wait(2)
        feedback.Text = ""
    end
end)
