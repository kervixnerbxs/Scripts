-- Cataclysm
-- Fully open source. If you want obfuscator - go to https://discord.gg/2tdsXcymZ and go to deobfuscator-and-obfuscator-here

-- Cataclysm DO NOT USE jnkie, luarmor. Please, if you see cataclysm hub IN jnkie, luarmor or all other service - DONT USE THAT. Official CATACLYSM - ONLY IN THIS REPO

local player = game.Players.LocalPlayer

local function isBadInjector()
    if getgenv and getgenv().Solara then
        return true
    end
    
    if getgenv and getgenv().Xeno then
        return true
    end
    
    if syn and syn.crypt then
        return true
    end
    
    if getgenv and getgenv().Luna then
        return true
    end

    if shared and shared.luna then
        return true
    end
    
    if _G and _G.Solara then
        return true
    end
    
    return false
end

if isBadInjector() then
    player:Kick("Your injector is a FULLY SHITTY and have a viruse. You cannot use this script.        By CATACLYSM DEVELOPER")
    return
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/kervixnerbxs/Scripts/refs/heads/main/script.luau"))()
