TaskHandler = {}
-- type
-- 1 关闭驱魔
-- 2 开启pk
-- 3 设置人物经验
-- 4 设置技能经验
-- 5 设置人物经验
-- 6 系统天降
-- 7 开启世界boss
-- 8 关闭世界boss
-- 99 游戏公告

local taskHandlerIndex = nil;
function initTaskHandlerNpc(_index)
    print("initTaskHandlerNpc")
    return true;
end

function initTaskHandler()
    if (taskHandlerIndex ~= nil) then
        return 1;
    end

    taskHandlerIndex = NL.CreateNpc("lua/System/OtherModule/TaskHandler.lua", "NPCInit");
    local myPlayer = MyPlayer:new(taskHandlerIndex);
    myPlayer:setImage(101003)
    myPlayer:setOriginalForm(101003)
    myPlayer:setX(21)
    myPlayer:setY(21)
    myPlayer:setMapId(777)
    myPlayer:setDirection(4)
    myPlayer:setName("定时任务处理")
    Char.SetLoopEvent("lua/System/OtherModule/TaskHandler.lua", "doTask", taskHandlerIndex, 3000);
end

function doTask(index)
    local sql = "SELECT Id, RegNum, Type, Info FROM tbl_task WHERE Status = 1 and ExeTime <= " .. os.time()
    local rs = SQL.Run(sql);
    if(type(rs) ~= "table")then
        return;
    end
    for i = 0, ((#rs) / 5) - 1  do
        local id = rs[i .. "_0"]
        local regNum = rs[i .. "_1"]
        local type = rs[i .. "_2"]
        local info = rs[i .. "_3"]
        local rs = TaskHandler[type](regNum, info)
        if 1 == rs then
            local sql1 = "UPDATE tbl_task SET Status = 2 WHERE Id = " .. id
            SQL.Run(sql1);
        end
    end
end
