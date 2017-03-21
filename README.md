# SetDesktopWebBrowser
Set specified web browser for each desktop in VirtuaWin

Powered by [AutoHotkey](https://autohotkey.com) and based on [Message Passthrough](http://virtuawin.sourceforge.net/?page_id=50) plugin.

# How to use
1. Edit "Configuration" section in the **SetDesktopWebBrowser.ahk**, define variables 'DesktopDefault' and 'DesktopX'
1. Compile script to executable by command: `ahk2exe /in SetDesktopWebBrowser.ahk /out SetDesktopWebBrowser.exe`
1. Download the [Message Passthrough](http://virtuawin.sourceforge.net/downloads/modules/MessagePassthrough.zip) module
1. Set writable  permission to modules directory of VirtuaWin (e.g. "Program Files (x86)\VirtuaWin\modules")
1. Copy compiled **SetWebBrowser.exe** and executable **jahkvwmsg.exe** from plugin above to the modules directory of VirtuaWin
1. Go to **VirtuaWin** -> **Setup** -> **Modules** and click **Reload** button
1. Ignore any errors, select **SetDesktopWebBrowser** and click **Enable/Disable** button
1. Add **SetDesktopWebBrowser.exe** from modules directory of VirtuaWin to the system auto-start
