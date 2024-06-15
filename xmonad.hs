-- xmonad config 
-- In haskell '--' Means comment

---------------------------------------------------imports--------------------------------------------------
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.MultiColumns
import XMonad.Util.Run
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CopyWindow(copy)
import qualified XMonad.Actions.DynamicWorkspaces as DW
import System.IO (hPutStrLn)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.SpawnOn
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.StatusBar.WorkspaceScreen
import Control.Monad (liftM2)
import XMonad.Util.ClickableWorkspaces
import XMonad.Actions.Minimize
import XMonad.Layout.Minimize
import qualified XMonad.Layout.BoringWindows as BW
---------------------------------------------------imports--------------------------------------------------


---------------------------------------------------setup up stuff--------------------------------------------------
myTerminal = "alacritty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 2
myModMask       = mod4Mask 

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#282c34" 
myFocusedBorderColor = "#46d9ff"
---------------------------------------------------steup up stuff--------------------------------------------------

---------------------------------------------------------------------------------------------worskapces-----------------------------------------------------------------
windowCount :: X (Maybe String) -- get the number of window open in a workspace
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset -- get total number of workspaces
myWorkspaces = ["main ", " www ", " shells ", " docs ", " kvm's ", " sessions ", " music ", " videos ", " emacs "] ++ map snd myExtraWorkspaces -- qmain workspaces
myExtraWorkspaces = [(xK_0, " pdf "), (xK_minus, " hacking "), (xK_equal, " aws "), (xK_q, " azure "), (xK_a, " extra1 ")] -- extra workspaces
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..] -- (,) == \x y -> (x,y)
---------------------------------------------------------------------------------------------------worskapces------------------------------------------------------------
-- Make xmobar workspaces clickable
--myWorkspaces = clickable . (map xmobarEscape) $ map show [1..9]







------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.

myKeys1 = 
        [ ("M-<Return>", spawn myTerminal) -- launch a terminal
        , ("M-<Print>", spawn "flameshot gui") --screenshot
        , ("M-<Space>",  sendMessage NextLayout) -- Rotate through the available layout algorithms
        , ("M-<Tab>", windows W.focusDown) -- Move focus to the next window
        , ("M-<F1>", DW.removeWorkspace) --delect a workspace
        , ("M-<F2>", DW.selectWorkspace def ) --add new workspace and goto it or goto it
        , ("M-<F3>", DW.withWorkspace def (windows . copy)) --cpoys a workspace not the window opne on it
        , ("M-<F4>", DW.withWorkspace def (windows . W.shift)) --moves the asact windo to a workspace



        , ("M-,", prevScreen)  -- Switch focus to prev monitor
        , ("M-.", nextScreen)  -- Switch focus to next monitor 


        , ("M-c", kill) -- close focused window
        , ("M-f", spawn "firefox") -- launch Firefox
        , ("M-h", sendMessage Shrink)  -- Shrink the master area
        , ("M-j", sendMessage Expand)  -- Expand the master area
        , ("M-k", windows W.focusUp) -- Move focus to the previous window
        , ("M-l", windows W.focusDown) -- Move focus to the next window
        , ("M-m", windows W.focusMaster) -- Move focus to the master window
        , ("M-n", refresh) -- Resize viewed windows to the correct size
        , ("M-p", spawn "dmenu_run") -- launch dmenu
        , ("M-t", withFocused $ windows . W.sink) -- Push window back into tiling
        , ("M-S-m", withLastMinimized maximizeWindow )--maximize focused window
        , ("M-C-m", withFocused minimizeWindow) --minimize focused window

--        , ("M-S-a", spawn "feh --bg-scale ~/Pictures/Wallpapers/Trisquel_GNU+Linux_10.0_Etiona_spanish.png && killall xmobarbk") -- sets fake wallpaper        
        , ("M-S-c", spawn "feh --randomize --bg-scale ~/Pictures/Wallpapers/*") -- Change wallpaperr
        , ("M-S-d", spawn "avogadro2") -- spawns chemistory digraming software
        , ("M-S-e", spawn "emacs") --spawn emacs the best editor
        , ("M-S-g", spawn "gimp") --starts gimp
        , ("M-S-j", windows W.swapDown) -- Swap the focused window with the next window
        , ("M-S-k", windows W.swapUp)  -- Swap the focused window with the previous window
        , ("M-S-o", spawn "obs") -- Spawn obs studio
        , ("M-S-p", spawn "thunar") -- lacunch pcmanfm (file manager)
        , ("M-S-q", io exitSuccess) -- Quit xmonad
        , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")  -- Restart xmoand && Recompiles xmonad
        , ("M-S-t", spawn "thunderbird")
        , ("M-S-v", spawn "virt-manager") -- starts virt-manager


        , ("M-S-<F7>", spawn "digikam") -- Spawn shotwell wallpaper mangaer
        


        , ("M-C-a", killAll) -- kill all windows on current workspace
--        , ("M-C-b", spawn "~/Projects/scripts/dmenu/brightness_controle/brightness.sh")
        , ("M-C-c", spawn "qalculate-gtk")       
        , ("M-C-e", spawn "okular") --spawns okular pdf viewer
        , ("M-C-r", spawn "cd ~/Projects/scripts/dmenu/run_scripts/ && bash run_scripts_from_dmenu.sh")
        , ("M-C-v", spawn "vlc") -- opens vlc
        , ("M-C-x", spawn "system-config-printer")


        , ("M-C-<F9>", spawn "pavucontrol")


--      , ("M-<F6>", renameWorkspace def)
--      , ("M-S-<Space>", setLayout $ XMonad.layoutHook conf)
        ]

