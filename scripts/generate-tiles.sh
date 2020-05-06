#!/bin/bash
#
# Generates OpenStreetMap map tiles to a new directory ./offline_tiles
# Requires internet connection.
#
# Dependencies:
# GTK2 for Python, can be installed with `sudo apt install python-gtk2`

# The type variable determines the directory structure for the output map tiles.
# The mapbox type only works with the MapBox map plugin, not MapBoxGL.
# For MapBoxGL, use bin/mbgl-offline found in https://github.com/mapbox/mapbox-gl-native
type="mapbox"
#type="osm"

DIR=$(dirname $(realpath $0))

# OpenStreetMap zoom levels
min_zoom=0
max_zoom=17

# Map from OpenStreetMap to GMapCatcher zoom levels.
min_zoom_gmapcatcher=$((17 - $max_zoom))
max_zoom_gmapcatcher=$((17 - $min_zoom))

$DIR/../dependencies/gmapcatcher/download.py \
  --location=Uppsala, Sweden \
  --min-zoom=$min_zoom_gmapcatcher \
  --max-zoom=$max_zoom_gmapcatcher \
  --latrange=0.015 \
  --lngrange=0.015

# The generated tiles are cached in the users home directory.
rm -rf tiles
mv ~/.GMapCatcher/tiles .

# Finally update the directory structure to work with the QtLocation map plugin.
echo 'Updating directory structure for map plugin'
rm -rf offline_tiles
$DIR/update-tile-structure.sh tiles offline_tiles "$type"
rm -rf tiles

echo "Generated map tiles to ./offline_tiles"
