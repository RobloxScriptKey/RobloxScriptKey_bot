local HttpService = game:GetService("HttpService")

-- Encrypted key (Base64 of "Lemon")
local encodedKey = "TGVtb24="

-- GUI
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "KeySystem"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "🔑 Enter your key:"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
label.Font = Enum.Font.SourceSansBold
label.TextSize = 20

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.9, 0, 0, 30)
box.Position = UDim2.new(0.05, 0, 0, 40)
box.PlaceholderText = "Type your key"
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
box.Font = Enum.Font.SourceSans
box.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9, 0, 0, 30)
button.Position = UDim2.new(0.05, 0, 0, 80)
button.Text = "✅ Submit"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18

-- Decode loader URL (Luarmor)
local encryptedURL = {114,104,116,116,112,115,58,47,47,97,112,105,46,108,117,97,114,109,111,114,46,110,101,116,47,102,105,108,101,115,47,118,51,47,108,111,97,100,101,114,115,47,102,102,100,102,101,97,100,102,48,97,102,55,57,56,55,52,49,56,48,54,101,97,52,48,52,54,56,50,97,57,51,56,46,108,117,97}
local function decodeURL(t)
    local s = ""
    for _, v in ipairs(t) do
        s = s .. string.char(v)
    end
    return s
end

-- Logic
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$")  -- trim
    local realKey = HttpService:Base64Decode(encodedKey)

    if input == realKey then
        gui:Destroy()
        loadstring(game:HttpGet(decodeURL(encryptedURL)))()
    else
        button.Text = "❌ Invalid Key"
        wait(1)
        button.Text = "✅ Submit"
    end
end)
