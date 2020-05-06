# CrossDump

A task managing navigation app built with Qt.

## Connect to display via Qt Creator

Go to Tools -> Options -> Devices -> Devices

Set "Host name" equal to the IP address of the display.

Test the connection with the "Test" button and finally click OK.

## Running on CCpilot VS

Select CCpilot VS as the compile target.

Add `-platform wayland` as "command line arguments". Optionally use `-platform eglfs` for drawing directly to the framebuffer. For the `eglfs` setting you also need to SSH into the display and run `/etc/init.d/weston stop`.

Under Run Environment:

- Set `QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS` to `/dev/input/touchscreen0`
- Set `XDG_RUNTIME_DIR` to `/run/user/root`

## License

Copyright © 2020 Anton Bergåker, Carl Enlund, Astrid Nord Olsson, Arvid Sandin

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
