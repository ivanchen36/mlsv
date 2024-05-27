TaskHandler = {}
-- type
-- 1 �ر���ħ
-- 2 ����pk
-- 3 �������ﾭ��
-- 4 ���ü��ܾ���
-- 5 �������ﾭ��
-- 6 ϵͳ�콵
-- 7 ��������boss
-- 8 �ر�����boss
-- 99 ��Ϸ����

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
    myPlayer:setName("��ʱ������")
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
