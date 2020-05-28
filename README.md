# CrossDump

A task managing navigation app built with Qt.

## Install offline maps

Offline map tile databases for MapBoxGL are included in the repository under `offline-maps/`.
Install an offline database by copying the selected database file to the MapBoxGL cache found in the home directory.

The following command makes Uppsala available for offline use:

```
cp offline-maps/uppsala.db ~/.cache/QtLocation/5.8/tiles/mapboxgl/mapboxgl.db
```

### Included offline maps

- `offline-maps/uppsala_day_night_3d.db` - central Uppsala area (zoom level 0 to 16) with 3D buildings and day/night mode

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

## Profiling the application

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
