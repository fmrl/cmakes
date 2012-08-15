# $legal:1599:
# 
# Copyright (c) 2011-2012, Michael Lowell Roberts.  
# All rights reserved. 
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are 
# met: 
# 
#   - Redistributions of source code must retain the above copyright 
#   notice, this list of conditions and the following disclaimer. 
# 
#   - Redistributions in binary form must reproduce the above copyright 
#   notice, this list of conditions and the following disclaimer in the 
#   documentation and/or other materials provided with the distribution.
#  
#   - Neither the name of the copyright holder nor the names of 
#   contributors may be used to endorse or promote products derived 
#   from this software without specific prior written permission. 
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
# 
# ,$

include(cmakes/config.cmake)
include(cmakes/yaml-cpp.cmake)

find_library(
	NYAN_LIBRARY libnyan.a
	HINTS "${NYAN_PREFIX}"
	PATH_SUFFIXES lib)

if(NYAN_LIBRARY)
	if (NOT DEFINED NYAN_PREFIX)
		get_filename_component(NYAN_PREFIX 
			"${NYAN_LIBRARY}" PATH)
		# on platforms where multi-configuration builds are supported,
		# the libraries are placed in the appropriate sub-directory of
		# the 'lib" directory.
		# [todo] i don't know if this is actually the case for 
		# libyaml-cpp though.
		# [todo] i want to cannonize this test into a function.
		if("${CMAKE_CONFIGURATION_TYPES}")
			get_filename_component(NYAN_PREFIX 
				"${NYAN_PREFIX}/../.." ABSOLUTE)
		else()
			get_filename_component(NYAN_PREFIX 
				"${NYAN_PREFIX}/.." ABSOLUTE)
		endif()
	endif()

	# [mlr][todo] boost should be included in this.
	set(NYAN_INCLUDE "${NYAN_PREFIX}/include" ${YAMLCPP_INCLUDE})
	set(NYAN_LIBRARIES ${NYAN_LIBRARY} ${YAMLCPP_LIBRARIES})
	include_directories(${NYAN_INCLUDE})

	can_has(nyan)
else()
	message(WARNING 
		"i could not find libnyan on your system. please specify the correct path using the NYAN_PREFIX variable.")
endif()

# $vim:23: vim:set sts=3 sw=3 et:,$






