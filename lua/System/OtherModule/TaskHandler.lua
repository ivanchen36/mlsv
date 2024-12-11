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

    local myPlayer = MyPlayer:createNpc(0, 0, 0, 0, 4, "彩虹使者")
    taskHandlerIndex = myPlayer:getObj()
    Char.SetLoopEvent(nil, "doTask", taskHandlerIndex, 3000);
end

function doTask(index)
    for _, func in ipairs(timerTask) do
        func()
    end

    local sql = "SELECT Id, RegNum, Type, Info FROM tbl_task WHERE Status = 1 and ExeTime <= UNIX_TIMESTAMP()"
    local rs = SQL.Run(sql);

    if(type(rs) ~= "table")then
        return
    end
    for i = 0, 99999 do
        if rs[i .. "_0"] == nil then
            break
        end
        local id = rs[i .. "_0"]
        local regNum = tonumber(rs[i .. "_1"])
        local type = tonumber(rs[i .. "_2"])
        local info = rs[i .. "_3"]
        if rawget(TaskHandler, type) == nil then
            logPrint("TaskHandler[" .. type .. "] is not function")
        else
            local rs = TaskHandler[type](regNum, info)
            if 1 == rs then
                local sql1 = "UPDATE tbl_task SET Status = 2 WHERE Id = " .. id
                SQL.Run(sql1);
            end
        end
    end
end

function addTimerTask(func)
    table.insert(timerTask, func)
end

function sysNotice(regNum, info)
    NLG.SystemMessage(-1 , info)
    return 1
end

TaskHandler[99] = sysNotice