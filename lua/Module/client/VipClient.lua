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
            ["title"] = "level",
            ["x"] = 59,
            ["y"] = 50,
            ["img"] = "vip10.bmp",
        },
        {
            ["type"] = "img",
            ["title"] = "me",
            ["x"] = 135,
            ["y"] = 141,
            ["img"] = player:getFace(),
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "lab",
            ["title"] = "#vipTitle",
            ["x"] = 240,
            ["y"] = 82,
            ["text"] = "#vipTitleVal",
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "lab",
            ["title"] = "#vipText",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "#vipTextVal",
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "btn",
            ["title"] = "#vipBtn",
            ["x"] = 400,
            ["y"] = 78,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "#vipBtnText",
            ["click"] = "#vipEvents",
        },
        {
            ["type"] = "btn",
            ["title"] = "upVip",
            ["x"] = 362,
            ["y"] = 258,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "����",
            ["click"] = "upVip",
        },
        {
            ["type"] = "btn",
            ["title"] = "upGift",
            ["x"] = 407,
            ["y"] = 258,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "��ȡ",
            ["click"] = "upGift",
        }
    }
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