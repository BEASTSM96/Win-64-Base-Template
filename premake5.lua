require "lua/init"
require "lua/project"
require "lua/workspace"
require "lua/third_party_includes"

_workspace( "App-Base", "ExePrj" )

third_party_include "vendor/glfw"
third_party_include "vendor/imgui"
third_party_include "vendor/xGL"


_project( "libProject" )
	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	includedirs
	{
		"%{prj.name}/src"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines "CORE_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "CORE_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "CORE_DIST"
		runtime "Release"
		optimize "on"

project "ExePrj"
	location "ExePrj"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{	
		"libProject/src"
	}

	links
	{
		"libProject"
	}

	filter "system:windows"
		systemversion "latest"
			
	filter "configurations:Debug"
		defines "CORE_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "CORE_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "CORE_DIST"
		runtime "Release"
		optimize "on"