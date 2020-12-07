
<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    CLEANDESKTOP REVAMPED
#>


# get the current script directory to import the module DesktopLocation.psm1
$ScriptDirectory = $PSScriptRoot
Import-Module $ScriptDirectory\DesktopLocation.psm1


# to make the gui autoscale, we need to get users display resolution
$ClientSize                      = [System.Windows.Forms.SystemInformation]::VirtualScreen
$ClientWidth                     = $ClientSize.Width
$ClientHeight                    = $ClientSize.Height


# make an array that can hold checkbox objects so we do not need to hardcode
# when reseting the values with a single button click 
$Script:GUIFormObjectList = @()


# add the form controls
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


# add a label with my github to the main tab of the gui
$CLEANDESKTOP_MAIN_PAGE_GITHUB_LABEL = New-Object System.Windows.Forms.Label
$CLEANDESKTOP_MAIN_PAGE_GITHUB_LABEL.Text = "github.com/raitnigol"
$CLEANDESKTOP_MAIN_PAGE_GITHUB_LABEL.AutoSize = $true
$CLEANDESKTOP_MAIN_PAGE_GITHUB_LABEL.Width = 25
$CLEANDESKTOP_MAIN_PAGE_GITHUB_LABEL.Height = 10
$CLEANDESKTOP_MAIN_PAGE_GITHUB_LABEL.Font = "Verdana, 10"

$CLEANDESKTOP_MAIN_PAGE.Controls.Add($CLEANDESKTOP_MAIN_PAGE_GITHUB_LABEL)


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


# button for selecting the desktop path
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON = New-Object System.Windows.Forms.Button
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.AutoSize = $true
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Text    = "Select Folder"
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Width   = 20
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Height  = 20
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Anchor = "left,right,bottom"
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.TextAlign = "BottomCenter"

$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.Controls.Add($CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON)

# add a function to the button
$CLEANDESKTOP_MAIN_PAGE_BROWSE_BUTTON.Add_Click({Show-TextBox-DesktopLocation})


# main button for executing the script to move the files to the selected folder
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON = New-Object System.Windows.Forms.Button
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.AutoSize = $true
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Text = "Move Files"
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Width = 20
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Height = 20
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Anchor = 'left,right,bottom'
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Enabled = $false
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",10)
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.TextAlign = "BottomCenter"
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.Controls.Add($CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON)

# add controls for the button
$CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Add_Click({Move-DesktopFiles})


# add a label to the main page where you can choose the folder where to move the files
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX = New-Object System.Windows.Forms.TextBox
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.AutoSize = $true
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.ReadOnly = $true
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.Anchor = "left,right,top"
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.TextAlign = "Left"
$CLEANDESKTOP_MAIN_PAGE_TEXTBOX.Text = $null
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
$DESKTOP_FILES_DATAGRIDVIEW.Dock = "Fill"
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
$DESKTOP_FILES_DATAGRIDVIEW.AutoSizeRowsMode = "AllCells"

$CLEANDESKTOP_DESKTOP_FILES.Controls.Add($DESKTOP_FILES_DATAGRIDVIEW)


# set up checkboxes for extensions tab
$CHECKBOX_PNG                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_JPG                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_JPEG                  = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_PSD                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_MP4                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_HTML                  = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_CSS                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_JS                    = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_PDF                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_AI                    = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_ID                    = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_PHP                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_TIFF                  = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_SOL                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_CS                    = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_MD                    = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_HPP                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_JSON                  = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_CPP                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_GO                    = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_SVG                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_GIF                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_EPS                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_DOC                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_XLS                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_PPT                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_OGG                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_WAV                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_MP3                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_MID                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_ZIP                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_AVI                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_FLV                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_WMV                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_MOV                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_MPG                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_XML                   = New-Object System.Windows.Forms.CheckBox
$CHECKBOX_FLA                   = New-Object System.Windows.Forms.CheckBox

