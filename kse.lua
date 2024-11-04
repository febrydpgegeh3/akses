local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

-- Data akses lokal (ganti key dan durasi sesuai kebutuhan)
local accessData = {
    key1 = 3600, -- durasi akses dalam detik
    key2 = 7200, -- durasi akses dalam detik
    -- Tambahkan key dan durasi lainnya sesuai kebutuhan
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

-- Fungsi untuk memeriksa apakah key memiliki akses
local function hasAccess(inputKey)
    if accessData[inputKey] then
        local duration = accessData[inputKey]
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
frame.Size = UDim2.new(0, 200, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

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
    local accessGranted, duration = hasAccess(inputKey)
    
    if accessGranted then
        print("Akses diterima dengan durasi:", duration, "detik")
        loadstring(game:HttpGet('https://raw.githubusercontent.com/akonber/RBLX/refs/heads/main/elte2m.lua'))("")
    else
        print("Akses ditolak.")
    end
end)
