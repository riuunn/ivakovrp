-- You can edit the events on the right side if you for any reason don't use the default event name

EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
    
    ["esx_society:registerSociety"] = "esx_society:registerSociety",
    ["esx_society:getSociety"] = "esx_society:getSociety",
    
    ["esx_addonaccount:getSharedAccount"] = "esx_addonaccount:getSharedAccount",

    ["esx_datastore:getSharedDataStore"] = "esx_datastore:getSharedDataStore",
    ["esx_datastore:getDataStore"] = "esx_datastore:getDataStore",

    ["esx_ambulancejob:revive"] = "esx_ambulancejob:revive",
    ["esx_ambulancejob:heal"] = "esx_ambulancejob:heal",
}