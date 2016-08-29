﻿using Dade.Dms.Repo.DataModel;
using Dade.Dms.Rest.ServiceModel;
using Dade.Dms.Rest.ServiceModel.Services;

namespace Dade.Dms.Rest.Impl.Repository
{
    public interface IDeviceSparePartRepository
    {
        int AddSparePart(DeviceSparePartSource deviceSparePartSource);

        int EditSparePart(DeviceSparePartSource deviceSparePartSource);

        int DeleteSparePart(DeviceSparePartSource deviceSparePartSource);

        DeviceSparePartSource[] QueryDeviceSpareParts(Paging paging, string deviceSparePartNumber);
    }
}
