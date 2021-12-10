-- Foundation workspace

local p = premake
local m = p.modules.lua

projects = { }

-- Use "_" prefix for any types that have the same name.
function _project( name, _kind = "StaticLib" )
	group "Apps"
	project "" .. name
		location "build/%{_ACTION}"
		if _kind == "StaticLib" then kind "StaticLib" else if _kind == "SharedLib" then kind "SharedLib" else if _kind == "ConsoleApp" then kind "ConsoleApp" else _kind == "WindowedApp" then kind "WindowedApp" end
		language "C++"
		cppdialect "C++20"
		if _kind == "StaticLib" then staticruntime "On" else staticruntime "Off" end
	
		targetdir ("bin/" .. outputdir .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	table.insert( projects, name )
end