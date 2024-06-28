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
            ["text"] = "升级",
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
            ["text"] = "礼包",
            ["click"] = "upGift",
        }
    }
    Protocol.PowerSend(player:getObj(), "VIP_CLIENT", vipClient)
end

ClientEvent["vip_client"] = getVipClient

-- 7 人物状态
-- 8 人物明细
-- 8 人物称号
-- 10 职业
-- 12 工作状态
-- 13 技能经验
-- 13 技能经验
-- 14 物品
-- 15 宠物
-- 16 宠物状态
-- 17 宠物明细
-- 18 宠物技能
-- 19 宠物图鉴
-- 20 图鉴明细
-- 21 名片
-- 22 信件
-- 24 系统
-- 25 热键设定
-- 30 战斗结束
-- 31 PK结束
-- 33 地图
-- 34 动作
-- 35 聊天框
-- 36 聊天框
-- 43 交易界面
-- 44 选择对象
-- 48 家族
-- 50 留言
-- 58 人物简介
-- 67 摆摊