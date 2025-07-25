-- 🤡 RobloxScriptKey – Clown Key System with hidden key + encrypted Luarmor loader

-- Key encoded as ASCII numbers
local keyData = {76, 101, 109, 111, 110} -- "Lemon"
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
gui.Name = "ClownKeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 360, 0, 200)
frame.Position = UDim2.new(0.5, -180, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(255, 204, 0)
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)

local label = Instance.new("TextLabel", frame)
label.Text = "🎪 Enter the magic clown key:"
label.Size = UDim2.new(1, 0, 0, 40)
label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
label.TextColor3 = Color3.fromRGB(0, 0, 255)
label.Font = Enum.Font.Arcade
label.TextSize = 22

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "🤡 Type your key here"
box.Size = UDim2.new(0.9, 0, 0, 35)
box.Position = UDim2.new(0.05, 0, 0, 50)
box.BackgroundColor3 = Color3.fromRGB(255, 230, 230)
box.TextColor3 = Color3.fromRGB(0, 0, 0)
box.Font = Enum.Font.SciFi
box.TextSize = 20

local button = Instance.new("TextButton", frame)
button.Text = "🎉 Let Me In!"
button.Size = UDim2.new(0.9, 0, 0, 35)
button.Position = UDim2.new(0.05, 0, 0, 95)
button.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
button.TextColor3 = Color3.fromRGB(0, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 22

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -20)
feedback.BackgroundTransparency = 1
feedback.TextColor3 = Color3.fromRGB(255, 0, 0)
feedback.Font = Enum.Font.SourceSansItalic
feedback.TextSize = 16
feedback.Text = ""

-- 🔒 Encrypted loader URL (Luarmor)
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
    local input = box.Text:match("^%s*(.-)%s*$") -- trim spaces

    if input == validKey then
        feedback.Text = "🎊 Correct key! Launching..."
        wait(1)
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
        feedback.Text = "❌ Wrong key, clown!"
        wait(2)
        feedback.Text = ""
        box.Text = ""
    end
end)
