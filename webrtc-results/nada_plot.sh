#! /bin/sh
instance=1
algo=nada
file1=${algo}1_rate.txt
file2=${algo}2_rate.txt
file3=${algo}3_rate.txt
output=${algo}_${instance}
gnuplot<<!
set xlabel "time/s" 
set ylabel "rate/kbps"
set xrange [0:300]
set yrange [0:4000]
set term "png"
set output "${output}_bw.png"
plot "${file1}" u 1:2 title "flow1" with lines lw 2,\
"${file2}" u 1:2 title "flow2" with lines lw 2,\
"${file3}" u 1:2 title "flow3" with lines lw 2
set output
exit
!
file1=${algo}1_delay.txt
file2=${algo}2_delay.txt
file3=${algo}3_delay.txt
gnuplot<<!
set xlabel "time/s" 
set ylabel "delay/ms"
set xrange [0:300]
set yrange [100:500]
set term "png"
set output "${output}_delay.png"
plot "${file1}" u 1:2 title "flow1" with lines lw 2,\
"${file2}" u 1:2 title "flow2" with lines lw 2,\
"${file3}" u 1:2 title "flow3" with lines lw 2
set output
exit
!


