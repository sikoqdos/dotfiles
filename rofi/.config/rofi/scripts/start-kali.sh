#!/bin/bash

qemu-system-x86_64 \
  -enable-kvm \
  -m 8192 \
  -smp 4 \
  -cpu host \
  -drive file=/var/lib/libvirt/images/Kali.qcow2,format=qcow2 \
  -device qxl-vga,vgamem_mb=64,ram_size=131072,vram_size=131072 \
  -spice port=5930,disable-ticketing=on \
  -vga none \
  -display none \
  -device virtio-serial \
  -chardev spicevmc,id=spicechannel0,name=vdagent \
  -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 &

for i in {1..50}; do
	nc -z 127.0.0.1 5930 && break
	sleep 0.1
done

remote-viewer spice://127.0.0.1:5930

