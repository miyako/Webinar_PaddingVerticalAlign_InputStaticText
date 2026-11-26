//%attributes = {"invisible":true}
// Switches the UI language. Forms already open keep their labels, so every demo window
// is closed and reopened at the same place in the new language (SET DATABASE LOCALIZATION
// only affects what is displayed after the call). Must run in the launcher's form method.
#DECLARE($language : Text)

var $reopen : Collection
var $formName : Text
var $window; $left; $top; $right; $bottom : Integer
$reopen:=[]

ARRAY LONGINT($windows; 0)
WINDOW LIST($windows)
var $i : Integer
For ($i; 1; Size of array($windows))
	$window:=$windows{$i}
	For each ($formName; ["NewTrip_21R4"; "NewTrip_21R5"])
		If (Get window title($window)=Demo_windowTitle($formName))
			GET WINDOW RECT($left; $top; $right; $bottom; $window)
			$reopen.push({form: $formName; left: $left; top: $top})
			CALL FORM($window; Formula(CANCEL))
		End if 
	End for each 
End for 

SET DATABASE LOCALIZATION($language)
CANCEL  // closes the launcher; Start reopens it (and the demo windows) in the new language
CALL WORKER(1; "Start"; {reopen: $reopen})
