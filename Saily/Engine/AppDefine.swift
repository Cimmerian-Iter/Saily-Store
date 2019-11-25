//
//  AppDefine.swift
//  Saily
//
//  Created by Lakr Aream on 2019/7/18.
//  Copyright © 2019 Lakr Aream. All rights reserved.
//

let DATEBASE_MINCAP_VERSION: Int64 = 200110020001 // My birthday. REMEMBER IT

let TWEAK_DEFAULT_IMG_NAME = "xerusdesign"
let USE_SILEO_DEPICTION = true
let EXCLUDE_INSTALLED_LIST = [
    "gsc.3-gvenice", "gsc.64-bit", "gsc.720p", "gsc.a-w-d-l-capability", "gsc.accelerometer", "gsc.accessibility", "gsc.activation-protocol", "gsc.additional-text-tones", "gsc.aggregate-device-photo-zoom-factor", "gsc.aggregate-device-video-zoom-factor", "gsc.air-drop-capability", "gsc.airplay-mirroring", "gsc.all-features", "gsc.allow-you-tube-plugin", "gsc.allow32-bit-apps", "gsc.ambient-light-sensor", "gsc.any-telephony", "gsc.app-capacity-t-v-o-s", "gsc.app-store", "gsc.application-installation", "gsc.arkit", "gsc.arm64", "gsc.armv6", "gsc.armv7", "gsc.armv7s", "gsc.assistant", "gsc.audio-playback-capability", "gsc.auto-focus-camera", "gsc.backlight-capability", "gsc.baseband-class", "gsc.battery-current-capacity", "gsc.blue-light-reduction-supported", "gsc.bluetooth", "gsc.bluetooth-le", "gsc.board-id", "gsc.c-p-u-sub-type", "gsc.c-p-u-type", "gsc.camera-flash", "gsc.camera-front-flash", "gsc.camera-live-effects-capability", "gsc.camera-max-burst-length", "gsc.cellular-data", "gsc.cellular-telephony-capability", "gsc.chip-i-d", "gsc.cloud-photo-library-capability", "gsc.coastline-glow-rendering-capability", "gsc.compass-type", "gsc.contains-cellular-radio", "gsc.continuity-capability", "gsc.core-routine-capability", "gsc.device-class-number", "gsc.device-color", "gsc.device-cover-glass-color", "gsc.device-enclosure-color", "gsc.device-has-aggregate-camera", "gsc.device-housing-color", "gsc.device-launch-time-limit-scale", "gsc.device-prefers-building-strokes", "gsc.device-prefers-procedural-anti-aliasing", "gsc.device-prefers-traffic-alpha", "gsc.device-prefers3-d-building-strokes", "gsc.device-r-g-b-color", "gsc.device-scene-update-time-limit-scale", "gsc.device-supports-a-o-p", "gsc.device-supports-a-s-t-c", "gsc.device-supports-adaptive-maps-u-i", "gsc.device-supports-always-listening", "gsc.device-supports-always-on-compass", "gsc.device-supports-c-c-k", "gsc.device-supports-camera-haptics", "gsc.device-supports-car-integration", "gsc.device-supports-closed-loop-haptics", "gsc.device-supports-crude-prox", "gsc.device-supports-do-not-disturb-while-driving", "gsc.device-supports-enhanced-a-c3", "gsc.device-supports-haptics", "gsc.device-supports-hi-res-buildings", "gsc.device-supports-liquid-detection_-corrosion-mitigation", "gsc.device-supports-maps-blurred-u-i", "gsc.device-supports-navigation", "gsc.device-supports-periodic-a-l-s-updates", "gsc.device-supports-r-g-b10", "gsc.device-supports-si-d-p", "gsc.device-supports-simplistic-road-mesh", "gsc.device-supports-tethering", "gsc.device-supports-webkit", "gsc.device-supports-y-cb-cr10", "gsc.device-supports1080p", "gsc.device-supports3-d-imagery", "gsc.device-supports3-d-maps", "gsc.device-supports4k", "gsc.device-supports720p", "gsc.device-supports9-pin", "gsc.dictation", "gsc.display-mirroring", "gsc.displayport", "gsc.encode-aac", "gsc.encrypted-data-partition", "gsc.f-d-r-sealing-status", "gsc.f-m-f-allowed", "gsc.face-time-back-camera-temporal-noise-reduction-mode", "gsc.face-time-camera-supports-hardware-face-detection", "gsc.face-time-front-camera-temporal-noise-reduction-mode", "gsc.face-time-photos-opt-in", "gsc.fcc-logos-via-software", "gsc.first-party-launch-time-limit-scale", "gsc.forward-camera-capability", "gsc.front-facing-camera", "gsc.front-facing-camera-auto-h-d-r-capability", "gsc.front-facing-camera-burst-capability", "gsc.front-facing-camera-h-d-r-capability", "gsc.front-facing-camera-h-d-r-on-capability", "gsc.front-facing-camera-max-video-zoom-factor", "gsc.front-facing-camera-still-duration-for-burst", "gsc.front-facing-camera-video-capture1080p-max-f-p-s", "gsc.front-facing-camera-video-capture720p-max-f-p-s", "gsc.full-6", "gsc.gamekit", "gsc.gas-gauge-battery", "gsc.gps", "gsc.green-tea", "gsc.gyroscope", "gsc.h-e-v-c-decoder10bit-supported", "gsc.h-e-v-c-decoder8bit-supported", "gsc.h-e-v-c-encoding-capability", "gsc.h264-encoder-capability", "gsc.hardware-keyboard", "gsc.has-baseband", "gsc.has-extended-color-display", "gsc.has-mesa", "gsc.has-p-k-a", "gsc.has-s-e-p", "gsc.has-spring-board", "gsc.has-thin-bezel", "gsc.hd-video-capture", "gsc.hdr-image-capture", "gsc.healthkit", "gsc.hearingaid-audio-equalization", "gsc.hearingaid-low-energy-audio", "gsc.hidpi", "gsc.highest-supported-video-mode", "gsc.home-button-type", "gsc.homescreen-wallpaper", "gsc.hw-encode-snapshots", "gsc.i-a-p2-capability", "gsc.i-d-a-m-capability", "gsc.image4-supported", "gsc.international-settings", "gsc.io-surface-backed-images", "gsc.is-large-format-phone", "gsc.is-pwr-opposed-vol", "gsc.is-u-i-build", "gsc.launch-time-limit-scale-supported", "gsc.load-thumbnails-while-scrolling", "gsc.location-reminders", "gsc.location-services", "gsc.magnetometer", "gsc.main-screen-class", "gsc.main-screen-height", "gsc.main-screen-pitch", "gsc.main-screen-scale", "gsc.main-screen-width", "gsc.max-h264-playback-level", "gsc.maximum-screen-scale", "gsc.metal", "gsc.microphone", "gsc.microphone-count", "gsc.mix-and-match-prevention", "gsc.mms", "gsc.multitasking", "gsc.music-store", "gsc.n-f-c-radio-calibration-data-present", "gsc.navajo-fusing-state", "gsc.nfc", "gsc.offline-dictation-capability", "gsc.open-g-l-e-s-version", "gsc.opengles-1", "gsc.opengles-2", "gsc.opengles-3", "gsc.panorama-camera-capability", "gsc.peer-peer", "gsc.personal-hotspot", "gsc.phosphorus-capability", "gsc.photo-adjustments", "gsc.photo-capability", "gsc.photo-sharing-capability", "gsc.photo-stream", "gsc.photos-post-effects-capability", "gsc.pipelined-still-image-processing-capability", "gsc.proximity-sensor", "gsc.ptp-large-files", "gsc.r-f-exposure-separation-distance", "gsc.rear-camera-capability", "gsc.rear-facing-camera", "gsc.rear-facing-camera-auto-h-d-r-capability", "gsc.rear-facing-camera-burst-capability", "gsc.rear-facing-camera-h-d-r-capability", "gsc.rear-facing-camera-h-d-r-on-capability", "gsc.rear-facing-camera-h-f-r-capability", "gsc.rear-facing-camera-h-f-r-video-capture1080p-max-f-p-s", "gsc.rear-facing-camera-h-f-r-video-capture720p-max-f-p-s", "gsc.rear-facing-camera-max-video-zoom-factor", "gsc.rear-facing-camera-still-duration-for-burst", "gsc.rear-facing-camera-video-capture-f-p-s", "gsc.rear-facing-camera-video-capture1080p-max-f-p-s", "gsc.rear-facing-camera-video-capture4k-max-f-p-s", "gsc.rear-facing-camera-video-capture720p-max-f-p-s", "gsc.rear-facing-camera60fps-video-capture-capability", "gsc.rear-facing-telephoto-camera-capability", "gsc.regional-behavior-china-brick", "gsc.regional-behavior-g-b18030", "gsc.regional-behavior-valid", "gsc.render-wide-gamut-images-at-display-time", "gsc.ringer-switch", "gsc.screen-recorder-capability", "gsc.secure-element", "gsc.shoebox", "gsc.signing-fuse", "gsc.siri-gesture", "gsc.siri-offline-capability", "gsc.sms", "gsc.sphere-capability", "gsc.stand-alone-contacts", "gsc.stark-capability", "gsc.still-camera", "gsc.supports-force-touch", "gsc.supports-iris-capture", "gsc.supports-low-power-mode", "gsc.supports-rotate-to-wake", "gsc.supports-s-o-s", "gsc.supports-s-s-h-b-button-type", "gsc.telephony", "gsc.touch-id", "gsc.tv-out-crossfade", "gsc.u-i-background-quality", "gsc.u-i-parallax-capability", "gsc.u-i-procedural-wallpaper-capability", "gsc.u-i-reachability", "gsc.unified-ipod", "gsc.venice", "gsc.vibrator-capability", "gsc.video-camera", "gsc.video-stills", "gsc.voice-control", "gsc.voip", "gsc.volume-buttons", "gsc.w-a-graphic-quality", "gsc.w-l-a-n-bkg-scan-cache", "gsc.wapi", "gsc.watch-companion", "gsc.wi-fi", "gsc.wifi", "gsc.wifi-chipset", "gsc.youtube-plugin", "cy+cpu.arm64", "cy+kernel.darwin", "cy+lib.corefoundation", "cy+model.iphone", "cy+os.ios", "gsc.battery-is-charging", "gsc.camera-h-d-r2-capability", "gsc.device-corner-radius", "gsc.device-requires-proximity-ameliorations", "gsc.device-supports-e-label", "gsc.device-supports-portrait-light-effect-filters", "gsc.device-supports-tap-to-wake", "gsc.device-supports-tone-mapping", "gsc.external-power-source-connected", "gsc.h-e-v-c-decoder12bit-supported", "gsc.hall-effect-sensor", "gsc.has-battery", "gsc.o-l-e-d-display", "gsc.pearl-i-d-capability", "gsc.si-k-a-capability", "gsc.supports-burnin-mitigation", "gsc.touch-delivery120-hz", "gsc.wireless-charging-capability", "gsc.device-color-map-policy", "gsc,device-enclosure-r-g-b-color", "gsc.device-supports-d-clr", "gsc.external-charge-capability"]