# CHECKBOX_PNG
$CHECKBOX_PNG.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_PNG.Size               = $System_Drawing_Size
$CHECKBOX_PNG.TabIndex           = 1
$CHECKBOX_PNG.Text               = ".png"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 10
$CHECKBOX_PNG.Location           = $System_Drawing_Point
$CHECKBOX_PNG.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_PNG.Name               = "checkBox1"

$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_PNG)

# add the checkbox to the array that we created earlier
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
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 30
$CHECKBOX_JPG.Location           = $System_Drawing_Point
$CHECKBOX_JPG.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_JPG.Name               = "checkBox2"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_JPG)

# add the checkbox to the array that we created earlier
$Script:GUIFormObjectList += $CHECKBOX_JPG


# CHECKBOX_JPEG
$CHECKBOX_JPEG.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_JPEG.Size               = $System_Drawing_Size
$CHECKBOX_JPEG.TabIndex           = 1
$CHECKBOX_JPEG.Text               = ".jpeg"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 50
$CHECKBOX_JPEG.Location           = $System_Drawing_Point
$CHECKBOX_JPEG.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_JPEG.Name               = "checkBox3"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_JPEG)


# CHECKBOX_PSD
$CHECKBOX_PSD.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_PSD.Size               = $System_Drawing_Size
$CHECKBOX_PSD.TabIndex           = 1
$CHECKBOX_PSD.Text               = ".psd"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 70
$CHECKBOX_PSD.Location           = $System_Drawing_Point
$CHECKBOX_PSD.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_PSD.Name               = "checkBox4"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_PSD)


# CHECKBOX_MP4
$CHECKBOX_MP4.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_MP4.Size               = $System_Drawing_Size
$CHECKBOX_MP4.TabIndex           = 1
$CHECKBOX_MP4.Text               = ".mp4"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 90
$CHECKBOX_MP4.Location           = $System_Drawing_Point
$CHECKBOX_MP4.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_MP4.Name               = "checkBox5"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_MP4)


# CHECKBOX_HTML
$CHECKBOX_HTML.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_HTML.Size               = $System_Drawing_Size
$CHECKBOX_HTML.TabIndex           = 1
$CHECKBOX_HTML.Text               = ".html"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 110
$CHECKBOX_HTML.Location           = $System_Drawing_Point
$CHECKBOX_HTML.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_HTML.Name               = "checkBox6"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_HTML)


# CHECKBOX_CSS
$CHECKBOX_CSS.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_CSS.Size               = $System_Drawing_Size
$CHECKBOX_CSS.TabIndex           = 1
$CHECKBOX_CSS.Text               = ".css"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 130
$CHECKBOX_CSS.Location           = $System_Drawing_Point
$CHECKBOX_CSS.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_CSS.Name               = "checkBox7"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_CSS)


# CHECKBOX_JS
$CHECKBOX_JS.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_JS.Size               = $System_Drawing_Size
$CHECKBOX_JS.TabIndex           = 1
$CHECKBOX_JS.Text               = ".js"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 150
$CHECKBOX_JS.Location           = $System_Drawing_Point
$CHECKBOX_JS.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_JS.Name               = "checkBox8"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_JS)


# CHECKBOX_PDF
$CHECKBOX_PDF.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_PDF.Size               = $System_Drawing_Size
$CHECKBOX_PDF.TabIndex           = 1
$CHECKBOX_PDF.Text               = ".pdf"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 170
$CHECKBOX_PDF.Location           = $System_Drawing_Point
$CHECKBOX_PDF.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_PDF.Name               = "checkBox9"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_PDF)


# CHECKBOX_AI
$CHECKBOX_AI.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_AI.Size               = $System_Drawing_Size
$CHECKBOX_AI.TabIndex           = 1
$CHECKBOX_AI.Text               = ".ai"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 190
$CHECKBOX_AI.Location           = $System_Drawing_Point
$CHECKBOX_AI.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_AI.Name               = "checkBox10"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_AI)


