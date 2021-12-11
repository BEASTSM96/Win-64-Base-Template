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