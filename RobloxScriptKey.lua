-- Ключ в виде чисел (Lemon)
local keyData = {76, 101, 109, 111, 110}
local function decodeKey(tbl)
    local result = ""
    for _, v in ipairs(tbl) do
        result = result .. string.char(v)
    end
    return result
end
local validKey = decodeKey(keyData)

-- GUI ввод ключа
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 180)
frame.Position = UDim2.new(0.5, -175, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)

local label = Instance.new("TextLabel", frame)
label.Text = "🤡 Enter clown key:"
label.Size = UDim2.new(1, 0, 0, 40)
label.BackgroundColor3 = Color3.fromRGB(55, 0, 0)
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.Fantasy
label.TextSize = 26
label.TextStrokeTransparency = 0.7

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Type your clown key here"
box.Size = UDim2.new(0.9, 0, 0, 40)
box.Position = UDim2.new(0.05, 0, 0, 50)
box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
box.TextColor3 = Color3.new(1,1,1)
box.Font = Enum.Font.SourceSans
box.TextSize = 22
box.ClearTextOnFocus = false

local button = Instance.new("TextButton", frame)
button.Text = "🎪 Submit"
button.Size = UDim2.new(0.9, 0, 0, 40)
button.Position = UDim2.new(0.05, 0, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.Fantasy
button.TextSize = 24

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 30)
feedback.Position = UDim2.new(0, 0, 1, -30)
feedback.BackgroundTransparency = 1
feedback.TextColor3 = Color3.fromRGB(255, 100, 100)
feedback.Font = Enum.Font.SourceSansItalic
feedback.TextSize = 18
feedback.Text = ""

-- Функция создания клоуна с анимацией танца
local function spawnDancingClown(position, onDanceEnd)
    local clown = Instance.new("Model")
    clown.Name = "ClownNPC"
    
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(2, 1, 1)
    head.Position = position + Vector3.new(0, 3.5, 0)
    head.BrickColor = BrickColor.new("Bright red")
    head.Parent = clown
    
    local face = Instance.new("Decal", head)
    face.Texture = "http://www.roblox.com/asset/?id=11225325857" -- Клоунское лицо (замени если хочешь)
    face.Face = Enum.NormalId.Front
    
    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2, 1)
    torso.Position = position + Vector3.new(0, 2, 0)
    torso.BrickColor = BrickColor.new("Bright yellow")
    torso.Parent = clown
    
    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = clown
    
    local rootPart = Instance.new("Part")
    rootPart.Name = "HumanoidRootPart"
    rootPart.Size = Vector3.new(2, 2, 1)
    rootPart.Position = position + Vector3.new(0, 1, 0)
    rootPart.Transparency = 1
    rootPart.Parent = clown
    
    clown.PrimaryPart = rootPart
    clown.Parent = workspace

    -- Создаём аниматор и загружаем стандартную анимацию танца (ID: 507768133)
    local animator = Instance.new("Animator")
    animator.Parent = humanoid
    local danceAnimation = Instance.new("Animation")
    danceAnimation.AnimationId = "rbxassetid://507768133" -- Стандартный танец
    local danceTrack = animator:LoadAnimation(danceAnimation)
    
    -- Воспроизводим анимацию танца
    danceTrack:Play()
    
    -- Добавляем звук смеха
    local laughSound = Instance.new("Sound", rootPart)
    laughSound.SoundId = "rbxassetid://911882213" -- Клоунский смех
    laughSound.Volume = 0.7
    laughSound:Play()
    
    -- По окончанию танца (примерно 10 сек), исчезаем и вызываем callback
    delay(10, function()
        danceTrack:Stop()
        clown:Destroy()
        if onDanceEnd then
            onDanceEnd()
        end
    end)
end

-- Логика кнопки Submit
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- Убираем пробелы
    
    if input == validKey then
        feedback.Text = ""
        gui:Destroy()
        
        -- Появляем клоуна прямо перед игроком
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local spawnPos = rootPart.Position + rootPart.CFrame.LookVector * 5 + Vector3.new(0,0,0)
        
        spawnDancingClown(spawnPos, function()
            -- После исчезновения клоуна запускаем твой скрипт
            local url = "https://raw.githubusercontent.com/isakiroblox/ISAKITOP/main/ISAKITOP.lua" -- твой гитхаб-скрипт
            local success, result = pcall(function()
                return game:HttpGet(url)
            end)
            if success then
                local func, err = loadstring(result)
                if func then func() else warn("Ошибка скрипта:", err) end
            else
                warn("Не удалось загрузить скрипт:", result)
            end
        end)
    else
        feedback.Text = "❌ Invalid Key"
        wait(2)
        feedback.Text = ""
    end
end)