# CHECKBOX_ID
$CHECKBOX_ID.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_ID.Size               = $System_Drawing_Size
$CHECKBOX_ID.TabIndex           = 1
$CHECKBOX_ID.Text               = ".id"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 210
$CHECKBOX_ID.Location           = $System_Drawing_Point
$CHECKBOX_ID.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_ID.Name               = "checkBox11"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_ID)


# CHECKBOX_PHP
$CHECKBOX_PHP.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_PHP.Size               = $System_Drawing_Size
$CHECKBOX_PHP.TabIndex           = 1
$CHECKBOX_PHP.Text               = ".php"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 230
$CHECKBOX_PHP.Location           = $System_Drawing_Point
$CHECKBOX_PHP.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_PHP.Name               = "checkBox12"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_PHP)


# CHECKBOX_TIFF
$CHECKBOX_TIFF.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_TIFF.Size               = $System_Drawing_Size
$CHECKBOX_TIFF.TabIndex           = 1
$CHECKBOX_TIFF.Text               = ".tiff"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 250
$CHECKBOX_TIFF.Location           = $System_Drawing_Point
$CHECKBOX_TIFF.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_TIFF.Name               = "checkBox13"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_TIFF)


# CHECKBOX_GIF
$CHECKBOX_GIF.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_GIF.Size               = $System_Drawing_Size
$CHECKBOX_GIF.TabIndex           = 1
$CHECKBOX_GIF.Text               = ".gif"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 270
$CHECKBOX_GIF.Location           = $System_Drawing_Point
$CHECKBOX_GIF.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_GIF.Name               = "checkBox13"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_GIF)


# CHECKBOX_EPS
$CHECKBOX_EPS.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_EPS.Size               = $System_Drawing_Size
$CHECKBOX_EPS.TabIndex           = 1
$CHECKBOX_EPS.Text               = ".eps"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 290
$CHECKBOX_EPS.Location           = $System_Drawing_Point
$CHECKBOX_EPS.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_EPS.Name               = "checkBox15"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_EPS)


# CHECKBOX_DOC
$CHECKBOX_DOC.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_DOC.Size               = $System_Drawing_Size
$CHECKBOX_DOC.TabIndex           = 1
$CHECKBOX_DOC.Text               = ".doc"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 310
$CHECKBOX_DOC.Location           = $System_Drawing_Point
$CHECKBOX_DOC.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_DOC.Name               = "checkBox16"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_DOC)


# CHECKBOX_XLS
$CHECKBOX_XLS.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_XLS.Size               = $System_Drawing_Size
$CHECKBOX_XLS.TabIndex           = 1
$CHECKBOX_XLS.Text               = ".xls"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 330
$CHECKBOX_XLS.Location           = $System_Drawing_Point
$CHECKBOX_XLS.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_XLS.Name               = "checkBox17"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_XLS)


# CHECKBOX_PPT
$CHECKBOX_PPT.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_PPT.Size               = $System_Drawing_Size
$CHECKBOX_PPT.TabIndex           = 1
$CHECKBOX_PPT.Text               = ".ppt"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 350
$CHECKBOX_PPT.Location           = $System_Drawing_Point
$CHECKBOX_PPT.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_PPT.Name               = "checkBox18"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_PPT)


# CHECKBOX_OGG
$CHECKBOX_OGG.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_OGG.Size               = $System_Drawing_Size
$CHECKBOX_OGG.TabIndex           = 1
$CHECKBOX_OGG.Text               = ".ogg"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 370
$CHECKBOX_OGG.Location           = $System_Drawing_Point
$CHECKBOX_OGG.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_OGG.Name               = "checkBox19"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_OGG)


# CHECKBOX_WAV
$CHECKBOX_WAV.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_WAV.Size               = $System_Drawing_Size
$CHECKBOX_WAV.TabIndex           = 1
$CHECKBOX_WAV.Text               = ".wav"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 390
$CHECKBOX_WAV.Location           = $System_Drawing_Point
$CHECKBOX_WAV.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_WAV.Name               = "checkBox20"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_WAV)


