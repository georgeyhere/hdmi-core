# hdmi-core
![HDMI IP](docs/top.png)

A basic HDMI IP core. Takes 8-bit RGB as inputs, outputs TMDS channels. Pixel clock is encoded as o_TMDS_P and o_TMDS_N [3]. Note that this core does require both pixel and serial clocks to be provided to it; it does not contain internal primitives to generate the fast serial clock needed for TMDS like the [digilent core](https://github.com/Digilent/vivado-library/tree/master/ip/rgb2dvi) does.

Tested on Zybo Z7-20, used in Bronco Pong class project. To use, just add the ip folder path to Vivado IP Repositories.


[![Demo](https://img.youtube.com/vi/_cfxz9SJ9kk/0.jpg)](https://www.youtube.com/watch?v=_cfxz9SJ9kk)
