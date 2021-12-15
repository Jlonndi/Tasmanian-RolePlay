

-- Branding!
local label = 
[[
                            . .  ,  ,
                            |` \/ \/ \,',	
                            ;          ` \/\,.
                           :               ` \,/				
                           |                  /
                           ;                 :
                          :                  ;
                          |      ,---.      /
                         :     ,'     `,-._ \
                         ;    (   o    \   `'
                       _:      .      ,'  o ;
                      /,.`      `.__,'`-.__,
                      \_  _               \
                     ,'  / `,          `.,'
               ___,'`-._ \_/ `,._        ;
            __;_,'      `-.`-'./ `--.____)
         ,-'           _,--\^-'
       ,:_____      ,-'     \
      (,'     `--.  \;-._    ;
      :    Y      `-/    `,  :   This is a sponsored message
      :    :       :     /_;'		TassieRP supports this message.
      :    :       |    :				Moon Thy Neighbour
       \    \      :    :
        `-._ `-.__, \    `.
           \   \  `. \     `.
         ,-;    \---)_\ ,','/
         \_ `---'--'" ,'^-;'
         (_`     ---'" ,-')
         / `--.__,. ,-'    \
-hrr-    )-.__,-- ||___,--' `-.
        /._______,|__________,'\
        `--.____,'|_________,-'
]]
function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end 

PerformHttpRequest( "https://wolfknight98.github.io/wk_wars2x_web/version.txt", function( err, text, headers )
	Citizen.Wait( 2000 )

	print( label )

	local curVer = GetCurrentVersion()
	
	if ( text ~= nil ) then 
		print( "  ||    Current version: " .. curVer )
		print( "  ||    Latest recommended version: " .. text .."\n  ||" )
		
		if ( text ~= curVer ) then
			print( "|trp:radar| there would appear to be a more upto date version please download it" )
		else
			print( "|trp:radar| Radar is up to date!" )
		end
	else 
		    print( "|trp:radar| An error was detected when fetching updates please manually install an updated version!" )
	end 
end )