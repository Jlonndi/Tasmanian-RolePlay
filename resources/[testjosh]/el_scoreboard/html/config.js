var Config = {
    group_labels: { // these are custom labels that show instead of the normal group name
        superadmin: "<span style='color:cyan;'>Member</span>",
        admin: "<span style='color:cyan;'>Member</span>",
        mod: "<span style='color:cyan;'>Member</span>",
        user: "<span style='color:cyan;'>Member</span>",
    }, 
    steam_api_key: "https://cdn.discordapp.com/attachments/754922077571514390/828863036914925568/tassierp_logo_5.png", // this is required for getting players' profile pics (https://steamcommunity.com/dev/apikey) or change this to a url for an image to use instead of players' pfp, recommended resolution is 96x96
    discord_url: "https://discord.gg/AvnUUsk",
    //website_url: "https://elipse458.me", LMAO
    steam_group_url: "https://TassieRP.com",
    navbar_buttons: [ // examples of custom buttons found below
        // { label: "MyCoolButton", page: "mycoolpage" }, // when page is specified, it will switch to the specified page (if defined)
        // { // if action is speicifed, page will not switch but the action function will be executed, there's a few custom functions you can use which are in github readme
        //     label: "MyCoolButton2",
        //     action: function() {
        // console.log("clicked my cool button 2");
        //     }
        // },
        { label: "Player List", page: "list" },
        { label: "Rules & Information Guide", page: "rules" },
        { label: "Keybinds Guide", page: "keybinds" },
        { label: "Jobs Guide", page: "jobs" },
        { label: "Illegal Activity's", page: "illegalactivity" },
        { label: "Donation Rewards", page: "donations" },
      //  { label: "Trucking Guide", page: "trucking" },
       // { label: "Fuck Off NUB", page: "rules" },
        //{
        //    label: "Discord",
        //    action: function() {
        //        copyText(Config.discord_url, "Discord URL Copied to Clipboard", 1850);
         /*   }
        },
        {
            label: "Website",
            action: function() {
                copyText(Config.steam_group_url, "TassieRP.com URL Copied to Clipboard", 1850);
            }
        },*/
    ],
    navbar_pages: {
        default: "list", // auto switch to this page when opening scoreboard (set to null to stay on last page)
        rules: "<div style='text-align: center;'><span style='color: red;font-size: 20px;'>TassieRP Rules & Information Guide</span></div><div style='text-align: center;'><br>Hello Welcome to TassieRP's Information Guide!<br>To begin use the Contents table to your left! <br><br>You will find things like <br>Full Rules, Job Information, <br>Illegal activitys, <br>Keybind information, <br>And All the things things that you can find to do Around TassieRP! <br>Hopefully this guide will help you to find, the things that there is to do in TassieRP! <br>And Thank you for playing here with us we hope you enjoy your stay! <br>Some Generally Important Rules: <br>NO VDMING/RDMING <br>No Personal Threats/Racism we understand being in RP but there is a line... <br>No Meta-gaming This includes but is not limited to stream/sniping using information gained from discord etc etc <br><br>Please remember to read the full rules! <br>Please Note that The Donations Section is currently Incomplete <br>Current as of 25/04/2021</div> ",
        list: "<table><thead><tr><th>ID</th><th>Name</th><th>Group</th><th>Ping</th></tr></thead><tbody class='lcd-body'></tbody></table>",
        jobs: "<div style='text-align: center;'><span style='color: red;font-size: 20px;'>TassieRP Job Information Guide</span></div><div style='text-align: center;'><br>Hello Welcome to the Job Information Guide!<br><br>In This guide you will find things like: The Jobs you can do, How to do them, Where to get a job Etc, <br><br><span style='color: red;'>1.1,<span style='color: green;'>|How to get A Job|<br><br><span style='color: red;'>1.2,<span style='color: green;'> WhiteListed Jobs<span style='color: white;'> <br>To Start it's important to mention that some jobs are whitelisted and you must apply for them<br>The Current Whitelisted Jobs are as followed |Police|EMS|Barista|Mechanic| we will go over these later in greater detail <br>These Jobs MUST be applied for and cannot be done with a submitted application <br>To Apply for a WhiteListed Job Please Head Over to the TassieRP Discord and go to the WhiteListed-Jobs Section<br><br><span style='color: red;'>1.3,<span style='color: green;'> Normal Jobs <span style='color: white;'><br>Normal Jobs are Jobs everyone can do! there are a ton of normal jobs that can be done in TassieRP<br>Some of the normal jobs include |Trucking|Landscaping|Mining|LumberJack|Taxi| Go to --- To see more information<br>To start doing a job you must head over to the job centre and get obtain one from the circle there <br>You can find the Job centre on the map as the blue blip and on the side under Job Centre<br>Once you have a job you will recieve an in-game hourly salary dependant on the job All jobs have different pay-grades <br><br><span style='color: red;'>1.4,<span style='color: green;'>|How to Do The Jobs|<span style='color: white;'><br><br><span style='color: red;'>1.5 <span style='color: green;'>|Land-Scaping|<span style='color: white;'><br>To Start Head over the the Job centre and select the job Land-Scaping<br>Now that you've got the job land-scaping if you hit TAB you will see that above your name it will show your job grade as Land-Scaper<br>In your Inventory you will notice 3 new items in your inventory |LandscapingGPS| |LandscapingTool| |LandscapingFinish|<br>To start landScaping please drag all 3 on to your hot-bar or drag LandscapingGPS to the (Use) function provided if dragged to hotbar please hit the number corrisponding if slot 1 press 1 etc <br>You will then notice a notification appear saying you've now started landscaping Head-over to your map by pressing ESC <br>And you will find a Yellow Blip this is the Landscaping Location Please head to there <br>Once at the yellow blip on the map Drag |LandScapingTool| to the hotbar Or Drag the item to the (Use) function provided <br>If in the right spot a progress bar will appear and you will start doing the land-scaping job<br>Once completed you will be paid and experience will be added towards your total level <br>The higher the level the higher you will end up getting paid<br>Once you are finished doing land-scaping and if you have a job active please use the |LandscapingFinish| By using the Hotbar and or (Use) Function provided!<br>And that's all there is to it! Now you now how to do the land-scaping job! Go out there and make yourself some money!<br><br><br><br><span style='color: red;'>1.6<span style='color: green;'> |Trucking Job|<span style='color: white;'><br>To Start Trucking Head over the the Job centre and select the job Trucking<br>Now that you've got the job Trucker if you hit TAB you will see that above your name it will show your job grade as Trucker<br>In your Inventory you will notice 3 new items in your inventory |TruckerGPS| |TruckingDeliver| |TruckingFinish|<br>To start Trucker please drag TruckerGPS on to your hot-bar or drag TruckerGPS to the (Use) function provided <br>if dragged to hotbar please hit the number corrisponding if slot 1 press 1 etc <br>You will then notice a notification appear saying you've now started Trucking Head-over to your map by pressing ESC <br>Now you will be able to find  a Yellow Blip this is the Trucking Location Please head to there <br>Once at the yellow blip on the map Drag |TruckingDeliver| to the hotbar Or Drag the item to the (Use) function provided <br>If in the right spot a progress bar will appear and you will start doing the trucker job<br>Once completed you will be paid and experience will be added towards your total level <br>The higher the level the higher you will end up getting paid<br>Once you are finished doing trucking and if you have a job active please use the |TruckingFinish| By using the Hotbar and or (Use) Function provided!<br>And that's all there is to it! Now you now how to do the Trucking job! Go out there and make yourself some money!<br><br><br><span style='color: red;'>1.7<span style='color: green;'>|Taxi Job|<span style='color: yellow;'><br>Current as of 26/04/2021</div> ",
        illegalactivity: "<table><thead><tr><th>Name</th><th>Reason</th><th>Time</th></tr></thead><tbody class='lcd-body'></tbody></table>",
        donations: "<table><thead><tr><th>Name</th><th>Reason</th><th>Time</th></tr></thead><tbody class='lcd-body'></tbody></table>",
        keybinds: "<table><thead><tr><th>Name</th><th>Reason</th><th>Time</th></tr></thead><tbody class='lcd-body'></tbody></table>"
     /// useless shit
        //   con: "<table><thead><tr><th>Name</th><th>Time</th></tr></thead><tbody class='lcd-body'></tbody></table>",
      //  disc: "<table><thead><tr><th>Name</th><th>Reason</th><th>Time</th></tr></thead><tbody class='lcd-body'></tbody></table>"
    },
    el_bwh_installed: false, // this will add ban and warn to the admin content menu
    admin_groups: ["mod", "admin", "superadmin"],
    admin_context_menu: [ // examples of custom buttons below
        // {label:"My Cool Button",action:function(target){ // this function doesn't require args, you'll only get target which is the player's server id as a string
        // console.log("Clicked my cool button","player id "+target.toString());
        // }, style:"color:purple;"},
        // this example asks for text input from the user, if they press the "X" icon, your callback won't get called and current action will not proceed
        // {label:"My Cool Button",action:function(target,args){ // since this button uses args, you'll get a second parameter with the string content of the input
        //  console.log("Clicked my cool button","player id "+target.toString(),"input: "+args);
        // }, style:"color:purple;",args:{description:"Write something cool"}}, // args syntax: {description -> string, shows above text input; placeholder -> string, hint in text input (optional)}
        // {label:"My Cool Button",action:"some-action",style:"color:purple;"}, // this button will send a NUI event to client.lua (admin-ctx) with all the parameters, check client.lua and search for admin-ctx; this can also use args, check example above
        {
            label: "Copy SteamID",
            action: function() {
                copyText($(".player-context").data("steamid"), "SteamID Copied to clipboard", 1850);
            }
        },
        {
            label: "Copy SteamID64",
            action: function() {
                copyText(hexidtodec($(".player-context").data("steamid")), "SteamID Copied to clipboard", 1850);
            }
        },
        { label: "Goto", action: "goto" },
        { label: "Bring", action: "bring" },
        { label: "Spectate", action: "spectate", style: "color:green;" },
        { label: "Revive", action: "revive", style: "color:green;" },
       // { label: "Freeze", action: "slay", style: "color:red;" },
    ]
};