# CHECKBOX_MP3
$CHECKBOX_MP3.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_MP3.Size               = $System_Drawing_Size
$CHECKBOX_MP3.TabIndex           = 1
$CHECKBOX_MP3.Text               = ".mp3"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 410
$CHECKBOX_MP3.Location           = $System_Drawing_Point
$CHECKBOX_MP3.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_MP3.Name               = "checkBox21"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_MP3)


# CHECKBOX_MID
$CHECKBOX_MID.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_MID.Size               = $System_Drawing_Size
$CHECKBOX_MID.TabIndex           = 1
$CHECKBOX_MID.Text               = ".mid"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 430
$CHECKBOX_MID.Location           = $System_Drawing_Point
$CHECKBOX_MID.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_MID.Name               = "checkBox22"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_MID)


# CHECKBOX_ZIP
$CHECKBOX_ZIP.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_ZIP.Size               = $System_Drawing_Size
$CHECKBOX_ZIP.TabIndex           = 1
$CHECKBOX_ZIP.Text               = ".zip"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 450
$CHECKBOX_ZIP.Location           = $System_Drawing_Point
$CHECKBOX_ZIP.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_ZIP.Name               = "checkBox23"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_ZIP)


# CHECKBOX_AVI
$CHECKBOX_AVI.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_AVI.Size               = $System_Drawing_Size
$CHECKBOX_AVI.TabIndex           = 1
$CHECKBOX_AVI.Text               = ".avi"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 470
$CHECKBOX_AVI.Location           = $System_Drawing_Point
$CHECKBOX_AVI.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_AVI.Name               = "checkBox24"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_AVI)


# CHECKBOX_FLV
$CHECKBOX_FLV.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_FLV.Size               = $System_Drawing_Size
$CHECKBOX_FLV.TabIndex           = 1
$CHECKBOX_FLV.Text               = ".flv"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 490
$CHECKBOX_FLV.Location           = $System_Drawing_Point
$CHECKBOX_FLV.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_FLV.Name               = "checkBox25"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_FLV)


# CHECKBOX_WMV
$CHECKBOX_WMV.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_WMV.Size               = $System_Drawing_Size
$CHECKBOX_WMV.TabIndex           = 1
$CHECKBOX_WMV.Text               = ".wmv"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 510
$CHECKBOX_WMV.Location           = $System_Drawing_Point
$CHECKBOX_WMV.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_WMV.Name               = "checkBox26"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_WMV)


# CHECKBOX_MOV
$CHECKBOX_MOV.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_MOV.Size               = $System_Drawing_Size
$CHECKBOX_MOV.TabIndex           = 1
$CHECKBOX_MOV.Text               = ".mov"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 530
$CHECKBOX_MOV.Location           = $System_Drawing_Point
$CHECKBOX_MOV.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_MOV.Name               = "checkBox27"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_MOV)

# CHECKBOX_MPG
$CHECKBOX_MPG.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_MPG.Size               = $System_Drawing_Size
$CHECKBOX_MPG.TabIndex           = 1
$CHECKBOX_MPG.Text               = ".mpg"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 550
$CHECKBOX_MPG.Location           = $System_Drawing_Point
$CHECKBOX_MPG.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_MPG.Name               = "checkBox28"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_MPG)


# CHECKBOX_XML
$CHECKBOX_XML.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_XML.Size               = $System_Drawing_Size
$CHECKBOX_XML.TabIndex           = 1
$CHECKBOX_XML.Text               = ".xml"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 570
$CHECKBOX_XML.Location           = $System_Drawing_Point
$CHECKBOX_XML.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_XML.Name               = "checkBox28"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_XML)


