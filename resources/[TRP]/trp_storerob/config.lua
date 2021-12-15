Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'STUPIDLOCALE'
local PAYOUT = {300, 1500} -- payment range
Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-705.73, -914.91, 19.22-0.98), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1819.516, 793.4769, 138.0791), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
   -- {coords = vector3(-1819.516, 793.4769, 138.0791), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1818.91, 792.9626, 138.0791), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1486.233, -378.0923, 40.14795), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1134.119, -982.4308, 46.39929), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(2554.879, 380.822, 108.6088), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1958.862, 3742.048, 32.32971), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1728.58, 6416.703, 35.02563), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1697.473, 4923.244, 42.052), heading = 91.0, money = PAYOUT, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},


}

Translation = {
    ['STUPIDLOCALE'] = {
        ['shopkeeper'] = 'shopkeeper',
        ['robbed'] = "I don't have anything left! ~r~Please Don't hurt me!!",
        ['cashrecieved'] = 'You got:',
        ['currency'] = '$',
        ['scared'] = 'Scared:',
        ['no_cops'] = 'There are ~r~not~w~ enough cops online!',
        ['cop_msg'] = 'We have sent a photo of the robber taken by the CCTV camera!',
        ['set_waypoint'] = 'Set waypoint to the store',
        ['hide_box'] = 'Close this box',
        ['robbery'] = 'Robbery in progress',
        ['walked_too_far'] = 'You walked too far away!'
    },
}