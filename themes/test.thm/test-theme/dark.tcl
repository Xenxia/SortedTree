ttk::style theme create test-dark -parent clam -settings {

        proc load_images {imgdir} {
            variable I
            foreach file [glob -directory $imgdir *.png] {
                set img [file tail [file rootname $file]]
                set I($img) [image create photo -file $file -format png]
            }
        }

        load_images [file join [file dirname [info script]] dark]

        # Global Color

        array set colors {
            -fg             "#ffffff"
            -bg             "#000000"
            -disabledfg     "#ffffff"
            -disabledbg     "#737373"
            -selectfg       "#ffffff"
            -selectbg       "#000111"
        }

        #Global Config

        ttk::style configure . \
            -background $colors(-bg) \
            -foreground $colors(-fg) \
            -troughcolor $colors(-bg) \
            -focuscolor $colors(-selectbg) \
            -selectbackground $colors(-selectbg) \
            -selectforeground $colors(-selectfg) \
            -insertcolor $colors(-fg) \
            -insertwidth 1 \
            -fieldbackground $colors(-selectbg) \
            -font {"Segoe Ui" 10} \
            -borderwidth 1 \
            -relief flat
        
        

        tk_setPalette background [ttk::style lookup . -background] \
            foreground [ttk::style lookup . -foreground] \
            highlightColor [ttk::style lookup . -focuscolor] \
            selectBackground [ttk::style lookup . -selectbackground] \
            selectForeground [ttk::style lookup . -selectforeground] \
            activeBackground [ttk::style lookup . -selectbackground] \
            activeForeground [ttk::style lookup . -selectforeground]

        ttk::style map . -foreground [list disabled $colors(-disabledfg)]

        option add *font [ttk::style lookup . -font]
        option add *Menu.selectcolor $colors(-fg)

        ttk::style configure Sash -gripcount 0

        # ============================================================================

        # Button
        ttk::style configure TButton -width -10 -anchor center

        ttk::style map TButton \
            -background [list disabled $colors(-disabledbg)  active #333333] \
            -foreground [list disabled $colors(-disabledfg)] \
            -relief [list {pressed !disabled} flat]

        # Button no bg
        ttk::style configure nobg.TButton -width -10 -anchor center

        ttk::style map nobg.TButton \
            -background [list disabled $colors(-bg)  active $colors(-bg)] \
            -foreground [list disabled $colors(-fg)] \
            -relief [list {pressed !disabled} flat]

        # LabelFrame
        ttk::style element create Labelframe.border image $I(card2) \
            -border 5 -padding 4 -sticky news

        # Combobox
        ttk::style map TCombobox -selectbackground [list \
            {!focus} $colors(-selectbg) \
            {readonly hover} $colors(-selectbg) \
            {readonly focus} $colors(-selectbg) \
        ]
            
        ttk::style map TCombobox -selectforeground [list \
            {!focus} $colors(-selectfg) \
            {readonly hover} $colors(-selectfg) \
            {readonly focus} $colors(-selectfg) \
        ]

        ttk::style element create Combobox.field \
            image [list $I(box-basic) \
                {readonly disabled} $I(rect-basic) \
                {readonly pressed} $I(rect-basic) \
                {readonly focus hover} $I(button-hover) \
                {readonly focus} $I(button-hover) \
                {readonly hover} $I(button-hover) \
                {focus hover} $I(box-accent) \
                readonly $I(rect-basic) \
                invalid $I(box-invalid) \
                disabled $I(box-basic) \
                focus $I(box-accent) \
                hover $I(box-hover) \
            ] -border 2
            
        ttk::style element create Combobox.button \
            image [list $I(combo-button-basic) \
                 {!readonly focus} $I(combo-button-focus) \
                 {readonly focus} $I(combo-button-hover) \
                 {readonly hover} $I(combo-button-hover)
            ] -border 2

        ttk::style element create Combobox.arrow image $I(down) \
            -width 10 -sticky e

        ttk::style layout TCombobox {
            Combobox.field -sticky nswe -children {
                Combobox.padding -expand true -sticky nswe -children {
                    Combobox.textarea -sticky nswe
                }
            }
            Combobox.button -side right -sticky ns -children {
                Combobox.arrow -sticky nsew
            }
        }

}