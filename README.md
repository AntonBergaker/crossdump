# CrossDump

A task managing navigation app built with Qt.
The project has been developed mainly to run on [CrossControl's](https://crosscontrol.com/) display computers.

Techniques used in the project have been documented in [**DOCS.md**](DOCS.md).

## Offline maps

An offline map of Uppsala has been generated and is included in the repo under `offline-maps/`.
Below are instructions for installing the offline map on one of CrossControl's displays and in a virtual machine.

View [DOCS.md](DOCS.md) for further documentation on creating and using offline maps.

### Install offline maps on CrossControl displays

Copy the offline map to the display's cache directory via SSH:

~~~
scp offline-maps/uppsala.db ccs@192.168.0.163:~
ssh ccs@192.168.0.163
...
sudo su
mv uppsala.db /home/root/.cache/QtLocation/5.8/tiles/mapboxgl/mapboxgl.db
~~~

### Install offline maps on Linux

Copy the offline map to the local cache directory:

~~~
cp offline-maps/uppsala.db ~/.cache/QtLocation/5.8/tiles/mapboxgl/mapboxgl.db
~~~

## Connect to a CrossControl display via Qt Creator

Go to Tools -> Options -> Devices -> Devices

Set "Host name" equal to the IP address of the display.

Test the connection with the "Test" button and finally click OK.

## Running on CrossControl displays

Select compile target matching the display, for example CCpilot VS.

Add `-platform wayland` as "command line arguments".
Optionally use `-platform eglfs` for drawing directly to the framebuffer.
For the `eglfs` setting you also need to SSH into the display and run `/etc/init.d/weston stop`.

Under Run Environment:

- Set `QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS` to `/dev/input/touchscreen0`
- Set `XDG_RUNTIME_DIR` to `/run/user/root`

## Profiling the app

Enable an FPS counter by adding the following code to the bottom of `main.qml`, which will print information to the console:

```
import com.crossdump.fpscounter 1.0

FPSCounter {
    id: fpsCounter
    width: 100
    height: 100
}
Text {
    text: fpsCounter.fps
}
```

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
