# This file is part of the *fmrl.cmake* project at <http://fmrl.org>.
# Copyright (c) 2011, Michael Lowell Roberts.
# All rights reserved. 
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are 
# met: 
#
#  * Redistributions of source code must retain the above copyright 
#  notice, this list of conditions and the following disclaimer. 
#
#  * Redistributions in binary form must reproduce the above copyright 
#  notice, this list of conditions and the following disclaimer in the 
#  documentation and/or other materials provided with the distribution.
# 
#  * Neither the name of the copyright holder nor the names of 
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

include(cmake/debug.cmake)

if(NOT DEFINED generate_config_header)

function(generate_config_header NAMESPACE)

	string(TOUPPER ${NAMESPACE} CAN_HAS_NAMESPACE)

	# CAN_HAS contains information about which feature macros
	# we can generate.
	foreach(I ${CAN_HAS})
		string(TOUPPER ${I} S) 
		set(S ${CAN_HAS_NAMESPACE}_CAN_HAS_${S})
		set(${S} YES)
		debug_message("#define ${S} 1")
	endforeach()

	# to namespace header file substitutions, i use a two-pass
	# subtitution method i encountered on the CMake mailing list.
	# see <http://public.kitware.com/pipermail/cmake/2006-March/008685.html>.
	set(CMAKEDEFINE "#cmakedefine01")
	set(TMPFILE "${CMAKE_CURRENT_BINARY_DIR}/tmp.fmrl.config/${NAMESPACE}/config.h.in")
	configure_file(cmake/config.h.in ${TMPFILE} @ONLY)
	configure_file(${TMPFILE} ${CMAKE_CURRENT_BINARY_DIR}/include/${NAMESPACE}/config.h)

endfunction()

function(can_has FEATURE)
	list(APPEND CAN_HAS ${FEATURE})
	set(CAN_HAS ${CAN_HAS} PARENT_SCOPE)
endfunction()

endif()








