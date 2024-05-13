#SingleInstance Force
#Warn All, Off

; # Left Win
; ^ Ctrl
; ! Alt
; + Shift

#Include komorebic.lib.ahk

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

^#h::Focus("left")
^#j::Focus("down")
^#k::Focus("up")
^#l::Focus("right")
^#+[::CycleFocus("previous")
^#+]::CycleFocus("next")

^#+h::Move("left")
^#+j::Move("down")
^#+k::Move("up")
^#+l::Move("right")
^#p::Promote()

#Enter::Run "wt.exe"
#t::Run "wt.exe"
#c::Run "code.exe"
#b::Run "chrome.exe" 
#s::Run "C:\Users\kevinnitro\AppData\Roaming\Spotify\Spotify.exe" 

#f::ToggleFloat()
^#m::Minimize()
#q::Close()
^#t::ToggleTiling() ; avoid with opening terminal
#z::ToggleMonocle()

^#r::Retile()
^#+p::TogglePause()

^#+Left::Stack("left")
^#+Right::Stack("right")
^#+Up::Stack("up")
^#+Down::Stack("down")
^#+;::Unstack()

^#Right::ResizeAxis("horizontal", "increase")
^#Left::ResizeAxis("horizontal", "decrease")
^#Up::ResizeAxis("vertical", "increase")
^#Down::ResizeAxis("vertical", "decrease")

^#x::FlipLayout("horizontal")
^#y::FlipLayout("vertical")

#^o::ReloadConfiguration()
