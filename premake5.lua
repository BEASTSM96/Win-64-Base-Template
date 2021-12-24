require "lua/init"
require "lua/project"
require "lua/workspace"
require "lua/third_party_include"

_workspace( "App-Base", "ExePrj" )

third_party_include "third_party/glfw"
third_party_include "third_party/imgui"
third_party_include "third_party/xGL"

_project( "libProject", "StaticLib" )
	includedirs
	{
		"%{prj.name}/src"
	}

	files
	{ 
		"%{prj.name}/src/**.h", 
		"%{prj.name}/src/**.cpp"
	}

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

_project( "ExePrj", "ConsoleApp" )
	includedirs
	{	
		"%{prj.name}/src/**.h",
		"libProject/src/**.h",
		"third_party/glfw/include",
		"third_party/ImGui/",
		"third_party/xGL/src/"
	}
	
	files
	{ 
		"%{prj.name}/src/**.h", 
		"%{prj.name}/src/**.cpp"
	}

	links
	{
		"libProject"
	}
	
	defines 
	{
		"GLFW_INCLUDE_NONE"
	}

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