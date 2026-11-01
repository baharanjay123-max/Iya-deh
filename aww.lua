-- ============================================================
-- SCRIPT SIMPLE: MUSIK (SEMUA BKB) + FLY (FIX ANALOG)
-- by BRUHH
-- ============================================================

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- ===================== SEMUA DATA LAGU BKB =====================
local Playlists = {
    {
        Name = "BKB / BREAKBEAT",
        Tracks = {
            { SongName = "BLACK HOLE BREAKBEAT", SoundId = "rbxassetid://118362297271903" },
            { SongName = "NU BREAKBEAT", SoundId = "rbxassetid://76497788855136" },
            { SongName = "BREAKBEAT BEAUTIFUL", SoundId = "rbxassetid://124564676675935" },
            { SongName = "BREAKBEAT PURE LOVE", SoundId = "rbxassetid://128392830206161" },
            { SongName = "BREAKBEAT ALWAYS LOVING YOU", SoundId = "rbxassetid://128071048140468" },
            { SongName = "BREAKBEAT RIVER FLOWS IN YOU", SoundId = "rbxassetid://125026658817868" },
            { SongName = "I NEED TO DACTOR", SoundId = "rbxassetid://89433429094554" },
            { SongName = "ROULATE RUSSIAN BKB", SoundId = "rbxassetid://112975242747165" },
            { SongName = "NOBARE YOU BKB", SoundId = "rbxassetid://108695200115706" },
            { SongName = "TAK BISA LAGI MENCINTAIMU BKB", SoundId = "rbxassetid://137798111576173" },
            { SongName = "CHICA LOCA BKB", SoundId = "rbxassetid://82808551264264" },
            { SongName = "AKU SUDAH HAMIL SAYANG BKB", SoundId = "rbxassetid://92817454990794" },
            { SongName = "GEN-Z BKB", SoundId = "rbxassetid://107968763369784" },
            { SongName = "IRAMA BKB", SoundId = "rbxassetid://74394269263180" },
            { SongName = "FOREVER BKB", SoundId = "rbxassetid://116187656749144" },
            { SongName = "JADIKAN LAH DIRIKU YG KE 2 BKB", SoundId = "rbxassetid://96287468808586" },
            { SongName = "AHOYxMATOTO BKB", SoundId = "rbxassetid://125071929480860" },
            { SongName = "KAMU MALU-MALU BKB", SoundId = "rbxassetid://104538666715482" }
        }
    }
}

local flying = false
local bodyVelocity, bodyGyro
local music = Instance.new("Sound", SoundService)
music.Volume = 0.5
local isPlaying = false

-- ===================== GUI UTAMA =====================
local gui = Instance.new("ScreenGui")
gui.Name = "SimpleGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- 1. MENU MUSIK (Disembunyiin dulu)
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 280, 0, 400) -- Sedikit lebih besar biar lega
menu.Position = UDim2.new(0.5, -140, 0.5, -200)
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
menu.Visible = false
menu.Parent = gui

local corner = Instance.new("UICorner", menu)
corner.CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", menu)
stroke.Color = Color3.fromRGB(138, 43, 226)

-- Tombol X (Tutup Menu)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = menu
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() menu.Visible = false end)

-- Daftar Lagu
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.9, 0, 0, 300)
scroll.Position = UDim2.new(0.05, 0, 0, 40)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(186, 85, 211)
scroll.Parent = menu

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 5)

for i, track in ipairs(Playlists[1].Tracks) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
    btn.Text = track.SongName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    btn.MouseButton1Click:Connect(function()
        music.SoundId = track.SoundId
        music:Play()
        isPlaying = true
    end)
end

-- Tombol Stop Musik
local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(0.8, 0, 0, 35)
stopBtn.Position = UDim2.new(0.1, 0, 1, -45)
stopBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
stopBtn.Text = "STOP MUSIK"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextScaled = true
stopBtn.Parent = menu
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 5)
stopBtn.MouseButton1Click:Connect(function()
    music:Stop()
    isPlaying = false
end)

-- 2. TOMBOL BUKA MENU (Kecil di pojok)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 80, 0, 35)
openBtn.Position = UDim2.new(0, 10, 0, 10)
openBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
openBtn.Text = "MENU"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextScaled = true
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 5)
openBtn.MouseButton1Click:Connect(function() menu.Visible = not menu.Visible end)

-- 3. TOMBOL FLY (Melayang di bawah)
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 100, 0, 45)
flyBtn.Position = UDim2.new(0.5, -50, 1, -70)
flyBtn.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
flyBtn.Text = "FLY: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.Font = Enum.Font.GothamBlack
flyBtn.TextScaled = true
flyBtn.Parent = gui
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 8)

-- Logika Buka/Tutup Fly
flyBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    flying = not flying
    if flying then
        bodyVelocity = Instance.new("BodyVelocity", hrp)
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Velocity = Vector3.zero
        
        bodyGyro = Instance.new("BodyGyro", hrp)
        bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bodyGyro.P = 3000
        bodyGyro.D = 500
        
        flyBtn.Text = "FLY: ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(186, 85, 211)
    else
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        flyBtn.Text = "FLY: OFF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
    end
end)

-- ===================== LOOP FLY (FIX ANALOG) =====================
RunService.RenderStepped:Connect(function()
    if flying and bodyVelocity and bodyGyro then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hum then
            -- Baca joystick
            local moveDir = hum.MoveDirection
            
            if moveDir.Magnitude > 0 then
                -- Terbang ngikutin arah joystick
                bodyVelocity.Velocity = moveDir * 60
            else
                -- Kalo joystick diem, hover (gak jatuh)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
            
            -- Biar badan gak muter aneh, ngikutin kamera
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        end
    end
end)
