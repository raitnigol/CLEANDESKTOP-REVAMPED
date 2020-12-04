<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    CLEANDESKTOP REVAMPED
#>


# first of all, get the desktop location of currently signed in users and count the files on the desktop
$ScriptDirectory = $PSScriptRoot
Import-Module $ScriptDirectory\DesktopLocation.psm1

# to make the gui autoscale, we need to get users display resolution
$ClientSize                      = [System.Windows.Forms.SystemInformation]::VirtualScreen
$ClientWidth                     = $ClientSize.Width
$ClientHeight                    = $ClientSize.Height

# make an array that can hold checkbox objects so we do not need to hardcode
# when reseting the valus
$Script:GUIFormObjectList = @()

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


# initiate the form
$CLEANDESKTOP                    = New-Object system.Windows.Forms.Form
$CLEANDESKTOP.ClientSize         = "$($ClientWidth / 1.5), $($ClientHeight / 1.5)"
$CLEANDESKTOP.text               = "CLEANDESKTOP"
$CLEANDESKTOP.TopMost            = $false
$CLEANDESKTOP.StartPosition      = 'CenterScreen'
$CLEANDESKTOP.BackColor          = 'White'
$CLEANDESKTOP.MinimumSize        = "$($ClientWidth / 2), $($ClientHeight / 2)"
$CLEANDESKTOP.BringToFront()


# add tab control
$TabControl                      = New-Object System.Windows.Forms.TabControl
$TabControl.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 0
$System_Drawing_Point.Y          = 0
$TabControl.Location             = $System_Drawing_Point
$TabControl.Name                 = "TabControl"
$TabControl.SizeMode             = "Fixed"

$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = "$($ClientWidth / 1.5)"
$System_Drawing_Size.Height      = "$($ClientHeight / 1.5)"
$TabControl.Size                 = $System_Drawing_Size
$TabControl.Anchor               = "left, right, top, bottom"

# add main page to the gui
$CLEANDESKTOP_MAIN_PAGE          = New-Object System.Windows.Forms.TabPage
$CLEANDESKTOP_MAIN_PAGE.DataBindings.DefaultDataSourceUpdateMode = 0
$CLEANDESKTOP_MAIN_PAGE.UseVisualStyleBackColor = $true
$CLEANDESKTOP_MAIN_PAGE.Text     = "Main Page"
$TabControl.Controls.Add($CLEANDESKTOP_MAIN_PAGE)


# add two buttons to the main page, one that moves the files and one that lets you choose the location
# of the folder where to copy the files
# first of all create a table layout panel so we can center the buttons to the center of the screen
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL = New-Object System.Windows.Forms.TableLayoutPanel
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.AutoSize = $true
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.AutoSizeMode = "GrowAndShrink"
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.RowCount = 2
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.ColumnCount = 2
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.BackColor = "White"
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.Anchor = "none"
$CLEANDESKTOP_MAIN_PAGE.Controls.Add($CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL)

$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON = New-Object System.Windows.Forms.Button
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.AutoSize = $true
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Text    = "Select Folder"
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Width   = 20
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Height  = 20
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Anchor = "left,right,bottom"
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.TextAlign = "BottomCenter"
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.Controls.Add($CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON)

$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON = New-Object System.Windows.Forms.Button
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.AutoSize = $true
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Text = "Move Files"
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Width = 20
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Height = 20
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Anchor = 'left,right,bottom'
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",10)
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.TextAlign = "BottomCenter"
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.Controls.Add($CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON)

# add a label to the main page where you can choose the folder where to move the files
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX = New-Object System.Windows.Forms.TextBox
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.AutoSize = $true
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.ReadOnly = $true
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.Anchor = "left,right,top"
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.TextAlign = "Left"
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.Controls.Add($CLEANDESKTOP_MAIN_PAGE_TEXTBOX)
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.SetColumnSpan($CLEANDESKTOP_MAIN_PAGE_TEXTBOX, 2)


# add extensions tab to the gui
$CLEANDESKTOP_EXTENSIONS_PAGE        = New-Object System.Windows.Forms.TabPage
$CLEANDESKTOP_EXTENSIONS_PAGE.DataBindings.DefaultDataSourceUpdateMode = 0
$CLEANDESKTOP_EXTENSIONS_PAGE.UseVisualStyleBackColor = $true
$CLEANDESKTOP_EXTENSIONS_PAGE.Text = "Extensions"
$TabControl.Controls.Add($CLEANDESKTOP_EXTENSIONS_PAGE)


# add desktop files tab to the gui
$CLEANDESKTOP_DESKTOP_FILES      = New-Object System.Windows.Forms.TabPage
#$CLEANDESKTOP_DESKTOP_FILES.DataBindingds.DefaultSourceUpdateMode = 0
$CLEANDESKTOP_DESKTOP_FILES.UseVisualStyleBackColor = $true
$CLEANDESKTOP_DESKTOP_FILES.Text = "Desktop Files"
$TabControl.Controls.Add($CLEANDESKTOP_DESKTOP_FILES)


