echo -e -n "\e[0;31mStopping Klipper Service. "
echo -e -n '\e[0;0m'

sudo systemctl stop klipper
sudo systemctl status klipper

################################################################################

git pull

################################################################################

# Flash main MCU - BTT Octopus
make clean KCONFIG_CONFIG=klipper-bigtreetech-octopus.config
make menuconfig KCONFIG_CONFIG=klipper-bigtreetech-octopus.config
make -j4 KCONFIG_CONFIG=klipper-bigtreetech-octopus.config

echo -e -n "\e[0;33mBTT Octopus MCU firmware built, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32f446xx_380033000A51373330333137-if00 KCONFIG_CONFIG=klipper-bigtreetech-octopus.config
make flash FLASH_DEVICE=/dev/serial/by-id/usb-CanBoot_stm32f446xx_380033000A51373330333137-if00 KCONFIG_CONFIG=klipper-bigtreetech-octopus.config
echo -e -n "\e[0;33mBTT Octopus MCU firmware flashed, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

################################################################################

# Flash secondary MCU - Fystec PITB
make clean KCONFIG_CONFIG=klipper-fystec-pitb.config
make menuconfig KCONFIG_CONFIG=klipper-fystec-pitb.config
make -j 4 KCONFIG_CONFIG=klipper-fystec-pitb.config

echo -e -n "\e[0;33mFYSTEC PITB MCU firmware built, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

python3 ~/klipper/lib/canboot/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 0a754ef78da4

echo -e -n "\e[0;33mFYSTEC PITB MCU firmware flashed, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

################################################################################

# Flash tertiary MCU - Mellow SB2040
#make clean KCONFIG_CONFIG=klipper-mellow-fly-SB2040.config
#make menuconfig KCONFIG_CONFIG=klipper-mellow-fly-SB2040.config
#make -j 4 KCONFIG_CONFIG=klipper-mellow-fly-SB2040.config

#echo -e -n "\e[0;33mMellow FLY SB2040 MCU firmware built, please check above for any errors. "
#echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
#echo -e -n '\e[0;0m'
#read

#python3 ~/klipper/lib/canboot/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 62aff65e7dcf

#echo -e -n "\e[0;33mMellow FLY SB2040 MCU firmware flashed, please check above for any errors. "
#echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
#echo -e -n '\e[0;0m'
#read

################################################################################

# Flash Host MCU - Raspberry Pi
make clean KCONFIG_CONFIG=klipper-raspberry-pi.config
make menuconfig KCONFIG_CONFIG=klipper-raspberry-pi.config
make -j 4 KCONFIG_CONFIG=klipper-raspberry-pi.config

echo -e -n "\e[0;33mRaspberry Pi MCU firmware flashed, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

make flash KCONFIG_CONFIG=klipper-raspberry-pi.config

echo -e -n "\e[0;33mRaspberry Pi MCU firmware flashed, please check above for any errors. "
echo -e -n "\e[0;33mPress [Enter] to continue flashing, or [Ctrl+C] to abort"
echo -e -n '\e[0;0m'
read

################################################################################

echo -e -n "\e[0;32mStarting Klipper Service."
echo -e -n '\e[0;0m'
sudo systemctl start klipper
sudo systemctl status klipper

exit 0
