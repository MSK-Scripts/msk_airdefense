Config = {}

Config.Debug = true

Config.Zones = {
    {
        pos = vector3(1704.71, 2573.79, 45.56), 
        radius = 230.0, 
        allowedJobs = {"police", "ambulance"}, 
        time = 10, -- in seconds, time until vehicle failure
        timeLow = 2, -- in seconds, time until vehicle engine starts slow down again
        Notify = {
            header = 'Flugverbotszone',
            subject = 'Merryweather',
            msg = 'Du befindest dich in einer Flugverbotszone. Du hast %s Sekunde(n) um umzukehren!',
            mugshot = 'CHAR_MP_MERRYWEATHER',
            iconType = 1
        },
        Blip = {
            enable = true,
            color = 1, 
            alpha = 128 -- transparency
        }
    },
}