Locales = {}

function _(str, ...)  -- Translate string

	if Locales[Config.Locale] ~= nil or Locales[Config.Locale2] ~= nil or Locales[Config.Locale3] ~= nil or Locales[Config.Locale4] ~= nil then

		if Locales[Config.Locale][str] ~= nil then	
			return string.format(Locales[Config.Locale][str], ...)
		else
			return 'Translation does not exist CHECK CONFIG'
		end
		if Locales[Config.Locale2][str] ~= nil then	
			return string.format(Locales[Config.Locale2][str], ...)
		else
			return 'Translation does not exist CHECK CONFIG'
		end
		if Locales[Config.Locale3][str] ~= nil then	
			return string.format(Locales[Config.Locale3][str], ...)
		else
			return 'Translation does not exist CHECK CONFIG'
		end
		if Locales[Config.Locale4][str] ~= nil then	
			return string.format(Locales[Config.Locale3][str], ...)
		else
			return 'Translation does not exist CHECK CONFIG'
		end

	else
		return 'Locale does not exist CHECK CONFIG'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end
