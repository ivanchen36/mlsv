function getVipClient(player, arg)
    local vipClient = {
        {
            ["type"] = "bg",
            ["img"] = "vip.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 461,
            ["y"] = 8,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        },
        {
            ["type"] = "img",
            ["title"] = "aLevel",
            ["x"] = 35,
            ["y"] = 29,
            ["img"] = "vip0.bmp",
        },
        {
            ["type"] = "img",
            ["title"] = "mask",
            ["x"] = 203,
            ["y"] = 34,
            ["img"] = "mask.bmp",
        },
        {
            ["type"] = "img",
            ["title"] = "me",
            ["x"] = 218,
            ["y"] = 48,
            ["img"] = player:getFace(),
        },
        {
            ["table"] = "0,2",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#vipTitle",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "#vipTitleVal",
        },
        {
            ["table"] = "0,2",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#vipTitle$Lab",
            ["x"] = 27,
            ["y"] = 146,
            ["img"] = "lab.bmp",
        },
        {
            ["table"] = "0,2",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#vipTitle$Text",
            ["x"] = 95,
            ["y"] = 151,
            ["text"] = "#vipTextVal",
        },
        {
            ["table"] = "0,2",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "btn",
            ["title"] = "#vipBtn",
            ["x"] = 187,
            ["y"] = 147,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "#vipBtnText",
            ["click"] = "#vipEvents",
        },
        {
            ["type"] = "btn",
            ["title"] = "upVip",
            ["x"] = 297,
            ["y"] = 143,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "����",
            ["click"] = "upVip",
        },
        {
            ["type"] = "btn",
            ["title"] = "upGift",
            ["x"] = 397,
            ["y"] = 143,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "���",
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