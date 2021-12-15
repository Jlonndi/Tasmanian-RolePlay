noradarConfig = {}

noradarConfig.Measurement = "Imperial" --"Imperial" (mph) or "Metric" (km/h), if you write anything else, it will be considered imperial.

--Speed levels (keep them all at an insanely high number if you don't want the speedometer to change colors based on vehicle speed)
noradarConfig.Level1 = 10              --Very slow speed
noradarConfig.Level2 = 30              --City speed limit
noradarConfig.Level3 = 50              --Outside city speed limit
noradarConfig.Level4 = 70              --Highway speed limit
noradarConfig.Level5 = noradarConfig.Level4   --Over the highway speed limit || DO NOT CHANGE
                                --Use the speeds in the measurement type of your choice.

noradarConfig.Level1color = "~w~"      --Colors:   ~r~ = Red || ~b~ = Blue || ~g~ = Green || ~y~ = Yellow || ~p~ = Purple || ~o~ = Orange || ~c~ = Grey || ~m~ = Darker Grey || ~u~ = Black || ~s~ = Default White || ~w~ = White
noradarConfig.Level2color = "~g~"
noradarConfig.Level3color = "~y~"
noradarConfig.Level4color = "~o~"
noradarConfig.Level5color = "~r~"

noradarConfig.RadarToggler = true          --This will disable the radar (minimap) if the player is NOT in a vehicle. Because of the way the radar is made, a new health and shield bar has to be drawn and it doesn't show the air capacity if the player is under water.
noradarConfig.SpeedometerToggler = false    --This will disable the speedometer. You can disable it in case you want to use ONLY the hidden radar part of the script
--Fun fact, if you set both of the variables from above to false, the script does absolutely nothing, so don't.