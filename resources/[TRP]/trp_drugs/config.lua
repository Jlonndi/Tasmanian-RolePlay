Config = {} -- DO NOT CHANGE ANYTHING ON LINE 1 OF THIS FILE, SPECIFICALLY THIS LINE RIGHT HERE, AS WELL AS, DO NOT CHANGE ANY TEXT PRIOR TO A =
	-- FOR CLARIFICATION, DO CHANGE ANYTHING ON LINE 1 OF THIS FILE, AS WELL AS, DO NOT CHANGE ANY TEXT PRIOR TO A =, PRIOR TO REFERRING TO THE LEFT SIDE
	-- IF A VALUE AFTER A =, AFTER REFERRING TO THE RIGHT SIDE, IS INSIDE TWO ', MAKE SURE TO PUT YOUR NEW VALUE INSIDE THOSE TWO '.
	-- IF A VALUE AFTER A = IS A NUMERIC DECIMAL, MAKE SURE TO ROUND YOUR NEW VALUE TO THE SAME LENGTH OF THE DEFAULT VALUE
	-- IF YOU ADD A COMPLETELY NEW VALUE TO A TABLE BELOW MAKE SURE TO THOROUGHLY CHECK ALL SYMBOLS:({["',.'"]}) ARE IN THEIR APPROPRIATE LOCATION
	-- IF A VALUE AFTER A = IS true MAKE SURE YOUR NEW VALUE IS false, IF A VALUE AFTER A = IS false MAKE SURE YOUR NEW VALUE IS true

Config.Auth = {
	UseLoader = false, -- USE MODIT LOADER UTILITY TO AUTHORIZE SCRIPT IN TABLE WITH OTHERS?
	Wait = 1 -- WAIT TIME IN SECONDS FOR SERVER BEFORE ATTEMPTING TO AUTHORIZE AND PULL SCRIPT(ADJUST IF RUNNING MANY AUTHORIZED SCRIPTS AND ERROR CONNECTING ISSUE OCCURS)
}

Config.SodyClubs = false -- SET TRUE IF USING SODY CLUBS FOR GANG JOBS INSTEAD OF JOB

Config.MenuAlign = 'top-left' -- SET ESX MENU ALIGNMENT HERE( DONT KNOW WHAT ALL IS ACCEPTABLE, FIGURE IT OUT IF YOU WANT TO CHANGE IT )

Config.Keys = { -- COMMAND KEYS GO HERE
	Deal = 'l'
}

Config.Jobs = { -- SET ALL JOB INFORMATION HERE:POLICE(POLICE JOB NAMES), OTHER(OTHER JOBS NOT ALLOWED TO USE DRUG ZONES/SELL DRUGS), GANGS(GANG NAMES)
	Police = {
		'police',
	},
	Other = {
		'ambulance',
		'fire',
	},
	Gangs = {
		'vagos',
		'ballas',
		'lostmc',
		'lafamilia',
	}
}

Config.JobOptions = {
	OnlyNamed = false, -- SET TRUE TO ONLY LET THE NAMED JOB FOR EACH DRUG USE THAT SYSTEM, FALSE WILL ALLOW ANYONE TO USE ANY SYSTEM
	NotAllowBlacklist = false, -- SET TRUE TO DISABLE POLICE AND OTHER JOBS FROM USING ANY SYSTEMS, FALSE WILL ALLOW THEM TO USE NIL JOB SYSTEMS OR SPECIFIC NAMED ONES
	BlacklistTables = {'Police', 'Other'} -- SET CONFIG.JOBS[TABLE_NAME] YOU WISH TO BE BLACKLISTED FROM USING DRUG ZONES
}

Config.PlantTimer = { -- SET MINIMUM/MAXIMUM TIME BETWEEN PICKING PLANTS
	mini = 3,
	maax = 8
}

Config.UsableCraftModels = { -- SET MODELS OF CARS USABLE TO CRAFT METH
	'journey',
	'camper',
}

Config.CurrencyIcon = '$' -- SET SERVER CURRENCY ICON HERE

