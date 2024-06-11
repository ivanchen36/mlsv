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
            ["text"] = "升级",
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
            ["text"] = "领取",
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