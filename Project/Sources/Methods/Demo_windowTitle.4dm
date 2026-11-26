//%attributes = {"invisible":true}
// Localised window title of a demo form ("NewTrip_21R4" -> NewTrip_WindowTitleR4)
#DECLARE($formName : Text) : Text

return Localized string("NewTrip_WindowTitle"+Substring($formName; Length($formName)-1))
