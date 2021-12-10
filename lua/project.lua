-- Foundation workspace

local p = premake
local m = p.modules.lua

projects = { }

-- Use "_" prefix for any types that have the same name.
function _project( name, _kind )
	group "Apps"
	project ( name )
		location( "build/%{_ACTION}" )
		if _kind == "StaticLib" then 
			kind "StaticLib" 
		elseif _kind == "SharedLib" then 
			kind "SharedLib" 
		elseif _kind == "ConsoleApp" then 
			kind "ConsoleApp" 
		else 
			kind "WindowedApp" 
		end
		language( "C++" )
		cppdialect( "C++20" )
		if _kind == "StaticLib" then staticruntime( "On" ) else staticruntime( "Off" ) end
	
		targetdir ("bin/" .. outputdir() .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir() .. "/%{prj.name}")

		links( third_party_projects )

		files( "%{prj.name}/src/**.h", "%{prj.name}/src/**.cpp")	

		filter "system:windows"
			systemversion "latest"
	
		filter "system:linux"
			systemversion "latest"

		filter "system:macosx"
			systemversion "11"

		filter "configurations:Debug"
			defines "CORE_DEBUG"
			runtime "Debug"
			symbols "on"

		filter "configurations:Release"
			defines "CORE_RELEASE"
			runtime "Release"
			optimize "on"

	table.insert( projects, name )
end