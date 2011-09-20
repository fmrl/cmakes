# This file is part of the *fmrl* project at <http://fmrl.org>.
# Copyright (c) 2011, Michael Lowell Roberts.
# All rights reserved. 
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are 
# met: 
#
#  - Redistributions of source code must retain the above copyright 
#  notice, this list of conditions and the following disclaimer. 
#
#  - Redistributions in binary form must reproduce the above copyright 
#  notice, this list of conditions and the following disclaimer in the 
#  documentation and/or other materials provided with the distribution.
# 
#  - Neither the name of the copyright holder nor the names of 
#  contributors may be used to endorse or promote products derived 
#  from this software without specific prior written permission. 
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED 
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER 
# OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 

# find_boost(...)
# ---------------
# *find_boost(...)* invokes *find_package(Boost ...)*. the boost package
# requires additional configuration that can be computed from exposed
# options ('WANT_STATIC_LIBS') and requires additional definitions on certain
# platforms.
#
# this function accepts all of the optional arguments that *find_package()* 
# recognizes.
#
macro(find_boost)
	set(Boost_USE_MULTITHREADED ${Threads_FOUND})
	set(Boost_USE_STATIC_LIBS ${WANT_STATIC_LIBS})
	find_package(Boost ${ARGN})
	if(WIN32)
		# i prefer to disable automatic linking on windows because
		# it's not portable and tends to be a pain.
		add_definitions(-DBOOST_ALL_NO_LIB)
	endif()
endmacro()
