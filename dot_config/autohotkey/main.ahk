#SingleInstance Force

SetTitleMatchMode 3
DetectHiddenWindows true

; #Warn All, Off

; # Left Win
; ^ Ctrl
; ! Alt
; + Shift

#Include "komorebic.lib.ahk"
; #Include "autohotkey/hotstring.ahk"
#Include "hidecursor.ahk"

; --- HIDE CURSOR ---

#c::ToggleCursor()

; --- CONFIG ---

#Backspace:: {
  try ControlSend "!{F4}",, "ahk_class Progman"
  try ControlFocus "ComboBox1", "Shut Down Windows"
}

#o::
{
    Sleep 1000  ; Give user a chance to release keys (in case their release would wake up the monitor again).
    ; Turn Monitor Off:
    ;  Turns off the monitor via hotkey. In the SendMessage line, replace the number 2 with -1 to turn on the monitor, or replace it with 1 to activate the monitor's low-power mode.
    SendMessage 0x0112, 0xF170, 2,, "Program Manager"  ; 0x0112 is WM_SYSCOMMAND, 0xF170 is SC_MONITORPOWER.
}

^#!+r::Reload

; --- CAPSLOCK AND CONTROL ---
CapsLock:: {
  Send "{Blind}{LControl down}"
}

CapsLock up:: {
  Send "{Blind}{LControl Up}"
  if (A_PriorKey == "CapsLock" and A_TimeSincePriorHotkey < 400)
  {
    SetCapsLockState !GetKeyState("CapsLock", "T")
  }
}

; --- RUN APP VIA KEYBOARD SHORTCUT ---

#Enter::Run "wt.exe"
#t::Run "alacritty.exe"
; #c::Run "code.exe" ; Replace with hide cusor
#b::Run "brave.exe" 
; #m::Run "C:\Users\kevinnitro\AppData\Roaming\Spotify\Spotify.exe" 

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

; TODO: Working on this later
/*
previous_workspace := 0

QueryCurrentWorkspace() {
  command := "komorebic.exe query focused-workspace-index"
  shell := ComObject("WScript.Shell")
  ; Execute a single command via cmd.exe
  exec := shell.Exec(A_ComSpec " /C " command)
  ; Read and return the command's output
  return exec.StdOut.ReadAll()
}

ToggleSecretWorkspace(){
  global previous_workspace
  current := QueryCurrentWorkspace()
  msgbox current previous_workspace
  if (current == "10") {
    FocusWorkspace(previous_workspace)
  }
  else {
    FocusWorkspace(10) 
    previous_workspace := current
  }
}
*/

; #^o::ReloadConfiguration()
#^!r::RestoreWindows()
#^+r:: {
  try RunWait("komorebic.exe stop", , "Hide")
  RunWait("komorebic.exe start", , "Hide")
}

#1::FocusNamedWorkspace("0")
#2::FocusNamedWorkspace("1")
#3::FocusNamedWorkspace("2")
#4::FocusNamedWorkspace("3")
#5::FocusNamedWorkspace("4")
#6::FocusNamedWorkspace("5")
#7::FocusNamedWorkspace("6")
#8::FocusNamedWorkspace("7")
#9::FocusNamedWorkspace("8")
#0::FocusNamedWorkspace("9")
#s::FocusNamedWorkspace("secret")

#[::CycleWorkspace("previous")
#]::CycleWorkspace("next")

#+1::MoveToNamedWorkspace("0")
#+2::MoveToNamedWorkspace("1")
#+3::MoveToNamedWorkspace("2")
#+4::MoveToNamedWorkspace("3")
#+5::MoveToNamedWorkspace("4")
#+6::MoveToNamedWorkspace("5")
#+7::MoveToNamedWorkspace("6")
#+8::MoveToNamedWorkspace("7")
#+9::MoveToNamedWorkspace("8")
#+0::MoveToNamedWorkspace("9")
#!s::MoveToNamedWorkspace("secret")

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
^#m::Minimize()
#q::Close()
^#t::ToggleTiling() ; avoid with opening terminal
#m::ToggleMonocle()
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
