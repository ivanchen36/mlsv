function getVipClient(player, arg)
    local vipClient = {
        {
            ["type"] = "bg",
            ["img"] = "vip.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 466,
            ["y"] = 14,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        },
        {
            ["type"] = "img",
            ["x"] = 60,
            ["y"] = 50,
            ["img"] = "vip0.bmp",
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "lab",
            ["title"] = "#vipTitle",
            ["x"] = 260,
            ["y"] = 74,
            ["text"] = "#vipTitleVal",
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "lab",
            ["title"] = "#vipText",
            ["x"] = 320,
            ["y"] = 74,
            ["text"] = "",
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "btn",
            ["title"] = "#vipBtn",
            ["x"] = 380,
            ["y"] = 77,
            ["img"] = "green1.bmp",
            ["active"] = "green2.bmp",
            ["disable"] = "gray.bmp",
            ["text"] = "#vipBtnText",
            ["click"] = "#vipEvents",
        },
        {
            ["type"] = "btn",
            ["title"] = "collect",
            ["x"] = 362,
            ["y"] = 247,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "��ȡ",
        }
    }
    logPrint("getVipClient")
    Protocol.PowerSend(player:getObj(), "VIP_CLIENT", vipClient)
end

ClientEvent["vip_client"] = getVipClient

-- 7 ����״̬
-- 8 ������ϸ
-- 8 ����ƺ�
-- 10 ְҵ
-- 12 ����״̬
-- 13 ���ܾ���
-- 13 ���ܾ���
-- 14 ��Ʒ
-- 15 ����
-- 16 ����״̬
-- 17 ������ϸ
-- 18 ���＼��
-- 19 ����ͼ��
-- 20 ͼ����ϸ
-- 21 ��Ƭ
-- 22 �ż�
-- 24 ϵͳ
-- 25 �ȼ��趨
-- 30 ս������
-- 31 PK����
-- 33 ��ͼ
-- 34 ����
-- 35 �����
-- 36 �����
-- 43 ���׽���
-- 44 ѡ�����
-- 48 ����
-- 50 ����
-- 58 ������
-- 67 ��̯
-- 68

function showVip1(player)
    Protocol.PowerSend(player:getObj(),"SHOW_VIP", 70)
end

TalkEvent["vip1"] = showVip1