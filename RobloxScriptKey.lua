-- Ключ, зашифрованный ASCII
local keyData = {76, 101, 109, 111, 110} -- "Lemon"

local function decodeKey(tbl)
    local s = ""
    for _, v in ipairs(tbl) do
        s = s .. string.char(v)
    end
    return s
end

local validKey = decodeKey(keyData)

-- Создаём GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(50, 20, 70)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)

local label = Instance.new("TextLabel", frame)
label.Text = "🍋 Enter your key"
label.Size = UDim2.new(1, 0, 0, 30)
label.BackgroundColor3 = Color3.fromRGB(100, 40, 140)
label.TextColor3 = Color3.fromRGB(255, 255, 0)
label.Font = Enum.Font.GothamBold
label.TextSize = 22

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Enter the key you got from Telegram bot at http://t.me/RobloxScriptKey_bot"
box.Size = UDim2.new(0.9, 0, 0, 40)
box.Position = UDim2.new(0.05, 0, 0, 40)
box.BackgroundColor3 = Color3.fromRGB(230, 230, 80)
box.TextColor3 = Color3.fromRGB(40, 10, 70)
box.Font = Enum.Font.Gotham
box.TextSize = 18
box.ClearTextOnFocus = false

local button = Instance.new("TextButton", frame)
button.Text = "✅ Submit"
button.Size = UDim2.new(0.9, 0, 0, 40)
button.Position = UDim2.new(0.05, 0, 0, 90)
button.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.AutoButtonColor = true

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 30)
feedback.Position = UDim2.new(0, 0, 1, -30)
feedback.TextColor3 = Color3.fromRGB(255, 70, 70)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.Font = Enum.Font.GothamItalic
feedback.TextSize = 16

-- URL для Luarmor loader (зашифрован)
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

-- Функция создания 3D лимона
local function createLemon(position)
    local lemonModel = Instance.new("Model")
    lemonModel.Name = "Lemon"

    -- Желтый овал (основа лимона)
    local lemonBody = Instance.new("Part")
    lemonBody.Size = Vector3.new(2, 3, 1)
    lemonBody.Shape = Enum.PartType.Ball
    lemonBody.Color = Color3.fromRGB(255, 255, 100)
    lemonBody.Material = Enum.Material.SmoothPlastic
    lemonBody.Anchored = true
    lemonBody.CanCollide = false
    lemonBody.Position = position
    lemonBody.Parent = lemonModel

    -- Листочек сверху
    local leaf = Instance.new("Part")
    leaf.Size = Vector3.new(0.5, 0.1, 1)
    leaf.Shape = Enum.PartType.Block
    leaf.Color = Color3.fromRGB(30, 150, 30)
    leaf.Material = Enum.Material.SmoothPlastic
    leaf.Anchored = true
    leaf.CanCollide = false
    leaf.CFrame = CFrame.new(position + Vector3.new(0, 1.5, 0)) * CFrame.Angles(0, math.rad(45), 0)
    leaf.Parent = lemonModel

    lemonModel.Parent = workspace
    return lemonModel, lemonBody
end

-- Анимация вращения и подпрыгивания
local function animateLemon(part)
    local runService = game:GetService("RunService")
    local startTime = tick()
    local initialPos = part.Position

    local connection
    connection = runService.Heartbeat:Connect(function()
        local elapsed = tick() - startTime

        -- Вращение вокруг оси Y
        part.CFrame = CFrame.new(initialPos) * CFrame.Angles(0, elapsed * math.rad(90), 0)

        -- Плавное подпрыгивание
        local bounce = math.sin(elapsed * 3) * 0.2
        part.Position = initialPos + Vector3.new(0, bounce, 0)
    end)
    return connection
end

-- Основная логика кнопки
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- trim

    if input == validKey then
        feedback.Text = ""
        gui:Destroy()

        -- Создаём лимон перед игроком
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")

        local lemonPos = rootPart.Position + rootPart.CFrame.LookVector * 5 + Vector3.new(0, 3, 0)
        local lemonModel, lemonBody = createLemon(lemonPos)

        -- Запускаем анимацию лимона
        local animConnection = animateLemon(lemonBody)

        -- Через 10 секунд останавливаем анимацию и удаляем лимон с плавным затуханием
        delay(10, function()
            animConnection:Disconnect()
            for i = 1, 20 do
                lemonBody.Transparency = i / 20
                wait(0.05)
            end
            lemonModel:Destroy()
        end)

        -- Загружаем Luarmor loader
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
