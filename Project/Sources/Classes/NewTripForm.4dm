// Shared behaviour of the NewTrip_21R4 and NewTrip_21R5 forms.
// Both forms call cs.NewTripForm.new().handle(FORM Event) so the demo compares layout only, not code.

Function handle($event : Object)
	
	Case of 
		: ($event.code=On Load)
			This.onLoad()
		: ($event.code=On Data Change)
			This.onDataChange($event.objectName)
		: ($event.code=On Clicked)
			If ($event.objectName="totalSeatsStepper")
				This.onDataChange($event.objectName)
			End if 
	End case 
	
Function onLoad()
	
	// language-dependent lists cannot use :xliff: (static JSON only) -> built from XLIFF in code
	Form.destination:={values: This.list("NewTrip_Destinations"); currentValue: ""}
	Form.tripType:={values: This.list("NewTrip_TripTypes"); index: 0}
	Form.currency:={values: This.list("NewTrip_Currencies"); index: 0}
	Form.totalSeats:=20
	Form.availableSeats:=20
	This.applyCurrency()
	This.alignRequiredMarks()
	This.centerBrowseLink()
	
Function onDataChange($objectName : Text)
	
	Case of 
		: ($objectName="currency")
			This.applyCurrency()
		: ($objectName="startDate") || ($objectName="endDate")
			This.updateDuration()
		: ($objectName="totalSeats") || ($objectName="totalSeatsStepper")
			Form.availableSeats:=Form.totalSeats
	End case 
	
Function list($id : Text) : Collection
	
	return Split string(Localized string($id); "|")
	
Function applyCurrency()
	
	var $index : Integer
	var $decimals : Integer
	$index:=Form.currency.index
	If ($index<0)
		$index:=0
	End if 
	$decimals:=Num(This.list("NewTrip_CurrencyDecimals")[$index])
	OBJECT SET TITLE(*; "basePriceUnit"; This.list("NewTrip_CurrencyUnits")[$index])
	If ($decimals=0)
		OBJECT SET FORMAT(*; "basePrice"; "###,###,##0")
		OBJECT SET PLACEHOLDER(*; "basePrice"; "0")
	Else 
		OBJECT SET FORMAT(*; "basePrice"; "###,###,##0.00")
		OBJECT SET PLACEHOLDER(*; "basePrice"; "0.00")
	End if 
	
Function updateDuration()
	
	var $days : Integer
	Form.duration:=""
	If (Value type(Form.startDate)=Is date) && (Value type(Form.endDate)=Is date)
		If (Form.startDate#!00-00-00!) && (Form.endDate>=Form.startDate)
			$days:=Form.endDate-Form.startDate+1
			If ($days=1)
				Form.duration:=Localized string("NewTrip_DurationOneDay")
			Else 
				Form.duration:=Replace string(Localized string("NewTrip_DurationDays"); "{n}"; String($days))
			End if 
		End if 
	End if 
	
Function alignRequiredMarks()
	
	// the red "*" sits right after its label, whatever the label length in the current language
	var $label : Text
	var $left; $top; $right; $bottom; $width; $height : Integer
	var $markLeft; $markTop; $markRight; $markBottom : Integer
	For each ($label; ["tripNameLabel"; "destinationLabel"; "startDateLabel"; "endDateLabel"; "basePriceLabel"; "totalSeatsLabel"])
		OBJECT GET BEST SIZE(*; $label; $width; $height)
		OBJECT GET COORDINATES(*; $label; $left; $top; $right; $bottom)
		OBJECT GET COORDINATES(*; $label+"Required"; $markLeft; $markTop; $markRight; $markBottom)
		OBJECT SET COORDINATES(*; $label+"Required"; $left+$width+2; $markTop; $left+$width+2+($markRight-$markLeft); $markBottom)
	End for each 
	
Function centerBrowseLink()
	
	// "or click to" + "browse" are two objects (the link has its own colour): centre the pair under the first line
	var $left; $top; $right; $bottom; $width; $height; $browseWidth : Integer
	var $zoneLeft; $zoneTop; $zoneRight; $zoneBottom; $start : Integer
	OBJECT GET COORDINATES(*; "dropZoneText1"; $zoneLeft; $zoneTop; $zoneRight; $zoneBottom)
	OBJECT GET BEST SIZE(*; "dropZoneText2"; $width; $height)
	OBJECT GET BEST SIZE(*; "dropZoneBrowse"; $browseWidth; $height)
	// 4D has no operator precedence (strictly left to right): parenthesise the division
	$start:=$zoneLeft+((($zoneRight-$zoneLeft)-($width+4+$browseWidth))\2)
	OBJECT GET COORDINATES(*; "dropZoneText2"; $left; $top; $right; $bottom)
	OBJECT SET COORDINATES(*; "dropZoneText2"; $start; $top; $start+$width; $bottom)
	OBJECT GET COORDINATES(*; "dropZoneBrowse"; $left; $top; $right; $bottom)
	OBJECT SET COORDINATES(*; "dropZoneBrowse"; $start+$width+4; $top; $start+$width+4+$browseWidth; $bottom)
	
