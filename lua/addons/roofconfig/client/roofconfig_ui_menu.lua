roofconfig = roofconfig or {}
roofconfig.client = roofconfig.client or {}
roofconfig.client.menus = roofconfig.client.menus or {}
roofconfig.client.menus.main = roofconfig.client.menus.main or {}
roofconfig.client.data = roofconfig.client.data or {}
roofconfig.client.data.addons = roofconfig.client.data.addons or {}

function roofconfig.client.menus.main.open()
    local tabs = {}
    local data = {}

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
                :Text("Debug Settings", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 650, -450)
            table.insert(d, #d, debu)

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