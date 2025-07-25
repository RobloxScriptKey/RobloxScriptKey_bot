-- RobloxScriptKey – Key system с скрытым Luarmor loader

-- Ключ в ASCII
local keyData = {76, 101, 109, 111, 110} -- "Lemon"
local function decodeKey(tbl)
    local s = ""
    for _, v in ipairs(tbl) do s = s .. string.char(v) end
    return s
end
local validKey = decodeKey(keyData)

-- Ссылка Luarmor в ASCII
local urlData = {
    104,116,116,112,115,58,47,47,97,112,105,46,108,117,97,114,109,111,114,46,110,101,116,
    47,102,105,108,101,115,47,118,51,47,108,111,97,100,101,114,115,47,
    102,102,100,102,101,97,100,102,48,97,102,55,57,56,55,52,49,56,48,54,101,97,
    52,48,52,54,56,50,97,57,51,56,46,108,117,97
}
local function decodeURL(tbl)
    local s = ""
    for _, v in ipairs(tbl) do s = s .. string.char(v) end
    return s
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "KeySystem"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 170)
frame.Position = UDim2.new(0.5, -175, 0.5, -85)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 128) -- лимонный цвет
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(200, 200, 50)
frame.ClipsDescendants = true
frame.AnchorPoint = Vector2.new(0.5, 0.5)

local label = Instance.new("TextLabel", frame)
label.Text = "🍋 Enter your key from Telegram bot: http://t.me/RobloxScriptKey_bot"
label.Size = UDim2.new(1, -20, 0, 50)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(50, 50, 50)
label.Font = Enum.Font.GothamBold
label.TextSize = 18
label.TextWrapped = true

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your key here..."
box.Size = UDim2.new(0.9, 0, 0, 40)
box.Position = UDim2.new(0.05, 0, 0, 70)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 200)
box.TextColor3 = Color3.fromRGB(50, 50, 50)
box.Font = Enum.Font.Gotham
box.TextSize = 20
box.ClearTextOnFocus = false

local button = Instance.new("TextButton", frame)
button.Text = "✅ Submit"
button.Size = UDim2.new(0.9, 0, 0, 40)
button.Position = UDim2.new(0.05, 0, 0, 115)
button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.AutoButtonColor = true
button.Modal = true

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -25)
feedback.TextColor3 = Color3.fromRGB(200, 0, 0)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.GothamItalic
feedback.TextSize = 16

-- Обработчик нажатия
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- trim spaces

    if input == validKey then
        feedback.Text = ""
        gui:Destroy()

        -- Декодируем ссылку
        local url = decodeURL(urlData)

        -- Запускаем загрузку скрипта в pcall и через loadstring
        local success, err = pcall(function()
            local scriptText = game:HttpGet(url)
            local func, loadErr = loadstring(scriptText)
            if not func then
                error("Loadstring error: "..tostring(loadErr))
            end
            func()
        end)

        if not success then
            warn("❌ Failed to load Luarmor script: "..tostring(err))
        else
            print("✅ Luarmor script loaded successfully!")
        end
    else
        feedback.Text = "❌ Invalid Key! Try again."
        wait(2)
        feedback.Text = ""
    end
end)
