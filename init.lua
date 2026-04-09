dofile_once("data/scripts/lib/utilities.lua")

local new_translations = ModTextFileGetContent("mods/NotesExpanded/translations.csv")

local function updateTranslations()
	local translations = ModTextFileGetContent("data/translations/common.csv")
	translations = translations .. new_translations
	translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
	ModTextFileSetContent("data/translations/common.csv", translations)
end

function OnModPreInit()
    updateTranslations()
    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/NotesExpanded/files/scripts/gun/gun_actions.lua" )
end
