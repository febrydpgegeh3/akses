local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local Players = game:GetService("Players")

-- Data akses lokal (UserId, Key)
local accessData = {
    [7523995740] = { key = "key1" }, -- ID Pemain dan Key
    [176010632] = { key = "key2" }, -- ID Pemain dan Key
    -- Tambahkan UserId dan key lainnya sesuai kebutuhan
}

-- Daftar ID pemain yang ingin diberi notifikasi saat bergabung
local notifyUserIds = {
    [202038212] = true,  -- Ganti dengan ID pemain yang ingin diberi notifikasi
    [127711155] = true,  -- Ganti dengan ID pemain yang ingin diberi notifikasi
    [695146286] = true,  -- Ganti dengan ID pemain yang ingin diberi notifikasi
    [489401796] = true,  -- Ganti dengan ID pemain yang ingin diberi notifikasi
    [138509994] = true,  -- Ganti dengan ID pemain yang ingin diberi notifikasi
    [71243418] = true,  -- Ganti dengan ID pemain yang ingin diberi notifikasi
    [44038206] = true,  -- Ganti dengan ID pemain yang ingin diberi notifikasi
    [2828604791] = true,  -- Ganti dengan ID pemain yang ingin diberi notifikasi
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
        notify("Akses diterima!", "Anda telah mendapatkan akses.", 5)
        return true
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
button.Size = UDim2.new(0.8, 0, 0.2, 0)
button.Text = "Cek Akses"
button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Fungsi yang dipanggil saat tombol "Cek Akses" ditekan
button.MouseButton1Click:Connect(function()
    local inputKey = textBox.Text
    local accessGranted = hasAccess(inputKey)
    
    if accessGranted then
        print("Akses diterima.")
        loadstring(game:HttpGet('https://raw.githubusercontent.com/akonber/RBLX/refs/heads/main/elte2m.lua'))("")
        
        -- Menghilangkan GUI setelah akses diterima
        screenGui:Destroy()
    else
        print("Akses ditolak.")
    end
end)

-- Fungsi untuk memeriksa pemain yang sudah dalam permainan
local function checkExistingPlayers()
    for _, existingPlayer in pairs(Players:GetPlayers()) do
        if notifyUserIds[existingPlayer.UserId] then
            notify("WARNING!", existingPlayer.Name .. " ADMIN IN THIS SERVER.", 5)
        end
    end
end

-- Panggil fungsi untuk memeriksa pemain yang sudah ada saat skrip dijalankan
checkExistingPlayers()

-- Fungsi untuk memeriksa pemain yang bergabung
Players.PlayerAdded:Connect(function(newPlayer)
    if notifyUserIds[newPlayer.UserId] then
        notify("WARNING!", newPlayer.Name .. " ADMIN JOIN.", 5)
    end
end)
