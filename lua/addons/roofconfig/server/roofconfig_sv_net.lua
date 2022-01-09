roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.addons.data = roof.server.addons.data or {}
roof.server.errors = roof.server.errors or {}
roof.server.player = roof.server.player or {}
jlib = jlib or {}

util.AddNetworkString("RoofConfig:Net:Menus:Main")
util.AddNetworkString("RoofConfig:Net:SyncClient")
util.AddNetworkString("RoofConfig:Net:UpdateSettings")
util.AddNetworkString("RoofConfig:Net:UpdateAddon")

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