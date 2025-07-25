-- RobloxScriptKey – Клоунско-лимонный интерфейс ввода ключа + загрузчик Luarmor

-- Ключ "Lemon" в виде ASCII-кодов (для простоты)
local keyData = {76, 101, 109, 111, 110} -- "Lemon"

local function decodeKey(tbl)
    local result = ""
    for _, v in ipairs(tbl) do
        result = result .. string.char(v)
    end
    return result
end

local validKey = decodeKey(keyData)

-- URL загрузки Luarmor скрипта в ASCII
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

-- Создаем GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 170)
frame.Position = UDim2.new(0.5, -160, 0.5, -85)
frame.BackgroundColor3 = Color3.fromRGB(255, 240, 140) -- лимонный желтый фон
frame.BorderSizePixel = 4
frame.BorderColor3 = Color3.fromRGB(255, 200, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.ClipsDescendants = true
frame.Rotation = 0

-- Анимация лёгкого покачивания (клоунский стиль)
spawn(function()
    while frame.Parent do
        for i = -5, 5, 0.5 do
            frame.Rotation = i
            wait(0.03)
        end
        for i = 5, -5, -0.5 do
            frame.Rotation = i
            wait(0.03)
        end
    end
end)

-- Заголовок с лимончиком
local label = Instance.new("TextLabel", frame)
label.Text = "🍋 Enter your key 🍋"
label.Size = UDim2.new(1, 0, 0, 40)
label.BackgroundColor3 = Color3.fromRGB(255, 230, 120)
label.TextColor3 = Color3.fromRGB(90, 50, 0)
label.Font = Enum.Font.FredokaOne
label.TextSize = 26
label.AnchorPoint = Vector2.new(0.5, 0)
label.Position = UDim2.new(0.5, 0, 0, 0)

-- Инструкция ниже (телега и английский)
local info = Instance.new("TextLabel", frame)
info.Text = "Enter the key you got from Telegram bot:\nhttp://t.me/RobloxScriptKey_bot"
info.Size = UDim2.new(1, -20, 0, 40)
info.Position = UDim2.new(0, 10, 0, 45)
info.BackgroundTransparency = 1
info.TextColor3 = Color3.fromRGB(100, 60, 0)
info.Font = Enum.Font.SourceSansItalic
info.TextSize = 16
info.TextWrapped = true

-- Поле ввода
local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your key here..."
box.Size = UDim2.new(0.9, 0, 0, 40)
box.Position = UDim2.new(0.05, 0, 0, 90)
box.BackgroundColor3 = Color3.fromRGB(255, 250, 180)
box.TextColor3 = Color3.fromRGB(80, 40, 0)
box.Font = Enum.Font.FredokaOne
box.TextSize = 20
box.ClearTextOnFocus = false
box.Text = ""

-- Кнопка Submit
local button = Instance.new("TextButton", frame)
button.Text = "🍋 Submit 🍋"
button.Size = UDim2.new(0.9, 0, 0, 40)
button.Position = UDim2.new(0.05, 0, 0, 135)
button.BackgroundColor3 = Color3.fromRGB(255, 200, 20)
button.TextColor3 = Color3.fromRGB(90, 50, 0)
button.Font = Enum.Font.FredokaOne
button.TextSize = 22
button.AutoButtonColor = true

-- Обратная связь
local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -20)
feedback.TextColor3 = Color3.fromRGB(200, 0, 0)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.SourceSansItalic
feedback.TextSize = 16
feedback.TextWrapped = true
feedback.TextStrokeTransparency = 0.7

-- Функция запуска внешнего скрипта
local function loadExternalScript()
    local url = decodeURL(encryptedURL)
    print("🍋 Loading script from:", url)

    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        local func, err = loadstring(result)
        if func then
            func()
            print("🍋 Script executed successfully!")
        else
            warn("❌ Script compile error:", err)
            feedback.Text = "Script error! Check Output."
        end
    else
        warn("❌ Failed to load script:", result)
        feedback.Text = "Failed to load script! Check Output."
    end
end

-- Обработка кнопки Submit
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- trim spaces

    if input == validKey then
        feedback.Text = ""
        gui:Destroy() -- скрываем интерфейс

        loadExternalScript()
    else
        feedback.Text = "❌ Invalid Key!"
        wait(2)
        feedback.Text = ""
    end
end)
