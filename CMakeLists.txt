cmake_minimum_required(VERSION 2.8.3)
project(adis_16480_driver)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  message_generation
  genmsg
  std_srvs
  roscpp_serialization
)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${PROJECT_SOURCE_DIR}/include
)


## System dependencies are found with CMake's conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Generate messages in the 'msg' folder
add_message_files(DIRECTORY msg FILES
   Acceleration.msg
   Velocity.msg
   YPR.msg
   Quaternion.msg
   LR_YPR.msg
   HR_YPR_lACC.msg
   HR_YPR_lVEL.msg

 )

## Generate services in the 'srv' folder
 add_service_files(DIRECTORY srv FILES
   switchDataOutMode.srv
   switchFrame.srv
   doSoftReset.srv
   doEKFReset.srv
   doTare.srv
   pause.srv
   setFilterCoeffs.srv
   startstopFilter.srv
   setDecRate.srv
 )


## Generate added messages and services with any dependencies listed here
 generate_messages(DEPENDENCIES
   std_msgs
   std_srvs
 )

catkin_package(CATKIN_DEPENDS 
  roscpp 
  std_msgs 
  std_srvs
  message_runtime 
)


set(adis_16480_driver_SRCS
  src/driver.cpp
  src/spi_ADIS_16480.cpp
  src/drivers_services.cpp
  src/ADIS_interrupt_read.cpp
  src/ADIS_write_to_registers.cpp
  src/HR_data_out.cpp
  src/data_out.cpp
  src/interrupt_detection.cpp
  src/reg_diag_sts.cpp
  src/reg_ekf_cnfg.cpp
  src/reg_glob_cmd.cpp
  src/reg_sys_e_flag.cpp
  src/wrapper_C_library_callback_to_Cpp.cpp
  src/fir_filter_bank.cpp
  )



###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)


## Declare a cpp executable
add_executable(adis_16480_driver_node ${adis_16480_driver_SRCS})

target_link_libraries(adis_16480_driver_node
  /usr/local/lib/libsoc.so
  ${roscpp_LIBRARIES}
  ${catkin_LIBRARIES} 
  )
## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
 add_dependencies(adis_16480_driver_node 
  adis_16480_driver_node_gencpp
  adis_16480_driver_generate_messages_cpp
)

## Specify libraries to link a library or executable target against
#find_library(LIBSOC_LIBRARY libsoc /usr/local/lib)

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS adis_16480_driver adis_16480_driver_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_adis_16480_driver.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
