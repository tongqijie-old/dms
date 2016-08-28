﻿using Dade.Dms.Rest.ServiceModel.Enums;

namespace Dade.Dms.Rest.ServiceModel
{
    public class MaintenanceRecord : FoundationInfo
    {
        public int Id { get; set; }

        public DeviceInfo DeviceInfo { get; set; }

        public MaintenanceRecordStatus Status { get; set; }

        public MaintenancePlan MaintenancePlan { get; set; }

        public string ScheduleTime { get; set; }

        public string MaintainBeginTime { get; set; }

        public string MaintainEndTime { get; set; }

        public string Persons { get; set; }

        public string Content { get; set; }

        public string Remark { get; set; }

        public DeviceCheckpoint[] DeviceCheckpoints { get; set; }

        public DeviceSparePart[] DeviceSpareParts { get; set; }
    }
}
