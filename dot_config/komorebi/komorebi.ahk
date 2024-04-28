; #SingleInstance Force

; ^ Ctrl
; ! Alt
; + Shift

#Include komorebic.lib.ahk

^!o::ReloadConfiguration()

^!h::Focus("left")
^!j::Focus("down")
^!k::Focus("up")
^!l::Focus("right")
^!+[::CycleFocus("previous")
^!+]::CycleFocus("next")

^!+h::Move("left")
^!+j::Move("down")
^!+k::Move("up")
^!+l::Move("right")
^!p::Promote()

^!+Left::Stack("left")
^!+Right::Stack("right")
^!+Up::Stack("up")
^!+Down::Stack("down")
^!+;::Unstack()
; ^!+[::CycleStack("previous")
; ^!+]::CycleStack("next")

^!Right::ResizeAxis("horizontal", "increase")
^!Left::ResizeAxis("horizontal", "decrease")
^!Up::ResizeAxis("vertical", "increase")
^!Down::ResizeAxis("vertical", "decrease")

^!f::ToggleFloat()
^!m::Minimize()
^!w::Close()
^!+t::ToggleTiling() ; avoid with opening terminal
^!z::ToggleMonocle()

^!r::Retile()
^!+p::TogglePause()

!x::FlipLayout("horizontal")
!y::FlipLayout("vertical")

!1::FocusWorkspace(0)
!2::FocusWorkspace(1)
!3::FocusWorkspace(2)
!4::FocusWorkspace(3)
!5::FocusWorkspace(4)
!6::FocusWorkspace(5)
!7::FocusWorkspace(6)
!8::FocusWorkspace(7)
!9::FocusWorkspace(8)
!0::FocusWorkspace(9)

![::CycleWorkspace("previous")
!]::CycleWorkspace("next")

!+1::MoveToWorkspace(0)
!+2::MoveToWorkspace(1)
!+3::MoveToWorkspace(2)
!+4::MoveToWorkspace(3)
!+5::MoveToWorkspace(4)
!+6::MoveToWorkspace(5)
!+7::MoveToWorkspace(6)
!+8::MoveToWorkspace(7)
!+9::MoveToWorkspace(8)
!+0::MoveToWorkspace(9)

!+[::CycleMoveToWorkspace("previous")
!+]::CycleMoveToWorkspace("next")
