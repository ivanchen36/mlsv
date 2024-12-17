local petEquipSeller = {
    ["1"] = {
        ["name"] = "青铜",
        [20201] = {[20399] = 10, [0] = 1000},
        [20202] = {[20399] = 20, [0] = 1000},
        [20203] = {[20399] = 10, [0] = 1000},
        [20204] = {[20398] = 10, [0] = 1000},
        [20205] = {[20398] = 10, [0] = 1000},
        [20206] = {[20398] = 10, [0] = 1000},
        [20207] = {[20398] = 10, [0] = 1000},
        [20208] = {[20398] = 10, [0] = 1000},
    },
    ["2"] = {
        ["name"] = "白银",
        [20211] = {[20397] = 10, [0] = 2000},
        [20212] = {[20397] = 20, [0] = 2000},
        [20213] = {[20397] = 10, [0] = 2000},
        [20214] = {[20396] = 10, [0] = 2000},
        [20215] = {[20396] = 10, [0] = 2000},
        [20216] = {[20396] = 10, [0] = 2000},
        [20217] = {[20396] = 10, [0] = 2000},
        [20218] = {[20396] = 10, [0] = 2000},
    },
    ["3"] = {
        ["name"] = "黄金",
        [20221] = {[20395] = 10, [0] = 5000},
        [20222] = {[20395] = 20, [0] = 5000},
        [20223] = {[20395] = 10, [0] = 5000},
        [20224] = {[20394] = 10, [0] = 5000},
        [20225] = {[20394] = 10, [0] = 5000},
        [20226] = {[20394] = 10, [0] = 5000},
        [20227] = {[20394] = 10, [0] = 5000},
        [20228] = {[20394] = 10, [0] = 5000},
    },
    ["4"] = {
        ["name"] = "钻石",
        [20231] = {[20393] = 10, [0] = 10000},
        [20232] = {[20393] = 20, [0] = 10000},
        [20233] = {[20393] = 10, [0] = 10000},
        [20234] = {[20392] = 10, [0] = 10000},
        [20235] = {[20392] = 10, [0] = 10000},
        [20236] = {[20392] = 10, [0] = 10000},
        [20237] = {[20392] = 10, [0] = 10000},
        [20238] = {[20392] = 10, [0] = 10000},
    },
    ["5"] = {
        ["name"] = "星耀",
        [20241] = {[20391] = 10, [0] = 15000},
        [20242] = {[20391] = 20, [0] = 15000},
        [20243] = {[20391] = 10, [0] = 15000},
        [20244] = {[20390] = 10, [0] = 15000},
        [20245] = {[20390] = 10, [0] = 15000},
        [20246] = {[20390] = 10, [0] = 15000},
        [20247] = {[20390] = 10, [0] = 15000},
        [20248] = {[20390] = 10, [0] = 15000},
    },
    ["6"] = {
        ["name"] = "王者",
        [20251] = {[20389] = 10, [0] = 20000},
        [20252] = {[20389] = 20, [0] = 20000},
        [20253] = {[20389] = 10, [0] = 20000},
        [20254] = {[20388] = 10, [0] = 20000},
        [20255] = {[20388] = 10, [0] = 20000},
        [20256] = {[20388] = 10, [0] = 20000},
        [20257] = {[20388] = 10, [0] = 20000},
        [20258] = {[20388] = 10, [0] = 20000},
    },
    ["7"] = {
        ["name"] = "荣耀",
        [20261] = {[20387] = 10, [0] = 30000},
        [20262] = {[20387] = 20, [0] = 30000},
        [20263] = {[20387] = 10, [0] = 30000},
        [20264] = {[20386] = 10, [0] = 30000},
        [20265] = {[20386] = 10, [0] = 30000},
        [20266] = {[20386] = 10, [0] = 30000},
        [20267] = {[20386] = 10, [0] = 30000},
        [20268] = {[20386] = 10, [0] = 30000},
    },
}

local petSeller = {
    ["1"] = {
        ["name"] = "宠物",
        [Const.PetSkuBaseId + 8] = {[20109] = 10, [0] = 50000},
        [Const.PetSkuBaseId + 9] = {[20106] = 1, [20107] = 1, [20108] = 1, [0] = 50000},
    }
}

