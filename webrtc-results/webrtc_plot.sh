#! /bin/sh
instance=4
algo=webrtc
file1=${instance}_${algo}_1_rate.txt
output=${algo}_${instance}
gnuplot<<!
set xlabel "time/s" 
set ylabel "rate/kbps"
set xrange [0:300]
set yrange [0:4000]
set term "png"
set output "${output}_bw.png"
plot "${file1}" u 1:2 title "flow1" with lines lw 2
set output
exit
!
file1=${instance}_${algo}_1_delay.txt
gnuplot<<!
set xlabel "time/s" 
set ylabel "delay/ms"
set xrange [0:300]
set yrange [100:500]
set term "png"
set output "${output}_delay.png"
plot "${file1}" u 1:2 title "flow1" with lines lw 2
set output
exit
!


