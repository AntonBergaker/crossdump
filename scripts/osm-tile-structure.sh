#!/bin/bash
#
# Updates GMapCatcher tiles directory structure to work as an offline map tile
# directory with QtLocation using the OpenStreetMap plugin.
#
# Note: You shouldn't have to call this script directly.

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <GMapCatcher tiles dir> <output dir>"
  exit 1
fi
in="$1"
out="$2"

rm -rf "$out"
mkdir "$out"

# Go through the GMapCatcher directory structure and map all tiles
# to a single directory used by the OpenStreetMap plugin.
for zoom in "$in"/*; do
  for x in "$zoom"/*/*; do
    for y in "$x"/*/*; do
      # Each tile is a leaf in the directory strucure and is named with their
      # respective y tile indices.
      tile="$y"

      # Convert from GMapCatcher to OpenStreetMap zoom level.
      osm_zoom=$((17 - "$(basename "$zoom")"))

      # 1 = Street map type
      map_id=1

      # Tile file name based on:
      # https://www.qt.io/blog/2017/05/24/qtlocation-using-offline-map-tiles-openstreetmap-plugin
      new_tile="osm_100-l-${map_id}-${osm_zoom}-$(basename "$x")-$(basename "$y" .png).png"

      mv "$tile" "$out/$new_tile"
    done
  done
done
