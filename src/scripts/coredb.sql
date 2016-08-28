﻿USE dms_coredb;

CREATE TABLE DeviceInfo
(
	DeviceNumber NVARCHAR(20) NOT NULL,
	DeviceName NVARCHAR(60) NOT NULL,
	[Status] CHAR(1) NOT NULL DEFAULT 'A',
	DepartmentId INT NULL,
	Manufactory NVARCHAR(60) NULL,
	DateOfManufacture DATETIME NULL,
	Model NVARCHAR(60) NULL,
	Category NVARCHAR(20) NULL,
	DeviceIP NVARCHAR(20) NULL,
	DevicePort NVARCHAR(20) NULL,
	DeviceSIM NVARCHAR(20) NULL,
	PeriodOfMaintenance NVARCHAR(20) NULL,
	ProductionAbility NVARCHAR(20) NULL,
	MaintenanceMaunal NVARCHAR(120) NULL,
	CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
	ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
	CreationUserId INT NOT NULL DEFAULT 0,
	ModifiedUserId INT NOT NULL DEFAULT 0,
	CONSTRAINT PK_DEVICEINFO PRIMARY KEY (DeviceNumber),
);

CREATE INDEX IX_DEVICEINFO_DEVICENAME ON DeviceInfo (DeviceName);
CREATE INDEX IX_DEVICEINFO_STATUS ON DeviceInfo ([Status]);
CREATE INDEX IX_DEVICEINFO_CREATIONDATE ON DeviceInfo (CreationDate);

CREATE TABLE DeviceCheckpoint
(
  Id INT IDENTITY(1, 1),
  DeviceNumber VARCHAR(20) NOT NULL,
  [Description] NVARCHAR(60) NOT NULL,
  Flag CHAR(1) NOT NULL,
  UpperLimit DECIMAL(18, 6) NULL,
  LowerLimit DECIMAL(18, 6) NULL,
  Remark NVARCHAR(100) NULL,
  CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
  ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
  CreationUserId INT NOT NULL DEFAULT 0,
  ModifiedUserId INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_DEVICECHECKPOINT PRIMARY KEY (Id),
);

CREATE INDEX IX_DEVICECHECKPOINT_DEVICENUMBER ON DeviceCheckpoint (DeviceNumber);
CREATE INDEX IX_DEVICECHECKPOINT_CREATIONDATE ON DeviceCheckpoint (CreationDate);

CREATE TABLE DeviceSparePart
(
  SparePartNumber VARCHAR(20) NOT NULL,
  SparePartName NVARCHAR(60) NOT NULL,
  Category CHAR(1) NULL,
  ServiceLife INT NULL,
  Remark NVARCHAR(100) NULL,
  CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
  ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
  CreationUserId INT NOT NULL DEFAULT 0,
  ModifiedUserId INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_DEVICESPAREPART PRIMARY KEY (SparePartNumber),
);

CREATE INDEX IX_DEVICESPAREPART_CATEGORY ON DeviceSparePart (SparePartNumber);
CREATE INDEX IX_DEVICESPAREPART_CREATIONDATE ON DeviceSparePart (CreationDate);

CREATE TABLE DeviceFaultCategory
(
  Id INT IDENTITY(1, 1),
  Title NVARCHAR(60) NOT NULL,
  DeviceNumber VARCHAR(20) NOT NULL,
  [Description] NVARCHAR(200) NULL,
  CONSTRAINT PK_DEVICEFAULTCATEGORY PRIMARY KEY (Id),
);

CREATE INDEX IX_DEVICEFAULTCATEGORY_DEVICENUMBER ON DeviceFaultCategory (DeviceNumber);

