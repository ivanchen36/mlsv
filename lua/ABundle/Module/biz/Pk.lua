pkTitle = {"single", "team"}
pkTime = {"ÿ��������8��", "ÿ��������8��"}
pkRule = {"������", "��̭��"}
pkInfo = {"���˲�������ȡ���ֶһ�����", "����������������η��Ž���"}

local pkInfo = {}
local pkWnd = nil
function initPkContent()
    local level = pkInfo["level"]

end

function flushPkInfo(info)
    logPrintTbl(info)
    pkInfo = info;
    initPkContent()
end

function loadPkClient(client)
    logPrint("loadPkClient")
    logPrintTbl(client)
    pkWnd = createWindow("pk", client)
end

function showPk(info)
    if (pkWnd == nil) then
        Cli.Send("Pk_client")
        Cli.SysMessage("[ϵͳ��ʾ] pkϵͳ�������ڼ����У����Ժ�",4,3)
        return
    end
    logPrint( 'showPk1')
    logPrintTbl(info)
    pkInfo = info;
    pkWnd:show()
    initPkContent()
    logPrint( 'showPk2')
end

Cli.Send().wait["FLUSH_PK"] = flushPkInfo
cli.send().wait["SHOW_PK"] = showPk
Cli.Send().wait["PK_CLIENT"] = loadPkClient
Cli.Send("pk_client")