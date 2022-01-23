-- You can edit the events on the right side if you for any reason don't use the default event name

EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found    
}

-- If you use different names for police job, you can add/change it here, all jobs here will be used for police features (example: the alerts)
POLICE_JOBS_NAMES = {
    ["police"] = true,
    ["fbi"] = true, 
    ["sasp"] = true,
} 