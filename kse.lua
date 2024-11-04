local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

-- Data akses lokal (UserId, Key, Durasi dalam detik)
local accessData = {
    [176010631] = { key = "key1", duration = 3600 }, -- Durasi akses dalam detik
    [7523995740] = { key = "test2", duration = 7200 }, -- Durasi akses dalam detik
    -- Tambahkan UserId, key dan durasi lainnya sesuai kebutuhan
}

-- Fungsi untuk menampilkan notifikasi
local function notify(Title, Text, Duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = Title;
        Text = Text;
        Icon = nil;
        Duration = Duration;
    })
end

-- Fungsi untuk memeriksa apakah UserId dan key memiliki akses
local function hasAccess(inputKey)
    local userAccess = accessData[player.UserId]

    if userAccess and userAccess.key == inputKey then
        local duration = userAccess.duration
        notify("Akses diterima!", "Durasi akses: " .. math.floor(duration / 60) .. " menit", 5)
        return true, duration
    else
        notify("Akses ditolak", "Key tidak terdaftar dalam daftar akses.", 5)
        return false
    end
end

-- Membuat GUI untuk memasukkan Key
local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local frame = Instance.new("Frame", screenGui)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0

-- Menambahkan Strip LED di sekeliling GUI
local function createLedStrip()
    local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0)}
    
    for _, color in ipairs(colors) do
        local ledFrame = Instance.new("Frame", screenGui)
        ledFrame.Size = UDim2.new(1, 0, 0, 5) -- Strip horizontal
        ledFrame.Position = UDim2.new(0, 0, 0, -5) -- Atas
        ledFrame.BackgroundColor3 = color
        ledFrame.BorderSizePixel = 0

        local ledFrame2 = ledFrame:Clone() -- Strip horizontal bawah
        ledFrame2.Position = UDim2.new(0, 0, 1, 0) -- Bawah
        ledFrame2.Parent = screenGui
        
        local ledFrame3 = ledFrame:Clone() -- Strip vertical kiri
        ledFrame3.Size = UDim2.new(0, 5, 1, 0)
        ledFrame3.Position = UDim2.new(-5, 0, 0, 0) -- Kiri
        ledFrame3.Parent = screenGui

        local ledFrame4 = ledFrame3:Clone() -- Strip vertical kanan
        ledFrame4.Position = UDim2.new(1, 0, 0, 0) -- Kanan
        ledFrame4.Parent = screenGui
    end
end

createLedStrip()

-- Menambahkan Judul
local titleLabel = Instance.new("TextLabel", frame)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Text = "Masukkan Key Akses"
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- RGB untuk judul
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true

local textBox = Instance.new("TextBox", frame)
textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
textBox.Size = UDim2.new(0.8, 0, 0.3, 0)
textBox.PlaceholderText = "Masukkan Key"
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local button = Instance.new("TextButton", frame)
button.Position = UDim2.new(0.1, 0, 0.7, 0)
button.Size = UDim2.new(1, 0, 0.8, 0)
button.Text = "Cek Akses"
button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Fungsi yang dipanggil saat tombol "Cek Akses" ditekan
button.MouseButton1Click:Connect(function()
    local inputKey = textBox.Text
    local accessGranted, duration = hasAccess(inputKey)
    
    if accessGranted then
        print("Akses diterima dengan durasi:", duration, "detik")
        loadstring(game:HttpGet('https://raw.githubusercontent.com/akonber/RBLX/refs/heads/main/elte2m.lua'))("")
        -- Menghilangkan GUI setelah akses diterima
        screenGui:Destroy()
    else
        print("Akses ditolak.")
    end
end)
