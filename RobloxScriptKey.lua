local validKey = "Lemon"  -- Правильный ключ

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local label = Instance.new("TextLabel", frame)
label.Text = "🔑 Enter key:"
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

-- Encrypted loader URL (Luarmor)
local encryptedURL = {
    114,104,116,116,112,115,58,47,47,97,112,105,46,108,117,97,114,109,111,114,46,110,101,116,
    47,102,105,108,101,115,47,118,51,47,108,111,97,100,101,114,115,47,102,102,100,102,101,97,
    100,102,48,97,102,55,57,56,55,52,49,56,48,54,101,97,52,48,52,54,56,50,97,57,51,56,46,108,
    117,97
}

local function decodeURL(tbl)
    local s = ""
    for _, v in ipairs(tbl) do
        s = s .. string.char(v)
    end
    return s
end

local function isKeyCorrect(input)
    return input:match("^%s*(.-)%s*$") == validKey
end

button.MouseButton1Click:Connect(function()
    local input = box.Text
    print("Input entered by user:", input)  -- Отладочная информация

    if isKeyCorrect(input) then
        feedback.Text = ""
        gui:Destroy()

        local url = decodeURL(encryptedURL)
        print("✅ Loading script from:", url)

        -- Попробуем получить скрипт и проверить на ошибки
        local success, scriptCode = pcall(function()
            return game:HttpGet(url)
        end)

        if success and scriptCode then
            print("Script loaded successfully!")  -- Отладочная информация
            local func, err = loadstring(scriptCode)
            if func then
                print("Executing script...")
                func()
            else
                warn("Failed to compile script:", err)
                feedback.Text = "❌ Script compile error"
            end
        else
            warn("Failed to get script from url:", scriptCode)
            feedback.Text = "❌ Failed to load script"
        end
    else
        feedback.Text = "❌ Invalid Key"
        wait(2)
        feedback.Text = ""
        box.Text = ""
    end
end)
