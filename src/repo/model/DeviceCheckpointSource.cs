﻿using Petecat.Data.Attributes;

namespace Dade.Dms.Repo.RepoModel
{
    public class DeviceCheckpointSource : FoundationInfoSource
    {
        [PlainDataMapping]
        public int Id { get; set; }

        [CompositeDataMapping(typeof(DeviceInfoSource), Prefix = "DIS_")]
        public DeviceInfoSource DeviceInfo { get; set; }

        [PlainDataMapping]
        public string Description { get; set; }

        [PlainDataMapping]
        public string Flag { get; set; }

        [PlainDataMapping]
        public decimal UpperLimit { get; set; }

        [PlainDataMapping]
        public decimal LowerLimit { get; set; }

        [PlainDataMapping]
        public string Remark { get; set; }
    }
}
