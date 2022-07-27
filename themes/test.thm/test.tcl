source [file join [file dirname [info script]] test-theme dark.tcl]

proc set_theme {mode} {
    if {$mode == "dark"} {
        ttk::style theme use "test-dark"

        

        
        

        
    }
}