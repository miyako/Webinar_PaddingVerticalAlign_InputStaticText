// Opens (or brings to front) the demo launcher. Called by On Startup and by File > Demo Launcher…
// $params (from Demo_switchLanguage) may list demo windows to reopen: {reopen: [{form; left; top}]}
#DECLARE($params : Object)

var $title : Text
var $window : Integer
$title:=Localized string("Launcher_WindowTitle")

If (Count parameters=0)
	
	ARRAY LONGINT($windows; 0)
	WINDOW LIST($windows)
	var $i : Integer
	For ($i; 1; Size of array($windows))
		$window:=$windows{$i}
		If (Window process($window)=1) && (Get window title($window)=$title)
			var $left; $top; $right; $bottom : Integer
			GET WINDOW RECT($left; $top; $right; $bottom; $window)
			CALL FORM($window; Formula(SET WINDOW RECT($left; $top; $right; $bottom; $window)))
			return 
		End if 
	End for 
	
	CALL WORKER(1; Current method name; {})
	
Else 
	
	SET MENU BAR(1)
	$window:=Open form window("Launcher"; Plain form window; Horizontally centered; Vertically centered)
	SET WINDOW TITLE($title; $window)
	DIALOG("Launcher"; $params; *)
	
End if 
