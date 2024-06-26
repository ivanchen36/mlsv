TaskHandler = {}
local timerTask = {}
-- type
-- 1 关闭驱魔
-- 2 开启pk
-- 3 设置人物经验
-- 4 设置技能经验
-- 5 设置生产经验
-- 6 系统天降
-- 7 开启世界boss
-- 8 关闭世界boss
-- 10 开启个人pk
-- 99 游戏公告
-- 100 发放物品

local taskHandlerIndex = nil;

function initTaskHandler()
    if (taskHandlerIndex ~= nil) then
        return 1;
    end

    taskHandlerIndex = NL.CreateNpc(nil, "NPCInit");
    local myPlayer = MyPlayer:new(taskHandlerIndex);
    myPlayer:setImage(101003)
    myPlayer:setOriginalForm(101003)
    myPlayer:setX(21)
    myPlayer:setY(21)
    myPlayer:setMapId(777)
    myPlayer:setDirection(4)
    myPlayer:setName("彩虹使者")
    Char.SetLoopEvent(nil, "doTask", taskHandlerIndex, 3000);
end

function doTask(index)
    local sql = "SELECT Id, RegNum, Type, Info FROM tbl_task WHERE Status = 1 and ExeTime <= UNIX_TIMESTAMP()"
    local rs = SQL.Run(sql);

    if(type(rs) ~= "table")then
        return
    end
    local len = countKeys(rs)
    for i = 0, (len / 4) - 1  do
        local id = rs[i .. "_0"]
        local regNum = tonumber(rs[i .. "_1"])
        local type = tonumber(rs[i .. "_2"])
        local info = rs[i .. "_3"]
        if rawget(TaskHandler, type) == nil then
            logPrint("TaskHandler[" .. type .. "] is not function")
            return
        end
        local rs = TaskHandler[type](regNum, info)
        if 1 == rs then
            local sql1 = "UPDATE tbl_task SET Status = 2 WHERE Id = " .. id
            SQL.Run(sql1);
        end
    end

    for _, func in ipairs(timerTask) do
        func()
    end
end

function addTimerTask(func)
    table.insert(timerTask, func)
end

function sysNotice(regNum, info)
    NLG.SystemMessage(-1 , info)
    return 1
end

function sendItem(regNum, info)
    local player = MyPlayer:new(vipInfo[regNum]["index"])
    player:getItem(tonumber(info))
    return 1
end

TaskHandler[99] = sysNotice
TaskHandler[100] = sendItem
