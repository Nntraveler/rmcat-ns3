# c++11 required
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
include_directories(../../../)
include_directories(../../)
set(remote_bitrate_estimator_FILES
aimd_rate_control.cc
bwe_defines.cc
inter_arrival.cc
overuse_detector.cc
overuse_estimator.cc
remote_bitrate_estimator_abs_send_time.cc
remote_bitrate_estimator_single_stream.cc
remote_estimator_proxy.cc
send_time_history.cc
)
add_library(remote_bitrate_estimator SHARED ${remote_bitrate_estimator_FILES})
target_link_libraries(remote_bitrate_estimator rtp_rtcp_format system_wrappers rtc_base pacing)
