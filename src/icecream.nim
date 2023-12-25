when defined(js):
    import jsconsole

when not defined(js):
    import std/terminal
    
    proc green(body:string) = stdout.styledWriteLine(fgGreen, body)
    proc red(body:string)   = stdout.styledWriteLine(fgRed, body)
    proc blue(body:string)  = stdout.styledWriteLine(fgBlue, body)


template ic*(body: untyped): untyped = 
    when defined(ic):
        when defined(js):
            console.trace body
        when not defined(js):
            let info = instantiationInfo(fullPaths = true)
            let formatted_info = info.filename & ":" & $info.line
            green(formatted_info & ": " & body & "\n")

template icr*(body: untyped): untyped =
    when defined(ic):
        when defined(js):
            console.error body
        when not defined(js): 
            let info = instantiationInfo(fullPaths = true)
            let formatted_info = info.filename & ":" & $info.line
            red(formatted_info & ": " & body & "\n")

template icb*(body: untyped): untyped =
    when defined(ic):
        when defined(js):
            discard 
        when not defined(js): 
            let info = instantiationInfo(fullPaths = true)
            let formatted_info = info.filename & ":" & $info.line
            blue(formatted_info & ": " & body & "\n")
