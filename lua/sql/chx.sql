
-- tbl_vip_info
DROP TABLE IF EXISTS `tbl_vip_info`;
CREATE TABLE `tbl_vip_info` (
                                      `RegNum` int NOT NULL COMMENT '角色id',
                                      `VipLevel` int NOT NULL DEFAULT 0 COMMENT '会员等级',
                                      `VipExp` int NOT NULL DEFAULT 0 COMMENT 'vip经验',
                                      `LastExp` int NOT NULL DEFAULT 0 COMMENT '上次领取的vip',
                                      `LastTime` int NOT NULL DEFAULT 0 COMMENT '上次领取时间',
                                      `LuckVal` int NOT NULL DEFAULT 0 COMMENT '幸运值',
                                      `EnemyAvoidSec` int NOT NULL DEFAULT 0 COMMENT '不遇敌秒数',
                                      `RemoteBank` int NOT NULL DEFAULT 0 COMMENT '远程银行开关',
                                      `GodGift` int NOT NULL DEFAULT 0 COMMENT '天降开关',
                                      `Warp` int NOT NULL DEFAULT 0 COMMENT '传送开关',
                                      `UpGift` int NOT NULL DEFAULT 0 COMMENT '升级礼包',
                                      `AddExp` int NOT NULL DEFAULT 0 COMMENT '经验加成',
                                      `CreateTime` int NOT NULL,
                                      `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`RegNum`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='角色信息表';

-- tbl_task
DROP TABLE IF EXISTS `tbl_task`;
CREATE TABLE `tbl_task` (
                                `Id` int NOT NULL AUTO_INCREMENT COMMENT '自增id',
                                `RegNum` int NOT NULL COMMENT '角色id',
                                `Type` int NOT NULL DEFAULT 0 COMMENT '任务类型',
                                `Status` int NOT NULL DEFAULT 0 COMMENT '状态',
                                `Info` Varchar(512) NOT NULL DEFAULT '' COMMENT '任务信息',
                                `ExeTime` int NOT NULL DEFAULT 0 COMMENT '执行时间',
                                `CreateTime` int NOT NULL,
                                `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                PRIMARY KEY (`id`),
                                INDEX `idx_Type` (`Type`,`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='角色信息表';

-- tbl_pk_info
DROP TABLE IF EXISTS `tbl_pk_info`;
CREATE TABLE `tbl_pk_info` (
                                  `Id` int NOT NULL AUTO_INCREMENT COMMENT '赛事ID',
                                  `PkDate` varchar(20) NOT NULL COMMENT '举办日期',
                                  `PkType` int NOT NULL COMMENT '赛事类型（1-单人PK，2-组队PK周赛 3-月赛 4-季度 5-年度）',
                                  `Round` int NOT NULL COMMENT '当前轮次',
                                  `Count` int NOT NULL COMMENT '比赛次数',
                                  `EventDescription` Varchar(128) NOT NULL DEFAULT '' COMMENT '赛事描述',
                                  `ParticipantCount` int NOT NULL DEFAULT 0 COMMENT '参与人数',
                                  `Status` int NOT NULL DEFAULT 1 COMMENT '状态（0-未开始 1-匹配中，2-进行中，3-结算中，4-已经结束）',
                                  `CreateTime` int NOT NULL,
                                  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='PK赛事信息表';

-- tbl_pk_team
DROP TABLE IF EXISTS `tbl_pk_team`;
CREATE TABLE `tbl_pk_team` (
                                        `Id` int NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                        `RegNum` int NOT NULL COMMENT '队长角色ID',
                                        `Name` int NOT NULL COMMENT '队长角色名',
                                        `PkId` int NOT NULL COMMENT '所属于赛事ID',
                                        `Status` int NOT NULL DEFAULT 0 COMMENT '当前参与状态（0-未开始，1-进行中，2-待发奖品， 3-已结束）',
                                        `CurrentRanking` int COMMENT '当前成绩名次',
                                        `TeamInfo` Varchar(512) NOT NULL DEFAULT '' COMMENT '队伍信息，可以使用JSON格式存储',
                                        `Mac` varchar(128) NOT NULL DEFAULT '' COMMENT '队长Mac地址',
                                        `CreateTime` int NOT NULL,
                                        `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                        PRIMARY KEY (`Id`),
                                        INDEX `idx_Type` (`RegNum`,`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='PK队伍信息表';

-- tbl_pk_record
DROP TABLE IF EXISTS `tbl_pk_record`;
CREATE TABLE `tbl_pk_record` (
                                  `Id` int NOT NULL AUTO_INCREMENT COMMENT '比赛ID',
                                  `PkId` int NOT NULL COMMENT '所属于赛事ID',
                                  `Round` int NOT NULL COMMENT '当前轮次',
                                  `TeamARegNum` int NOT NULL COMMENT '对战双方A队队长角色ID',
                                  `TeamBRegNum` int NOT NULL COMMENT '对战双方B队队长角色ID',
                                  `TeamAName` int NOT NULL COMMENT '对战双方A队队长角色名',
                                  `TeamBName` int NOT NULL COMMENT '对战双方B队队长角色名',
                                  `Status` int NOT NULL DEFAULT 0 COMMENT '战斗状态（0-未开始，1-进行中，2-已完成）',
                                  `BattleIndex` int NOT NULL COMMENT '战斗序号',
                                  `WinnerRegNum` int COMMENT '胜方队长角色ID',
                                  `StartTime` int NOT NULL COMMENT '比赛开始时间',
                                  `EndTime` int NOT NULL COMMENT '比赛结束时间',
                                  `CreateTime` int NOT NULL,
                                  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`Id`),
                                  INDEX `idx_Status` (`Status`),
                                  INDEX `idx_BattleIndex` (`BattleIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='PK记录表';

-- tbl_pet_proficient
DROP TABLE IF EXISTS `tbl_pet_proficient`;
CREATE TABLE `tbl_pet_proficient` (
                                      `RegNum` int NOT NULL COMMENT '角色id',
                                      `Race` int NOT NULL DEFAULT '-1' COMMENT '种族',
                                      `Level` int NOT NULL DEFAULT 0 COMMENT '精通等级',
                                      `KillNum` int NOT NULL DEFAULT 0 COMMENT '当前击杀数',
                                      `CreateTime` int NOT NULL,
                                      `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`RegNum`, `Race`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='宠物精通表';

-- tbl_pet_info
DROP TABLE IF EXISTS `tbl_pet_info`;
CREATE TABLE `tbl_pet_info` (
                                      `uuid` int NOT NULL COMMENT '宠物uuid',
                                      `EarthLevel` int NOT NULL DEFAULT 0 COMMENT '地属性觉醒等级',
                                      `WaterLevel` int NOT NULL DEFAULT 0 COMMENT '水属性觉醒等级',
                                      `FireLevel` int NOT NULL DEFAULT 0 COMMENT '火属性觉醒等级',
                                      `WindLevel` int NOT NULL DEFAULT 0 COMMENT '风属性觉醒等级',
                                      `CreateTime` int NOT NULL,
                                      `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='宠物信息表';

-- tbl_player_task
DROP TABLE IF EXISTS `tbl_player_task`;
CREATE TABLE `tbl_player_task` (
                                   `Id` int NOT NULL AUTO_INCREMENT COMMENT '任务ID',
                                   `RegNum` int NOT NULL COMMENT '角色id',
                                   `Cycle` INT NOT NULL COMMENT '任务周期（日常、周常、月常）',
                                   `CycleDate` INT NOT NULL COMMENT '当年的第几日/周/月',
                                   `Type` INT NOT NULL COMMENT '任务类型（封印、猎杀、搜寻、挑战）',
                                   `Item` INT NOT NULL COMMENT '任务物品对应的宠物id、物品id或者怪物id',
                                   `Count` int NOT NULL COMMENT '任务物品数量',
                                   `Progress` INT NOT NULL DEFAULT 0 COMMENT '当前进度（例如已击杀的怪物数量）',
                                   `Status` int NOT NULL DEFAULT 0 COMMENT '状态（1-进行中，2-已完成）',
                                   `CreateTime` INT NOT NULL COMMENT '创建时间',
                                   `UpdateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                   PRIMARY KEY (`Id`),
                                   INDEX `idx_RegNum` (`RegNum`, `Cycle`, `CycleDate`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='玩家任务表';

-- tbl_tax_info
DROP TABLE IF EXISTS `tbl_tax_info`;
CREATE TABLE `tbl_tax_info` (
                                      `RegNum` int NOT NULL COMMENT '角色id',
                                      `Amount` int NOT NULL DEFAULT 0 COMMENT '金币收入金额',
                                      `TaxAmount` int NOT NULL DEFAULT 0 COMMENT '金币上缴税收金额',
                                      `Cycle` INT NOT NULL COMMENT '周期-当日0点时间戳',
                                      `CreateTime` int NOT NULL,
                                      `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`RegNum`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='角色税务表';

-- tbl_user_limit
DROP TABLE IF EXISTS `tbl_user_limit`;
CREATE TABLE `tbl_user_limit` (
                                `UserId` int NOT NULL COMMENT 'id reqnum 或者 mac',
                                `Type` int NOT NULL DEFAULT 0 COMMENT '类型',
                                `Count` int NOT NULL DEFAULT 0 COMMENT '总次数',
                                `Used` int NOT NULL DEFAULT 0 COMMENT '金币上缴税收金额',
                                `Cycle` INT NOT NULL COMMENT '周期',
                                `CreateTime` int NOT NULL,
                                `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='用户限制表';





