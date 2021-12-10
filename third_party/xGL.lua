require "../lua/init"
require "../lua/third_party_project"

third_party_project( "xGL", "StaticLib" )
	files
	{
		"%{prj.name}/src/xgl.cpp",
		"%{prj.name}/src/xgl.h"
	}
	
	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}
	
	includedirs
	{
		"%{prj.name}/src/**.h"
	}