-----------------------------------------------------------------------------
-- old key binding method

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
   -- Increment the number of windows in the master area
    [((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    --, ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++ 
    [((myModMask, key), windows $ W.greedyView ws) 
        | (key,ws) <- myExtraWorkspaces]
 
    ++ 
    [((myModMask .|. shiftMask, key), windows $ W.shift ws)
        | (key,ws) <- myExtraWorkspaces]

    ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList 

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                                      >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                                      >> windows W.shiftMaster)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------


------------------------------------------------------------------------
-- Layouts:
myLayout = avoidStruts $ smartBorders (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     -- tiled   = Tall nmaster delta ratio
     tiled = spacing 11 $ Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

--------------------------------------------------------------------------


--------------------------------------------------------------------------
-- manages all the programas and where to send them and what to do with them
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "vlc"            --> hasBorder False
    , className =? "explorer.exe"   --> doFullFloat
    , className =? "explorer.exe"   --> hasBorder False
    , className =? "conky"         --> hasBorder False
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "explorer.exe"   --> doShift ( myWorkspaces !! 0 )
    , className =? "vlc"            --> doShift ( myWorkspaces !! 7 )
--    , className =? "okular"         --> doShift ( myWorkspaces !! 9 )
    , className =? "Virt-manager"   --> doShift ( myWorkspaces !! 4 )
    , className =? "Emacs"          --> doShift ( myWorkspaces !! 8 )
    , className =? "obs"            --> doShift ( myWorkspaces !! 2 )
    , className =? "XTerm"          --> doShift ( myWorkspaces !! 5 )
--    , className =? "Virt-manager" --> viewShift "doc"
    ]
  where doShift = doF . liftM2 (.) W.greedyView W.shift
------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
            spawnOnce "~/Projects/scripts/dmenu/wallpaper_setter/feh.sh &"
            spawnOnce "picom &"
            spawnOnce "ibus-daemon -d &"
            spawnOnce "dunst &"
            spawnOnce "mpv -no-video ~/Music/bootsound/boot-sound.wav &"
--            spawnOnce "sleep 2s; killall lxappearance &"
--            spawnOnce "rclone mount --daemon gdrive3: /home/shaun/online_drives/google/gdrive3/ &"
--            spawnOnce "rclone mount --daemon gdrive1: /home/shaun/online_drives/google/gdrive1/ &"
--            spawnOnce "rclone mount --daemon gdrive2: /home/shaun/online_drives/google/gdrive2/ &"
-------------------------------------------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

main = do

--------------------------------------- xmobar------------------------------------------
--    xmpeoc0 <- spawnPipe "$HOME/.local/bin/xmobarbk -x 0 $HOME/.config/xmobar/xmobarrc1"
    xmpeoc0 <- spawnPipe "xmobar -x 0 /home/shaun/.config/xmobar/xmobarrc"
--  xmpeoc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/xmobarrc1"
--------------------------------------- xmobar-------------------------------------------

    xmonad $ ewmhFullscreen . ewmh $ docks defaults {logHook = clickablePP xmobarPP { ppOutput = hPutStrLn xmpeoc0  -- >> hPutStrLn xmpeoc1 x
                                                     , ppCurrent = xmobarColor "#944dff" "" .  wrap "[" "]"         -- Current workspace
                                                     , ppVisible = xmobarColor "#3399ff" ""   
                                                     , ppHidden = xmobarColor "#FF1493" "" .  wrap "*" ""
                                                     , ppHiddenNoWindows = xmobarColor "#00ff00"  ""            -- Workspaces with no windows open (empty workspaces)
                                                     , ppTitle = xmobarColor "#b3afc2" "" . shorten 60
                                                     , ppSep =  "<fc=#666666> | </fc>"                    -- |  |  | seprater between names 
                                                     , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace
                                                     , ppExtras  = [windowCount]                                     -- numbers of windows current workspace
                                                     , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
                                                     } >>= dynamicLogWithPP}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------						    


-----------------------------------------------------------------
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = minimize . BW.boringWindows $ myLayout,
        manageHook         = myManageHook,
--        handleEventHook    = fullscreenEventHook,
       -- logHook            = myLogHook,
        startupHook        = myStartupHook >> setWMName "xmonad on Arch Gnu/Linux"
    }`additionalKeysP` myKeys1
-----------------------------------------------------------------
