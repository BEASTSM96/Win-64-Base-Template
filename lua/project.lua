-- Foundation workspace

local p = premake
local m = p.modules.lua

projects = { }

-- Use "_" prefix for any types that have the same name.
function _project( name, _kind )
	group "Apps"
	project ( name )
		location( name )
		kind( get_kind( _kind ) )
		language( "C++" )
		cppdialect( "C++20" )
		staticruntime( "On" )
	
		targetdir ("bin/" .. outputdir() .. "/%{prj.name}")
		objdir ("bin-int/" .. outputdir() .. "/%{prj.name}")

		links( third_party_projects )
		
	table.insert( projects, name )
end