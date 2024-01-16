# Ultrasonic Screwdriver Case STL files

These STL files were created with [OpenScad](https://openscad.org/) from
the source code in
[openscad](https://github.com/cytan299/Ultrasonic_Screwdriver/tree/main/openscad). These
files are loaded into a slicer program like the [Ultimaker
CURA](https://ultimaker.com/software/ultimaker-cura/) for 3D printing.

## Infill

It is interesting that the best setting that I have found for the infill is
zigzag and not cubic. I wanted a strong shell and so I had to set the
fill fraction to be 50%. You should check that zigzag and 50% fill
works for you by examining the generated cross sections in your slicer
program.

## Upgrade to v2

In v1, the Ultrasonic Screwdriver is charged by unscrewing its base to
reveal a charging plug. The plug is then attached to the Charging
Stand's socket for charging.

In the upgraded version 2, the Ultrasonic Screwdriver can be charged
by inserting it into the Charging Stand. This upgrade will require the
following new STL files:

* **slip_adapter_v2.stl** The slip adapter that has space for the spring
  connector and the alignment recesses.
* **slip_cap_v2.stl** The slip cap that covers the bottom of the _slip
adapter v2_.

## Copyright

All the software that I have written is copyright 2023 C.Y. Tan.

All software is released under GPLv3.







 
