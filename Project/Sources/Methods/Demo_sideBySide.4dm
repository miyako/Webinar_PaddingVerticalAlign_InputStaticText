//%attributes = {"invisible":true}
// Opens both demo forms next to each other (they overlap when the screen is narrower than both).
var $width; $height; $top; $gap; $leftR4; $leftR5 : Integer

FORM GET PROPERTIES("NewTrip_21R4"; $width; $height)
$gap:=12
$top:=Menu bar height+40
If (Screen width>=((2*$width)+(3*$gap)))
	$leftR4:=(Screen width-((2*$width)+$gap))\2
	$leftR5:=$leftR4+$width+$gap
Else 
	$leftR4:=$gap
	$leftR5:=Screen width-$width-$gap
End if 

Demo_openForm("NewTrip_21R4"; {left: $leftR4; top: $top})
Demo_openForm("NewTrip_21R5"; {left: $leftR5; top: $top+24})
