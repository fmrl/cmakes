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

function(set_cache_builtin TYPE NAME)
	set(GUARD ${PROJECT_NAME}_${NAME}_IS_CONFIGURED)
	if(NOT ${GUARD})
		set(${NAME} "${ARGN}" CACHE ${TYPE} "see CMakeFile.txt for more details." FORCE)
		set(${GUARD} YES CACHE INTERNAL 
			"a guard variable used by set_default_cache().")
	endif()
endfunction()

function(optional_cache_string NAME DESCRIPTION)
	# set up cache variable defaults for ramalloc compile-time options.
	set(${NAME} "DEFAULT" CACHE STRING "${DESCRIPTION}")
	if(NOT ${NAME} STREQUAL DEFAULT)
		set(${NAME}_SPECIFIED YES PARENT_SCOPE)
	endif()
endfunction()

# $vim:23: vim:set sts=3 sw=3 et:,$

