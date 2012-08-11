# $legal:226:
# 
# Copyright (c) 2012, Michael Lowell Roberts.
# All rights reserved.
# 
# Redistribution or use in source or binary forms, with or without
# modification, is prohibited without the express permission of the
# author.
# 
# ,$ 

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

# $vim:23: vim:set sts=3 sw=3 et:,$ 

