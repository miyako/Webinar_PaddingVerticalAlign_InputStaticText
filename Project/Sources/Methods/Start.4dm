// Opens (or brings to front) the demo launcher. Called by On Startup and by File > Demo Launcher…
// $params (from Demo_switchLanguage) may list demo windows to reopen: {reopen: [{form; left; top}]}
#DECLARE($params : Object)

var $title : Text
var $window; $left; $top; $right; $bottom : Integer

If (Count parameters=0)
	// always hop to the application process: its messages run one at a time, so the
	// "already open?" check below cannot race when Start is called twice in a row
	CALL WORKER(1; Current method name; {})
	return 
End if 

$title:=Localized string("Launcher_WindowTitle")
ARRAY LONGINT($windows; 0)
WINDOW LIST($windows)
var $i : Integer
For ($i; 1; Size of array($windows))
	$window:=$windows{$i}
	If (Window process($window)=Current process) && (Get window title($window)=$title)
		GET WINDOW RECT($left; $top; $right; $bottom; $window)
		SET WINDOW RECT($left; $top; $right; $bottom; $window)  // brings it to the front
		return 
	End if 
End for 

SET MENU BAR(1)
$window:=Open form window("Launcher"; Plain form window; Horizontally centered; Vertically centered)
SET WINDOW TITLE($title; $window)
DIALOG("Launcher"; $params; *)
