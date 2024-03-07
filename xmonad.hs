import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeys)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.Loggers


main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- STATUS BAR STUFF
myBar = "xmobar"
myPP = xmobarPP 
    { ppCurrent = xmobarColor krorange "" . wrap "[" "]"
    , ppTitle = xmobarColor krgreen "" . shorten 40
    , ppSep = " > "
    }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- BASE CONFIG
--main = do
--  xmonad $ def
myConfig = def
    { terminal    = "urxvt"
    , modMask = mod4Mask
    -- , borderWidth = 0
    , borderWidth = 3
    , normalBorderColor  = grey
    , focusedBorderColor = krarchblue
    , layoutHook = avoidStruts $ layoutHook def
    --, logHook = dynamicLogWithPP $ def {
    --             ppExtras = [ aumixVolume
    --                        , battery
    --                        ]
    --            }
    } `additionalKeys` myKeys

-- KEY BINDINGS
myKeys =
    [
      ((mod4Mask .|. shiftMask, xK_f), spawn "firefox")
    , ((mod4Mask, xK_q), spawn "xmonad --recompile; pkill xmobar; xmonad --restart")
    , ((0, xF86XK_PowerDown),         spawn "sudo systemctl suspend")
    , ((0, xF86XK_AudioRaiseVolume),  spawn "pactl set-sink-volume $(get-current-sink) +5%")
    , ((0, xF86XK_AudioLowerVolume),  spawn "pactl set-sink-volume $(get-current-sink) -5%")
    , ((0, xF86XK_AudioMute),         spawn "pactl set-sink-mute $(get-current-sink) toggle")
    -- , ((0, xF86XK_AudioRaiseVolume),  spawn "amixer -D pulse sset Master 5%+")
    -- , ((0, xF86XK_AudioLowerVolume),  spawn "amixer -D pulse sset Master 5%-")
    -- , ((0, xF86XK_AudioMute),         spawn "amixer -D pulse sset Master toggle")
    , ((0, xF86XK_MonBrightnessUp),   spawn "brightnessctl set +5%")
    , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl set 5%-")
    , ((0, xK_Print), spawn "screenshot_hacksaw")
    , ((mod4Mask, xK_Print), spawn "flameshot gui")
    , ((mod4Mask .|. shiftMask, xK_l), spawn "xset s activate")
    --  ((mod1Mask, xK_b), spawn "ibus engine next")
    --, 
    ]

-- COLORS
grey = "#AAAAAA"
krorange = "#FF9900"
krgreen = "#00B800"
krarchblue = "#1793D1"