# add a datagrid view to the desktop files tab so we can
# add all files on the desktop there, and make them selectable
# for individual removal or moving
$DESKTOP_FILES_DATAGRIDVIEW          = New-Object System.Windows.Forms.DataGridView
$DESKTOP_FILES_DATAGRIDVIEW.Anchor   = "top, bottom, left, right"
$DESKTOP_FILES_DATAGRIDVIEW.AutoSizeColumnsMode = "Fill"
$DESKTOP_FILES_DATAGRIDVIEW.TabIndex = 0
$DESKTOP_FILES_DATAGRIDVIEW.RowHeadersVisible = $false
$DESKTOP_FILES_DATAGRIDVIEW.Location = $System_Drawing_Point
$DESKTOP_FILES_DATAGRIDVIEW.Size     = $System_Drawing_Size
$DESKTOP_FILES_DATAGRIDVIEW.AllowUserToResizeRows = $false
$DESKTOP_FILES_DATAGRIDVIEW.AllowUserToResizeColumns = $false
$DESKTOP_FILES_DATAGRIDVIEW.AllowUserToAddRows = $false
$DESKTOP_FILES_DATAGRIDVIEW.AllowUserToDeleteRows = $false
$DESKTOP_FILES_DATAGRIDVIEW.ReadOnly = $true
$DESKTOP_FILES_DATAGRIDVIEW.BackColor = "White"
$DESKTOP_FILES_DATAGRIDVIEW.Font = New-Object System.Drawing.Font("Arial", 10)
$DESKTOP_FILES_DATAGRIDVIEW.AllowUser
$DESKTOP_FILES_DATAGRIDVIEW.ColumnCount = 1
$DESKTOP_FILES_DATAGRIDVIEW.Columns[0].Name = "File name"
$DESKTOP_FILES_DATAGRIDVIEW.Columns[0].Width = 200
$CLEANDESKTOP_DESKTOP_FILES.Controls.Add($DESKTOP_FILES_DATAGRIDVIEW)


# set up tabs for extensions tab
$CHECKBOX_PNG                    = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_JPG                    = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_JPEG                   = New-Object System.Windows.Forms.CheckBox


# CHECKBOX_PNG
$CHECKBOX_PNG.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_PNG.Size               = $System_Drawing_Size
$CHECKBOX_PNG.TabIndex           = 1
$CHECKBOX_PNG.Text               = ".png"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 25
$System_Drawing_Point.Y          = 50
$CHECKBOX_PNG.Location           = $System_Drawing_Point
$CHECKBOX_PNG.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_PNG.Name               = "checkBox2"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_PNG)
$Script:GUIFormObjectList += $CHECKBOX_PNG


# CHECKBOX_JPG
$CHECKBOX_JPG.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_JPG.Size               = $System_Drawing_Size
$CHECKBOX_JPG.TabIndex           = 1
$CHECKBOX_JPG.Text               = ".jpg"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 25
$System_Drawing_Point.Y          = 25
$CHECKBOX_JPG.Location           = $System_Drawing_Point
$CHECKBOX_JPG.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_JPG.Name               = "checkBox2"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_JPG)
$Script:GUIFormObjectList += $CHECKBOX_JPG


# add button that can reset the state of all checkboxes on extensions tab
$CLEAR_EXTENSIONS_BUTTON         = New-Object system.Windows.Forms.Button
$CLEAR_EXTENSIONS_BUTTON.AutoSize = $true
$CLEAR_EXTENSIONS_BUTTON.text    = "Reset all"
$CLEAR_EXTENSIONS_BUTTON.width   = 10
$CLEAR_EXTENSIONS_BUTTON.height  = 10
$CLEAR_EXTENSIONS_BUTTON.Anchor  = 'top,bottom'
$CLEAR_EXTENSIONS_BUTTON.Dock    = "Bottom"
$CLEAR_EXTENSIONS_BUTTON.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$CLEAR_EXTENSIONS_BUTTON.TextAlign = "BottomCenter"  
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CLEAR_EXTENSIONS_BUTTON)


# add logic to the button
$CLEAR_EXTENSIONS_BUTTON.Add_Click({CleanExtensions})


# add label that shows the current item count on the desktop
$DESKTOPITEMCOUNT                = New-Object system.Windows.Forms.Label
$DESKTOPITEMCOUNT.AutoSize       = $false
$DESKTOPITEMCOUNT.Width          = 50
$DESKTOPITEMCOUNT.Height         = 50
$DESKTOPITEMCOUNT.Anchor         = "top, bottom"
$DESKTOPITEMCOUNT.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$DESKTOPITEMCOUNT.Visible        = $false
$DESKTOPITEMCOUNT.TextAlign      = "BottomCenter"
$DESKTOPITEMCOUNT.Dock           = "Fill"
$DESKTOPITEMCOUNT.Padding        = 10
# add the label to the main page
$CLEANDESKTOP_MAIN_PAGE.Controls.Add($DESKTOPITEMCOUNT)


# execute required scripts and apply logic (functions) here


# get desktop item count and display it in the textbox
# make it as a service, running every 30 seconds
function Update-DesktopItemCount {
    $DesktopItemsCount = Get-DesktopItemCount
    $DesktopLocation = Get-DesktopLocation

    $DesktopItemsCount = $DesktopItemsCount.ToString()

    $DESKTOPITEMCOUNT.Text        = "There are currently $DesktopItemsCount files on the desktop | Desktop path: $DesktopLocation"
    $DESKTOPITEMCOUNT.Visible     = $true
}
Update-DesktopItemCount


# we do not need to hardcode to reset checkboxes, instead take the array
# we created previously, loop over it and reset all fields to $false
function CleanExtensions {
    ForEach ($Field in $Script:GUIFormObjectList) {
    $FieldType = $Field.GetType().Name
    Switch($FieldType) {
        CheckBox { $Field.Checked = $False }
        }
    }
}



function List-DesktopFiles {
    # list the desktop files and show them in the desktop files tab
    Show-DesktopFiles | 
    ForEach-Object {
        [void]$DESKTOP_FILES_DATAGRIDVIEW.Rows.Add($_) 
     }
}
List-DesktopFiles


function Show-TextBox-DesktopLocation { }


# add controls
$CLEANDESKTOP.controls.AddRange(@($TabControl))


# show the gui
[void]$CLEANDESKTOP.ShowDialog()


# after closing the program, dispose of it
$CLEANDESKTOP.Dispose()