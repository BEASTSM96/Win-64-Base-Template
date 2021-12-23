-- Foundation third party project

local p = premake
local m = p.modules.lua

third_party_projects = { }

function third_party_project( name, _kind ) 
	group "Third Party"
	project ( name )
		location ( name )
		kind( get_kind( _kind ) )
		language "C++"
		cppdialect "C++20"
		if _kind == "StaticLib" then staticruntime "On" else staticruntime "Off" end
	
		warnings "Off"

		targetdir ("bin/" .. outputdir() .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir() .. "/%{prj.name}")
			
	table.insert( third_party_projects, name )
end