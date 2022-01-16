roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.addons.data = roof.server.addons.data or {}
roof.server.errors = roof.server.errors or {}
roof.server.player = roof.server.player or {}
roof.server.settings = roof.server.settings or {}
jlib = jlib or {}

util.AddNetworkString("RoofConfig:Net:Menus:Main")
util.AddNetworkString("RoofConfig:Net:SyncClient")
util.AddNetworkString("RoofConfig:Net:UpdateSettings")
util.AddNetworkString("RoofConfig:Net:UpdateAddon")
util.AddNetworkString("RoofConfig:Net:UpdateSetting")
util.AddNetworkString("RoofConfig:Net:RemoveSetting")
util.AddNetworkString("RoofConfig:Net:CreateSetting")

net.Receive("RoofConfig:Net:UpdateAddon", function(len, ply)
    if !roof.server.player.auth(ply) then return end
    addon = roof.server.data.addons[net.ReadString()]
    val = net.ReadBool()
    if !addon then
        roof.server.errors.severe("Internal Error Occured in (RoofConfig:Net:UpdateAddon), This shouldnt happen!\n")
        roof.server.errors.severe("Details: ", addon, val, "\n")
        roof.server.errors.severe("[ROOF]", "Please Contact Justice#4956 If this happens again!\n")
    return end

    if val then
        if addon.enabled then
            roof.server.errors.normal("Addon '"..addon.name.."' is already enabled!\n")
        return end
        addon.enabled = true
        addon.enable()
        roof.server.errors.change("Enabled Addon: " .. addon.name .. "\n")
    else
        if !addon.enabled then
            roof.server.errors.normal("Addon '"..addon.name.."' is already disabled!\n")    
        return end
        addon.enabled = false
        addon.disable()
        roof.server.errors.change("Disabled Addon: " .. addon.name .. "\n")
    end

    ply:JLIBSendNotification("ROOF CONFIG SYSTEM", "Addon '"..addon.name.."' has been "..(val and "enabled" or "disabled").."!", "success!")

end)

net.Receive("RoofConfig:Net:UpdateSetting", function(len, ply)
    if !roof.server.player.auth(ply) then return end
    setting = roof.server.data.settings[net.ReadString()]
    val = net.ReadBool()

    if !setting then
        roof.server.errors.severe("Internal Error Occured in (RoofConfig:Net:UpdateSetting), This shouldnt happen!\n")
        roof.server.errors.severe("Details: ", setting, val, "\n")
        roof.server.errors.severe("[ROOF]", "Please Contact Justice#4956 If this happens again!\n")
    return end
    
    if val then
        if setting.value then
            roof.server.errors.normal("Setting '"..setting.var.."' is already enabled!\n")
        return end
        setting.value = true
        roof.server.errors.change("Enabled Setting: " .. setting.var .. "\n")
    else
        if !setting.value then
            roof.server.errors.normal("Setting '"..setting.var.."' is already disabled!\n")
        return end
        setting.value = false
        roof.server.errors.change("Disabled Setting: " .. setting.var .. "\n")
    end
    
end)
net.Receive("RoofConfig:Net:RemoveSetting", function(len, ply)
    if !roof.server.player.auth(ply) then return end
    setting = roof.server.data.settings[net.ReadString()]
    print("ran")

    if !setting then
        roof.server.errors.severe("Internal Error Occured in (RoofConfig:Net:RemoveSetting), This shouldnt happen!\n")
        roof.server.errors.severe("Details: ", setting, "\n")
        roof.server.errors.severe("[ROOF]", "Please Contact Justice#4956 If this happens again!\n")
    return end

    roof.server.settings.remove(setting.var)
end)

net.Receive("RoofConfig:Net:CreateSetting", function(len, ply)
    if !roof.server.player.auth(ply) then return end

    local n = net.ReadString()
    local d = net.ReadString()
    local c = net.ReadString()
    local b = net.ReadBool()

    print("bool")
    print(b)

    roof.server.settings.createInternal(n, {
        default = b,
        desc = d,
        category = c,
    })

end)