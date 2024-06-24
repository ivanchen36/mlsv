
-- tbl_vip_info
DROP TABLE IF EXISTS `tbl_vip_info`;
CREATE TABLE `tbl_vip_info` (
                                      `RegNum` int NOT NULL COMMENT '��ɫid',
                                      `VipLevel` int NOT NULL DEFAULT 0 COMMENT '��Ա�ȼ�',
                                      `VipExp` int NOT NULL DEFAULT 0 COMMENT 'vip����',
                                      `LastExp` int NOT NULL DEFAULT 0 COMMENT '�ϴ���ȡ��vip',
                                      `LastTime` int NOT NULL DEFAULT 0 COMMENT '�ϴ���ȡʱ��',
                                      `LuckVal` int NOT NULL DEFAULT 0 COMMENT '����ֵ',
                                      `EnemyAvoidSec` int NOT NULL DEFAULT 0 COMMENT '����������',
                                      `RemoteBank` int NOT NULL DEFAULT 0 COMMENT 'Զ�����п���',
                                      `GodGift` int NOT NULL DEFAULT 0 COMMENT '�콵����',
                                      `Warp` int NOT NULL DEFAULT 0 COMMENT '���Ϳ���',
                                      `UpGift` int NOT NULL DEFAULT 0 COMMENT '�������',
                                      `AddExp` int NOT NULL DEFAULT 0 COMMENT '����ӳ�',
                                      `CreateTime` int NOT NULL,
                                      `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`RegNum`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='��ɫ��Ϣ��';

-- tbl_task
DROP TABLE IF EXISTS `tbl_task`;
CREATE TABLE `tbl_task` (
                                `Id` int NOT NULL AUTO_INCREMENT COMMENT '����id',
                                `RegNum` int NOT NULL COMMENT '��ɫid',
                                `Type` int NOT NULL DEFAULT 0 COMMENT '��������',
                                `Status` int NOT NULL DEFAULT 0 COMMENT '״̬',
                                `Info` Varchar(512) NOT NULL DEFAULT '' COMMENT '������Ϣ',
                                `ExeTime` int NOT NULL DEFAULT 0 COMMENT 'ִ��ʱ��',
                                `CreateTime` int NOT NULL,
                                `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                PRIMARY KEY (`id`),
                                INDEX `idx_Type` (`Type`,`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='��ɫ��Ϣ��';

-- tbl_pk_info
DROP TABLE IF EXISTS `tbl_pk_info`;
CREATE TABLE `tbl_pk_info` (
                                  `Id` int NOT NULL AUTO_INCREMENT COMMENT '����ID',
                                  `PkDate` varchar(20) NOT NULL COMMENT '�ٰ�����',
                                  `PkType` int NOT NULL COMMENT '�������ͣ�1-����PK��2-���PK���� 3-���� 4-���� 5-��ȣ�',
                                  `Round` int NOT NULL COMMENT '��ǰ�ִ�',
                                  `Count` int NOT NULL COMMENT '��������',
                                  `EventDescription` Varchar(128) NOT NULL DEFAULT '' COMMENT '��������',
                                  `ParticipantCount` int NOT NULL DEFAULT 0 COMMENT '��������',
                                  `Status` int NOT NULL DEFAULT 1 COMMENT '״̬��0-δ��ʼ 1-ƥ���У�2-�����У�3-�����У�4-�Ѿ�������',
                                  `CreateTime` int NOT NULL,
                                  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='PK������Ϣ��';

-- tbl_pk_team
DROP TABLE IF EXISTS `tbl_pk_team`;
CREATE TABLE `tbl_pk_team` (
                                        `Id` int NOT NULL AUTO_INCREMENT COMMENT '����ID',
                                        `RegNum` int NOT NULL COMMENT '�ӳ���ɫID',
                                        `Name` int NOT NULL COMMENT '�ӳ���ɫ��',
                                        `PkId` int NOT NULL COMMENT '����������ID',
                                        `Status` int NOT NULL DEFAULT 0 COMMENT '��ǰ����״̬��0-δ��ʼ��1-�����У�2-������Ʒ�� 3-�ѽ�����',
                                        `CurrentRanking` int COMMENT '��ǰ�ɼ�����',
                                        `TeamInfo` Varchar(512) NOT NULL DEFAULT '' COMMENT '������Ϣ������ʹ��JSON��ʽ�洢',
                                        `Mac` varchar(128) NOT NULL DEFAULT '' COMMENT '�ӳ�Mac��ַ',
                                        `CreateTime` int NOT NULL,
                                        `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                        PRIMARY KEY (`Id`),
                                        INDEX `idx_Type` (`RegNum`,`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='PK������Ϣ��';

-- tbl_pk_record
DROP TABLE IF EXISTS `tbl_pk_record`;
CREATE TABLE `tbl_pk_record` (
                                  `Id` int NOT NULL AUTO_INCREMENT COMMENT '����ID',
                                  `PkId` int NOT NULL COMMENT '����������ID',
                                  `Round` int NOT NULL COMMENT '��ǰ�ִ�',
                                  `TeamARegNum` int NOT NULL COMMENT '��ս˫��A�Ӷӳ���ɫID',
                                  `TeamBRegNum` int NOT NULL COMMENT '��ս˫��B�Ӷӳ���ɫID',
                                  `TeamAName` int NOT NULL COMMENT '��ս˫��A�Ӷӳ���ɫ��',
                                  `TeamBName` int NOT NULL COMMENT '��ս˫��B�Ӷӳ���ɫ��',
                                  `Status` int NOT NULL DEFAULT 0 COMMENT 'ս��״̬��0-δ��ʼ��1-�����У�2-����ɣ�',
                                  `BattleIndex` int NOT NULL COMMENT 'ս�����',
                                  `WinnerRegNum` int COMMENT 'ʤ���ӳ���ɫID',
                                  `StartTime` int NOT NULL COMMENT '������ʼʱ��',
                                  `EndTime` int NOT NULL COMMENT '��������ʱ��',
                                  `CreateTime` int NOT NULL,
                                  `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`Id`),
                                  INDEX `idx_Status` (`Status`),
                                  INDEX `idx_BattleIndex` (`BattleIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='PK��¼��';

-- tbl_pet_proficient
DROP TABLE IF EXISTS `tbl_pet_proficient`;
CREATE TABLE `tbl_pet_proficient` (
                                      `RegNum` int NOT NULL COMMENT '��ɫid',
                                      `Race` int NOT NULL DEFAULT '-1' COMMENT '����',
                                      `Level` int NOT NULL DEFAULT 0 COMMENT '��ͨ�ȼ�',
                                      `KillNum` int NOT NULL DEFAULT 0 COMMENT '��ǰ��ɱ��',
                                      `CreateTime` int NOT NULL,
                                      `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`RegNum`, `Race`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='���ﾫͨ��';

-- tbl_pet_info
DROP TABLE IF EXISTS `tbl_pet_info`;
CREATE TABLE `tbl_pet_info` (
                                      `uuid` int NOT NULL COMMENT '����uuid',
                                      `EarthLevel` int NOT NULL DEFAULT 0 COMMENT '�����Ծ��ѵȼ�',
                                      `WaterLevel` int NOT NULL DEFAULT 0 COMMENT 'ˮ���Ծ��ѵȼ�',
                                      `FireLevel` int NOT NULL DEFAULT 0 COMMENT '�����Ծ��ѵȼ�',
                                      `WindLevel` int NOT NULL DEFAULT 0 COMMENT '�����Ծ��ѵȼ�',
                                      `CreateTime` int NOT NULL,
                                      `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='������Ϣ��';

-- tbl_player_task
DROP TABLE IF EXISTS `tbl_player_task`;
CREATE TABLE `tbl_player_task` (
                                   `Id` int NOT NULL AUTO_INCREMENT COMMENT '����ID',
                                   `RegNum` int NOT NULL COMMENT '��ɫid',
                                   `Cycle` INT NOT NULL COMMENT '�������ڣ��ճ����ܳ����³���',
                                   `CycleDate` INT NOT NULL COMMENT '����ĵڼ���/��/��',
                                   `Type` INT NOT NULL COMMENT '�������ͣ���ӡ����ɱ����Ѱ����ս��',
                                   `Item` INT NOT NULL COMMENT '������Ʒ��Ӧ�ĳ���id����Ʒid���߹���id',
                                   `Count` int NOT NULL COMMENT '������Ʒ����',
                                   `Progress` INT NOT NULL DEFAULT 0 COMMENT '��ǰ���ȣ������ѻ�ɱ�Ĺ���������',
                                   `Status` int NOT NULL DEFAULT 0 COMMENT '״̬��1-�����У�2-����ɣ�',
                                   `CreateTime` INT NOT NULL COMMENT '����ʱ��',
                                   `UpdateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����ʱ��',
                                   PRIMARY KEY (`Id`),
                                   INDEX `idx_RegNum` (`RegNum`, `Cycle`, `CycleDate`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='��������';

-- tbl_tax_info
DROP TABLE IF EXISTS `tbl_tax_info`;
CREATE TABLE `tbl_tax_info` (
                                      `RegNum` int NOT NULL COMMENT '��ɫid',
                                      `Amount` int NOT NULL DEFAULT 0 COMMENT '���������',
                                      `TaxAmount` int NOT NULL DEFAULT 0 COMMENT '����Ͻ�˰�ս��',
                                      `Cycle` INT NOT NULL COMMENT '����-����0��ʱ���',
                                      `CreateTime` int NOT NULL,
                                      `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      PRIMARY KEY (`RegNum`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='��ɫ˰���';

-- tbl_user_limit
DROP TABLE IF EXISTS `tbl_user_limit`;
CREATE TABLE `tbl_user_limit` (
                                `UserId` int NOT NULL COMMENT 'id reqnum ���� mac',
                                `Type` int NOT NULL DEFAULT 0 COMMENT '����',
                                `Count` int NOT NULL DEFAULT 0 COMMENT '�ܴ���',
                                `Used` int NOT NULL DEFAULT 0 COMMENT '����Ͻ�˰�ս��',
                                `Cycle` INT NOT NULL COMMENT '����',
                                `CreateTime` int NOT NULL,
                                `UpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC COMMENT='�û����Ʊ�';





