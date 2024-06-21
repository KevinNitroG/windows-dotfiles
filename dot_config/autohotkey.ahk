#SingleInstance Force

SetTitleMatchMode 3
DetectHiddenWindows true

; #Warn All, Off

; # Left Win
; ^ Ctrl
; ! Alt
; + Shift

#Include "komorebi/komorebic.lib.ahk"

; --- CONFIG ---

#Backspace::{
  try ControlSend "!{F4}",, "ahk_class Progman"
  try ControlFocus "Shut Down Windows"
}
^#!r::Reload

; --- RUN APP VIA KEYBOARD SHORTCUT ---

#Enter::Run "wt.exe"
#t::Run "alacritty.exe"
#c::Run "code.exe"
#b::Run "chrome.exe" 
#s::Run "C:\Users\kevinnitro\AppData\Roaming\Spotify\Spotify.exe" 

; --- ALT TO SWITCH TAB IN BROWSER ---

GroupAdd "Browser", "ahk_exe arc.exe"
GroupAdd "Browser", "ahk_exe brave.exe"
GroupAdd "Browser", "ahk_exe chrome.exe"
GroupAdd "Browser", "ahk_exe chromium.exe"
GroupAdd "Browser", "ahk_exe edge.exe"
GroupAdd "Browser", "ahk_exe firefox.exe"
GroupAdd "Browser", "ahk_exe thorium.exe"

#HotIf WinActive("ahk_group Browser")

!1::^1
!2::^2
!3::^3
!4::^4
!5::^5
!6::^6
!7::^7
!8::^8
!9::^9

#HotIf

; --- UNIKEY ---

; #space::!z

; Cannot use bellow :v, UniKeyNT doesn't read the key
; #space::try ControlSend "!z",, "ahk_exe UniKeyNT.exe"

; --- KOMOREBI ---

#^o::ReloadConfiguration()
#^+r:: {
  try RunWait("komorebic.exe stop", , "Hide")
  RunWait("komorebic.exe start", , "Hide")
}

#1::FocusWorkspace(0)
#2::FocusWorkspace(1)
#3::FocusWorkspace(2)
#4::FocusWorkspace(3)
#5::FocusWorkspace(4)
#6::FocusWorkspace(5)
#7::FocusWorkspace(6)
#8::FocusWorkspace(7)
#9::FocusWorkspace(8)
#0::FocusWorkspace(9)

#[::CycleWorkspace("previous")
#]::CycleWorkspace("next")

#+1::MoveToWorkspace(0)
#+2::MoveToWorkspace(1)
#+3::MoveToWorkspace(2)
#+4::MoveToWorkspace(3)
#+5::MoveToWorkspace(4)
#+6::MoveToWorkspace(5)
#+7::MoveToWorkspace(6)
#+8::MoveToWorkspace(7)
#+9::MoveToWorkspace(8)
#+0::MoveToWorkspace(9)

#+[::CycleMoveToWorkspace("previous")
#+]::CycleMoveToWorkspace("next")

#Left::Focus("left")
#Down::Focus("down")
#Up::Focus("up")
#Right::Focus("right")
^#+[::CycleFocus("previous")
^#+]::CycleFocus("next")

^#+Left::Move("left")
^#+Down::Move("down")
^#+Up::Move("up")
^#+Right::Move("right")
^#p::Promote()

#+Right::ResizeAxis("horizontal", "increase")
#+Left::ResizeAxis("horizontal", "decrease")
#+Up::ResizeAxis("vertical", "increase")
#+Down::ResizeAxis("vertical", "decrease")

#w::ToggleFloat()
#m::Minimize()
#q::Close()
^#t::ToggleTiling() ; avoid with opening terminal
#z::ToggleMonocle()
; !Enter::F11 ; Toggle fullscreen
^#r::Retile()
^#+p::TogglePause()

^#h::Stack("left")
^#l::Stack("right")
^#k::Stack("up")
^#j::Stack("down")
^#;::Unstack()

#x::FlipLayout("horizontal")
#y::FlipLayout("vertical")
