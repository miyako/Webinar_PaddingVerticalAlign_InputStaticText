//%attributes = {"invisible":true}
// Opens a demo form in its own non-blocking window, or brings the existing one to the front.
// $position: Null = centred, or {left; top} (content-area coordinates)
#DECLARE($formName : Text; $position : Object)

var $title : Text
var $window; $left; $top; $right; $bottom : Integer
$title:=Demo_windowTitle($formName)

ARRAY LONGINT($windows; 0)
WINDOW LIST($windows)
var $i : Integer
For ($i; 1; Size of array($windows))
	$window:=$windows{$i}
	If (Get window title($window)=$title)
		GET WINDOW RECT($left; $top; $right; $bottom; $window)
		If ($position#Null)
			$right:=$right+$position.left-$left
			$bottom:=$bottom+$position.top-$top
			$left:=$position.left
			$top:=$position.top
		End if 
		CALL FORM($window; Formula(SET WINDOW RECT($left; $top; $right; $bottom; $window)))
		return 
	End if 
End for 

If ($position=Null)
	$window:=Open form window($formName; Plain form window; Horizontally centered; Vertically centered)
Else 
	$window:=Open form window($formName; Plain form window; $position.left; $position.top)
End if 
SET WINDOW TITLE($title; $window)
DIALOG($formName; {}; *)
