"
" AutoGit.vim
"
" An assistant script for automating my most common git process.
"

function RunAutoGit(dir, ...)
    let message=""
    for s in a:000
        let message=message . " " . s
    endfor
    execute "silent !python ~/.vim/plugin/AutoGit/AutoGit.py " . a:dir . " '" . message . "'"
    execute "redraw!"
endfunction

com -nargs=* AutoGit call RunAutoGit(getcwd(), <f-args>)

