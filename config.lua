Config = {}

Config.Zones = {
    {
        pos = vector3(1689.3793, 2595.6357, 72.8098), 
        radius = 300.0, 
        allowedJobs = {"police", "ambulance"}, 
        time = 10, -- in seconds, time until vehicle failure
        Notify = {
            header = 'Flugverbotszone',
            subject = '',
            msg = 'Du befindest dich in einer Flugverbotszone. Du hast %s Sekunde(n) um umzukehren!',
            mugshot = 'CHAR_MP_MERRYWEATHER',
            iconType = 1
        }
    },
}
