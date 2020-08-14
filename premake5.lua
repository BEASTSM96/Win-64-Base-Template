workspace "Win64-Win32-Base"
	architecture "x86_64"
	startproject "ExePrj"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}
	
	flags
	{
		"MultiProcessorCompile"
	}
	
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

group "Base/Core"
project "libProject"
	location "libProject"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")


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
		"%{prj.name}/src",
		
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