# CHECKBOX_FLA
$CHECKBOX_FLA.UseVisualStyleBackColor = $True
$System_Drawing_Size             = New-Object System.Drawing.Size
$System_Drawing_Size.Width       = 104
$System_Drawing_Size.Height      = 24
$CHECKBOX_FLA.Size               = $System_Drawing_Size
$CHECKBOX_FLA.TabIndex           = 1
$CHECKBOX_FLA.Text               = ".fla"
$System_Drawing_Point            = New-Object System.Drawing.Point
$System_Drawing_Point.X          = 10
$System_Drawing_Point.Y          = 590
$CHECKBOX_FLA.Location           = $System_Drawing_Point
$CHECKBOX_FLA.DataBindings.DefaultDataSourceUpdateMode = 0
$CHECKBOX_FLA.Name               = "checkBox29"
$CLEANDESKTOP_EXTENSIONS_PAGE.Controls.Add($CHECKBOX_FLA)

# add the checkbox to the array that we created earlier
$Script:GUIFormObjectList += $CHECKBOX_FLA


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

$CLEANDESKTOP_MAIN_PAGE.Controls.Add($DESKTOPITEMCOUNT)


# add a progress bar
$MAIN_PAGE_PROGRESSBAR = New-Object System.Windows.Forms.ProgressBar
$MAIN_PAGE_PROGRESSBAR.AutoSize = $true
$MAIN_PAGE_PROGRESSBAR.Name = "PowerShellProgressBar"
$MAIN_PAGE_PROGRESSBAR.Value = 0
$MAIN_PAGE_PROGRESSBAR.Visible = $false
$MAIN_PAGE_PROGRESSBAR.Anchor = "left,right, top"
$MAIN_PAGE_PROGRESSBAR.Style="Continuous"
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.Controls.Add($MAIN_PAGE_PROGRESSBAR)
$CLEANDESKTOP_MAIN_PAGE_TABLE_LAYOUT_PANEL.SetColumnSpan($MAIN_PAGE_PROGRESSBAR, 2)


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

# update the desktop item count on form creation
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


function Show-TextBox-DesktopLocation {
    # create filebrowser object and initial directory should be desktop, 
    $FileBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property ${
        InitialDirectory = [Environment]::GetFolderPath('Desktop')
    }

    $OpenDialog = $FileBrowser.ShowDialog()
    if ($OpenDialog -eq "OK") {
        $DestinationFolder = $FileBrowser.SelectedPath
        # set the textbox text to the selected path
        $CLEANDESKTOP_MAIN_PAGE_TEXTBOX.Text = $DestinationFolder
    }

    if (![string]::IsNullOrEmpty($CLEANDESKTOP_MAIN_PAGE_TEXTBOX.Text)) {
        $CLEANDESKTOP_MAIN_PAGE_MOVE_BUTTON.Enabled = $true
    }
}


function Move-DesktopFiles {
    # function to move the files to the selected folder

    # set progressbar to visible
    $MAIN_PAGE_PROGRESSBAR.Visible = $true

    # get sum of total files on the desktop
    $TotalFiles = Get-DesktopItemCount

    $DesktopLocation = Get-DesktopLocation
    $DestinationPath = $CLEANDESKTOP_MAIN_PAGE_TEXTBOX.Text

    $Result = Get-ChildItem -Path $DesktopLocation -File
    Write-Host $Result
    # set counter to 0
	$Counter = 0

    Get-ChildItem -Path $DesktopLocation -File |
    ForEach-Object {
        # get full name of the files (path+filename) and then move the files
        Move-Item -Path $_.FullName -Destination $DestinationPath
    }

	ForEach ($File In $Result) {
		# calculate the percentage
		$Counter++
		[Int]$Percentage = ($Counter/$Result.Count)*100
		$MAIN_PAGE_PROGRESSBAR.Value = $Percentage
		Start-Sleep -Milliseconds 50
        # get full name of the files (path+filename) and then move the files
	}

    # finally update the desktop item count
    Update-DesktopItemCount
}


# add controls
$CLEANDESKTOP.controls.AddRange(@($TabControl))


# show the gui
[void]$CLEANDESKTOP.ShowDialog()


# after closing the program, dispose of it
$CLEANDESKTOP.Dispose()