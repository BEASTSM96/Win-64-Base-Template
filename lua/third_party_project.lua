-- Foundation third party project

local p = premake
local m = p.modules.lua

third_party_projects = { }

function third_party_project( name, _kind ) 
	group "Third Party"
	project ( name )
		location "../build/%{_ACTION}"
		if _kind == "StaticLib" then 
			kind "StaticLib" 
		elseif _kind == "SharedLib" then 
			kind "SharedLib" 
		elseif _kind == "ConsoleApp" then 
			kind "ConsoleApp" 
		else 
			kind "WindowedApp" 
		end
		language "C++"
		cppdialect "C++20"
		if _kind == "StaticLib" then staticruntime "On" else staticruntime "Off" end
	
		targetdir ("../bin/" .. outputdir() .. "/%{prj.name}")
		objdir ("../bin-int/" .. outputdir() .. "/%{prj.name}")

		filter "system:windows"
			systemversion "latest"
	
		filter "system:linux"
			systemversion "latest"

		filter "system:macosx"
			systemversion "11"

		filter "configurations:Debug"
			runtime "Debug"
			symbols "on"

		filter "configurations:Release"
			runtime "Release"
			optimize "on"
			
	table.insert( third_party_projects, name )
end