local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

-- URL untuk data akses di Pastebin (ganti 'YOUR_PASTEBIN_ID' dengan ID Pastebin Anda)
local pastebinUrl = "https://pastebin.com/raw/21zjhmJg"

-- Fungsi untuk menampilkan notifikasi
local function notify(Title, Text, Duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = Title;
        Text = Text;
        Icon = nil;
        Duration = Duration;
    })
end

-- Fungsi untuk mengambil data akses dari Pastebin
local function getAccessData()
    local success, response = pcall(function()
        return HttpService:GetAsync(pastebinUrl)
    end)
    
    if success then
        return HttpService:JSONDecode(response) -- Mengembalikan data dalam format tabel
    else
        warn("Gagal mengambil data dari Pastebin: " .. tostring(response))
        return nil
    end
end

-- Fungsi untuk memeriksa apakah username memiliki akses
local function hasAccess(username)
    local accessData = getAccessData()
    
    if accessData and accessData[username] then
        notify("Akses diterima!", "Selamat datang, " .. username, 5)
        return true
    else
        notify("Akses ditolak", "Username tidak terdaftar dalam daftar akses.", 5)
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
    if hasAccess(player.Name) then
        print("Akses diterima untuk Username:", player.Name)
        loadstring(game:HttpGet('https://raw.githubusercontent.com/akonber/RBLX/refs/heads/main/elte2m.lua'))("")
    else
        print("Akses ditolak.")
    end
end)