Config.Strings = { -- DO NOT CHANGE ANY '%s' DO NOT ADD ANY '%s' DO NOT CHANGE ANY '%d' DO NOT ADD ANY '%d'
	trigEv = 'esx:getSharedObject',
	sellCommand = 'sellDrugs',
	craftMethCommand = 'craftMeth',
	craftCrackCommand = 'craftCrack',
	commandInfo = 'If carrying drugs, use to attempt selling',
	cannabisLabel = 'Cannabis',
	marijuanaLabel = 'Marijuana',
	jointLabel = 'Joint',
	bluntLabel = 'Blunt',
	wrapLabel = 'Blunt Wrap',
	dabsLabel = 'Dabs',
	cocaLabel = 'Coca Leaves',
	cokeLabel = 'Coke',
	crackLabel = 'Crack',
	ephedraLabel = 'Ephedra Leaves',
	sudafedLabel = 'Sudafed',
	methLabel = 'Meth',
	poppyLabel = 'Poppy Leaves',
	opiumLabel = 'Opium',
	heroineLabel = 'Heroine',
	wetshroomLabel = 'Mushrooms',
	shroomLabel = 'Shrooms',
	lsdLabel = 'LSD',
	mollyLabel = 'MDMA',
	narcanLabel = 'Narcan',
	----SERVER STRINGS----
	tooMany = 'You can not carry that many ~r~%s you were instead given ~r~%d',
	cantCarry = 'You can not carry any more ~r~%s',
	notEnough = 'You do not have enough ~r~%s',
	didProcess = 'You have processed %d ~r~%s~s~ into %d ~r~%s',
	whileUse = '~s~ using 1 ~g~%s',
	didRoll = 'You have rolled %d ~r~%s~s~ into %d ~r~%s',
	cantRoll = 'You have nothing to roll with',
	----CLIENT STRINGS----
	bloodFlow = 'Make sure to keep your blood flowing by moving around',
	rollTitle = 'Choose What To Roll',
	tiredHands = 'Your hands are tired, rest them for %s',
	harvestItem = 'You need to have ~g~%s~s~ to harvest ~r~%s',
	closerTo = 'You need to be closer to the %s',
	processItem = 'You need to have ~g~%s~s~ to process ~r~%s',
	missingLastdrug = 'You need to have %d ~g~%s~s~ to process ~r~%s',
	buyerBlipText = 'Buyer',
	acceptSaleText = 'Accept Sale',
	declineSaleTxt = 'Decline Sale',
	checkForBuyers = 'Texting some "clients", press E to cancel messages',
	onTheirWayText = 'A buyer is on the way, press E to cancel sale',
	nobodyWantedIt = 'Nobody responded to your messages',
	drugsWereStole = 'Your %s were stolen!',
	buyerWantsDrug = 'Buyer wants %d %s for '..Config.CurrencyIcon..'%d',
	walkedTooFar = 'You walked too far from the buyer, they got sketched out',
	confirmSale = 'Sell %d %s for '..Config.CurrencyIcon..'%d',
	dealerReport = 'DRUG DEALER REPORTED',
	descriptAdded = 'Description and GPS added',
	dealerBlipText = 'Dealer',
	chooseDrug2Sell = 'Choose Drug To Sell',
	notInRightArea = 'Nobody will buy this drug in this area',
	youHaveNoDrugs = 'You do not have any drugs anyone wants',
	notEnoughMixxy = 'You did not mix the chemicals enough',
	moveTooQuickly = 'You are travelling too quickly to make meth',
	uMustBeDriving = 'You must be driving a van to do this',
	youCannotDoTht = 'You are unable to do this',
	uMustBeWalking = 'You must be walking to do this',
	creationFailur = 'Buyer creation failed',
	requestingModl = 'Requesting model, please wait',
	requestingAnim = 'Requesting animation, please wait',
	animFaild2Load = 'Animation %s failed to load, found in server image, please attempt re-logging to solve',
	modelFail2Load = 'Model %s failed to load, found in server image, please attempt re-logging to solve',
}

Config.Drugs = { -- CREATE AN EMPTY TABLE FOR ANY NEW DRUGS YOU WISH TO ADD
	['cannabis'] = {},
	
	--HOW TO ADD NEW DRUG ZONE--
	-- ['cannabis1'] = {},

	['marijuana'] = {},
	
	['blunt'] = {},
	
	['dabs'] = {},

	['coca'] = {},

	['coke'] = {},
	
	-- ['coke1'] = { },

	['crack'] = {},
	
	-- ['crack1'] = {},

	['ephedra'] = {},

	['sudafed'] = {},

	['meth'] = {},
	
	-- ['meth1'] = {},

	['poppy'] = {},

	['opium'] = {},

	['heroine'] = {},
	
	-- ['heroine1'] = { },
	
	['wetshroom'] = {},

	['shroom'] = {},
	
	['lsd'] = {},
	
	['molly'] = {},

	-- ALL SYSTEMS SET BELOW ARE WIPS AND NOT FULLY IMPLEMENTED --
	
	-- ['narcan'] = {},
}

Config.Swap = { -- SET ALL ZONE SWAPPING INFO BELOW: ONCE(SET ZONES ONLY ONE TIME ON SCRIPT START OR SET THEM REPEATEDLY AFTER A WAIT),
	-- WAIT(TIME TO WAIT IN MINUTES BETWEEN SWAPS IF NOT USING SWAP ONCE)
	Once = false,
	Wait = 60
}

