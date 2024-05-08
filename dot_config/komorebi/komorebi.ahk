#SingleInstance Force
#Warn All, Off

; <# Left Win
; ^ Ctrl
; ! Alt
; + Shift

#Include komorebic.lib.ahk

<#1::FocusWorkspace(0)
return
<#2::FocusWorkspace(1)
return
<#3::FocusWorkspace(2)
return
<#4::FocusWorkspace(3)
return
<#5::FocusWorkspace(4)
return
<#6::FocusWorkspace(5)
return
<#7::FocusWorkspace(6)
return
<#8::FocusWorkspace(7)
return
<#9::FocusWorkspace(8)
return
<#0::FocusWorkspace(9)
return

<#[::CycleWorkspace("previous")
return
<#]::CycleWorkspace("next")
return

<#+1::MoveToWorkspace(0)
return
<#+2::MoveToWorkspace(1)
return
<#+3::MoveToWorkspace(2)
return
<#+4::MoveToWorkspace(3)
return
<#+5::MoveToWorkspace(4)
return
<#+6::MoveToWorkspace(5)
return
<#+7::MoveToWorkspace(6)
return
<#+8::MoveToWorkspace(7)
return
<#+9::MoveToWorkspace(8)
return
<#+0::MoveToWorkspace(9)
return

<#+[::CycleMoveToWorkspace("previous")
return
<#+]::CycleMoveToWorkspace("next")
return

^<#h::Focus("left")
return
^<#j::Focus("down")
return
^<#k::Focus("up")
return
^<#l::Focus("right")
return
^<#+[::CycleFocus("previous")
return
^<#+]::CycleFocus("next")
return

^<#+h::Move("left")
return
^<#+j::Move("down")
return
^<#+k::Move("up")
return
^<#+l::Move("right")
return
^<#p::Promote()
return

<#Enter::Run "wt.exe"
return

^<#f::ToggleFloat()
return
^<#m::Minimize()
return
^<#w::Close()
return
^<#t::ToggleTiling() ; avoid with opening terminal
return
^<#z::ToggleMonocle()
return

^<#r::Retile()
return
^<#+p::TogglePause()
return

^<#+Left::Stack("left")
return
^<#+Right::Stack("right")
return
^<#+Up::Stack("up")
return
^<#+Down::Stack("down")
return
^<#+;::Unstack()
return

^<#Right::ResizeAxis("horizontal", "increase")
return
^<#Left::ResizeAxis("horizontal", "decrease")
return
^<#Up::ResizeAxis("vertical", "increase")
return
^<#Down::ResizeAxis("vertical", "decrease")
return

^<#x::FlipLayout("horizontal")
return
^<#y::FlipLayout("vertical")
return

<#^o::ReloadConfiguration()
return
