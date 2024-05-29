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
            ["text"] = "领取",
        }
    }
    logPrint("getVipClient")
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
-- 68

function showVip1(player)
    Protocol.PowerSend(player:getObj(),"SHOW_VIP", 70)
end

TalkEvent["vip1"] = showVip1