Config.Zones = { -- SET ALL DRUG INFORMATION HERE: NAME(DATABASE ITEM NAME), LABEL(WHAT YOU WANT TO CALL IT), PROP(PLANT PROP IF FIRST LEVEL), MAXSPAWN(MAX AMOUNT OF PROPS TO SPAWN IN ZONE),
	-- MAXPICK(MAX AMOUNT OF PLANT TO RECIEVE WHEN PICKING), JOB(JOB REQUIRED TO USE ZONE), COORDS(ZONE COORDS), HEADING(ZONE HEADING), DELAY(TIME TAKEN TO DO ACTION), LASTDRUG(DRUG NEEDED TO PRODUCE NEW DRUG),
	-- COST(HOW MUCH OF LASTDRUG IS NEEDED TO MAKE REWARD), REWARD(HOW MUCH OF DRUG IS GIVEN FROM PRODUCTION),
	-- REQITEM(DATABASE ITEM NAME REQUIRED TO START PRODUCTION(NOTE THAT, LIKE WETSHROOMS ALREADY HAS EXAMPLED IF YOU DO NOT WANT TO HAVE TO USE AN ITEM FOR A ZONE THEN SET THE REQITEM OPTION TO nil)),
  -- REQITEMNAME(WHAT YOU WANT TO CALL REQITEM), REQITEMREMOVE(SHOULD THE SCRIPT REMOVE THE REQITEM),
	-- MARKERTYPE(TYPE OF MARKER TO DRAW, SET TO -1 TO NOT HAVE A MARKER), MARKERCOLOR(COLOR OF MARKER), DRAWDISTANCE(DISTANCE TO DRAW MARKER), ZONESIZE(SIZE OF MARKER ZONE), ALPHA(MARKER OPACITY),
	-- SPRITE(BLIP PICTURE, SET TO -1 TO NOT HAVE A BLIP), DISPLAY(BLIP DISPLAY TYPE, 4 = MAIN MAP, 5 = MINI MAP), COLOR(BLIP COLOR), SCALE(BLIP SCALE), DICT(ANIMATION DICT TO USE IN ZONE),
	-- ANIM(ANIMATION TO USE IN ZONE), PED(SPAWNED PED MODEL, SET NIL TO NOT SPAWN PED), PEDPOS(SPAWNED PED POSITION), MESSAGE(MESSAGE TO DISPLAY FOR ZONE)
	-- ACTION(CLIENT ACTION STRING, USED TO DETERMINE STAGE), BLENDIN(ANIMATION BLEND IN SPEED), BLENDOUT(ANIMATION BLEND OUT SPEED), ANIMFLAG(ANIMATION FLAG), PLAYBACK(ANIMATION PLAYBACK RATE)

	-- COMMENT [CRACK]/[METH] AND UNCOMMENT AND SETUP [CRACK1]/[METH1] IF WISHING TO USE STANDARD ZONES FOR THESE DRUGS INSTEAD OF SHAKE AND BAKE/METH VAN
	
	-- IF WISHING TO USE A THIRD PARTY MOD DRUG AS A LASTDRUG(BRICKS OF DRUGS, BAGGIES OF DRUGS, ETC) YOU MUST INCLUDE THEM IN THIS TABLE WITH AT LEAST NAME AND LABEL
	-- ['3rdpartydrugcuzspindlenogood'] = {name = 'databasename', label = 'That Better Drug'} YOU DO NOT NEED TO ADD THE DRUG IF USING IT AS A REQITEM, ONLY IF ITS A LASTDRUG

	-- UNCOMMENT ZONE 2 AND ADD MORE ASCENDING VALUED TABLES IF YOU WISH TO HAVE A ZONE MOVEABLE
	-- DEFAULT ZONE 2 IS EXACT SAME AS ZONE 1 (ZONE 2 MUST BE CONFIGURED BY YOURSELF TO FUNCTION PROPERLY)
	
	['cannabis'] = {
		[1] = {name = 'cannabis', label = Config.Strings.cannabisLabel, prop = 'prop_weed_01', maxSpawn = 25, maxPick = 2, job = nil, coords = vector3(350.68, 4417.41, 62.97), heading = nil, delay = 10000, lastdrug = nil,
		cost = 5, reward = 1, reqitem = 'trimmers', reqitemname = 'Trimmers', reqitemremove = false, markertype = -1, markercolor = vector3(255, 204, 100), drawdistance = 30,
		zonesize = vector3(25.0, 25.0, 3.0), alpha = 20, sprite = 66, display = 6, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 's_m_m_gardener_01',
		pedpos = vector4(353.68, 4412.41, 62.97, 0.00), message = 'You remember your ~g~Friend~s~ said they put some ~r~'..Config.Strings.cannabisLabel..'~s~ plants up here somewhere', shouldTP = true, action = 'spawn',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'coca', label = Config.Strings.cocaLabel, prop = 'prop_bush_med_01', maxSpawn = 25, maxPick = 3, job = 'ballas', coords = vector3(350.68, 4417.41, 62.97), heading = nil, delay = 20000, lastdrug = nil,
		-- cost = 5, reward = 1, reqitem = 'trimmers', reqitemname = 'Trimmers', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 50,
		-- zonesize = vector3(25.0, 25.0, 3.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 's_m_m_gardener_01',
		-- pedpos = vector4(2575.85, 5020.34, 49.91, 0.00), message = 'You remember your ~g~Friend~s~ said they put some ~r~'..Config.Strings.cocaLabel..'~s~ plants up here somewhere', shouldTP = true, action = 'spawn',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['marijuana'] = {
		[1] = {name = 'marijuana', label = Config.Strings.marijuanaLabel, prop = nil, job = 'ballas', coords = vector3(2327.94, 2569.65, 45.68), heading = 133.98, delay = 15000, lastdrug = 'cannabis',
		cost = 1, reward = 15, reqitem = 'baggy', reqitemname = 'Baggy', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', anim = 'weed_crouch_checkingleaves_idle_01_inspector', ped = 'g_m_importexport_01',
		pedpos = vector4(2328.55, 2572.18, 45.68, 65.00), message = 'You see your ~g~Friend~s~ processing ~r~'..Config.Strings.marijuanaLabel..'~s~ here often', shouldTP = true, action = 'process',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'marijuana', label = Config.Strings.marijuanaLabel, prop = nil, job = 'ballas', coords = vector3(2327.94, 2569.65, 45.68), heading = 133.98, delay = 10000, lastdrug = 'cannabis',
		-- cost = 1, reward = 15, reqitem = 'baggy', reqitemname = 'Baggy', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		 zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', anim = 'weed_crouch_checkingleaves_idle_01_inspector', ped = 'g_m_importexport_01',
		-- pedpos = vector4(2328.55, 2572.18, 45.68, 65.00), message = 'You see your ~g~Friend~s~ processing ~r~'..Config.Strings.marijuanaLabel..'~s~ here often', shouldTP = true, action = 'process',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},
	
	['blunt'] = {-- SET JOINT/BLUNT ROLLING ANIMATION INFORMATION HERE
		[1] = {name = 'blunt', delay = 20000, dict = 'amb@prop_human_movie_studio_light@base', anim = 'base', blendIn = 8.0,
		blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0},
		-- [2] = {name = 'blunt', delay = 20000, dict = 'amb@prop_human_movie_studio_light@base', anim = 'base', blendIn = 8.0,
		-- blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0},
	},
	
	['dabs'] = {
		[1] = {name = 'dabs', label = Config.Strings.dabsLabel, prop = nil, job = 'ballas', coords = vector3(471.83, -1309.81, 28.23), heading = 115.44, delay = 10000, lastdrug = 'marijuana',
		cost = 3, reward = 1, reqitem = 'drugpress', reqitemname = 'Drug Press', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'anim@amb@business@coc@coc_packing@', anim = 'operate_press_basicmould_v1_pressoperator', ped = 'g_m_importexport_01',
		pedpos = vector4(474.91, -1309.25, 28.21, 300.00), message = 'You see your ~g~Friend~s~ creating ~r~'..Config.Strings.dabsLabel..'~s~ here often', shouldTP = true, action = 'harden',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'dabs', label = Config.Strings.dabsLabel, prop = nil, job = 'ballas', coords = vector3(471.83, -1309.81, 28.23), heading = 115.44, delay = 10000, lastdrug = 'marijuana',
		-- cost = 3, reward = 1, reqitem = 'drugpress', reqitemname = 'Drug Press', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		 zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'anim@amb@business@coc@coc_packing@', anim = 'operate_press_basicmould_v1_pressoperator', ped = 'g_m_importexport_01',
		-- pedpos = vector4(474.91, -1309.25, 28.21, 300.00), message = 'You see your ~g~Friend~s~ creating ~r~'..Config.Strings.dabsLabel..'~s~ here often', shouldTP = true, action = 'harden',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['coca'] = {
		[1] = {name = 'coca', label = Config.Strings.cocaLabel, prop = 'prop_bush_med_01', maxSpawn = 25, maxPick = 5, job = 'ballas', coords = vector3(2575.85, 5020.34, 49.91), heading = nil, delay = 20000, lastdrug = nil,
		cost = 5, reward = 1, reqitem = 'trimmers', reqitemname = 'Trimmers', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 50,
		zonesize = vector3(50.0, 50.0, 3.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 's_m_m_gardener_01',
		pedpos = vector4(2575.85, 5020.34, 49.91, 0.00), message = 'You remember your ~g~Friend~s~ said they put some ~r~'..Config.Strings.cocaLabel..'~s~ plants up here somewhere', shouldTP = true, action = 'spawn',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'coca', label = Config.Strings.cocaLabel, prop = 'prop_bush_med_01', maxSpawn = 25, maxPick = 3, job = 'ballas', coords = vector3(2575.85, 5020.34, 49.91), heading = nil, delay = 20000, lastdrug = nil,
		-- cost = 5, reward = 1, reqitem = 'trimmers', reqitemname = 'Trimmers', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 50,
		-- zonesize = vector3(50.0, 50.0, 3.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 's_m_m_gardener_01',
		-- pedpos = vector4(2575.85, 5020.34, 49.91, 0.00), message = 'You remember your ~g~Friend~s~ said they put some ~r~'..Config.Strings.cocaLabel..'~s~ plants up here somewhere', shouldTP = true, action = 'spawn',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['coke'] = {
		[1] = {name = 'coke', label = Config.Strings.cokeLabel, prop = nil, job = 'ballas', coords = vector3(1981.76, 5178.07, 46.64), heading = 26.95, delay = 20000, lastdrug = 'coca',
		cost = 2, reward = 1, reqitem = 'baggy', reqitemname = 'Baggy', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'anim@amb@business@coc@coc_packing@', anim = 'fill_basicmould_v2_pressoperator', ped = 'g_m_importexport_01',
		pedpos = vector4(1982.81, 5178.34, 46.64, 41.43), message = 'You see your ~g~Friend~s~ processing ~r~'..Config.Strings.cokeLabel..'~s~ here often', shouldTP = true, action = 'process',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'coke', label = Config.Strings.cokeLabel, prop = nil, job = 'ballas', coords = vector3(1981.76, 5178.07, 46.64), heading = 26.95, delay = 20000, lastdrug = 'coca',
		-- cost = 2, reward = 1, reqitem = 'baggy', reqitemname = 'Baggy', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		-- zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'anim@amb@business@coc@coc_packing@', anim = 'fill_basicmould_v2_pressoperator', ped = 'g_m_importexport_01',
		-- pedpos = vector4(1982.81, 5178.34, 46.64, 41.43), message = 'You see your ~g~Friend~s~ processing ~r~'..Config.Strings.cokeLabel..'~s~ here often', shouldTP = true, action = 'process',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['crack'] = {
		[1] = {name = 'crack', label = Config.Strings.crackLabel, prop = nil, job = 'ballas', delay = 35000, lastdrug = 'coke', cost = 2, reward = 1,
		reqitem = 'chemicals', reqitemname = 'Crack Chems', reqitemremove = true, dict = 'missminuteman_1ig_2', anim = 'handsup_base',
		message = 'You are creating ~r~'..Config.Strings.crackLabel..'~s~, run around to help mix it', blendIn = 3.0, blendOut = -3.0, animFlag = 49, playBack = 1.0, reqCops = 0},
		-- [2] = {name = 'crack', label = Config.Strings.crackLabel, prop = nil, job = 'ballas', delay = 35000, lastdrug = 'coke', cost = 2, reward = 1,
		-- reqitem = 'chemicals', reqitemname = 'Crack Chems', reqitemremove = true, dict = 'missminuteman_1ig_2', anim = 'handsup_base',
		-- message = 'You are creating ~r~'..Config.Strings.crackLabel..'~s~, run around to help mix it', blendIn = 3.0, blendOut = -3.0, animFlag = 49, playBack = 1.0, reqCops = 0},
	},

	['ephedra'] = {
		[1] = {name = 'ephedra', label = Config.Strings.ephedraLabel, prop = 'prop_weeddry_nxg04', maxSpawn = 25, maxPick = 4, job = 'ballas', coords = vector3(340.06, 3567.50, 32.47), heading = nil, delay = 20000, lastdrug = nil,
		cost = 5, reward = 1, reqitem = 'trimmers', reqitemname = 'Trimmers', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 30,
		zonesize = vector3(25.0, 25.0, 3.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 's_m_m_gardener_01',
		pedpos = vector4(340.06, 3567.50, 32.47, 0.00), message = 'You remember your ~g~Friend~s~ said they put some ~r~'..Config.Strings.ephedraLabel..'~s~ plants up here somewhere', shouldTP = true, action = 'spawn',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'ephedra', label = Config.Strings.ephedraLabel, prop = 'prop_weeddry_nxg04', maxSpawn = 25, maxPick = 3, job = 'ballas', coords = vector3(340.06, 3567.50, 32.47), heading = nil, delay = 20000, lastdrug = nil,
		-- cost = 5, reward = 1, reqitem = 'trimmers', reqitemname = 'Trimmers', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 30,
		-- zonesize = vector3(25.0, 25.0, 3.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 's_m_m_gardener_01',
		-- pedpos = vector4(340.06, 3567.50, 32.47, 0.00), message = 'You remember your ~g~Friend~s~ said they put some ~r~'..Config.Strings.ephedraLabel..'~s~ plants up here somewhere', shouldTP = true, action = 'spawn',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['sudafed'] = {
		[1] = {name = 'sudafed', label = Config.Strings.sudafedLabel, prop = nil, job = 'ballas', coords = vector3(1976.73, 3819.35, 32.45), heading = 121.19, delay = 20000, lastdrug = 'ephedra',
		cost = 5, reward = 1, reqitem = 'drugpress', reqitemname = 'Drug Press', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 'g_m_m_chemwork_01',
		pedpos = vector4(1975.46, 3818.47, 32.44, 205.22), message = 'You see your ~g~Friend~s~ processing ~r~'..Config.Strings.sudafedLabel..'~s~ here often', shouldTP = true, action = 'process',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'sudafed', label = Config.Strings.sudafedLabel, prop = nil, job = 'ballas', coords = vector3(1976.73, 3819.35, 32.45), heading = 121.19, delay = 20000, lastdrug = 'ephedra',
		-- cost = 5, reward = 1, reqitem = 'drugpress', reqitemname = 'Drug Press', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		-- zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 'g_m_m_chemwork_01',
		-- pedpos = vector4(1975.46, 3818.47, 32.44, 205.22), message = 'You see your ~g~Friend~s~ processing ~r~'..Config.Strings.sudafedLabel..'~s~ here often', shouldTP = true, action = 'process',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['meth'] = {
		[1] = {name = 'meth', label = Config.Strings.methLabel, prop = nil, job = 'ballas', delay = 60000, lastdrug = 'sudafed', cost = 2, reward = 1, 
		reqitem = 'chemicals1', reqitemname = 'Meth Chems', reqitemremove = true, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', 
		message = 'You are crafting ~r~'..Config.Strings.methLabel..'~s~, keep the horn on', blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0},
		-- [2] = {name = 'meth', label = Config.Strings.methLabel, prop = nil, job = 'ballas', delay = 60000, lastdrug = 'sudafed', cost = 5, reward = 1, 
		-- reqitem = 'chemicals1', reqitemname = 'Meth Chems', reqitemremove = true, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', 
		-- message = 'You are crafting ~r~'..Config.Strings.methLabel..'~s~, keep the horn on', blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0},
	},

	['poppy'] = {
		[1] = {name = 'poppy', label = Config.Strings.poppyLabel, prop = 'prop_plant_fern_01b', maxSpawn = 25, maxPick = 3, job = 'lostmc', coords = vector3(-1819.52, 1973.8, 132.37), heading = nil, delay = 20000, lastdrug = nil,
		cost = 5, reward = 1, reqitem = 'trimmers', reqitemname = 'Trimmers', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 35,
		zonesize = vector3(32.5, 32.5, 3.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 's_m_m_gardener_01',
		pedpos = vector4(-1819.52, 1973.8, 132.37, 0.00), message = 'You remember your ~g~Friend~s~ said they put some ~r~'..Config.Strings.poppyLabel..'~s~ plants up here somewhere', shouldTP = true, action = 'spawn',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'poppy', label = Config.Strings.poppyLabel, prop = 'prop_plant_fern_01b', maxSpawn = 25, maxPick = 3, job = 'lostmc', coords = vector3(-1819.52, 1973.8, 132.37), heading = nil, delay = 20000, lastdrug = nil,
		-- cost = 5, reward = 1, reqitem = 'trimmers', reqitemname = 'Trimmers', reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 35,
		-- zonesize = vector3(32.5, 32.5, 3.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 's_m_m_gardener_01',
		-- pedpos = vector4(-1819.52, 1973.8, 132.37, 0.00), message = 'You remember your ~g~Friend~s~ said they put some ~r~'..Config.Strings.poppyLabel..'~s~ plants up here somewhere', shouldTP = true, action = 'spawn',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['opium'] = {
		[1] = {name = 'opium', label = Config.Strings.opiumLabel, prop = nil, job = 'ballas', coords = vector3(1392.00, 3605.90, 37.94), heading = 111.65, delay = 20000, lastdrug = 'poppy',
		cost = 2, reward = 1, reqitem = 'chemicals2', reqitemname = 'Opium Chems', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 'g_m_importexport_01',
		pedpos = vector4(1389.04, 3605.33, 37.94, 290.08), message = 'You see your ~g~Friend~s~ processing ~r~'..Config.Strings.opiumLabel..'~s~ here often', shouldTP = true, action = 'process',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'opium', label = Config.Strings.opiumLabel, prop = nil, job = 'ballas', coords = vector3(1392.00, 3605.90, 37.94), heading = 111.65, delay = 20000, lastdrug = 'poppy',
		-- cost = 5, reward = 1, reqitem = 'chemicals2', reqitemname = 'Opium Chems', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		-- zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 'g_m_importexport_01',
		-- pedpos = vector4(1389.04, 3605.33, 37.94, 290.08), message = 'You see your ~g~Friend~s~ processing ~r~'..Config.Strings.opiumLabel..'~s~ here often', shouldTP = true, action = 'process',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['heroine'] = {
		[1] = {name = 'heroine', label = Config.Strings.heroineLabel, prop = nil, job = 'vagos', coords = vector3(2431.60, 4970.97, 41.35), heading = 46.61, delay = 10000, lastdrug = 'opium',
		cost = 2, reward = 1, reqitem = 'needle', reqitemname = 'Hypodermic Needle', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 'g_m_m_chemwork_01',
		pedpos = vector4(2432.43, 4970.23, 41.35, 223.95), message = 'You see your ~g~Friend~s~ creating ~r~'..Config.Strings.heroineLabel..'~s~ here often', shouldTP = true, action = 'package',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'heroine', label = Config.Strings.heroineLabel, prop = nil, job = 'vagos', coords = vector3(2431.60, 4970.97, 41.35), heading = 46.61, delay = 10000, lastdrug = 'opium',
		-- cost = 5, reward = 1, reqitem = 'needle', reqitemname = 'Hypodermic Needle', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		-- zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 'g_m_m_chemwork_01',
		-- pedpos = vector4(2432.43, 4970.23, 41.35, 223.95), message = 'You see your ~g~Friend~s~ creating ~r~'..Config.Strings.heroineLabel..'~s~ here often', shouldTP = true, action = 'package',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},
	
	['wetshroom'] = {
		[1] = {name = 'wetshroom', label = Config.Strings.wetshroomLabel, prop = 'prop_weeddry_nxg04', maxSpawn = 25, maxPick = 3, job = 'ballas', coords = vector3(2155.02, 5041.87, 41.89), heading = nil, delay = 10000, lastdrug = nil,
		cost = 1, reward = 1, reqitem = nil, reqitemname = nil, reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 50,
		zonesize = vector3(35.0, 35.0, 3.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 'a_m_m_farmer_01',
		pedpos = vector4(2155.02, 5041.87, 41.79, 0.00), message = 'You remember hearing about a ~r~'..Config.Strings.wetshroomLabel..'~s~ farm up here somewhere', shouldTP = true, action = 'spawn',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'wetshroom', label = Config.Strings.wetshroomLabel, prop = 'prop_weeddry_nxg04', maxSpawn = 25, maxPick = 3, job = 'ballas', coords = vector3(2155.02, 5041.87, 41.89), heading = nil, delay = 10000, lastdrug = nil,
		-- cost = 1, reward = 1, reqitem = nil, reqitemname = nil, reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 50,
		-- zonesize = vector3(35.0, 35.0, 3.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'amb@world_human_gardener_plant@female@base', anim = 'base_female', ped = 'a_m_m_farmer_01',
		-- pedpos = vector4(2155.02, 5041.87, 41.79, 0.00), message = 'You remember hearing about a ~r~'..Config.Strings.wetshroomLabel..'~s~ farm up here somewhere', shouldTP = true, action = 'spawn',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},

	['shroom'] = {
		[1] = {name = 'shroom', label = Config.Strings.shroomLabel, prop = nil, job = 'ballas', coords = vector3(2451.98, 3758.18, 40.82), heading = 338.57, delay = 20000, lastdrug = 'wetshroom',
		cost = 1, reward = 1, reqitem = 'joint', reqitemname = 'Joint', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'amb@world_human_smoking_pot@male@base', anim = 'base', ped = 'u_m_y_hippie_01',
		pedpos = vector4(2451.27, 3759.30, 40.72, 285.54), message = 'These ~g~Hippies~s~ will let you dry your ~r~'..Config.Strings.shroomLabel..'~s~ while you smoke with them', shouldTP = true, action = 'process',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'shroom', label = Config.Strings.shroomLabel, prop = nil, job = 'ballas', coords = vector3(2451.98, 3758.18, 40.82), heading = 338.57, delay = 20000, lastdrug = 'wetshroom',
		-- cost = 1, reward = 1, reqitem = 'joint', reqitemname = 'Joint', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		-- zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'amb@world_human_smoking_pot@male@base', anim = 'base', ped = 'u_m_y_hippie_01',
		-- pedpos = vector4(2451.27, 3759.30, 40.72, 285.54), message = 'These ~g~Hippies~s~ will let you dry your ~r~'..Config.Strings.shroomLabel..'~s~ while you smoke with them', shouldTP = true, action = 'process',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},
	
	['lsd'] = {
		[1] = {name = 'lsd', label = Config.Strings.lsdLabel, prop = nil, job = 'ballas', coords = vector3(3559.56, 3672.19, 27.12), heading = 350.18, delay = 20000, lastdrug = 'shroom',
		cost = 2, reward = 1, reqitem = nil, reqitemname = nil, reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 's_m_m_scientist_01',
		pedpos = vector4(3559.86, 3674.77, 27.12, 170.00), message = 'You can probably find a shady ~b~Scientist~s~ who can make you ~r~'..Config.Strings.lsdLabel..'~s~ here', shouldTP = true, action = 'package',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'lsd', label = Config.Strings.lsdLabel, prop = nil, job = 'ballas', coords = vector3(3559.56, 3672.19, 27.12), heading = 350.18, delay = 20000, lastdrug = 'shroom',
		-- cost = 5, reward = 1, reqitem = nil, reqitemname = nil, reqitemremove = false, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		-- zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 's_m_m_scientist_01',
		-- pedpos = vector4(3559.86, 3674.77, 27.12, 170.00), message = 'You can probably find a shady ~b~Scientist~s~ who can make you ~r~'..Config.Strings.lsdLabel..'~s~ here', shouldTP = true, action = 'package',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},
	
	['molly'] = {
		[1] = {name = 'molly', label = Config.Strings.mollyLabel, prop = nil, job = 'ballas', coords = vector3(3537.06, 3660.20, 27.12), heading = 348.80, delay = 20000, lastdrug = 'lsd',
		cost = 1, reward = 1, reqitem = 'heroine', reqitemname = 'Heroine', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 0, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 's_m_m_scientist_01',
		pedpos = vector4(3536.84, 3662.80, 27.12, 170.00), message = 'You can probably find a shady ~b~Scientist~s~ who can make you ~r~'..Config.Strings.mollyLabel..'~s~ here', shouldTP = true, action = 'harden',
		blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
		-- [2] = {name = 'molly', label = Config.Strings.mollyLabel, prop = nil, job = 'ballas', coords = vector3(3537.06, 3660.20, 27.12), heading = 348.80, delay = 20000, lastdrug = 'lsd',
		-- cost = 1, reward = 1, reqitem = 'heroine', reqitemname = 'Heroine', reqitemremove = true, markertype = -1, markercolor = vector3(100, 204, 100), drawdistance = 10,
		-- zonesize = vector3(1.25, 1.25, 1.0), alpha = 20, sprite = 66, display = 4, color = 2, scale = 1.0, dict = 'mp_am_hold_up', anim = 'purchase_beerbox_shopkeeper', ped = 's_m_m_scientist_01',
		-- pedpos = vector4(3536.84, 3662.80, 27.12, 170.00), message = 'You can probably find a shady ~b~Scientist~s~ who can make you ~r~'..Config.Strings.mollyLabel..'~s~ here', shouldTP = true, action = 'harden',
		-- blendIn = 8.0, blendOut = -8.0, animFlag = 1, playBack = 1.0, reqCops = 0, pedWander = true},
	},
}

Config.SellableDrugs = { -- SET ALL DRUG SALE PED INFORMATION HERE: ZONES(IN-GAME ZONE LOCATIONS PLAYERS CAN SELL THAT DRUG IN), PEDS(LIST ALL PED MODELS TO SELECT FROM HERE), CANCALL(CHOOSE WHETHER THESE PEDS CAN/WILL CALL THE COPS ON PLAYER DEALING,
	-- CALLCHANCE(SET PERCENT CHANCE OF PED CALLING COPS IF CANCALL = TRUE), CANROB(CHOOSE WHETHER THESE PEDS CAN/WILL ROB PLAYERS DEALING), ROBCHANCE(SET PERCENT CHANCE OF PED ROBBING PLAYER IF CANROB = TRUE)
	-- CALLCHANCE/ROBCHANCE ARE PERCENT VALUES OUT OF 100, MINPRICE/MAXPRICE(MINIMUM/MAXIMUM SALE PRICE FOR EACH ITEM SOLD), ACCOUNT(xPLAYER ACCOUNT TO GIVE MONEY TO)
	-- MAXAMOUNT(MAXIMUM AMOUNT OF DRUGS THAT CAN BE BOUGHT AT ONE TIME), NOJOBS(SET WHETHER OR NOT PLAYERS WITH GANG JOBS OR "OTHER JOBS" CAN SELL THAT DRUG),
	-- BLACKLISTGANGS(GANGS YOU DO NOT WANT SELLING THAT DRUG, ONLY USED IF NOJOBS = false)
	-- ZONE MAP AND NAMES AVAILABLE HERE https://www.igta5.com/images/gtav-map-neighborhoods.jpg AND HERE https://forums.gta5-mods.com/topic/5749/reference-map-zone-names-and-zone-labels
	['cannabis'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = true,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 15,
		maxPrice = 100,
		account = 'money',
		maxAmount = 15,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['marijuana'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 25,
		maxPrice = 120,
		account = 'money',
		maxAmount = 15,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},
	
	['joint'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 40,
		maxPrice = 180,
		account = 'money',
		maxAmount = 10,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},
	
	['blunt'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = true,
		robChance = 10,
		minPrice = 80,
		maxPrice = 230,
		account = 'money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['dabs'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 400,
		maxPrice = 540,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['coca'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = true,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 20,
		maxPrice = 150,
		account = 'black_money',
		maxAmount = 18,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['coke'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = true,
		robChance = 10,
		minPrice = 650,
		maxPrice = 790,
		account = 'black_money',
		maxAmount = 18,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['crack'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = true,
		robChance = 10,
		minPrice = 800,
		maxPrice = 1000,
		account = 'black_money',
		maxAmount = 18,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['ephedra'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = true,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 78,
		maxPrice = 252,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['sudafed'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = true,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 99,
		maxPrice = 240,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['meth'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = true,
		robChance = 10,
		minPrice = 400,
		maxPrice = 800,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['poppy'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = true,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 100,
		maxPrice = 230,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['opium'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 450,
		maxPrice = 700,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['heroine'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 80,
		maxPrice = 380,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},
	
	['wetshroom'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = true,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 80,
		maxPrice = 250,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},

	['shroom'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 130,
		maxPrice = 250,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},
	
	['lsd'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = false,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 33,
		maxPrice = 250,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	},
	
	['molly'] = {
		zones = {'LEGSQU', 'STRAW', 'SKID', 'DAVIS', 'RANCHO', 'CHAMH', 'TEXTI', 'PBOX', 'KOREAT', 'DELPE', 'ROCKF', 'BURTON', 'ALTA', 'WVINE', 'DTVINE', 'EAST_V', 'DOWNT', 'LMESA', 'MIRR', 'HAWICK'},
		peds = {'g_m_importexport_01', 'g_m_m_chicold_01', 'g_m_y_ballaeast_01', 'g_m_y_lost_01', 'g_m_y_famca_01', 'g_m_y_salvaboss_01', 'g_f_importexport_01', 'g_f_y_lost_01', 'g_f_y_vagos_01'},
		copsNeeded = 0,
		canCall = true,
		callChance = 10,
		canRob = false,
		robChance = 10,
		minPrice = 60,
		maxPrice = 310,
		account = 'black_money',
		maxAmount = 35,
		noJobs = false,
		blacklistGangs = {'ballas', 'vagos'}
	}
}