CREATE TABLE DeviceRepairRecord
(
  Id INT IDENTITY(1, 1),
  DeviceNumber VARCHAR(20) NOT NULL,
  [Status] CHAR(1) NOT NULL DEFAULT 'P',
  [Source] CHAR(1) NOT NULL DEFAULT 'U',
  SourceId INT NOT NULL DEFAULT 0,
  FaultTime DATETIME NOT NULL,
  [Description] NVARCHAR(200) NULL,
  Severity CHAR(1) NOT NULL DEFAULT 'N',
  DepartmentId INT DEFAULT 0,
  AcceptorId INT DEFAULT 0,
  RepairBeginTime DATETIME NULL,
  RepairEndTime DATETIME NULL,
  Persons NVARCHAR(60) NULL,
  Content NVARCHAR(200) NULL,
  Remark NVARCHAR(100) NULL,
  CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
  ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
  CreationUserId INT NOT NULL DEFAULT 0,
  ModifiedUserId INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_DEVICEREPAIRRECORD PRIMARY KEY (Id),
);

CREATE INDEX IX_DEVICEREPAIRRECORD_DEVICENUMBER ON DeviceRepairRecord (DeviceNumber);
CREATE INDEX IX_DEVICEREPAIRRECORD_STATUS ON DeviceRepairRecord ([Status]);
CREATE INDEX IX_DEVICEREPAIRRECORD_FAULTTIME ON DeviceRepairRecord (FaultTime);
CREATE INDEX IX_DEVICEREPAIRRECORD_CREATIONDATE ON DeviceRepairRecord (CreationDate);

