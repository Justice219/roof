adminsystem = adminsystem or {}
adminsystem.client = adminsystem.client or {}
adminsystem.client.menus = adminsystem.client.menus or {}
adminsystem.client.menus.main = adminsystem.client.menus.main or {}

function adminsystem.client.menus.main.open()
    local tabs = {}
    local data = {}
    local funcs = {}

    local panel = vgui.Create("DPanel")
    panel:TDLib()
    panel:SetSize(ScrW()/2, ScrH()/2)
    panel:Center()
    panel:MakePopup()
    panel:ClearPaint()
        :Background(Color(40, 41, 40), 6)
        :Text("Roof Admin Panel", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 400, -240)
        :Text("v1.0", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 5,250)
        :CircleHover(Color(59, 59, 59), 5, 20)

    local panel2 = panel:Add("DPanel")
    panel2:TDLib()
    panel2:SetPos(0, 60)
    panel2:SetSize(1920, 5)
    panel2:ClearPaint()
        :Background(Color(255, 255, 255), 0)

    local panel3 = panel:Add("DPanel")
    panel3:TDLib()
    panel3:SetPos(275, 60)
    panel3:SetSize(5, 1000)
    panel3:ClearPaint()
        :Background(Color(255, 255, 255), 0)


    local close = panel:Add("DImageButton")
    close:SetPos(925,10)
    close:SetSize(20,20)
    close:SetImage("icon16/cross.png")
    close.DoClick = function()
        panel:Remove()
    end

    local scroll = panel:Add("DScrollPanel")
    scroll:SetPos(17.5, 75)
    scroll:SetSize(240, 425)
    scroll:TDLib()
    scroll:ClearPaint()
        --:Background(Color(0, 26, 255), 6)
        :CircleHover(Color(59, 59, 59), 5, 20)

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
        scroll:SetTall( 50 )
        scroll:DockMargin( 0, 5, 0, 5 )
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

    CreateTab("Players", {
        icon = "icon16/user.png",
        change = function()
            local d = {}
            players = panel:Add("DPanel")
            players:SetPos(290, 75)
            players:SetSize(660, 455)
            players:TDLib()
            players:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Player Management", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 230,-200)
            table.insert(d, #d, players)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
        end
    })
    CreateTab("Groups", {
        icon = "icon16/group.png",
        change = function()
            local d = {}
            groups = panel:Add("DPanel")
            groups:SetPos(290, 75)
            groups:SetSize(660, 455)
            groups:TDLib()
            groups:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Group Management", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 230,-200)
            table.insert(d, #d, groups)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
    CreateTab("Config", {
        icon = "icon16/cog.png",
        change = function()
            local d = {}
            config = panel:Add("DPanel")
            config:SetPos(290, 75)
            config:SetSize(660, 455)
            config:TDLib()
            config:ClearPaint()
                :Background(Color(59, 59, 59), 6)
                :Text("Configuration", "DermaLarge", Color(255, 255, 255), TEXT_ALIGN_LEFT, 250,-200)
            table.insert(d, #d, config)

            for k,v in pairs(d) do
                table.insert(data, #data, v)
            end
            PrintTable(data)
        end
    })
end