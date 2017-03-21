; SetDesktopWebBrowser v1.0
; https://github.com/chpock/SetDesktopWebBrowser

; Configuration

; DesktopX - specified web browser for each desktop
Desktop3 = ChromeHTML
; DesktopDefault - specified web browser for not defined desktop (default)
DesktopDefault = FirefoxHTML

; End of the configuration

#NoTrayIcon

GENERIC_WRITE = 0x40000000  ; Open the file for writing rather than reading.
CREATE_ALWAYS = 2  ; Create new file (overwriting any existing file).
hFile := DllCall("CreateFile", "str", A_ScriptDir . "\jahkvwmsg.exe.hwnd", "Uint", GENERIC_WRITE, "Uint", 0, "UInt", 0, "UInt", CREATE_ALWAYS, "Uint", 0, "UInt", 0)
if not hFile
{
	MsgBox Can't open "jahkvwmsg.exe.hwnd" for writing.
	return
}
pid:=DllCall("GetCurrentProcessId","Uint")
DetectHiddenWindows, On
hwnd:=WinExist("ahk_pid " . pid)		;Get the handle of AHK's window

hwnd+=0x1000<<32				;This is the message offset (can be zero)
						;Note that WM_USER is 0x400
						;The first module message: MOD_CHANGEDESK, is WM_USER+30
						;here offset to 0x1400+30

DllCall("WriteFile", "UInt", hFile, "UIntP", hwnd, "UInt", 8, "UIntP", BytesActuallyWritten, "UInt", 0)
DllCall("CloseHandle", "UInt", hFile)

OnMessage(0x1400+30 , "VWMess")	;Change Desk

OnMessage(0x1400+37 , "VWMessConfig")	;Module Configuration

VWMess(wParam, lParam, msg, hwnd) {
    global

    SetBrowser := Desktop%lParam%
    If(SetBrowser = "") {
        SetBrowser := DesktopDefault
    }

    RegRead, BrowserCmd, HKCR\%SetBrowser%\shell\open\command

    If(BrowserCmd = "") {

        MsgBox, 16, VirtuaWin - SwitchWebProwser plugin, Error: web browser %SetBrowser% not found.

    } else {

        Regwrite, REG_SZ, HKCU\Software\Classes\.htm, , %SetBrowser%
        Regwrite, REG_SZ, HKCU\Software\Classes\.html, , %SetBrowser%
        Regwrite, REG_SZ, HKCU\Software\Classes\.shtml, , %SetBrowser%
        Regwrite, REG_SZ, HKCU\Software\Classes\.xht, , %SetBrowser%
        Regwrite, REG_SZ, HKCU\Software\Classes\.xhtml, , %SetBrowser%
        Regwrite, REG_SZ, HKCU\Software\Classes\ftp\shell\open\command, , %BrowserCmd%
        Regwrite, REG_SZ, HKCU\Software\Classes\http\shell\open\command, , %BrowserCmd%
        Regwrite, REG_SZ, HKCU\Software\Classes\https\shell\open\command, , %BrowserCmd%
        Regwrite, REG_SZ, HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\ftp\UserChoice, Progid, %SetBrowser%
        Regwrite, REG_SZ, HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice, Progid, %SetBrowser%
        Regwrite, REG_SZ, HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice, Progid, %SetBrowser%

    }

}

VWMessConfig(wParam, lParam, msg, hwnd) {
	MsgBox, No configuration. Edit the source.
}
