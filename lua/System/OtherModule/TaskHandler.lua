TaskHandler = {}
local timerTask = {}
-- type
-- 1 �ر���ħ
-- 2 ����pk
-- 3 �������ﾭ��
-- 4 ���ü��ܾ���
-- 5 ������������
-- 6 ϵͳ�콵
-- 7 ��������boss
-- 8 �ر�����boss
-- 10 ��������pk
-- 99 ��Ϸ����
-- 100 ������Ʒ

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
    myPlayer:setName("�ʺ�ʹ��")
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
