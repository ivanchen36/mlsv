function getSellerClient(player, arg)
    local sellerClient = {
        {
            ["type"] = "bg",
            ["img"] = "seller.bmp",
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
            ["type"] = "lab",
            ["title"] = "title",
            ["x"] = 210,
            ["y"] = 35,
            ["text"] = "",
            ["font"] = 10,
        },
        {
            ["table"] = "1,10",
            ["high"] = 26,
            ["type"] = "btn",
            ["title"] = "cat&",
            ["x"] = 20,
            ["y"] = 70,
            ["img"] = "menu1.bmp",
            ["active"] = "menu2.bmp",
            ["disable"] = "menu3.bmp",
            ["text"] = "",
        },
        {
            ["table"] = "1,10",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "img",
            ["title"] = "goodI&",
            ["cx"] = 97,
            ["cy"] = 97,
            ["img"] = 0,
        },
        {
            ["table"] = "1,10",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "lab",
            ["title"] = "goodN&",
            ["x"] = 139,
            ["y"] = 91,
            ["text"] = "",
        },
        {
            ["table"] = "1,10",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "btn",
            ["title"] = "goodA&",
            ["x"] = 160,
            ["y"] = 110,
            ["img"] = 590,
            ["active"] = 592,
            ["disable"] = 591,
            ["text"] = "",
        },
        {
            ["table"] = "1,10",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "btn",
            ["title"] = "goodS&",
            ["x"] = 175,
            ["y"] = 97,
            ["img"] = 593,
            ["active"] = 595,
            ["disable"] = 594,
            ["text"] = "",
        },
        {
            ["table"] = "1,10",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "lab",
            ["title"] = "goodC&",
            ["x"] = 130,
            ["y"] = 110,
            ["text"] = "",
        },
        {
            ["table"] = "1,3",
            ["high"] = 59,
            ["type"] = "img",
            ["title"] = "payI&",
            ["cx"] = 430,
            ["cy"] = 97,
            ["img"] = 0,
        },
        {
            ["table"] = "1,3",
            ["high"] = 59,
            ["type"] = "img",
            ["title"] = "payN&",
            ["cx"] = 407,
            ["cy"] = 130,
            ["img"] = 0,
        },
        {
            ["type"] = "btn",
            ["title"] = "confirm",
            ["x"] = 407,
            ["y"] = 283,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "ȷ��",
        }
    }
    Protocol.PowerSend(player:getObj(), "TASK_CLIENT", sellerClient)
end

ClientEvent["task_client"] = getSellerClient