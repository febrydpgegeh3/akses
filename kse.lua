local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

local pastebinUrl = "https://pastebin.com/raw/FzQ2sbdW"


local function notify(Title, Text, Duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = Title;
        Text = Text;
        Icon = nil;
        Duration = Duration;
    })
end


local function getAccessData()
    local success, response = pcall(function()
        return HttpService:GetAsync(pastebinUrl)
    end)
    
    if success then
        return HttpService:JSONDecode(response) 
    else
        warn("Gagal mengambil data dari Pastebin: " .. tostring(response))
        return nil
    end
end


local function hasAccess(userId)
    local accessData = getAccessData()
    
    if accessData and accessData[tostring(userId)] then
        local expiryTime = accessData[tostring(userId)]
        
        if os.time() < expiryTime then
            notify("Akses diterima!", "Selamat datang!", 5)
            return true
        else
            notify("Akses sudah kedaluwarsa", "Silakan perpanjang akses.", 5)
            return false
        end
    else
        notify("Akses ditolak", "UserId tidak terdaftar dalam daftar akses.", 5)
        return false
    end
end


if hasAccess(player.UserId) then
    print("Akses diterima untuk UserId:", player.UserId)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/akonber/RBLX/refs/heads/main/elte2m.lua'))("")
else
    print("Akses ditolak.")
end
