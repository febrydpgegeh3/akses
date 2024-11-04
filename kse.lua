local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local Players = game:GetService("Players")

-- Daftar ID pemain yang harus dikeluarkan
local adminIDs = {
    [202038212] = true,  -- Ganti dengan ID pemain yang ingin dikeluarkan
    [987654321] = true,  -- Ganti dengan ID pemain yang ingin dikeluarkan
}

-- Data akses lokal (UserId, Key)
local accessData = {
    [7523995740] = { key = "key1" }, -- ID Pemain dan Key
    [176010632] = { key = "key2" }, -- ID Pemain dan Key
    -- Tambahkan UserId dan key lainnya sesuai kebutuhan
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

-- Fungsi untuk memeriksa pemain yang sudah ada di dalam game
local function checkExistingPlayers()
    for _, existingPlayer in pairs(Players:GetPlayers()) do
        if adminIDs[existingPlayer.UserId] then
            notify("Admin Bergabung!", existingPlayer.Name .. " sudah ada di dalam server.", 5)
            wait(1) -- Sedikit delay sebelum kick
            existingPlayer:Kick("Anda tidak diizinkan untuk bergabung.")
        end
    end
end

-- Memeriksa pemain yang bergabung
Players.PlayerAdded:Connect(function(newPlayer)
    if adminIDs[newPlayer.UserId] then
        notify("Admin Bergabung!", newPlayer.Name .. " telah bergabung ke dalam server.", 5)
        wait(1) -- Sedikit delay sebelum kick
        newPlayer:Kick("Anda tidak diizinkan untuk bergabung.")
    end
end)

-- Panggil fungsi untuk memeriksa pemain yang sudah ada saat skrip dijalankan
checkExistingPlayers()
