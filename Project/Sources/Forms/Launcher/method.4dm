var $event : Object
var $reopen : Object
$event:=FORM Event

Case of 
	: ($event.code=On Load)
		// language names are endonyms ("English", "日本語"): identical in every XLIFF file
		Form.language:={values: Split string(Localized string("Launcher_LanguageNames"); "|"); index: Num(Get database localization="ja@")}
		If (Form.reopen#Null)
			For each ($reopen; Form.reopen)
				Demo_openForm($reopen.form; {left: $reopen.left; top: $reopen.top})
			End for each 
		End if 
		
	: ($event.code=On Clicked)
		Case of 
			: ($event.objectName="btnOpenR4")
				Demo_openForm("NewTrip_21R4")
			: ($event.objectName="btnOpenR5")
				Demo_openForm("NewTrip_21R5")
			: ($event.objectName="btnSideBySide")
				Demo_sideBySide
		End case 
		
	: ($event.code=On Data Change) && ($event.objectName="language")
		Demo_switchLanguage(Choose(Form.language.index; "en"; "ja"))
		
End case 
