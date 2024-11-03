local player = game.Players.LocalPlayer
local keys = {
    [176010631] = {
        key = "gegeh", -- Key akses unik
        expiry = os.time() + 3600 -- Waktu kedaluwarsa (1 jam dari waktu saat ini)
    }
    -- Anda bisa menambahkan UserId lain dengan key berbeda
}

-- Fungsi untuk memeriksa akses key dan durasinya
local function checkAccess(userId, inputKey)
    local accessData = keys[userId]
    
    -- Periksa apakah UserId ada dalam daftar key dan inputKey cocok dengan key yang disimpan
    if accessData and inputKey == accessData.key then
        -- Periksa apakah waktu saat ini lebih kecil dari waktu kedaluwarsa
        if os.time() < accessData.expiry then
            return true -- Akses valid
        else
            print("Key akses sudah kedaluwarsa.")
            return false -- Key sudah kedaluwarsa
        end
    else
        print("Key akses tidak valid atau UserId tidak terdaftar.")
        return false -- Key tidak valid
    end
end

-- Meminta key dari pemain
print("Silakan masukkan key akses Anda:")
local playerInputKey = "Enter" -- Ini contoh input, ganti dengan metode input GUI di Roblox

-- Memeriksa akses dan menjalankan skrip jika valid
if checkAccess(player.UserId, playerInputKey) then
    print("Akses diterima!")
    loadstring(game:HttpGet('https://raw.githubusercontent.com/akonber/RBLX/refs/heads/main/elte2m.lua'))("")
else
    print("Akses ditolak.")
end
