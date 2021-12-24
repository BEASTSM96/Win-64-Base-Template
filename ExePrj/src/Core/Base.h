/********************************************************************************************
*                                                                                           *
*                                                                                           *
*                                                                                           *
* MIT License                                                                               *
*                                                                                           *
* Copyright (c) 2021 BEAST                                                           		*
*                                                                                           *
* Permission is hereby granted, free of charge, to any person obtaining a copy              *
* of this software and associated documentation files (the "Software"), to deal             *
* in the Software without restriction, including without limitation the rights              *
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell                 *
* copies of the Software, and to permit persons to whom the Software is                     *
* furnished to do so, subject to the following conditions:                                  *
*                                                                                           *
* The above copyright notice and this permission notice shall be included in all            *
* copies or substantial portions of the Software.                                           *
*                                                                                           *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR                *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,                  *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE               *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER                    *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,             *
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE             *
* SOFTWARE.                                                                                 *
*********************************************************************************************
*/

#pragma once

#define BIND_FUNC( fn ) [ this ]( auto&&... args ) -> decltype( auto ) { return this->fn( std::forward<decltype( args )>( args )...); }

#define SINGLETON( x )                    \
public:                                   \
static x& Get() { static x _; return _; } \
x( const x& ) = delete;                   \
x( x&& ) = delete;                        \
x& operator=( x&& ) = delete;             \
x& operator=( const x& ) = delete

#define BIT( x ) (1 << x)

// Short macro for typing "#if defined( _WIN32 ) || defined( _WIN64 )"
#if defined( _WIN32 ) || defined( _WIN64 )
#define WINDOWS 1
#endif

namespace Debug {

	static void BreakDebug()
	{
	#if defined ( WINDOWS )
		__debugbreak();
	#else // linux etc.
		//#TODO
	#endif
	}

}