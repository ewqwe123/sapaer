local correctKey = "KLHJHKJiueiiu777"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===== ВСПЫШКА =====
local flashGui = Instance.new("ScreenGui", PlayerGui)

local flashFrame = Instance.new("Frame")
flashFrame.Size = UDim2.new(1,0,1,0)
flashFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
flashFrame.AnchorPoint = Vector2.new(0.5,0.5)
flashFrame.Position = UDim2.new(0.5,0,0.5,0)
flashFrame.Parent = flashGui

local flashText = Instance.new("TextLabel")
flashText.Size = UDim2.new(1,0,0,50)
flashText.Position = UDim2.new(0,0,0.5,-25)
flashText.BackgroundTransparency = 1
flashText.TextColor3 = Color3.fromRGB(0,0,0)
flashText.Font = Enum.Font.GothamBold
flashText.TextScaled = true
flashText.Text = ""
flashText.Parent = flashFrame

-- Анимация текста (печатает по 0.1 сек)
local message = "Это сделал Тейлз"
for i = 1, #message do
    flashText.Text = string.sub(message, 1, i)
    wait(0.1)
end

-- Вспышка держится 3 секунды
wait(3)

-- Исчезновение вспышки за 1 секунду
local tween = TweenService:Create(flashFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
tween:Play()
tween.Completed:Wait()
flashGui:Destroy()

-- ===== GUI ВВОДА КЛЮЧА =====
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,20)
corner.Parent = frame

-- Поле ввода
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0, 360, 0, 60)
inputBox.Position = UDim2.new(0,20,0,40)
inputBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
inputBox.TextColor3 = Color3.fromRGB(255,255,255)
inputBox.Font = Enum.Font.Gotham
inputBox.TextScaled = true
inputBox.PlaceholderText = "Введите ключ..."
inputBox.ClearTextOnFocus = false
inputBox.Text = ""
inputBox.Parent = frame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0,15)
inputCorner.Parent = inputBox

-- Кнопка Ввод
local enterBtn = Instance.new("TextButton")
enterBtn.Size = UDim2.new(0, 160,0,50)
enterBtn.Position = UDim2.new(0,20,0,120)
enterBtn.BackgroundColor3 = Color3.fromRGB(70,150,70)
enterBtn.TextColor3 = Color3.fromRGB(255,255,255)
enterBtn.Text = "Ввод"
enterBtn.Font = Enum.Font.GothamBold
enterBtn.TextScaled = true
enterBtn.Parent = frame

local enterCorner = Instance.new("UICorner")
enterCorner.CornerRadius = UDim.new(0,15)
enterCorner.Parent = enterBtn

-- Кнопка Очистить (-)
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 160,0,50)
clearBtn.Position = UDim2.new(0,200,0,120)
clearBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
clearBtn.TextColor3 = Color3.fromRGB(255,255,255)
clearBtn.Text = "Очистить"
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextScaled = true
clearBtn.Parent = frame

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0,15)
clearCorner.Parent = clearBtn

-- Анимация неправильного ключа
local function wrongKeyEffect()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local redTween = TweenService:Create(inputBox, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255,0,0)})
    local normalTween = TweenService:Create(inputBox, tweenInfo, {BackgroundColor3 = Color3.fromRGB(50,50,50)})
    redTween:Play()
    redTween.Completed:Wait()
    wait(0.1)
    normalTween:Play()
    inputBox.Text = ""
end

-- Очистка
clearBtn.MouseButton1Click:Connect(function()
    inputBox.Text = ""
end)

-- Проверка ключа
enterBtn.MouseButton1Click:Connect(function()
    local typedKey = inputBox.Text
    if typedKey == correctKey then
        screenGui:Destroy()
        -- Запуск ESP + FullBright
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wa0101/Roblox-ESP/refs/heads/main/esp.lua",true))()
        game:GetService("Lighting").Ambient = Color3.new(1,1,1)
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").OutdoorAmbient = Color3.new(1,1,1)
    else
        wrongKeyEffect()
    end
end)
