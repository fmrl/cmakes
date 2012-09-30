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

# [mlr] this is adapted from code found on the CMake users list
# see <http://www.cmake.org/pipermail/cmake/2006-October/011446.html>.
# [mlr][todo] i need to implement proper windows support. 

include(cmakes/config.cmake)

find_library(CPPUNIT_LIBRARY cppunit
   HINTS "${CPPUNIT_PREFIX}"
   PATH_SUFFIXES lib)

if(CPPUNIT_LIBRARY)
   message("cppunit.cmake: i found cppunit at ${CPPUNIT_LIBRARY}.")
   if (NOT DEFINED CPPUNIT_PREFIX)
      get_filename_component(CPPUNIT_PREFIX 
         "${CPPUNIT_LIBRARY}" PATH)
      # on platforms where multi-configuration builds are supported,
      # the libraries are placed in the appropriate sub-directory of
      # the 'lib" directory.
      # [todo] i don't know if this is actually the case for 
      # libyaml-cpp though.
      # [todo] i want to cannonize this test into a function.
      if("${CMAKE_CONFIGURATION_TYPES}")
         get_filename_component(CPPUNIT_PREFIX 
            "${CPPUNIT_PREFIX}/../.." ABSOLUTE)
      else()
         get_filename_component(CPPUNIT_PREFIX 
            "${CPPUNIT_PREFIX}/.." ABSOLUTE)
      endif()
   endif()

   find_path(CPPUNIT_INCLUDE
      cppunit/TestCase.h
      HINTS "${CPPUNIT_PREFIX}"
      PATH_SUFFIXES include)

   if(CPPUNIT_INCLUDE)
      message("cppunit.cmake: i found cppunit/TestCase.h at ${CPPUNIT_INCLUDE}.")
      include_directories(${CPPUNIT_INCLUDE})
      set(CPPUNIT_LIBRARIES ${CPPUNIT_LIBRARY})

      can_has(cppunit)
      set(CPPUNIT_FOUND YES)
      message(STATUS "cppunit.cmake: cppunit configured.")
   endif()

endif()

if(NOT CPPUNIT_FOUND)
   message(WARNING 
      "cppunit.cmake: i could not find cppunit on your system. please specify the correct path using the CPPUNIT_PREFIX variable.")
endif()

# $vim:23: vim:set sts=3 sw=3 et:,$






