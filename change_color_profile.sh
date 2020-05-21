#Get the current display, choose to switch
property activeDesktop : missing value

set displayNames to {}

tell application "Image Events"
	set theDisplays to displays
	repeat with i from 1 to number of items in theDisplays
		set this_item to item i of theDisplays
		set theName to name of display profile of item i of theDisplays
		set end of displayNames to theName
		set activeDesktop to item 1 of displayNames
	end repeat
end tell

if activeDesktop = "Nightshift" then
	set displayProfile to "iMac" --change to desired profile
else
	set displayProfile to "Nightshift" --change to desired profile
end if

# ====================================================

# Open system preferences
tell application "System Preferences"
	activate
	set current pane to pane id "com.apple.preference.displays"
	reveal (first anchor of current pane whose name is "displaysColorTab")
end tell

# Open Color Profiles
tell application "System Events"
	tell process "System Preferences"
		click radio button "Color" of tab group of window 1
		repeat until exists tab group 1 of window "iMac"
		end repeat

		# Loop through the options
		tell table of scroll area 1 of tab group 1 of window 1
			repeat with i from 1 to (count of rows)

				# Get the text value of the row
				set textValue to (value of static text of row i) as string
				if textValue is equal to displayProfile then
					set selected of row i to true
					exit repeat
				end if
			end repeat
		end tell

	end tell
end tell


# Quit what you started
tell application "System Preferences"
	quit
end tell
