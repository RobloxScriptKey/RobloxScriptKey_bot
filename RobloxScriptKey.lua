-- RobloxScriptKey – Local Key System with simple "encryption" by sum of chars
local HttpService = game:GetService("HttpService")

-- Функция для подсчёта суммы ASCII кодов символов
local function encodeKey(str)
    local sum = 0
    for i = 1, #str do
        sum = sum + string.byte(str:sub(i, i))
    end
    return sum
end

-- "Зашифрованный" ключ — сумма символов слова "Lemon"
local correctKeySum = 522

-- GUI Setup
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local label = Instance.new("TextLabel", frame)
label.Text = "🔑 Please enter your key:"
label.Size = UDim2.new(1, 0, 0, 30)
label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 20

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Enter your key here"
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

-- Скрипт, который нужно запустить после проверки ключа
local function runScript()
    print("✅ Correct key! Script is running now.")
    -- Здесь можно загрузить и выполнить основной скрипт:
    -- loadstring(game:HttpGet("YOUR_SCRIPT_URL"))()
end

-- Обработка нажатия кнопки
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- trim пробелы

    if encodeKey(input) == correctKeySum then
        gui:Destroy()
        runScript()
    else
        button.Text = "❌ Invalid Key"
        wait(1)
        button.Text = "✅ Submit"
    end
end)
