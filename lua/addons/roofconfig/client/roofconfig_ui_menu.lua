roofconfig = roofconfig or {}
roofconfig.client = roofconfig.client or {}
roofconfig.client.menus = roofconfig.client.menus or {}
roofconfig.client.menus.main = roofconfig.client.menus.main or {}

function roofconfig.client.menus.main.open()
    local panel = vgui.Create("DPanel")
    panel:TDLib()
    panel:ClearPaint()
        :Background(Color(40, 41, 40), 6)

end