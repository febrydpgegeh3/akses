local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local UserId = player.UserId

-- Data akses lokal (UserId, Key, Durasi dalam detik)
local accessData = {
    [7523995740] = { key = "key1", duration = 3600 }, -- Durasi akses dalam detik
    [176010632] = { key = "key2", duration = 7200 }, -- Durasi akses dalam detik
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
    local userAccess = accessData[UserId]

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

-- Menambahkan Judul
local titleLabel = Instance.new("TextLabel", frame)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Text = "Masukkan Key Akses"
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- RGB untuk judul
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true

-- Fungsi untuk mengubah warna latar belakang judul secara berkelanjutan
coroutine.wrap(function()
    while true do
        for _, color in ipairs({Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0)}) do
            titleLabel.BackgroundColor3 = color
            wait(0.5)
        end
    end
end)()

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

-- Fungsi untuk membuat animasi warna-warni pada button
local function animateButtonColor()
    while true do
        for _, color in ipairs({Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0)}) do
            button.BackgroundColor3 = color
            wait(0.5)
        end
    end
end

animateButtonColor()

-- Fungsi yang dipanggil saat tombol "Cek Akses" ditekan
button.MouseButton1Click:Connect(function()
    local inputKey = textBox.Text
    local accessGranted, duration = hasAccess(inputKey)
    
    if accessGranted then
        print("Akses diterima dengan durasi:", duration, "detik")

        -- Notifikasi hitung mundur di pojok kanan atas
        local countdownLabel = Instance.new("TextLabel", game.Players.LocalPlayer.PlayerGui)
        countdownLabel.Position = UDim2.new(1, -150, 0, 10)
        countdownLabel.Size = UDim2.new(0, 140, 0, 50)
        countdownLabel.BackgroundTransparency = 1
        countdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        countdownLabel.TextScaled = true

        for remaining = duration, 0, -1 do
            countdownLabel.Text = "Waktu tersisa: " .. math.floor(remaining / 60) .. " menit " .. (remaining % 60) .. " detik"
            wait(1)
        end

        countdownLabel:Destroy() -- Menghapus label setelah hitung mundur selesai
        notify("Waktu habis", "Anda akan dikeluarkan dari game.", 5)
        wait(2) -- Menunggu sebelum kick
        player:Kick("Waktu akses habis.")
        
        -- Menghilangkan GUI setelah akses diterima
        screenGui:Destroy()
    else
        print("Akses ditolak.")
    end
end)
