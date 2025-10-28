script_author('deffix | Denis_Mansory')
script_properties('work-in-pause')
require 'lib.moonloader'
local sampev = require 'lib.samp.events'
local wm = require 'lib.windows.message'
local imgui = require 'mimgui'
local encoding = require 'encoding'
local inicfg = require 'inicfg'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local new = imgui.new
local tag = "{FF66FF}[Mordor Shop Interfaces]: {FFFFFF}"

local inicfgfile = '..//Mordor Shop Interfaces//MordorSI.ini'
local inisettings = inicfg.load(inicfg.load({
    settings = {
        pay_type = 0
    }
}, inicfgfile))
inicfg.save(inisettings, inicfgfile)

local shop_type = ''
local image_file = {
    { name = 'esc', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\esc.png" },
    { name = 'Балаклава', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\mask.png" },
    { name = 'Аптечка', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\heal.png" },
    { name = 'Сигареты', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\sigareta.png" },
    { name = 'Телефон', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\phone.png" },
    { name = 'Сим-Карта', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\simka.png" },
    { name = 'Плеер с наушниками', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pleer.png" },
    { name = 'Удочка', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\fishingrod.png" },
    { name = 'Снасти', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\snasti.png" },
    { name = 'GPS Навигатор', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\gps.png" },
    { name = 'Пейджер', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pager.png" },

    { name = 'Цемент', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\cement.png" },
    { name = 'Цветы', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\flowers.png" },
    { name = 'Коробка конфет в виде сердца', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\sweet.png" },
    { name = 'Коробочка с кольцом', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\ring.png" },
    { name = 'Спички', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\matches.png" },
    { name = 'Сырое мясо', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\meat.png" },
    { name = 'Мангал', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\grill.png" },
    { name = 'Шезлонг', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\loungechair.png" },
    { name = 'Тент', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\tent.png" },
    { name = 'Яйцо', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\egg.png" },

    { name = 'Соль', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\salt.png" },
    { name = 'Сахар', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\sugar.png" },
    { name = 'Мука', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\flour.png" },

    { name = 'Говядина', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\meatgovyadina.png" },
    { name = 'Сметана', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\smetana.png" },
    { name = 'Рыба', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\fish.png" },
    { name = 'Майонез', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\mayonez.png" },
    { name = 'Лимон', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\lemon.png" },
    { name = 'Приправы', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pripravbi.png" },

    { name = 'Картошка', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\potato.png" },

    { name = 'Горох', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\goroh.png" },


    { name = 'Спранк', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\sprunk.png" },
    { name = 'Темное пиво', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\darkbeer.png" },
    { name = 'Светлое пиво', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\lightbeer.png" },
    { name = 'Водка', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\vodka.png" },
    { name = 'Виски', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\viski.png" },
    { name = 'Коньяк', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\konyak.png" },
    { name = 'Шашлычок', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\shahlbichok.png" },
    { name = 'Коктейль', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\cocktail.png" },
    { name = 'Мохито', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\mohito.png" },
    { name = 'Кальян', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\smoke.png" }
}
local imgui_textures = {
    ['esc'] = nil,
    ['Балаклава'] = nil,
    ['Аптечка'] = nil,
    ['Сигареты'] = nil,
    ['Телефон'] = nil,
    ['Сим-Карта'] = nil,
    ['Плеер с наушниками'] = nil,
    ['Удочка'] = nil,
    ['Снасти'] = nil,
    ['GPS Навигатор'] = nil,
    ['Пейджер'] = nil,

    ['Цемент'] = nil,
    ['Цветы'] = nil,
    ['Коробка конфет в виде сердца'] = nil,
    ['Коробочка с кольцом'] = nil,
    ['Спички'] = nil,
    ['Сырое мясо'] = nil,
    ['Мангал'] = nil,
    ['Шезлонг'] = nil,
    ['Тент'] = nil,
    ['Яйцо'] = nil,

    ['Соль'] = nil,
    ['Сахар'] = nil,
    ['Мука'] = nil,
    ['Говядина'] = nil,
    ['Сметана'] = nil,
    ['Рыба'] = nil,
    ['Майонез'] = nil,
    ['Лимон'] = nil,
    ['Приправы'] = nil,
    ['Картошка'] = nil,

    ['Горох'] = nil,


    ['Спранк'] = nil,
    ['Темное пиво'] = nil,
    ['Светлое пиво'] = nil,
    ['Водка'] = nil,
    ['Виски'] = nil,
    ['Коньяк'] = nil,
    ['Шашлычок'] = nil,
    ['Коктейль'] = nil,
    ['Мохито'] = nil,
    ['Кальян'] = nil
}

local item_list = {}
local check_items = false
local hovered = -1
local first_use = 0
local first = true
local buy_settings = {
    pay_int = new.int(inisettings.settings.pay_type),
    pay_types = {u8'Наличные', u8'Банковская карта'},
    shop_id = -1,
    find = false,
    c = 0,
    i = 0,
    count = new.int(1),
    buy_bool = false,
    title = '',
    price = ''
}

local ui_meta = {
    __index = function(self, v)
        if v == "switch" then
            local switch = function()
                if self.process and self.process:status() ~= "dead" then
                    return false
                end
                self.timer = os.clock()
                self.state = not self.state

                local function bringFloatTo(from, to, start_time, duration)
                    local timer = os.clock() - start_time
                    if timer >= 0 and timer <= duration then
                        local count = timer / (duration / 100)
                        return from + (count * (to - from) / 100)
                    end
                    return (timer > duration) and to or from
                end

                self.process = lua_thread.create(function()
                    while true do wait(0)
                        local a = bringFloatTo(0.00, 1.00, self.timer, self.duration)
                        self.alpha = self.state and a or 1.00 - a
                        if a == 1.00 then
                            if first_use < 2 then first_use = first_use + 1 end
                            if first_use == 2 then first = false end
                            break
                        end
                    end
                end)
                return true
            end
            return switch
        end
 
        if v == "alpha" then
            return self.state and 1.00 or 0.00
        end
    end
}
local shop = { state = true, duration = 0.25 }
local shop_buy = { state = true, duration = 0.35 }
setmetatable(shop, ui_meta)
setmetatable(shop_buy, ui_meta)

function new_num(num)
    local formatted = ""
    local k = 0
    for i = #num, 1, -1 do
        local digit = num:sub(i, i)
        formatted = digit .. formatted
        k = k + 1
        if k == 3 and i > 1 then
            formatted = "." .. formatted
            k = 0
        end
    end
    return formatted
end

function main()
    while not isSampAvailable() do wait(0) end
    local dirNames = {getWorkingDirectory() .. "\\Mordor Shop Interfaces", getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images"}
    for i, path in ipairs(dirNames) do
        if not doesDirectoryExist(path) then
            createDirectory(path)
        end
    end
    shop.switch()
    shop_buy.switch()
    sampRegisterChatCommand('shop', function() shop.switch() end)
    while true do
        wait(0)
        
    end
end

imgui.OnFrame(function() 
    return shop.alpha > 0.00 and (not isGamePaused() and not isPauseMenuActive())
end, function(player)
        player.HideCursor = not shop.state
        local alpha = first and 0 or shop.alpha
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, alpha)
        imgui.SetNextWindowPos(imgui.ImVec2(getScreenResolution() / 2, getScreenResolution() / 3.4), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(845, 600), imgui.Cond.Always)
        imgui.Begin('shop', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
        local p = imgui.GetCursorScreenPos()
        local dl = imgui.GetWindowDrawList()
        dl:AddRectFilledMultiColor(p, imgui.ImVec2(p.x + 845, p.y + 600), imgui.ColorConvertFloat4ToU32({0.7, 0.0, 0.0, shop.alpha}), imgui.ColorConvertFloat4ToU32({0.1, 0.0, 0.0, shop.alpha}), imgui.ColorConvertFloat4ToU32({0.1, 0.0, 0.0, shop.alpha}), imgui.ColorConvertFloat4ToU32({0.1, 0.0, 0.0, shop.alpha}))
        imgui.PushFont(shop_type_font)
        imgui.SetCursorPosY(10)
        imgui.SetCursorPosX((imgui.GetWindowSize().x - imgui.CalcTextSize(u8(shop_type)).x) / 2)
        imgui.Text(u8(shop_type))
        imgui.PopFont()
        local new_hovered = -1
        imgui.BeginChild('shop_items', imgui.ImVec2(845, 560), false)
            for i, il in ipairs(item_list) do
                local wpos = imgui.GetWindowPos()
                local cx, cy = getCursorPos()
                local x = 20 + ((i - 1) % 6) * 135
                local y = 10 + (math.ceil(i / 6) - 1) * 170
                imgui.SetCursorPosX(x)
                imgui.SetCursorPosY(y)
                item(((i - 1) % 6) + 1, il.title, il.price, i)
                if cx > wpos.x and cx < wpos.x + 845 and cy > wpos.y and cy < wpos.y + 560 then
                   if cx > x + wpos.x and cx < x + 130 + wpos.x and cy + imgui.GetScrollY() > y + wpos.y and cy + imgui.GetScrollY() < y + 165 + wpos.y then
                        new_hovered = i
                        if imgui.IsMouseClicked(0) then
                            buy_settings.title = il.title
                            buy_settings.price = il.price
                            buy_settings.count = new.int(1)
                            buy_settings.buy_bool = true
                            buy_settings.find = false
                            buy_settings.c = math.ceil(i / 10) + 1
                            if i % 10 == 0 then
                                buy_settings.i = 9
                            else
                                buy_settings.i = i % 10 - 1
                            end
                            shop.switch()
                            sampSendChat('/use')
                        end
                    end
                end
            end
            for i = 1, 6 do
                imgui.Spacing()
            end
            if new_hovered ~= hovered then
                hovered = new_hovered
            end
        imgui.EndChild()
        imgui.SetCursorPosX(810)
        imgui.SetCursorPosY(5)
        imgui.Image(imgui_textures['esc'], imgui.ImVec2(30, 30))
        if imgui.IsItemClicked(0) then
            shop.switch()
        end
        imgui.End()
        imgui.PopStyleVar()
    end
)
imgui.OnFrame(function()
    return shop_buy.alpha > 0.00 and (not isGamePaused() and not isPauseMenuActive())
end, function(player)
        player.HideCursor = not shop_buy.state
        local alpha = first and 0 or shop_buy.alpha
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, alpha)
        imgui.SetNextWindowPos(imgui.ImVec2(getScreenResolution() / 2, getScreenResolution() / 3.4), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(500, 300), imgui.Cond.Always)
        imgui.Begin('shop_buy', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
        local p = imgui.GetCursorScreenPos()
        local dl = imgui.GetWindowDrawList()
        dl:AddRectFilledMultiColor(p, imgui.ImVec2(p.x + 500, p.y + 300), imgui.ColorConvertFloat4ToU32({0.7, 0.0, 0.0, shop_buy.alpha}), imgui.ColorConvertFloat4ToU32({0.1, 0.0, 0.0, shop_buy.alpha}), imgui.ColorConvertFloat4ToU32({0.1, 0.0, 0.0, shop_buy.alpha}), imgui.ColorConvertFloat4ToU32({0.1, 0.0, 0.0, shop_buy.alpha}))
        imgui.PushFont(shop_type_font)
        imgui.SetCursorPosY(10)
        imgui.SetCursorPosX((imgui.GetWindowSize().x - imgui.CalcTextSize(u8(shop_type)).x) / 2)
        imgui.Text(u8(shop_type))
        imgui.PopFont()
        local title = buy_settings.title:gsub('^Продукт %- ', '')
        local price = buy_settings.price
        imgui.SetCursorPosX(20)
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 15)
        local p2 = imgui.GetCursorScreenPos()
        dl:AddRect(p2, imgui.ImVec2(p2.x + 130, p2.y + 165), imgui.ColorConvertFloat4ToU32({0.7, 0.1, 0.1, 1}), 15, bit.bor(bit.lshift(1, 0), bit.lshift(1, 1), bit.lshift(1, 2), bit.lshift(1, 3)))
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 10)
        imgui.SetCursorPosX(imgui.GetCursorPosX() + 23.5)
        imgui.Image(imgui_textures[title], imgui.ImVec2(80, 80))
        imgui.SetCursorPosX((130 - imgui.CalcTextSize(u8(title)).x) / 2 + 20)
        if imgui.CalcTextSize(u8(title)).x > 130 then
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 7)
            imgui.SetCursorPosX(imgui.GetCursorPosX() + 44)
            imgui.PushTextWrapPos(135)
            imgui.TextWrapped(u8(title))
            imgui.PopTextWrapPos()
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 8)
        else
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 15)
            imgui.Text(u8(title))
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 13)
        end
        imgui.SetCursorPosX((130 - imgui.CalcTextSize(u8(price .. '$')).x) / 2 + 20)
        imgui.TextColored({0, 0.8, 0, 1}, tostring(price .. '$'))

        imgui.SetCursorPosY(imgui.GetCursorPosY() + 45)
        imgui.SetCursorPosX(80)
        if imgui.Button(u8'Купить', imgui.ImVec2(150, 25)) then
            if buy_settings.count[0] < 1 then
                sampAddChatMessage(tag .. 'Количество приобретаемого товара не может быть меньше 1!', -1)
            else
                shop_buy.switch()
                sampSendDialogResponse(4428, 1, 1, buy_settings.count[0])
            end
        end
        imgui.SameLine(0, 40)
        if imgui.Button(u8'Отмена', imgui.ImVec2(150, 25)) then
            shop_buy.switch()
            sampSendDialogResponse(4428, 0, _, _)
        end
        imgui.SetCursorPosY(53)
        imgui.SetCursorPosX(170)
        imgui.Text(u8'Способ оплаты')
        imgui.SetNextItemWidth(212)
        imgui.SetCursorPosX(170)
        imgui.PushStyleVarVec2(imgui.StyleVar.WindowPadding, imgui.ImVec2(5, 5))
        if imgui.Combo('##pay_type', buy_settings.pay_int, new['const char*'][#buy_settings.pay_types](buy_settings.pay_types), #buy_settings.pay_types) then
            inisettings.settings.pay_type = buy_settings.pay_int[0]
            inicfg.save(inisettings, inicfgfile)
        end
        imgui.PopStyleVar()
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 8)
        imgui.SetCursorPosX(170)
        imgui.Text(u8'Количество приобретаемого товара')
        imgui.SetNextItemWidth(212)
        imgui.SetCursorPosX(170)
        imgui.InputInt(u8'##tpid', buy_settings.count)
        imgui.End()
        imgui.PopStyleVar()
    end
)

function item(i, title, price, i_of_all)
    title = title:gsub('^Продукт %- ', '')
    local draw_list = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local bgColor = i_of_all == hovered and {0.7, 0.1, 0.1, 1} or {1, 1, 1, 1}
    draw_list:AddRect(p, imgui.ImVec2(p.x + 130, p.y + 165), imgui.ColorConvertFloat4ToU32(bgColor), 15, bit.bor(bit.lshift(1, 0), bit.lshift(1, 1), bit.lshift(1, 2), bit.lshift(1, 3)))
    imgui.SetCursorPosY(imgui.GetCursorPosY() + 10)
    imgui.SetCursorPosX(imgui.GetCursorPosX() + 23.5)
    imgui.Image(imgui_textures[title], imgui.ImVec2(80, 80))
    imgui.SetCursorPosX((130 - imgui.CalcTextSize(u8(title)).x) / 2 + 20 + 135 * (i - 1))
    if imgui.CalcTextSize(u8(title)).x > 130 then
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 7)
        imgui.SetCursorPosX(imgui.GetCursorPosX() + 44)
        imgui.PushTextWrapPos(135)
        imgui.TextWrapped(u8(title))
        imgui.PopTextWrapPos()
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 8)
    else
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 15)
        imgui.Text(u8(title))
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 13)
    end
    imgui.SetCursorPosX((130 - imgui.CalcTextSize(u8(price .. '$')).x) / 2 + 20 + 135 * (i - 1))
    imgui.TextColored({0, 0.8, 0, 1}, tostring(price .. '$'))
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    --sampAddChatMessage(id, -1)
    if not buy_settings.buy_bool then
        if id == 4427 and (title:find('24/7') or title:find('Бар')) then
            if not shop.state then
                shop_type = title:match('{.+}(.+)')
                if shop_type ~= title then
                    item_list = {}
                end
                check_items = true
                shop.switch()
            end
            if check_items then
                for line in text:gmatch("[^\n]+") do
                    item_line_check(line)
                end
            end
        end
        if id == 4427 and title:find('Бар') and text:find('Спранк') and check_items then
            sampSendDialogResponse(4427, 0, _, _)
            return false
        end

        if id == 4427 and title:find('24/7') and text:find('Телефон') and not check_items then
            sampSendDialogResponse(4427, 0, _, _)
            return false
        end
        if id == 4427 and title:find('24/7') and text:find('Телефон') and check_items then
            sampSendDialogResponse(4427, 1, 10, _)
            return false
        end
        if id == 4427 and title:find('24/7') and text:find('Цемент') and check_items then
            sampSendDialogResponse(4427, 1, 10, _)
            return false
        end
        if id == 4427 and title:find('24/7') and text:find('Соль') and check_items then
            sampSendDialogResponse(4427, 1, 10, _)
            return false
        end
        if id == 4427 and title:find('24/7') and text:find('Горох') and check_items then
            sampSendDialogResponse(4427, 0, _, _)
            sampCloseCurrentDialogWithButton(0)
            check_items = false
            return false
        end
    else
        if not buy_settings.find then
            if id == 4427 and (title:find('24/7') and text:find('Телефон')) or (title:find('Бар') and text:find('Спранк')) then
                if buy_settings.c == 3 then
                    sampSendDialogResponse(4427, 1, 10, _)
                elseif buy_settings.c == 4 then
                    sampSendDialogResponse(4427, 1, 10, _)
                    sampSendDialogResponse(4427, 1, 10, _)
                elseif buy_settings.c == 5 then
                    sampSendDialogResponse(4427, 1, 10, _)
                    sampSendDialogResponse(4427, 1, 10, _)
                    sampSendDialogResponse(4427, 1, 10, _)
                end
                buy_settings.find = true
                buy_settings.buy_bool = false
                sampSendDialogResponse(4427, 1, buy_settings.i, 0)
                return false
            end
        end
    end

    if id == 4428 and title:find('Количество предметов') then
        shop_buy.switch()
        return false
    end
    if id == 4427 and title:find('24/7') and not shop.state and shop_buy.state then
        sampSendDialogResponse(4427, 0, _, _)
        return false
    end
    if id == 4429 and title:find('цена') and text:find('Оплата наличными') then
        sampSendDialogResponse(4429, 1, inisettings.settings.pay_type, _)
        return false
    end
end

function item_line_check(line)
    if line:match(".+%d+.+%$") then
        line = line:gsub(",", "")
        local title, price = line:match("^(.-)%s*(%d+)%$")
        local found_title = false
        for i, el in ipairs(item_list) do
            if el.title == title then
                item_list[i].price = price
                found_title = true
                break
            end
        end
        --sampAddChatMessage(title .. ' ' .. price, -1)
        if not found_title then
            table.insert(item_list, { title=title, price=price })
        end
    end
end

function onWindowMessage(msg, wparam, lparam)
    if wparam == 27 then
        if shop.state then
            if msg == wm.WM_KEYDOWN then
                consumeWindowMessage(true, true)
            end
            if msg == wm.WM_KEYUP then
                if shop.state then
                    if shop_buy.state then
                        shop_buy.switch()
                    else
                        shop.switch()
                        sampSendDialogResponse(4427, 0, _, _)
                    end
                end
            end
        end
    end
end

local function loadImages()
    for _, image in ipairs(image_file) do
        if imgui_textures[image.name] == nil and shop.state then
            if doesFileExist(image.file) then
                imgui_textures[image.name] = imgui.CreateTextureFromFile(image.file)
            else
                local png_name = image.file:match('.+%\\(.+)%.png')
                downloadUrlToFile('https://raw.githubusercontent.com/deffix-def/Mordor-Shop-Inferfaces/main/' .. png_name .. '.png', image.file, function(success)
                    if success then
                        imgui_textures[image.name] = imgui.CreateTextureFromFile(image.file)
                    else
                        sampAddChatMessage(tag .. 'Ошибка при скачивании иконки: ' .. image.name .. '!', -1)
                    end
                end)
            end
        end
    end
end

imgui.OnInitialize(function()
    local ImVec4 = imgui.ImVec4
    imgui.SwitchContext()
    imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.4, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.5, 0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.6, 0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.60, 0.50, 0.70, 1)
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.65, 0.55, 0.75, 1)
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.50, 0.45, 0.65, 0.51)
    imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.80, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.75, 0.60, 0.85, 1)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.80, 0.65, 0.90, 1)
    imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.6, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.75, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.9, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.30, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.4, 0.0, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.5, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.70, 0.60, 0.80, 1)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.75, 0.65, 0.85, 0.78)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.80, 0.70, 0.90, 1)
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.50, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.6, 0, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.70, 0.0, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.70, 0.60, 0.80, 0.35)
    imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1, 1, 1, 1)
    imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1)
    imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.95, 0.10, 0.30, 0.7)
    imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(0.9, 0.10, 0.30, 0)
    imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.20, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.70, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0, 0, 0, 0)
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.90, 0.30, 0.50, 1)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0, 0, 0, 0.9)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.2, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.3, 0.0, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.4, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.80, 0.0, 0.00, 1)
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.0, 0.00, 1)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.80, 0.0, 0.00, 1)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.0, 0.00, 1)
    -- == Декор == --
    imgui.GetStyle().WindowPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().FramePadding = imgui.ImVec2(3.5, 3.9)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 15
    imgui.GetStyle().GrabMinSize = 13
    imgui.GetStyle().WindowBorderSize = 0
    imgui.GetStyle().ChildBorderSize = 1
    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 1
    imgui.GetStyle().WindowRounding = 7
    imgui.GetStyle().ChildRounding = 2
    imgui.GetStyle().FrameRounding = 2
    imgui.GetStyle().PopupRounding = 2
    imgui.GetStyle().ScrollbarRounding = 1
    imgui.GetStyle().GrabRounding = 1
    imgui.GetStyle().TabRounding = 1

    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 15.0, nil, glyph_ranges)
    shop_type_font = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 25, _, glyph_ranges)

    for n = 1, 2 do
        for i, image in ipairs(image_file) do
            if imgui_textures[image.name] == nil and shop.state then
                if doesFileExist(image.file) then
                    imgui_textures[image.name] = imgui.CreateTextureFromFile(image.file)
                else
                    local png_name = image.file:match('.+%\\(.+)%.png')
                    downloadUrlToFile('https://raw.githubusercontent.com/deffix-def/Mordor-Shop-Inferfaces/main/' .. png_name .. '.png', image.file, function(success)
                        if success then
                            imgui_textures[image.name] = imgui.CreateTextureFromFile(image.file)
                        else
                            sampAddChatMessage(tag .. 'Ошибка при скачивании иконки: ' .. image.name .. '!', -1)
                        end
                    end)
                end
            end
        end
    end
end)