//
//let SAMPLE_PATCH_SCRIPT = """
//    #!/var/containers/Bundle/iosbinpack64/bin/bash
//
//    export LANG=C
//    export LC_CTYPE=C
//    export LC_ALL=C
//
//    find . -exec sed -i '' s/\/Library\//\/var\/LIB\//g {} +
//
//    for i in /var/LIB/MobileSubstrate/DynamicLibraries/*dylib
//    do
//    echo "Patching $i"
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/Library\//\/var\/LIB\//g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/System\/var\/LIB\//\/System\/Library\//g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/%@\/var\/LIB\//%@\/Library\//g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/mobile\/var\/LIB\//mobile\/Library\//g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/usr\/lib\/libsubstrate/\/var\/ulb\/libsubstrate/g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/usr\/lib\/libsubstitute/\/var\/ulb\/libsubstitute/g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/usr\/lib\/libprefs/\/var\/ulb\/libprefs/g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/ldid2 -S $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/inject $i 2> /dev/null
//    done
//
//    for i in /var/LIB/PreferenceBundles/*/*
//    do
//    echo "Patching $i"
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/Library\//\/var\/LIB\//g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/System\/var\/LIB\//\/System\/Library\//g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/%@\/var\/LIB\//%@\/Library\//g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/mobile\/var\/LIB\//mobile\/Library\//g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/usr\/lib\/libsubstrate/\/var\/ulb\/libsubstrate/g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/usr\/lib\/libsubstitute/\/var\/ulb\/libsubstitute/g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/sed -i "" 's/\/usr\/lib\/libprefs/\/var\/ulb\/libprefs/g' $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/ldid2 -S $i 2> /dev/null
//    /var/containers/Bundle/iosbinpack64/usr/bin/inject $i 2> /dev/null
//    done
//    """
