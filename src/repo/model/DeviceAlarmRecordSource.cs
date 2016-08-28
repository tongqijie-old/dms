﻿using Petecat.Data.Attributes;

namespace Dade.Dms.Repo.RepoModel
{
    public class DeviceAlarmRecordSource
    {
        [PlainDataMapping]
        public int Id { get; set; }

        [CompositeDataMapping(typeof(DeviceInfoSource), Prefix = "DIS_")]
        public DeviceInfoSource DeviceInfo { get; set; }

        [PlainDataMapping]
        public string AlarmTime { get; set; }

        [PlainDataMapping]
        public string Severity { get; set; }

        [PlainDataMapping]
        public string Remark { get; set; }

        [PlainDataMapping]
        public int Source { get; set; }
    }
}
