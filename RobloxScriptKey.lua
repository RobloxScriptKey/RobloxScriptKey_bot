-- 🤡 RobloxScriptKey – Animated Clown Key GUI with Encrypted Loader

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Encrypted key (Lemon)
local keyData = {76, 101, 109, 111, 110}
local function decodeKey(tbl)
    local result = ""
    for _, v in ipairs(tbl) do
        result = result .. string.char(v)
    end
    return result
end
local validKey = decodeKey(keyData)

-- Encrypted Luarmor URL
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

-- GUI Setup
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "KeySystem"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(255, 235, 59)
frame.BorderSizePixel = 6
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Parent = gui

-- Clown image
local clown = Instance.new("ImageLabel")
clown.Size = UDim2.new(0, 150, 0, 150)
clown.Position = UDim2.new(0.5, -75, 0, 10)
clown.BackgroundTransparency = 1
clown.Image = "rbxassetid://14073080557" -- Funny clown image
clown.Parent = frame

-- Animate clown
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local tween = TweenService:Create(clown, tweenInfo, {Position = clown.Position + UDim2.new(0, 0, 0, 10)})
tween:Play()

-- Input box
local box = Instance.new("TextBox")
box.Size = UDim2.new(0.8, 0, 0, 35)
box.Position = UDim2.new(0.1, 0, 0, 170)
box.PlaceholderText = "Enter the clown key 🎈"
box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
box.TextColor3 = Color3.fromRGB(0, 0, 0)
box.TextSize = 18
box.Font = Enum.Font.Gotham
box.Parent = frame

-- Submit button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0, 35)
button.Position = UDim2.new(0.1, 0, 0, 215)
button.Text = "🎪 Unlock Show!"
button.BackgroundColor3 = Color3.fromRGB(0, 200, 83)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 20
button.Font = Enum.Font.GothamBold
button.Parent = frame

-- Feedback label
local feedback = Instance.new("TextLabel")
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 1, -22)
feedback.TextColor3 = Color3.fromRGB(255, 0, 0)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.TextSize = 16
feedback.Font = Enum.Font.SourceSansItalic
feedback.Parent = frame

-- Logic
button.MouseButton1Click:Connect(function()
    local input = box.Text:match("^%s*(.-)%s*$")
    if input == validKey then
        feedback.Text = "🎉 Welcome to the circus!"
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
                warn("Script error:", err)
            end
        else
            warn("Load error:", result)
        end
    else
        feedback.Text = "🤡 Wrong key, try again!"
        -- shake effect
        for i = 1, 3 do
            frame.Position = frame.Position + UDim2.new(0, 10, 0, 0)
            wait(0.05)
            frame.Position = frame.Position - UDim2.new(0, 20, 0, 0)
            wait(0.05)
            frame.Position = frame.Position + UDim2.new(0, 10, 0, 0)
        end
        feedback.Text = ""
    end
end)
