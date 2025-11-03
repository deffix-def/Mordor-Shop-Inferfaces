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
    { name = 'pizza1', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pizza1.png" },
    { name = 'pizza2', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pizza2.png" },
    { name = 'pizza3', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pizza3.png" },
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
    { name = 'Кальян', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\smoke.png" },

    { name = 'Бренди', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\brendi.png" },
    { name = 'Джин', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\gin.png" },
    { name = 'Красное вино', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\redvino.png" },
    { name = 'Белое вино', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\whitevino.png" },
    { name = 'Шампанское', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\shampanskoe.png" },


    { name = 'Бургер', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\burger.png" },
    { name = 'Детское блюдо Моо', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\moo.png" },
    { name = 'Набор с говяжьим бургером', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\burger_govyadina.png" },
    { name = 'Набор с бургером из стейка', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\burger_steyk.png" },

    { name = 'Пончик', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\donut.png" },
    { name = 'Кофе', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\coffe.png" },
    { name = 'Кофе с пончиком и кексом', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\coffe2.png" },
    { name = 'Двойная порция пончиков', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\donut2.png" },
    { name = 'Огромная порция пончиков с кофе', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\donut3.png" },

    { name = 'Кусок пиццы', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pizza.png" },
    { name = 'Маленькая порция с пиццей', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pizzalow.png" },
    { name = 'Средняя порция с пиццей', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pizzamiddle.png" },
    { name = 'Набор с большой пиццей', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\pizzabig.png" },
    { name = 'Набор с салатом', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\salat.png" },

    { name = 'Ролл Цезарь', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\roll.png" },
    { name = 'Маленькая порция Клакин Белл', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\belllow.png" },
    { name = 'Средняя порция Клакин Белл', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\bellmiddle.png" },
    { name = 'Большая порция Клакин Белл', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\bellbig.png" },

    { name = 'Канистра', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\fuel.png" },
    { name = 'Ремкомплект', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\tools.png" },
    { name = 'Ремкомплект В/Ш', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\toolsvsh.png" },
    { name = 'Баллон с пропаном', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\ballon.png" },
    { name = 'АИ-80', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\ai80.png" },
    { name = 'АИ-92', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\ai92.png" },
    { name = 'АИ-95', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\ai95.png" },
    { name = 'АИ-98', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\ai98.png" },
    { name = 'АИ-100', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\ai100.png" },
    { name = 'Газ', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\gas.png" },
    { name = 'Дизель', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\dt.png" },
    { name = 'Выделенная АЗС', file = getWorkingDirectory() .. "\\Mordor Shop Interfaces\\Images\\hovered_fuel.png" }
}

local imgui_textures = {
    ['pizza1'] = nil,
    ['pizza2'] = nil,
    ['pizza3'] = nil,
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
    ['Кальян'] = nil,

    ['Бренди'] = nil,
    ['Джин'] = nil,
    ['Красное вино'] = nil,
    ['Белое вино'] = nil,
    ['Шампанское'] = nil,

    ['Бургер'] = nil,
    ['Детское блюдо Моо'] = nil,
    ['Набор с говяжьим бургером'] = nil,
    ['Набор с бургером из стейка'] = nil,

    ['Пончик'] = nil,
    ['Кофе'] = nil,
    ['Кофе с пончиком и кексом'] = nil,
    ['Двойная порция пончиков'] = nil,
    ['Огромная порция пончиков с кофе'] = nil,

    ['Кусок пиццы'] = nil,
    ['Маленькая порция с пиццей'] = nil,
    ['Средняя порция с пиццей'] = nil,
    ['Набор с большой пиццей'] = nil,
    ['Набор с салатом'] = nil,

    ['Ролл Цезарь'] = nil,
    ['Маленькая порция Клакин Белл'] = nil,
    ['Средняя порция Клакин Белл'] = nil,
    ['Большая порция Клакин Белл'] = nil,

    ['АИ-80'] = nil,
    ['АИ-92'] = nil,
    ['АИ-95'] = nil,
    ['АИ-98'] = nil,
    ['АИ-100'] = nil,
    ['Газ'] = nil,
    ['Дизель'] = nil,
    ['Выделенная АЗС'] = 1
}

local item_list = {}
local fuel_list = {}
local check_items = false
local checked_fuel = false
local exit_azs = false
local hovered = -1
local hovered_fuel = -1
local first_use = 0
local first = true
local buy_settings = {
    pay_int = new.int(inisettings.settings.pay_type),
    pay_types = {u8'Наличные', u8'Банковская карта'},
    azs = false,
    max_fuel = 0,
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
local shop = { state = true, duration = 0.3 }
local shop_buy = { state = true, duration = 0.15 }
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
        local new_hovered_fuel = -1
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
                        if shop_type == 'Заправочная станция' then
                            i = i + 1
                        end
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
            if isCharInAnyCar(PLAYER_PED) or isCharOnAnyBike(PLAYER_PED) then
                if shop_type == 'Заправочная станция' then
                    imgui.SetCursorPosY(imgui.GetCursorPosY() + 17)
                    imgui.Separator()
                    for i, station in ipairs(fuel_list) do
                        local wpos = imgui.GetWindowPos()
                        local cx, cy = getCursorPos()
                        local x = (i - 1) % 7 * 119
                        local y = 195 + math.floor((i - 1) / 7) * 145
                        imgui.SetCursorPosX(x)
                        imgui.SetCursorPosY(y)
                        fuel(i, station.title, station.price)
                        if cx > wpos.x and cx < wpos.x + 845 and cy > wpos.y and cy < wpos.y + 560 then
                            if cx > x + wpos.x and cx < x + 119 + wpos.x and cy + imgui.GetScrollY() > y + wpos.y and cy + imgui.GetScrollY() < y + 138 + wpos.y then
                                new_hovered_fuel = i
                                if imgui.IsMouseClicked(0) then
                                    buy_settings.azs = true
                                    buy_settings.title = station.title
                                    buy_settings.price = station.price
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
                end
            end
            for i = 1, 6 do
                imgui.Spacing()
            end
            if new_hovered ~= hovered then
                hovered = new_hovered
            end
            if new_hovered_fuel ~= hovered_fuel then
                hovered_fuel = new_hovered_fuel
            end
        imgui.EndChild()
        imgui.SetCursorPosX(810)
        imgui.SetCursorPosY(5)
        imgui.Image(imgui_textures['esc'], imgui.ImVec2(33, 33))
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
        title = title:gsub(' %(еда%)', '')
        local price = buy_settings.price
        imgui.SetCursorPosX(20)
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 15)
        local p2 = imgui.GetCursorScreenPos()
        dl:AddRect(p2, imgui.ImVec2(p2.x + 130, p2.y + 165), imgui.ColorConvertFloat4ToU32({0.7, 0.1, 0.1, 1}), 15, bit.bor(bit.lshift(1, 0), bit.lshift(1, 1), bit.lshift(1, 2), bit.lshift(1, 3)))
        if shop_type == 'Заправочная станция' and (title:find('АИ') or title:find('Газ') or title:find('Дизель')) then
            imgui.Image(imgui_textures[title], imgui.ImVec2(119, 145))
            if title:find('Дизель') then
                title = 'ДТ'
            end
            imgui.SetCursorPosY(imgui.GetCursorPosY() - 75)
            imgui.PushFont(fuel_title_font)
            imgui.SetCursorPosX((145 - imgui.CalcTextSize(u8(title)).x) / 2)
            imgui.Text(u8(title))
            imgui.PopFont()
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 45)
            imgui.SetCursorPosX((170 - imgui.CalcTextSize(tostring(new_num(price) .. u8'$/1л.')).x) / 2)
            imgui.TextColored({0, 0.8, 0, 1}, tostring(new_num(price) .. u8'$/1л.'))
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 43)
        else
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 10)
            imgui.SetCursorPosX(imgui.GetCursorPosX() + 23.5)
            imgui.Image(imgui_textures[title], imgui.ImVec2(80, 80))
            imgui.SetCursorPosX((130 - imgui.CalcTextSize(u8(title)).x) / 2 + 20)
            size_check(title)
            imgui.SetCursorPosX((130 - imgui.CalcTextSize(u8(price .. '$')).x) / 2 + 20)
            imgui.TextColored({0, 0.8, 0, 1}, tostring(price .. '$'))
            imgui.SetCursorPosY(imgui.GetCursorPosY() + 45)
        end
        imgui.SetCursorPosX(80)
        if imgui.Button(u8'Купить', imgui.ImVec2(150, 25)) then
            if buy_settings.count[0] < 1 then
                sampAddChatMessage(tag .. 'Количество приобретаемого товара не может быть меньше 1!', -1)
            else
                if shop_type == 'Заправочная станция' then
                    sampSendDialogResponse(32700, 1, 1, buy_settings.count[0])
                else
                    sampSendDialogResponse(4428, 1, 1, buy_settings.count[0])
                end
                shop_buy.switch()
            end
        end
        imgui.SameLine(0, 40)
        if imgui.Button(u8'Отмена', imgui.ImVec2(150, 25)) then
            shop_buy.switch()
            buy_settings.azs = false
            if shop_type == 'Заправочная станция' then
                exit_azs = true
                sampSendDialogResponse(32700, 0, _, _)
            else
                sampSendDialogResponse(4428, 0, _, _)
            end
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
        if shop_type == 'Заправочная станция' and (title:find('АИ') or title:find('Газ') or title:find('ДТ')) then
            imgui.Text(u8'Количество топлива для заправки:')
            imgui.SetCursorPosX(170)
            if tonumber(buy_settings.max_fuel) <= 0 then
                imgui.Text(u8'Бак полный! Топливо больше не влезет.')
            else
                imgui.SetNextItemWidth(212)
                imgui.SliderInt('##fuel_slider', buy_settings.count, 1, tonumber(buy_settings.max_fuel))
                imgui.SameLine()
                if imgui.Button(u8'Полный бак', imgui.ImVec2(100, 22)) then
                    buy_settings.count = new.int(tonumber(buy_settings.max_fuel))
                end
                imgui.SetCursorPosX(170)
                imgui.Text(u8'Вы заплатите: ' .. new_num(tostring(buy_settings.count[0] * price)) .. '$')
            end
        else
            imgui.Text(u8'Количество приобретаемого товара')
            imgui.SetNextItemWidth(212)
            imgui.SetCursorPosX(170)
            imgui.InputInt(u8'##tpid', buy_settings.count)
        end
        imgui.End()
        imgui.PopStyleVar()
    end
)

function item(i, title, price, i_of_all)
    title = title:gsub('^Продукт %- ', '')
    title = title:gsub(' %(еда%)', '')
    local draw_list = imgui.GetWindowDrawList()
    local p = imgui.GetCursorScreenPos()
    local bgColor = i_of_all == hovered and {0.7, 0.1, 0.1, 1} or {1, 1, 1, 1}
    draw_list:AddRect(p, imgui.ImVec2(p.x + 130, p.y + 165), imgui.ColorConvertFloat4ToU32(bgColor), 15, bit.bor(bit.lshift(1, 0), bit.lshift(1, 1), bit.lshift(1, 2), bit.lshift(1, 3)))
    imgui.SetCursorPosY(imgui.GetCursorPosY() + 10)
    imgui.SetCursorPosX(imgui.GetCursorPosX() + 23.5)
    imgui.Image(imgui_textures[title], imgui.ImVec2(80, 80))
    imgui.SetCursorPosX((130 - imgui.CalcTextSize(u8(title)).x) / 2 + 20 + 135 * (i - 1))
    size_check(title)
    imgui.SetCursorPosX((130 - imgui.CalcTextSize(u8(new_num(price) .. '$')).x) / 2 + 20 + 135 * (i - 1))
    imgui.TextColored({0, 0.8, 0, 1}, tostring(new_num(price) .. '$'))
end

function fuel(i, title, price)
    if i == hovered_fuel then
        imgui.Image(imgui_textures['Выделенная АЗС'], imgui.ImVec2(119, 145))
    else
        imgui.Image(imgui_textures[title], imgui.ImVec2(119, 145))
    end
    if title:find('Дизель') then
        title = 'ДТ'
    end
    imgui.SetCursorPosY(imgui.GetCursorPosY() - 75)
    imgui.PushFont(fuel_title_font)
    imgui.SetCursorPosX((105 - imgui.CalcTextSize(u8(title)).x) / 2 + 119 * (i - 1))
    imgui.Text(u8(title))
    imgui.PopFont()
    imgui.SetCursorPosY(imgui.GetCursorPosY() + 35)
    imgui.SetCursorPosX((105 - imgui.CalcTextSize(tostring(new_num(price) .. u8'$/1л.')).x) / 2 + 119 * (i - 1))
    imgui.TextColored({0, 0.8, 0, 1}, tostring(new_num(price) .. u8'$/1л.'))
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    --sampAddChatMessage(id, -1)
    if not buy_settings.buy_bool then
        if (id == 4427 and (title:find('24/7') or title:find('Бар') or title:find('Стрип%-клуб') or title:find('Закусочная Burger Shot') or title:find('Закусочная Rusty Brown') or title:find('Закусочная Cluckin Bell') or title:find('Закусочная Pizzeria'))) or (id == 32700 and (title:find('Заправочная станция') or title:find('Тип топлива'))) then
            if not shop.state then
                if title:find('Закусочная Rusty Brown') then
                    title = title:match('({.+}Закусочная Rusty Brown).+')
                end
                if title:find('Заправочная станция') then
                    title = title:match('({.+}Заправочная станция).+') 
                end
                shop_type = title:match('{.+}(.+)')
                if shop_type ~= title then
                    item_list = {}
                end
                check_items = true
                shop.switch()
            end
            if check_items then
                for line in text:gmatch("[^\n]+") do
                    if not line:find('Топливо') then
                        item_line_check(line)
                    end
                end
            end
        end
        if id == 4427 and title:find('Стрип%-клуб') and text:find('Темное пиво') and check_items then
            sampSendDialogResponse(4427, 0, _, _)
            check_items = false
            return false
        end
        if id == 4427 and title:find('Бар') and text:find('Спранк') and check_items then
            sampSendDialogResponse(4427, 0, _, _)
            check_items = false
            return false
        end

        if id == 4427 and title:find('Закусочная Burger Shot') and text:find('Бургер %(еда%)') and check_items then
            sampSendDialogResponse(4427, 0, _, _)
            check_items = false
            return false
        end
        if id == 4427 and title:find('Закусочная Rusty Brown') and text:find('Пончик') and check_items then
            sampSendDialogResponse(4427, 0, _, _)
            check_items = false
            return false
        end
        if id == 4427 and title:find('Закусочная Cluckin Bell') and text:find('Ролл Цезарь') and check_items then
            sampSendDialogResponse(4427, 0, _, _)
            check_items = false
            return false
        end
        if id == 4427 and title:find('Закусочная Pizzeria') and text:find('Кусок пиццы') and check_items then
            sampSendDialogResponse(4427, 0, _, _)
            check_items = false
            return false
        end

        if id == 32700 and title:find('Заправочная станция') and text:find('Топливо') then
            if exit_azs then
                sampSendDialogResponse(32700, 0, _, _)
                exit_azs = false
                check_items = false
                return false
            else
                if isCharInAnyCar(PLAYER_PED) or isCharOnAnyBike(PLAYER_PED) then
                    if check_items and not checked_fuel then
                        sampSendDialogResponse(32700, 1, 0, _)
                        return false
                    else
                        sampSendDialogResponse(32700, 0, _, _)
                        check_items = false
                        checked_fuel = false
                        return false
                    end
                else
                    if check_items then
                        sampSendDialogResponse(32700, 0, _, _)
                        check_items = false
                        return false
                    end
                end
            end
        end
        if id == 32700 and title:find('Тип топлива') and text:find('АИ') and check_items then
            if exit_azs then
                sampSendDialogResponse(32700, 0, _, _)
                return false
            else
                sampSendDialogResponse(32700, 0, _, _)
                checked_fuel = true
                return false
            end
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
            if id == 4427 and ((title:find('24/7') and text:find('Телефон')) or (title:find('24/7') and text:find('Цемент')) or (title:find('24/7') and text:find('Соль')) or (title:find('24/7') and text:find('Горох'))) then
                if buy_settings.c == 2 then
                    if id == 4427 and title:find('24/7') and text:find('Телефон') then
                        buy_settings.find = true
                        buy_settings.buy_bool = false
                        sampSendDialogResponse(4427, 1, buy_settings.i, 0)
                        return false
                    end
                elseif buy_settings.c == 3 then
                    if id == 4427 and title:find('24/7') and text:find('Телефон') then
                        sampSendDialogResponse(4427, 1, 10, _)
                        return false
                    end
                    if id == 4427 and title:find('24/7') and text:find('Цемент') then
                        buy_settings.find = true
                        buy_settings.buy_bool = false
                        sampSendDialogResponse(4427, 1, buy_settings.i, 0)
                        return false
                    end
                elseif buy_settings.c == 4 then
                    if id == 4427 and title:find('24/7') and text:find('Телефон') then
                        sampSendDialogResponse(4427, 1, 10, _)
                        return false
                    end
                    if id == 4427 and title:find('24/7') and text:find('Цемент') then
                        sampSendDialogResponse(4427, 1, 10, _)
                        return false
                    end
                    if id == 4427 and title:find('24/7') and text:find('Соль') then
                        buy_settings.find = true
                        buy_settings.buy_bool = false
                        sampSendDialogResponse(4427, 1, buy_settings.i, 0)
                        return false
                    end
                elseif buy_settings.c == 5 then
                    if id == 4427 and title:find('24/7') and text:find('Телефон') then
                        sampSendDialogResponse(4427, 1, 10, _)
                        return false
                    end
                    if id == 4427 and title:find('24/7') and text:find('Цемент') then
                        sampSendDialogResponse(4427, 1, 10, _)
                        return false
                    end
                    if id == 4427 and title:find('24/7') and text:find('Соль') then
                        sampSendDialogResponse(4427, 1, 10, _)
                        return false
                    end
                    if id == 4427 and title:find('24/7') and text:find('Горох') then
                        buy_settings.find = true
                        buy_settings.buy_bool = false
                        sampSendDialogResponse(4427, 1, buy_settings.i, 0)
                        return false
                    end
                end
            elseif id == 4427 and ((title:find('Бар') and text:find('Спранк')) or (title:find('Стрип%-клуб') and text:find('Темное пиво')) or (title:find('Закусочная Burger Shot') and text:find('Бургер %(еда%)')) or (title:find('Закусочная Rusty Brown') and text:find('Пончик')) or (title:find('Закусочная Cluckin Bell') and text:find('Ролл Цезарь')) or (title:find('Закусочная Pizzeria') and text:find('Кусок пиццы'))) then
                if buy_settings.c == 3 then
                    sampSendDialogResponse(id, 1, 10, _)
                elseif buy_settings.c == 4 then
                    sampSendDialogResponse(id, 1, 10, _)
                    sampSendDialogResponse(id, 1, 10, _)
                elseif buy_settings.c == 5 then
                    sampSendDialogResponse(id, 1, 10, _)
                    sampSendDialogResponse(id, 1, 10, _)
                    sampSendDialogResponse(id, 1, 10, _)
                end
                buy_settings.find = true
                buy_settings.buy_bool = false
                sampSendDialogResponse(id, 1, buy_settings.i, 0)
                return false
            elseif id == 32700 and (title:find('Заправочная станция') and text:find('Канистра') or title:find('Тип топлива') and text:find('АИ')) then
                if buy_settings.azs then
                    if id == 32700 and title:find('Заправочная станция') and text:find('Канистра') then
                        sampSendDialogResponse(32700, 1, 0, _)
                        return false
                    end
                    if id == 32700 and title:find('Тип топлива') and text:find('АИ') then
                        buy_settings.find = true
                        buy_settings.buy_bool = false
                        sampSendDialogResponse(32700, 1, buy_settings.i, 0)
                        return false
                    end
                else
                    buy_settings.find = true
                    buy_settings.buy_bool = false
                    sampSendDialogResponse(32700, 1, buy_settings.i, 0)
                    return false
                end
            end
        end
    end

    if (id == 4428 and title:find('Количество предметов')) or (id == 32700 and (title:find('Покупка топлива') or title:find('Покупка канистр') or title:find('Покупка ремкомплектов') or title:find('Покупка пропановых баллонов'))) then
        if text:find('Введите кол%-во топлива для заправки. Вы можете заправить %d+ литров.') then
            buy_settings.max_fuel = tonumber(text:match('Введите кол%-во топлива для заправки%. Вы можете заправить (%d+) литров%.')) - 1
        end
        shop_buy.switch()
        return false
    end
    if id == 4427 and title:find('24/7') and not shop.state and shop_buy.state then
        sampSendDialogResponse(4427, 0, _, _)
        return false
    end
    if ((id == 4429 and title:find('цена') and text:find('Оплата наличными')) or (id == 32700 and title:find('Способ оплаты') and text:find('Оплата наличными'))) then
        sampSendDialogResponse(id, 1, inisettings.settings.pay_type, _)
        return false
    end
end

function item_line_check(line)
    if line:match(".+%d+.+%$") then
        line = line:gsub(",", "")
        line = line:gsub("Доступно", "")
        line = line:gsub("Закончились", "")
        local title, price = line:match("^(.-)%s+(%d+)")
        if title and price then
            local found_title_item = false
            local found_title_fuel = false
            if title:find('АИ%-%d+') or title:find('Дизель') or title:find('Газ') then
                for i, el in ipairs(fuel_list) do
                    if el.title == title then
                        fuel_list[i].price = price
                        found_title_fuel = true
                        break
                    end
                end
                if not found_title_fuel then
                    table.insert(fuel_list, { title=title, price=price })
                end
            else
                for i, el in ipairs(item_list) do
                    if el.title == title then
                        item_list[i].price = price
                        found_title_item = true
                        break
                    end
                end
                if not found_title_item then
                    table.insert(item_list, { title=title, price=price })
                end
            end
        end
    end
end

function size_check(title)
    local textSizeX = imgui.CalcTextSize(u8(title)).x
    if textSizeX >= 167 then
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 7)
        imgui.SetCursorPosX(imgui.GetCursorPosX() + 32)
        if title:find('Коробка конфет в виде сердца') or title:find('Клакин Белл') then
            imgui.SetCursorPosX(imgui.GetCursorPosX() + 7)
        end
        if title:find('Огромная порция пончиков') then
            imgui.SetCursorPosX(imgui.GetCursorPosX() + 20)
        end
        imgui.PushTextWrapPos(imgui.GetCursorPosX() - 32 + 165)
        imgui.TextWrapped(u8(title))
        imgui.PopTextWrapPos()
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 7)
    elseif textSizeX >= 165 and textSizeX < 167 then
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 7)
        imgui.SetCursorPosX(imgui.GetCursorPosX() + 22)
        imgui.PushTextWrapPos(imgui.GetCursorPosX() - 22 + 165)
        imgui.TextWrapped(u8(title))
        imgui.PopTextWrapPos()
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 7)
    elseif textSizeX > 130 and textSizeX < 165 then
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 7)
        imgui.SetCursorPosX(imgui.GetCursorPosX() + 25)
        if title:find('Двойная порция пончиков') then
            imgui.SetCursorPosX(imgui.GetCursorPosX() + 4)
        end
        imgui.PushTextWrapPos(imgui.GetCursorPosX() - 25 + math.min(textSizeX, 165))
        imgui.TextWrapped(u8(title))
        imgui.PopTextWrapPos()
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 8)
    else
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 15)
        imgui.Text(u8(title))
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 13)
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
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.6, 0.0, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.80, 0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.6, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.75, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.9, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.30, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.4, 0.0, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.5, 0.0, 0.0, 1)
    imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.8, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.8, 0.00, 0, 1)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.9, 0.00, 0, 1)
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
    imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 15, nil, glyph_ranges)
    shop_type_font = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 25, _, glyph_ranges)
    fuel_title_font = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 18.5, _, glyph_ranges)

    for i, image in ipairs(image_file) do
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
end)