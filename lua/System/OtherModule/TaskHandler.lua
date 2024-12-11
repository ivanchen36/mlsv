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

    local myPlayer = MyPlayer:createNpc(0, 0, 0, 0, 4, "�ʺ�ʹ��")
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