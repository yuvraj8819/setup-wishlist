#!/bin/sh
# Wraps the page source (setup-wishlist.html) into index.html with the web app head tags.
# Usage: ./build.sh path/to/setup-wishlist.html
set -e
SRC="$1"
{
printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
printf '<link rel="manifest" href="manifest.webmanifest">\n<link rel="icon" href="icons/icon.svg" type="image/svg+xml">\n<link rel="apple-touch-icon" href="icons/apple-touch-icon.png">\n'
printf '<meta name="theme-color" content="#11131a">\n<meta name="mobile-web-app-capable" content="yes">\n<meta name="apple-mobile-web-app-capable" content="yes">\n<meta name="apple-mobile-web-app-title" content="Wishlist">\n<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">\n'
printf '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
sed -n '1,/^<\/style>$/p' "$SRC"
printf '</head>\n<body>\n'
sed -n '/^<\/style>$/,$p' "$SRC" | tail -n +2
printf '<script>if("serviceWorker" in navigator){navigator.serviceWorker.register("sw.js").catch(()=>{})}</script>\n'
printf '</body>\n</html>\n'
} > index.html
