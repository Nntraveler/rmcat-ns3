# rmcat-ns3
A comparison of rmcat protocol, namely NADA, GCC and SCReAM on ns3 platform. The version of ns is 3.26.   
The paper link https://arxiv.org/pdf/1809.00304.pdf   
The simulation code of NADA can get from https://github.com/cisco/ns3-rmcat  
In consideration that the author of NADA made an update to their code, I upload the code I used during writting of this paper. And I did test the performance of the newer code inplementation, but it seems the new version had introduce some bugs that the sender can get quite low throughput compared to the link capacity.  
For, I just release the SCReAM code modified from https://github.com/EricssonResearch/scream  

the code in screamex.cc sendApp->SetTraceFilePath("/you_path/trace_key.txt"),is no use in experiment, but it should be configured in right path. trace_key.txt is from https://github.com/EricssonResearch/scream/tree/master/traces  

the mytrace module is used for data collecion. And a file named "trace" should be created first under the  path of ns-allinone-3.26/ns-3.26/  

the razor project is a c version of GCC release at https://github.com/yuanrongxi/razor. And I make some minor modification to get it running on ns3. Thanks to the author's contributions.  
To run GCC congestion control algorithm, it depends on external library from webrtc and these files(home-zsy-webrtc-ns3/webrtc) should be put on the right path. Then configure the environemnt variables, for example:  
```
sudo su  
gedit /etc/profile  
```
add the following to /etc/profile, the path to  "home-zsy-webrtc-ns3/webrtc" in my comouter is "/home/zsy/webrtc-ns3/webrtc".  
Change them all with where you put these files.  
```
export LD_LIBRARY_PATH=/home/zsy/webrtc-ns3/webrtc/system_wrappers:/home/zsy/webrtc-ns3/webrtc/rtc_base:/home/zsy/webrtc-ns3/webrtc/api:/home/zsy/webrtc-ns3/webrtc/logging:/home/zsy/webrtc-ns3/webrtc/modules/utility:/home/zsy/webrtc-ns3/webrtc/modules/pacing:/home/zsy/webrtc-ns3/webrtc/modules/congestion_controller:/home/zsy/webrtc-ns3/webrtc/modules/bitrate_controller:/home/zsy/webrtc-ns3/webrtc/modules/remote_bitrate_estimator:/home/zsy/webrtc-ns3/webrtc/modules/rtp_rtcp:$LD_LIBRARY_PATH  
export CPLUS_INCLUDE_PATH=CPLUS_INCLUDE_PATH:/home/zsy/webrtc-ns3/webrtc/:/home/zsy/webrtc-ns3/webrtc/system_wrappers:/home/zsy/webrtc-ns3/webrtc/rtc_base:/home/zsy/webrtc-ns3/webrtc/api:/home/zsy/webrtc-ns3/webrtc/logging:/home/zsy/webrtc-ns3/webrtc/modules/utility:/home/zsy/webrtc-ns3/webrtc/modules/pacing:/home/zsy/webrtc-ns3/webrtc/modules/congestion_controller:/home/zsy/webrtc-ns3/webrtc/modules/bitrate_controller:/home/zsy/webrtc-ns3/webrtc/modules/remote_bitrate_estimator:/home/zsy/webrtc-ns3/webrtc/modules/rtp_rtcp  
```
and the path about the headers and so libs in wscript(under webrtc-ns3) should also be changed accordingly:  
```
  conf.env.append_value('INCLUDES', ['/home/zsy/webrtc-ns3/webrtc/'])
  conf.env.append_value("LINKFLAGS", ['-L/home/zsy/webrtc-ns3/webrtc/system_wrappers','-L/home/zsy/webrtc-ns3/webrtc/rtc_base','-L/home/zsy/webrtc-ns3/webrtc/api','-L/home/zsy/webrtc-ns3/webrtc/logging','-L/home/zsy/webrtc-ns3/webrtc/modules/utility','-L/home/zsy/webrtc-ns3/webrtc/modules/pacing','-L/home/zsy/webrtc-ns3/webrtc/modules/congestion_controller','-L/home/zsy/webrtc-ns3/webrtc/modules/bitrate_controller','-L/home/zsy/webrtc-ns3/webrtc/modules/remote_bitrate_estimator','-L/home/zsy/webrtc-ns3/webrtc/modules/rtp_rtcp'])
```
And the webrtc-ns3 module depends on multipathvideo, and multipathvideo should be put under src in ns3.  
Location:  
![image](https://github.com/sonyangchang/rmcat-ns3/blob/master/webrtc-results/location.png)  

In simulation(razor-example/gcc_tcp.cc), a point to point channel was created. From the time of 20s to 100s, A reno TCP connection flows into the network. The first picture shows the kalman-gcc cannot complete fair bandiwdth share with tcp flow.  

![image](https://github.com/sonyangchang/rmcat-ns3/blob/master/razor-example/gcc_razor_0remb.png)  
![image](https://github.com/sonyangchang/rmcat-ns3/blob/master/razor-example/gcc_razor_1remb.png)  
If you quite interesting in this simualation, and think the above instrcution is quite complex, you could email me for the VM during the experiment.  
some simualtion example of GCC algorithms:  
bandwidth fainress property:  
![image](https://github.com/sonyangchang/rmcat-ns3/blob/master/webrtc-results/webrtc_4_bw.png)  
owe way transmission delay:  
![image](https://github.com/sonyangchang/rmcat-ns3/blob/master/webrtc-results/webrtc_4_delay.png)  
In some test case, gcc flows may not converge to the fairness line, case 1.  
bandwidth fainress property:  
![image](https://github.com/sonyangchang/rmcat-ns3/blob/master/webrtc-results/webrtc_1_bw.png)  
owe way transmission delay:  
![image](https://github.com/sonyangchang/rmcat-ns3/blob/master/webrtc-results/webrtc_1_delay.png)  

The command to get webrtc-tcp running:  
```
sudo su  
source /etc/profile  
./waf --run "scratch/webrtc-tcp --it=1"  
```