CREATE TABLE DeviceRepairRecordFaultCategoryMapping
(
  Id	INT	IDENTITY(1, 1),
  DeviceRepairRecordId	INT	NOT NULL,
  DeviceFaultCategoryId	INT	NOT NULL,
  CONSTRAINT PK_DEVICEREPAIRRECORDFAULTCATEGORYMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_DEVICEREPAIRRECORDFAULTCATEGORYMAPPING_DEVICEREPAIRRECORDID ON DeviceRepairRecordFaultCategoryMapping (DeviceRepairRecordId);

CREATE TABLE DeviceAlarmRecord
(
  Id INT IDENTITY(1, 1),
  DeviceNumber VARCHAR(20) NOT NULL,
  AlarmTime DATETIME NOT NULL,
  Severity CHAR(1) DEFAULT 'N',
  CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
  Remark NVARCHAR(100) NULL,
  [Source] INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_DEVICEALARMRECORD PRIMARY KEY (Id),
);

CREATE INDEX IX_DEVICEALARMRECORD_DEVICENUMBER ON DeviceAlarmRecord (DeviceNumber);
CREATE INDEX IX_DEVICEALARMRECORD_ALARMTIME ON DeviceAlarmRecord (AlarmTime);

CREATE TABLE MaintenancePlan
(
  Id INT IDENTITY(1, 1),
  DeviceNumber VARCHAR(20) NOT NULL,
  [Status] CHAR(1) NOT NULL DEFAULT 'A',
  PeriodFrom DATETIME NOT NULL,
  PeriodTo DATETIME NOT NULL,
  ScheduleType CHAR(1) NOT NULL DEFAULT 'C',
  ScheduleValue VARCHAR(100) NULL,
  Content NVARCHAR(200) NULL,
  Remark NVARCHAR(100) NULL,
  CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
  ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
  CreationUserId INT NOT NULL DEFAULT 0,
  ModifiedUserId INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_MAINTENANCEPLAN PRIMARY KEY (Id),
);

CREATE INDEX IX_MAINTENANCEPLAN_DEVICENAME ON MaintenancePlan (DeviceNumber);
CREATE INDEX IX_MAINTENANCEPLAN_STATUS ON MaintenancePlan ([Status]);
CREATE INDEX IX_MAINTENANCEPLAN_CREATIONDATE ON MaintenancePlan (CreationDate);

CREATE TABLE MaintenancePlanCheckpointMapping
(
  Id INT IDENTITY(1, 1),
  MaintenancePlanId INT NOT NULL,
  DeviceCheckpointId INT NOT NULL,
  CONSTRAINT PK_MAINTENANCEPLANCHECKPOINTMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_MAINTENANCEPLANCHECKPOINTMAPPING_MAINTENANCEPLANID ON MaintenancePlanCheckpointMapping (MaintenancePlanId);

CREATE TABLE MaintenancePlanSparePartMapping
(
  Id INT IDENTITY(1, 1),
  MaintenancePlanId INT NOT NULL,
  SparePartNumber INT NOT NULL,
  CONSTRAINT PK_MAINTENANCEPLANSPAREPARTMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_MAINTENANCEPLANSPAREPARTMAPPING_MAINTENANCEPLANID ON MaintenancePlanSparePartMapping (MaintenancePlanId);

CREATE TABLE MaintenanceRecord
(
  Id INT IDENTITY(1, 1),
  DeviceNumber VARCHAR(20) NOT NULL,
  [Status] CHAR(1) DEFAULT 'P',
  MaintenancePlanId INT NULL,
  ScheduleTime DATETIME NOT NULL,
  DepartmentId INT DEFAULT 0,
  AcceptorId INT DEFAULT 0,
  MaintainBeginTime DATETIME NULL,
  MaintainEndTime DATETIME NULL,
  Persons NVARCHAR(100) NULL,
  Content NVARCHAR(200) NULL,
  Remark NVARCHAR(100) NULL,
  CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
  ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
  CreationUserId INT NOT NULL DEFAULT 0,
  ModifiedUserId INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_MAINTENANCERECORD PRIMARY KEY (Id),
);

CREATE INDEX IX_MAINTENANCERECORD_DEVICENUMBER ON MaintenanceRecord (DeviceNumber);
CREATE INDEX IX_MAINTENANCERECORD_STATUS ON MaintenanceRecord ([Status]);
CREATE INDEX IX_MAINTENANCERECORD_MAINTENANCEPLANID ON MaintenanceRecord (MaintenancePlanId);
CREATE INDEX IX_MAINTENANCERECORD_SCHEDULETIME ON MaintenanceRecord (ScheduleTime);
CREATE INDEX IX_MAINTENANCERECORD_CREATIONDATE ON MaintenanceRecord (CreationDate);

CREATE TABLE MaintenaceRecordCheckpointMapping
(
  Id INT IDENTITY(1, 1),
  MaintenanceRecordId INT NOT NULL,
  DeviceCheckpointId INT NOT NULL,
  CheckResult CHAR(1) NOT NULL DEFAULT 'U',
  CheckValue DECIMAL(18, 6) NULL,
  Remark NVARCHAR(100) NULL,
  CONSTRAINT PK_MAINTENACERECORDCHECKPOINTMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_MAINTENACERECORDCHECKPOINTMAPPING_MAINTENANCERECORDID ON MaintenaceRecordCheckpointMapping (MaintenanceRecordId);

CREATE TABLE MaintenanceRecordSparePartMapping
(
  Id INT IDENTITY(1, 1),
  MaintenanceRecordId INT NOT NULL,
  SparePartNumber VARCHAR(20) NOT NULL,
  CheckResult CHAR(1) DEFAULT 'U',
  ReplacementQuantity INT DEFAULT 0,
  Remark NVARCHAR(100) NULL,
  CONSTRAINT PK_MAINTENANCERECORDSPAREPARTMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_MAINTENANCERECORDSPAREPARTMAPPING_MAINTENANCERECORDID ON MaintenanceRecordSparePartMapping (MaintenanceRecordId);

CREATE TABLE InspectionPlan
(
  Id INT IDENTITY(1, 1),
  DeviceNumber VARCHAR(20) NOT NULL,
  [Status] CHAR(1) NOT NULL DEFAULT 'A',
  PeriodFrom DATETIME NOT NULL,
  PeriodTo DATETIME NOT NULL,
  ScheduleType CHAR(1) NOT NULL DEFAULT 'C',
  ScheduleValue VARCHAR(100) NULL,
  Content NVARCHAR(200) NULL,
  Remark NVARCHAR(100) NULL,
  CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
  ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
  CreationUserId INT NOT NULL DEFAULT 0,
  ModifiedUserId INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_INSPECTIONPLAN PRIMARY KEY (Id),
);

CREATE INDEX IX_INSPECTIONPLAN_DEVICENUMBER ON InspectionPlan (DeviceNumber);
CREATE INDEX IX_INSPECTIONPLAN_STATUS ON InspectionPlan ([Status]);
CREATE INDEX IX_INSPECTIONPLAN_CREATIONDATE ON InspectionPlan (CreationDate);

CREATE TABLE InspectionPlanCheckpointMapping
(
  Id INT IDENTITY(1, 1),
  InspectionPlanId INT NOT NULL,
  DeviceCheckpointId INT NOT NULL,
  CONSTRAINT PK_INSPECTIONPLANCHECKPOINTMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_INSPECTIONPLANCHECKPOINTMAPPING_INSPECTIONPLANID ON InspectionPlanCheckpointMapping (InspectionPlanId);

CREATE TABLE InspectionPlanSparePartMapping
(
  Id INT IDENTITY(1, 1),
  InspectionPlanId INT NOT NULL,
  SparePartNumber INT NOT NULL,
  CONSTRAINT PK_INSPECTIONPLANSPAREPARTMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_INSPECTIONPLANSPAREPARTMAPPING_INSPECTIONPLANID ON InspectionPlanSparePartMapping (InspectionPlanId);

CREATE TABLE InspectionRecord
(
  Id INT IDENTITY(1, 1),
  DeviceNumber VARCHAR(20) NOT NULL,
  [Status] CHAR(1) DEFAULT 'P',
  InspectionPlanId INT NULL,
  ScheduleTime DATETIME NOT NULL,
  DepartmentId INT DEFAULT 0,
  AcceptorId INT DEFAULT 0,
  InspectBeginTime DATETIME NULL,
  InspectEndTime DATETIME NULL,
  Persons NVARCHAR(100) NULL,
  Content NVARCHAR(200) NULL,
  Remark NVARCHAR(100) NULL,
  CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
  ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
  CreationUserId INT NOT NULL DEFAULT 0,
  ModifiedUserId INT NOT NULL DEFAULT 0,
  CONSTRAINT PK_INSPECTIONRECORD PRIMARY KEY (Id),
);

CREATE INDEX IX_INSPECTIONRECORD_DEVICENUMBER ON InspectionRecord (DeviceNumber);
CREATE INDEX IX_INSPECTIONRECORD_STATUS ON InspectionRecord ([Status]);
CREATE INDEX IX_INSPECTIONRECORD_INSPECTIONPLANID ON InspectionRecord (InspectionPlanId);
CREATE INDEX IX_INSPECTIONRECORD_SCHEDULETIME ON InspectionRecord (ScheduleTime);
CREATE INDEX IX_INSPECTIONRECORD_CREATIONDATE ON InspectionRecord (CreationDate);

CREATE TABLE InspectionRecordCheckpointMapping
(
  Id INT IDENTITY(1, 1),
  InspectionRecordId INT NOT NULL,
  DeviceCheckpointId INT NOT NULL,
  CheckResult CHAR(1) NOT NULL DEFAULT 'U',
  CheckValue DECIMAL(18, 6) NULL,
  Remark NVARCHAR(100) NULL,
  CONSTRAINT PK_INSPECTIONRECORDCHECKPOINTMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_INSPECTIONRECORDCHECKPOINTMAPPING_INSPECTIONRECORDID ON InspectionRecordCheckpointMapping (InspectionRecordId);

CREATE TABLE InspectionRecordSparePartMapping
(
  Id INT IDENTITY(1, 1),
  InspectionRecordId INT NOT NULL,
  SparePartNumber VARCHAR(20) NOT NULL,
  CheckResult CHAR(1) DEFAULT 'U',
  ReplacementQuantity INT DEFAULT 0,
  Remark NVARCHAR(100) NULL,
  CONSTRAINT PK_INSPECTIONRECORDSPAREPARTMAPPING PRIMARY KEY (Id),
);

CREATE INDEX IX_INSPECTIONRECORDSPAREPARTMAPPING_INSPECTIONRECORDID ON InspectionRecordSparePartMapping (InspectionRecordId);
