-------------------
-- C o n f i g s --
-------------------


companyName = "TazMan Mechs"       
companyIcon = "CHAR_LS_CUSTOMS" 
spawnRadius = 1000               
drivingStyle = 786603           -- Default Value: 786603
simplerRepair = false           -- When enabled, instead of getting out of the vehicle to repair, the mechanic stops his vehicle and the repair happens automatically.
repairComsticDamage = true    -- When enabled, the vehicle's cosmetic damage gets reset.
flipVehicle = true             -- When enabled, the vehicle will be flipped if on roof or side after repair.
enabletow = false   -- When enabled allows you to get your vehicle towed.. Literally zero reason to want this from what i can see but hey.. potato
 


mechPeds = {
                [1] = {name = "Billy Schwartz", icon = "CHAR_MP_MECHANIC", model = "S_M_Y_DockWork_01", vehicle = 'UtilliTruck3', colour = 111, 
                                ['lines'] = {
                                        "A bit of a fixer upper!",
                                        "All done here.",
                                        "Here you are, should be working now.",
                                        "It's done.",
                                        "What can I say, I'm a master of my craft.",
                                        "I had to sprinkle a little bit of magic, but it should work now.",
                                        "Just don't let vic roads know because this aint roady",
                                        "Easy peasy!",
                                        "Easier on the gas pedal next time, will ya?",
                                        "The only thing I can't fix is my marriage...",
                                        "Fixed. Have a good day, drive safe!",
                                        "It's a bit of a bodge, but it works.",}},

                [2] = {name = "John FixEmUp", icon = "CHAR_MP_BIKER_MECHANIC", model = "S_M_Y_Construct_01", vehicle = 'BobcatXL', colour = 118, 
                                ['lines'] = {
                                        "Yeehaw, now she's fresher than a pillow with a mint on it!",
                                        "All done here.",
                                        "Job done.",
                                        "I've done everything I could.",
                                        "I hit it with a wrench a couple times and I think it worked!",
                                        "Our company takes no responsibilities for spontanious combustions of the engine.",
                                        "Sometimes I don't really think I know what I'm doing. Anyway, here's your car!",
                                        "Ahh, yes... The water pipe needed to be replaced. All good now.",
                                        "She's in perfect condition.",
                                        "*slaps roof of the car* This bad boy can fit so many screws in it.",
                                        "Should work now."}},
             
                --Edit the NAME, ICON, PED MODEL and TRUCK COLOUR here:
               -- [driver_ID] = {name = "driver_name", icon = "driver_icon", model = "ped_model", vehicle = 'vehicle_model' colour = 'driver_colour',

                                --You can add or edit any existing vehicle fix lines here:
                             --   [1] = {"Sample text 1","Sample text 2",}}, -- lines of dialogue.

                  
               -- ]]
                }
