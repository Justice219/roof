roofconfig = roofconfig or {}
roofconfig.client = roofconfig.client or {}
roofconfig.client.menus = roofconfig.client.menus or {}
roofconfig.client.menus.main = roofconfig.client.menus.main or {}
roofconfig.client.data = roofconfig.client.data or {}
roofconfig.client.data.addons = roofconfig.client.data.addons or {}

function roofconfig.client.menus.main.open()
    local tabs = {}
    local data = {}
    local funcs = {}

    function funcs.randomAddon(category)
        local fail = nil
        local addon = nil
        
        for k,v in pairs(roofconfig.client.data.settings) do
            if v.category == category then
                addon = roofconfig.client.data.settings[k]
                fail = false 
                break                
            end
        end

        if fail == false then
            return addon
        else
            return false, reason
        end
    end

    surface.CreateFont("roofconfig_title", {
        font = "Roboto",
        size = 20,
        weight = 500,
        antialias = true
    })

    local panel = vgui.Create("DPanel")
    panel:TDLib()
    panel:SetSize(1920, 1080)
    panel:Center()
    panel:MakePopup()
    panel:ClearPaint()
        :Background(Color(40, 41, 40), 0)
        :Text("Roof Config Panel", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 850, -510)
        :Text("v1.0", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 25,500)
        :CircleHover(Color(59, 59, 59), 5, 20)

    local panel2 = panel:Add("DPanel")
    panel2:TDLib()
    panel2:SetPos(0, 60)
    panel2:SetSize(1920, 5)
    panel2:ClearPaint()
        :Background(Color(255, 255, 255), 0)

    local panel3 = panel:Add("DPanel")
    panel3:TDLib()
    panel3:SetPos(435, 60)
    panel3:SetSize(5, 1000)
    panel3:ClearPaint()
        :Background(Color(255, 255, 255), 0)


    local close = panel:Add("DImageButton")
    close:SetPos(1880, 20)
    close:SetSize(20,20)
    close:SetImage("icon16/cross.png")
    close.DoClick = function()
        panel:Remove()
    end

    --local welcome = panel:Add("RichText")
    --welcome:SetPos(20, 20)
    --welcome:SetSize(200,200)
    --welcome:InsertColorChange(255,255,255,255)
    --welcome:AppendText("Welcome to the RoofConfig Menu!\n\n")

    local scroll = panel:Add("DScrollPanel")
    scroll:SetPos(20, 75)
    scroll:SetSize(400, 1000)
    scroll:TDLib()
    scroll:ClearPaint()
        :CircleHover(Color(59, 59, 59), 5, 20)

    surface.CreateFont("RoofConfigMenuButton", {
        font = "Roboto",
        size = 30,
        weight = 500,
        antialias = true,
        shadow = false
    })
    local function ChangeTab(name)
        print("Changing Tab")
        for k,v in pairs(data) do
            table.RemoveByValue(data, v)
            v:Remove()
            print("Removed")
        end

        local tbl = tabs[name]
        tbl.change()

    end
    
    local function CreateTab(name, tbl)
        local scroll = scroll:Add( "DButton" )
        scroll:SetText( name)
        scroll:Dock( TOP )
        scroll:SetTall( 75 )
        scroll:DockMargin( 0, 0, 0, 5 )
        scroll:SetTextColor(Color(255,255,255))
        scroll:TDLib()
        scroll:SetFont("RoofConfigMenuButton")
        scroll:SetIcon(tbl.icon)
        scroll:ClearPaint()
            :Background(Color(59, 59, 59), 5)
            :BarHover(Color(255, 255, 255), 3)
            :CircleClick()
        scroll.DoClick = function()
            ChangeTab(name)
        end

        if tabs[name] then return end
        tabs[name] = tbl
    end

    CreateTab("Main", {
        icon = "icon16/application_view_tile.png",
        change = function()
            local d = {}
            main = panel:Add("DPanel")
            main:SetPos(452.5, 75)
            main:SetSize(1455, 985)
            main:TDLib()
            main:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Main Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, main)

            scroll = main:Add("DScrollPanel")
            scroll:SetPos(20, 75)
            scroll:SetSize(350,850)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
        
            infop = main:Add("DPanel")
            infop:SetPos(380, 75)
            infop:SetSize(1050, 850)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)

            name1 = infop:Add("DLabel")
            name1:SetPos(20, 0)
            name1:SetSize(500, 200)
            name1:SetText("Name: ")
            name1:SetFont("DermaLarge")
            name1:SetTextColor(Color(255, 255, 255))

            desc = infop:Add("RichText")
            desc:SetPos(20, 125)
            desc:SetSize(500, 200)
            desc:InsertColorChange(255,255,255,255)
            desc:AppendText("Description: ")
            desc:TDLib()
            desc:ClearPaint()
                :Background(Color(59, 59, 59), 6)

            enabled = infop:Add("DLabel")
            enabled:SetPos(20,250)
            enabled:SetSize(200, 200)
            enabled:SetText("Enabled: ")
            enabled:SetFont("DermaLarge")
            enabled:SetTextColor(Color(255, 255, 255))

            warn = infop:Add("DLabel")
            warn:SetPos(20,725)
            warn:SetSize(1000, 200)
            warn:SetText("")
            warn:SetFont("roofconfig_title")
            warn:SetTextColor(Color(255, 255, 255))

            local n = nil
            del = infop:Add("DButton")
            del:SetText("Remove")
            del:SetTextColor(Color(255,255,255))
            del:SetPos(20, 375)
            del:SetSize(150, 30)
            del:TDLib()
            del:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            del.DoClick = function()
                if n == nil then return end
                panel:Remove()
                net.Start("RoofConfig:Net:RemoveSetting")
                net.WriteString(n)
                net.SendToServer()
            end

            create = infop:Add("DButton")
            create:SetText("Create Setting")
            create:SetTextColor(Color(255,255,255))
            create:SetPos(200, 375)
            create:SetSize(150, 30)
            create:TDLib()
            create:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            create.DoClick = function()
                if n == nil then return end
                
                local pop = vgui.Create("DFrame")
                pop:SetSize(500, 200)
                pop:Center()
                pop:SetTitle("Create A New Setting")
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local name = pop:Add("DTextEntry")
                name:SetPos(20, 25)
                name:SetSize(450, 25)
                name:SetText("Var Name (Ex roof_enabled)")
                name:SetFont("roofconfig_title")
                name.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local desc = pop:Add("DTextEntry")
                desc:SetPos(20, 55)
                desc:SetSize(450, 25)
                desc:SetText("Description (Ex: this enables/disables roof)")
                desc:SetFont("roofconfig_title")
                desc.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local category = pop:Add("DTextEntry")
                category:SetPos(20, 85)
                category:SetSize(450, 25)
                category:SetText("Menu Category (Ex: main)")
                category:SetFont("roofconfig_title")
                category.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local bool = pop:Add("DCheckBox")
                bool:SetPos(20, 115)
                bool:SetSize(25, 25)

                create1 = pop:Add("DButton")
                create1:SetText("Finish")
                create1:SetTextColor(Color(255,255,255))
                create1:SetPos(175,140)
                create1:SetSize(150, 30)
                create1:TDLib()
                create1:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                create1.DoClick = function()
                    local n = name:GetValue()
                    local d = desc:GetValue()
                    local c = category:GetValue()
                    local b = bool:GetChecked()
                    print("BOOLEAN")
                    print(b)
                    if n == "" or d == "" or c == "" then return end
                    net.Start("RoofConfig:Net:CreateSetting")
                    net.WriteString(n)
                    net.WriteString(d)
                    net.WriteString(c)
                    net.WriteBool(b)
                    net.SendToServer()
                    panel:Remove()
                    pop:Remove()
                end
            end

            addon = funcs.randomAddon("main")
            name1:SetText("Name: "..addon.var)
            desc:SetText("Description: "..addon.desc)
            enabled:SetText("Enabled: "..tostring(addon.value))
            n = addon.var
            if addon.method == "create" then
                warn:SetText("Warning, deleting this addon wont permanently remove it from the server! It was created through the config file!")
            else
                warn:SetText("")
            end

            for k,v in pairs(roofconfig.client.data.settings) do
                if v.category != "main" then continue end
                name = scroll:Add("DButton")
                name:SetText(k)
                name:SetTextColor(Color(255,255,255))
                name:Dock(TOP)
                name:DockMargin(10,10,10,5)
                name:SetTall(50)
                name:TDLib()
                name:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                name.DoClick = function()
                    name1:SetText("Name: "..k)
                    desc:SetText("Description: "..v.desc)
                    enabled:SetText("Enabled: "..tostring(v.value))
                    n = v.var
                    if v.method == "create" then
                        warn:SetText("Warning, deleting this addon wont permanently remove it from the server! It was created through the config file!")
                    else
                        warn:SetText("")
                    end
                end
                name.DoRightClick = function()
                    if k == "roof_enabled" then
                        roofconfig.client.menus.popup(panel, "ERROR", "This setting is unable to be edited")
                    return end
                    name1:SetText("Name: "..k)
                    desc:SetText("Description: "..v.desc)
                    enabled:SetText("Enabled: "..tostring(v.value))
                    n = v.var

                    local f = vgui.Create( "DFrame" )
                    f:SetSize( 500, 300 )
                    f:Center()
                    f:MakePopup()
                    f:SetTitle("Roof Config - " .. k)
                    f:TDLib()
                    f:ClearPaint()
                        :Background(Color(133, 133, 133, 58), 6)

                    local popup = f:Add("DProperties")
                    popup:Dock(FILL)

                    local choice = popup:CreateRow( "Addon Settings", "Enabled" )
                    choice:SetPos(name:GetPos())
                    choice:Setup( "Combo", {} )
                    choice:AddChoice( "True", true )
                    choice:AddChoice( "False", false )
                    choice:SetValue(v.value)

                    choice.DataChanged = function(self, val)
                        enabled:SetText("Enabled: "..tostring(val))
                        net.Start("RoofConfig:Net:UpdateSetting")
                        net.WriteString(k)
                        net.WriteBool(val)
                        net.SendToServer()
                        roofconfig.client.menus.popup(panel, "Main Settings", "The setting has been updated!")
                    end
                end
            end


            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Player", {
        icon = "icon16/user.png",
        change = function()
            local d = {}
            play = panel:Add("DPanel")
            play:SetPos(452.5, 75)
            play:SetSize(1455, 985)
            play:TDLib()
            play:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Player Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, play)

            scroll = play:Add("DScrollPanel")
            scroll:SetPos(20, 75)
            scroll:SetSize(350,850)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
        
            infop = play:Add("DPanel")
            infop:SetPos(380, 75)
            infop:SetSize(1050, 850)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)

            name1 = infop:Add("DLabel")
            name1:SetPos(20, 0)
            name1:SetSize(500, 200)
            name1:SetText("Name: ")
            name1:SetFont("DermaLarge")
            name1:SetTextColor(Color(255, 255, 255))

            desc = infop:Add("RichText")
            desc:SetPos(20, 125)
            desc:SetSize(500, 200)
            desc:InsertColorChange(255,255,255,255)
            desc:AppendText("Description: ")
            desc:TDLib()
            desc:ClearPaint()
                :Background(Color(59, 59, 59), 6)

            enabled = infop:Add("DLabel")
            enabled:SetPos(20,250)
            enabled:SetSize(200, 200)
            enabled:SetText("Enabled: ")
            enabled:SetFont("DermaLarge")
            enabled:SetTextColor(Color(255, 255, 255))

            warn = infop:Add("DLabel")
            warn:SetPos(20,725)
            warn:SetSize(1000, 200)
            warn:SetText("")
            warn:SetFont("roofconfig_title")
            warn:SetTextColor(Color(255, 255, 255))

            local n = nil
            del = infop:Add("DButton")
            del:SetText("Remove")
            del:SetTextColor(Color(255,255,255))
            del:SetPos(20, 375)
            del:SetSize(150, 30)
            del:TDLib()
            del:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            del.DoClick = function()
                if n == nil then return end
                panel:Remove()
                net.Start("RoofConfig:Net:RemoveSetting")
                net.WriteString(n)
                net.SendToServer()
            end

            create = infop:Add("DButton")
            create:SetText("Create Setting")
            create:SetTextColor(Color(255,255,255))
            create:SetPos(200, 375)
            create:SetSize(150, 30)
            create:TDLib()
            create:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            create.DoClick = function()
                if n == nil then return end
                
                local pop = vgui.Create("DFrame")
                pop:SetSize(500, 200)
                pop:Center()
                pop:SetTitle("Create A New Setting")
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local name = pop:Add("DTextEntry")
                name:SetPos(20, 25)
                name:SetSize(450, 25)
                name:SetText("Var Name (Ex roof_enabled)")
                name:SetFont("roofconfig_title")
                name.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local desc = pop:Add("DTextEntry")
                desc:SetPos(20, 55)
                desc:SetSize(450, 25)
                desc:SetText("Description (Ex: this enables/disables roof)")
                desc:SetFont("roofconfig_title")
                desc.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local category = pop:Add("DTextEntry")
                category:SetPos(20, 85)
                category:SetSize(450, 25)
                category:SetText("Menu Category (Ex: main)")
                category:SetFont("roofconfig_title")
                category.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local bool = pop:Add("DCheckBox")
                bool:SetPos(20, 115)
                bool:SetSize(25, 25)

                create1 = pop:Add("DButton")
                create1:SetText("Finish")
                create1:SetTextColor(Color(255,255,255))
                create1:SetPos(175,140)
                create1:SetSize(150, 30)
                create1:TDLib()
                create1:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                create1.DoClick = function()
                    local n = name:GetValue()
                    local d = desc:GetValue()
                    local c = category:GetValue()
                    local b = bool:GetChecked()
                    print("BOOLEAN")
                    print(b)
                    if n == "" or d == "" or c == "" then return end
                    net.Start("RoofConfig:Net:CreateSetting")
                    net.WriteString(n)
                    net.WriteString(d)
                    net.WriteString(c)
                    net.WriteBool(b)
                    net.SendToServer()
                    panel:Remove()
                    pop:Remove()
                end
            end

            addon = funcs.randomAddon("player")
            name1:SetText("Name: "..addon.var)
            desc:SetText("Description: "..addon.desc)
            enabled:SetText("Enabled: "..tostring(addon.value))
            n = addon.var
            if addon.method == "create" then
                warn:SetText("Warning, deleting this addon wont permanently remove it from the server! It was created through the config file!")
            else
                warn:SetText("")
            end

            for k,v in pairs(roofconfig.client.data.settings) do
                if v.category != "player" then continue end
                name = scroll:Add("DButton")
                name:SetText(k)
                name:SetTextColor(Color(255,255,255))
                name:Dock(TOP)
                name:DockMargin(10,10,10,5)
                name:SetTall(50)
                name:TDLib()
                name:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                name.DoClick = function()
                    name1:SetText("Name: "..k)
                    desc:SetText("Description: "..v.desc)
                    enabled:SetText("Enabled: "..tostring(v.value))
                    n = v.var
                    if v.method == "create" then
                        warn:SetText("Warning, deleting this addon wont permanently remove it from the server! It was created through the config file!")
                    else
                        warn:SetText("")
                    end
                    print('string')
                    print(n)
                end
                name.DoRightClick = function()
                    if k == "roof_enabled" then
                        roofconfig.client.menus.popup(panel, "ERROR", "This setting is unable to be edited")
                    return end
                    name1:SetText("Name: "..k)
                    desc:SetText("Description: "..v.desc)
                    enabled:SetText("Enabled: "..tostring(v.value))
                    n = v.var

                    local f = vgui.Create( "DFrame" )
                    f:SetSize( 500, 300 )
                    f:Center()
                    f:MakePopup()
                    f:SetTitle("Roof Config - " .. k)
                    f:TDLib()
                    f:ClearPaint()
                        :Background(Color(133, 133, 133, 58), 6)

                    local popup = f:Add("DProperties")
                    popup:Dock(FILL)

                    local choice = popup:CreateRow( "Addon Settings", "Enabled" )
                    choice:SetPos(name:GetPos())
                    choice:Setup( "Combo", {} )
                    choice:AddChoice( "True", true )
                    choice:AddChoice( "False", false )
                    choice:SetValue(v.value)

                    choice.DataChanged = function(self, val)
                        enabled:SetText("Enabled: "..tostring(val))
                        net.Start("RoofConfig:Net:UpdateSetting")
                        net.WriteString(k)
                        net.WriteBool(val)
                        net.SendToServer()
                        roofconfig.client.menus.popup(panel, "Player Settings", "The setting has been updated!")
                    end
                end
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("World", {
        icon = "icon16/world.png",
        change = function()
            local d = {}
            world = panel:Add("DPanel")
            world:SetPos(452.5, 75)
            world:SetSize(1455, 985)
            world:TDLib()
            world:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("World Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, world)

            scroll = world:Add("DScrollPanel")
            scroll:SetPos(20, 75)
            scroll:SetSize(350,850)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
        
            infop = world:Add("DPanel")
            infop:SetPos(380, 75)
            infop:SetSize(1050, 850)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)

            name1 = infop:Add("DLabel")
            name1:SetPos(20, 0)
            name1:SetSize(500, 200)
            name1:SetText("Name: ")
            name1:SetFont("DermaLarge")
            name1:SetTextColor(Color(255, 255, 255))

            desc = infop:Add("RichText")
            desc:SetPos(20, 125)
            desc:SetSize(500, 200)
            desc:InsertColorChange(255,255,255,255)
            desc:AppendText("Description: ")
            desc:TDLib()
            desc:ClearPaint()
                :Background(Color(59, 59, 59), 6)

            enabled = infop:Add("DLabel")
            enabled:SetPos(20,250)
            enabled:SetSize(200, 200)
            enabled:SetText("Enabled: ")
            enabled:SetFont("DermaLarge")
            enabled:SetTextColor(Color(255, 255, 255))

            warn = infop:Add("DLabel")
            warn:SetPos(20,725)
            warn:SetSize(1000, 200)
            warn:SetText("")
            warn:SetFont("roofconfig_title")
            warn:SetTextColor(Color(255, 255, 255))

            local n = nil
            del = infop:Add("DButton")
            del:SetText("Remove")
            del:SetTextColor(Color(255,255,255))
            del:SetPos(20, 375)
            del:SetSize(150, 30)
            del:TDLib()
            del:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            del.DoClick = function()
                if n == nil then return end
                panel:Remove()
                net.Start("RoofConfig:Net:RemoveSetting")
                net.WriteString(n)
                net.SendToServer()
            end

            create = infop:Add("DButton")
            create:SetText("Create Setting")
            create:SetTextColor(Color(255,255,255))
            create:SetPos(200, 375)
            create:SetSize(150, 30)
            create:TDLib()
            create:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            create.DoClick = function()
                if n == nil then return end
                
                local pop = vgui.Create("DFrame")
                pop:SetSize(500, 200)
                pop:Center()
                pop:SetTitle("Create A New Setting")
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local name = pop:Add("DTextEntry")
                name:SetPos(20, 25)
                name:SetSize(450, 25)
                name:SetText("Var Name (Ex roof_enabled)")
                name:SetFont("roofconfig_title")
                name.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local desc = pop:Add("DTextEntry")
                desc:SetPos(20, 55)
                desc:SetSize(450, 25)
                desc:SetText("Description (Ex: this enables/disables roof)")
                desc:SetFont("roofconfig_title")
                desc.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local category = pop:Add("DTextEntry")
                category:SetPos(20, 85)
                category:SetSize(450, 25)
                category:SetText("Menu Category (Ex: main)")
                category:SetFont("roofconfig_title")
                category.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local bool = pop:Add("DCheckBox")
                bool:SetPos(20, 115)
                bool:SetSize(25, 25)

                create1 = pop:Add("DButton")
                create1:SetText("Finish")
                create1:SetTextColor(Color(255,255,255))
                create1:SetPos(175,140)
                create1:SetSize(150, 30)
                create1:TDLib()
                create1:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                create1.DoClick = function()
                    local n = name:GetValue()
                    local d = desc:GetValue()
                    local c = category:GetValue()
                    local b = bool:GetChecked()
                    print("BOOLEAN")
                    print(b)
                    if n == "" or d == "" or c == "" then return end
                    net.Start("RoofConfig:Net:CreateSetting")
                    net.WriteString(n)
                    net.WriteString(d)
                    net.WriteString(c)
                    net.WriteBool(b)
                    net.SendToServer()
                    panel:Remove()
                    pop:Remove()
                end
            end

            addon = funcs.randomAddon("world")
            name1:SetText("Name: "..addon.var)
            desc:SetText("Description: "..addon.desc)
            enabled:SetText("Enabled: "..tostring(addon.value))
            n = addon.var
            if addon.method == "create" then
                warn:SetText("Warning, deleting this addon wont permanently remove it from the server! It was created through the config file!")
            else
                warn:SetText("")
            end

            for k,v in pairs(roofconfig.client.data.settings) do
                if v.category != "world" then continue end
                name = scroll:Add("DButton")
                name:SetText(k)
                name:SetTextColor(Color(255,255,255))
                name:Dock(TOP)
                name:DockMargin(10,10,10,5)
                name:SetTall(50)
                name:TDLib()
                name:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                name.DoClick = function()
                    name1:SetText("Name: "..k)
                    desc:SetText("Description: "..v.desc)
                    enabled:SetText("Enabled: "..tostring(v.value))
                    n = v.var
                    if v.method == "create" then
                        warn:SetText("Warning, deleting this addon wont permanently remove it from the server! It was created through the config file!")
                    else
                        warn:SetText("")
                    end
                end
                name.DoRightClick = function()
                    if k == "roof_enabled" then
                        roofconfig.client.menus.popup(panel, "ERROR", "This setting is unable to be edited")
                    return end
                    name1:SetText("Name: "..k)
                    desc:SetText("Description: "..v.desc)
                    enabled:SetText("Enabled: "..tostring(v.enabled))
                    n = v.var

                    local f = vgui.Create( "DFrame" )
                    f:SetSize( 500, 300 )
                    f:Center()
                    f:MakePopup()
                    f:SetTitle("Roof Config - " .. k)
                    f:TDLib()
                    f:ClearPaint()
                        :Background(Color(133, 133, 133, 58), 6)

                    local popup = f:Add("DProperties")
                    popup:Dock(FILL)

                    local choice = popup:CreateRow( "Addon Settings", "Enabled" )
                    choice:SetPos(name:GetPos())
                    choice:Setup( "Combo", {} )
                    choice:AddChoice( "True", true )
                    choice:AddChoice( "False", false )
                    choice:SetValue(v.value)

                    choice.DataChanged = function(self, val)
                        enabled:SetText("Enabled: "..tostring(val))
                        net.Start("RoofConfig:Net:UpdateSetting")
                        net.WriteString(k)
                        net.WriteBool(val)
                        net.SendToServer()
                        roofconfig.client.menus.popup(panel, "Main Settings", "The setting has been updated!")
                    end
                end
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Addons", {
        icon = "icon16/world.png",
        change = function()
            local d = {}
            addons = panel:Add("DPanel")
            addons:SetPos(452.5, 75)
            addons:SetSize(1455, 985)
            addons:TDLib()
            addons:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Addon Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, addons)

            scroll = addons:Add("DScrollPanel")
            scroll:SetPos(20, 75)
            scroll:SetSize(350,850)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)

            infop = addons:Add("DPanel")
            infop:SetPos(380, 75)
            infop:SetSize(1050, 850)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)

            name1 = infop:Add("DLabel")
            name1:SetPos(20, 0)
            name1:SetSize(500, 200)
            name1:SetText("Name: ")
            name1:SetFont("DermaLarge")
            name1:SetTextColor(Color(255, 255, 255))

            author = infop:Add("DLabel")
            author:SetPos(20, 50)
            author:SetSize(200, 200)
            author:SetText("Author: ")
            author:SetFont("DermaLarge")
            author:SetTextColor(Color(255, 255, 255))

            desc = infop:Add("RichText")
            desc:SetPos(20, 200)
            desc:SetSize(500, 200)
            desc:InsertColorChange(255,255,255,255)
            desc:AppendText("Description: ")
            desc:TDLib()
            desc:ClearPaint()
                :Background(Color(59, 59, 59), 6)

            enabled = infop:Add("DLabel")
            enabled:SetPos(20,350)
            enabled:SetSize(200, 200)
            enabled:SetText("Enabled: ")
            enabled:SetFont("DermaLarge")
            enabled:SetTextColor(Color(255, 255, 255))


            for k,v in pairs(roofconfig.client.data.addons) do
                if k == "Roof Config" then continue end
                name = scroll:Add("DButton")
                name:SetText(k)
                name:SetTextColor(Color(255,255,255))
                name:Dock(TOP)
                name:DockMargin(10,10,10,5)
                name:SetTall(50)
                name:TDLib()
                name:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                name.DoClick = function()
                    name1:SetText("Name: "..k)
                    author:SetText("Author: ".. v.author)
                    desc:SetText("Description: "..v.description)
                    enabled:SetText("Enabled: "..tostring(v.enabled))
                end
                name.DoRightClick = function()
                    name1:SetText("Name: "..k)
                    author:SetText("Author: ".. v.author)
                    desc:SetText("Description: "..v.description)
                    enabled:SetText("Enabled: "..tostring(v.enabled))

                    local f = vgui.Create( "DFrame" )
                    f:SetSize( 500, 300 )
                    f:Center()
                    f:MakePopup()
                    f:SetTitle("Roof Config - " .. k)
                    f:TDLib()
                    f:ClearPaint()
                        :Background(Color(133, 133, 133, 58), 6)

                    local popup = f:Add("DProperties")
                    popup:Dock(FILL)

                    local choice = popup:CreateRow( "Addon Settings", "Enabled" )
                    choice:SetPos(name:GetPos())
                    choice:Setup( "Combo", {} )
                    choice:AddChoice( "True", true )
                    choice:AddChoice( "False", false )
                    choice:SetValue(v.enabled)

                    choice.DataChanged = function(self, val)
                        net.Start("RoofConfig:Net:UpdateAddon")
                        net.WriteString(k)
                        net.WriteBool(val)
                        net.SendToServer()

                        roofconfig.client.menus.popup(panel, "Addon Settings", "Updated", "The addon has been updated!", "Ok")
                    end

                end 

                addon = table.Random(roofconfig.client.data.addons)
                name1:SetText("Name: "..addon.name)
                author:SetText("Author: ".. addon.author)
                desc:SetText("Description: "..addon.description)
                enabled:SetText("Enabled: "..tostring(addon.enabled))
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Debug", {
        icon = "icon16/bug.png",
        change = function()
            local d = {}
            debu = panel:Add("DPanel")
            debu:SetPos(452.5, 75)
            debu:SetSize(1455, 985)
            debu:TDLib()
            debu:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Main Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, debu)

            scroll = debu:Add("DScrollPanel")
            scroll:SetPos(20, 75)
            scroll:SetSize(350,850)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
        
            infop = debu:Add("DPanel")
            infop:SetPos(380, 75)
            infop:SetSize(1050, 850)
            infop:TDLib()
            infop:ClearPaint()
                :Background(Color(40,41,40), 6)

            name1 = infop:Add("DLabel")
            name1:SetPos(20, 0)
            name1:SetSize(500, 200)
            name1:SetText("Name: ")
            name1:SetFont("DermaLarge")
            name1:SetTextColor(Color(255, 255, 255))

            desc = infop:Add("RichText")
            desc:SetPos(20, 125)
            desc:SetSize(500, 200)
            desc:InsertColorChange(255,255,255,255)
            desc:AppendText("Description: ")
            desc:TDLib()
            desc:ClearPaint()
                :Background(Color(59, 59, 59), 6)

            enabled = infop:Add("DLabel")
            enabled:SetPos(20,250)
            enabled:SetSize(200, 200)
            enabled:SetText("Enabled: ")
            enabled:SetFont("DermaLarge")
            enabled:SetTextColor(Color(255, 255, 255))

            warn = infop:Add("DLabel")
            warn:SetPos(20,725)
            warn:SetSize(1000, 200)
            warn:SetText("")
            warn:SetFont("roofconfig_title")
            warn:SetTextColor(Color(255, 255, 255))

            local n = nil
            del = infop:Add("DButton")
            del:SetText("Remove")
            del:SetTextColor(Color(255,255,255))
            del:SetPos(20, 375)
            del:SetSize(150, 30)
            del:TDLib()
            del:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            del.DoClick = function()
                if n == nil then return end
                panel:Remove()
                net.Start("RoofConfig:Net:RemoveSetting")
                net.WriteString(n)
                net.SendToServer()
            end

            create = infop:Add("DButton")
            create:SetText("Create Setting")
            create:SetTextColor(Color(255,255,255))
            create:SetPos(200, 375)
            create:SetSize(150, 30)
            create:TDLib()
            create:ClearPaint()
                :Background(Color(59, 59, 59), 5)
                :BarHover(Color(255, 255, 255), 3)
                :CircleClick()
            create.DoClick = function()
                if n == nil then return end
                
                local pop = vgui.Create("DFrame")
                pop:SetSize(500, 200)
                pop:Center()
                pop:SetTitle("Create A New Setting")
                pop:MakePopup()
                pop:TDLib()
                pop:ClearPaint()
                    :Background(Color(40,41,40), 6)
                    :CircleHover(Color(59, 59, 59), 5, 20)

                local name = pop:Add("DTextEntry")
                name:SetPos(20, 25)
                name:SetSize(450, 25)
                name:SetText("Var Name (Ex roof_enabled)")
                name:SetFont("roofconfig_title")
                name.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local desc = pop:Add("DTextEntry")
                desc:SetPos(20, 55)
                desc:SetSize(450, 25)
                desc:SetText("Description (Ex: this enables/disables roof)")
                desc:SetFont("roofconfig_title")
                desc.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local category = pop:Add("DTextEntry")
                category:SetPos(20, 85)
                category:SetSize(450, 25)
                category:SetText("Menu Category (Ex: main)")
                category:SetFont("roofconfig_title")
                category.Paint = function(self, w, h)
                    draw.RoundedBox( 6, 0, 0, w, h, Color(59,59,59))
                    self:DrawTextEntryText(Color(255, 255, 255), Color(255, 0, 0), Color(255, 255, 255))
                end

                local bool = pop:Add("DCheckBox")
                bool:SetPos(20, 115)
                bool:SetSize(25, 25)

                create1 = pop:Add("DButton")
                create1:SetText("Finish")
                create1:SetTextColor(Color(255,255,255))
                create1:SetPos(175,140)
                create1:SetSize(150, 30)
                create1:TDLib()
                create1:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                create1.DoClick = function()
                    local n = name:GetValue()
                    local d = desc:GetValue()
                    local c = category:GetValue()
                    local b = bool:GetChecked()
                    print("BOOLEAN")
                    print(b)
                    if n == "" or d == "" or c == "" then return end
                    net.Start("RoofConfig:Net:CreateSetting")
                    net.WriteString(n)
                    net.WriteString(d)
                    net.WriteString(c)
                    net.WriteBool(b)
                    net.SendToServer()
                    panel:Remove()
                    pop:Remove()
                end
            end

            addon = funcs.randomAddon("debug")
            name1:SetText("Name: "..addon.var)
            desc:SetText("Description: "..addon.desc)
            enabled:SetText("Enabled: "..tostring(addon.value))
            n = addon.var
            if addon.method == "create" then
                warn:SetText("Warning, deleting this addon wont permanently remove it from the server! It was created through the config file!")
            else
                warn:SetText("")
            end

            for k,v in pairs(roofconfig.client.data.settings) do
                if v.category != "debug" then continue end
                name = scroll:Add("DButton")
                name:SetText(k)
                name:SetTextColor(Color(255,255,255))
                name:Dock(TOP)
                name:DockMargin(10,10,10,5)
                name:SetTall(50)
                name:TDLib()
                name:ClearPaint()
                    :Background(Color(59, 59, 59), 5)
                    :BarHover(Color(255, 255, 255), 3)
                    :CircleClick()
                name.DoClick = function()
                    name1:SetText("Name: "..k)
                    desc:SetText("Description: "..v.desc)
                    enabled:SetText("Enabled: "..tostring(v.value))
                    n = v.var
                    if v.method == "create" then
                        warn:SetText("Warning, deleting this addon wont permanently remove it from the server! It was created through the config file!")
                    else
                        warn:SetText("")
                    end
                end
                name.DoRightClick = function()
                    if k == "roof_enabled" then
                        roofconfig.client.menus.popup(panel, "ERROR", "This setting is unable to be edited")
                    return end
                    name1:SetText("Name: "..k)
                    desc:SetText("Description: "..v.desc)
                    enabled:SetText("Enabled: "..tostring(v.value))
                    n = v.var

                    local f = vgui.Create( "DFrame" )
                    f:SetSize( 500, 300 )
                    f:Center()
                    f:MakePopup()
                    f:SetTitle("Roof Config - " .. k)
                    f:TDLib()
                    f:ClearPaint()
                        :Background(Color(133, 133, 133, 58), 6)

                    local popup = f:Add("DProperties")
                    popup:Dock(FILL)

                    local choice = popup:CreateRow( "Addon Settings", "Enabled" )
                    choice:SetPos(name:GetPos())
                    choice:Setup( "Combo", {} )
                    choice:AddChoice( "True", true )
                    choice:AddChoice( "False", false )
                    choice:SetValue(v.value)

                    choice.DataChanged = function(self, val)
                        enabled:SetText("Enabled: "..tostring(val))
                        net.Start("RoofConfig:Net:UpdateSetting")
                        net.WriteString(k)
                        net.WriteBool(val)
                        net.SendToServer()
                        roofconfig.client.menus.popup(panel, "Main Settings", "The setting has been updated!")
                    end
                end
            end

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Stats", {
        icon = "icon16/chart_bar.png",
        change = function()
            local d = {}
            stats = panel:Add("DPanel")
            stats:SetPos(452.5, 75)
            stats:SetSize(1455, 985)
            stats:TDLib()
            stats:ClearPaint()
                :Background(Color(59, 59, 59), 0)
                :Text("Server Statistics", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, stats)

            scroll = stats:Add("DScrollPanel")
            scroll:SetPos(20, 75)
            scroll:SetSize(350,850)
            scroll:TDLib()
            scroll:ClearPaint()
                :Background(Color(40,41,40), 6)
            for k,v in pairs(player.GetAll()) do
                name = scroll:Add("DLabel")
                name:SetText(" Player: " .. v:Nick())
                name:SetTextColor(Color(255,255,255))
                name:Dock(TOP)
                name:SetTall(25)

                local av = scroll:Add("DPanel")
                av:SetTall(75)
                av:Dock(TOP)
                av:DockMargin(10,5,10,5)
                av:TDLib()
                av:ClearPaint()
                    :CircleAvatar()
                    :SetPlayer(v, 184)
                    --:Text("n", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 5,5
                
                    print(v:Nick())
            end

            

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
end