local cardSeller = {
    ["1"] = {
        ["name"] = "消耗",
        [20021] = {[Const.ItemCard] = 50},
        [20101] = {[Const.ItemCard] = 50},
        [20102] = {[Const.ItemCard] = 50},
        [20103] = {[Const.ItemCard] = 50},
        [20104] = {[Const.ItemCard] = 50},
        [20105] = {[Const.ItemCard] = 50},
    },
    ["2"] = {
        ["name"] = "水晶",
        [20011] = {[Const.ItemCard] = 100},
        [20012] = {[Const.ItemCard] = 100},
        [20013] = {[Const.ItemCard] = 100},
        [20014] = {[Const.ItemCard] = 100},
        [20015] = {[Const.ItemCard] = 150},
        [20016] = {[Const.ItemCard] = 150},
    },
    ["3"] = {
        ["name"] = "饰品",
        [20045] = {[Const.ItemCard] = 66},
        [20046] = {[Const.ItemCard] = 66},
    },
    ["4"] = {
        ["name"] = "武器",
        [20031] = {[Const.ItemCard] = 100},
        [20032] = {[Const.ItemCard] = 100},
        [20033] = {[Const.ItemCard] = 100},
        [20034] = {[Const.ItemCard] = 100},
        [20035] = {[Const.ItemCard] = 100},
        [20036] = {[Const.ItemCard] = 100},
        [20037] = {[Const.ItemCard] = 100},
    },
    ["5"] = {
        ["name"] = "防具",
        [20038] = {[Const.ItemCard] = 50},
        [20039] = {[Const.ItemCard] = 50},
        [20040] = {[Const.ItemCard] = 50},
        [20041] = {[Const.ItemCard] = 50},
        [20042] = {[Const.ItemCard] = 50},
        [20043] = {[Const.ItemCard] = 50},
        [20044] = {[Const.ItemCard] = 50},
    },
    ["5"] = {
        ["name"] = "宠物",
        [Const.PetSkuBaseId + 1] = {[Const.ItemCard] = 188},
        [Const.PetSkuBaseId + 2] = {[Const.ItemCard] = 188},
        [Const.PetSkuBaseId + 3] = {[Const.ItemCard] = 888},
        [Const.PetSkuBaseId + 4] = {[Const.ItemCard] = 888},
        [Const.PetSkuBaseId + 5] = {[Const.ItemCard] = 999},
        [Const.PetSkuBaseId + 6] = {[Const.ItemCard] = 999},
    },
    ["6"] = {
        ["name"] = "宠装",
        [20271] = {[Const.ItemCard] = 88},
        [20272] = {[Const.ItemCard] = 188},
        [20273] = {[Const.ItemCard] = 88},
        [20274] = {[Const.ItemCard] = 88},
        [20275] = {[Const.ItemCard] = 88},
        [20276] = {[Const.ItemCard] = 88},
        [20277] = {[Const.ItemCard] = 88},
        [20278] = {[Const.ItemCard] = 88},
    },
}

local recycleSeller = {
    ["1"] = {
        ["name"] = "宠物",
        [Const.PetReCycleBaseId + 1] = {[20106] = 1},
        [Const.PetReCycleBaseId + 2] = {[20107] = 1},
        [Const.PetReCycleBaseId + 3] = {[20108] = 1},
        [Const.PetReCycleBaseId + 4] = {[20109] = 1},
    }
}

local jjcSeller = {
    ["1"] = {
        ["name"] = "宠物",
        [Const.PetSkuBaseId + 12] = {[20111] = 1, [0] = 10000},
        [Const.PetSkuBaseId + 13] = {[20111] = 1, [0] = 10000},
        [Const.PetSkuBaseId + 14] = {[20111] = 1, [0] = 10000},
        [Const.PetSkuBaseId + 15] = {[20111] = 1, [0] = 10000},
        [Const.PetSkuBaseId + 7] = {[20110] = 1, [0] = 50000},
    }
}

sellerList = {
    [Const.NpcSeller] = {"宠物装备", petEquipSeller},
    [Const.NpcGoldCard] = {"金币兑换", {}},
    [Const.NpcRecycle] = {"物品回收", recycleSeller},
    [Const.NpcPetTrade] = {"宠物兑换", petSeller},
    [Const.NpcCard] = {"金卡商店", cardSeller},
    [Const.NpcPkEquip] = {"竞技商店", jjcSeller},
}

sellerSkuList = {
    [Const.PetSkuBaseId + 1] = {Const.SkuTypePet, 30001, 1,""},
    [Const.PetSkuBaseId + 2] = {Const.SkuTypePet, 30002, 1,""},
    [Const.PetSkuBaseId + 3] = {Const.SkuTypePet, 30003, 1,""},
    [Const.PetSkuBaseId + 4] = {Const.SkuTypePet, 30006, 1,""},
    [Const.PetSkuBaseId + 5] = {Const.SkuTypePet, 30004, 1,""},
    [Const.PetSkuBaseId + 6] = {Const.SkuTypePet, 30005, 1,""},
    [Const.PetSkuBaseId + 7] = {Const.SkuTypePet, 30007, 1,""},
    [Const.PetSkuBaseId + 8] = {Const.SkuTypePet, 30008, 1,""},
    [Const.PetSkuBaseId + 9] = {Const.SkuTypePet, 30009, 1,""},
    [Const.PetSkuBaseId + 12] = {Const.SkuTypePet, 30012, 1,""},
    [Const.PetSkuBaseId + 13] = {Const.SkuTypePet, 30013, 1,""},
    [Const.PetSkuBaseId + 14] = {Const.SkuTypePet, 30009, 1,""},
    [Const.PetSkuBaseId + 15] = {Const.SkuTypePet, 30009, 1,""},

    [Const.PetReCycleBaseId + 1] = {Const.SkuTypeItem, Const.ItemCard, 500,"[彩]回收"},
    [Const.PetReCycleBaseId + 2] = {Const.SkuTypeItem, Const.ItemCard, 500,"[虹]回收"},
    [Const.PetReCycleBaseId + 3] = {Const.SkuTypeItem, Const.ItemCard, 500,"[星]回收"},
    [Const.PetReCycleBaseId + 4] = {Const.SkuTypeItem, Const.ItemCard, 100,"[寒霜飞龙魂魄]回收"},
}