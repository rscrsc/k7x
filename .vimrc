" === PairIn: Save one arrowkey hit when pairing ===
" Function to check for specific sequences and move the cursor
function! MoveCursorIfPair()
    let cursor_position = getcurpos()[2] - 1  " Get current cursor position (0-indexed)
    let last_inserted = getline('.')
    let char_before = (cursor_position > 0) ? strpart(last_inserted, cursor_position - 1, 1) : ''
    let second_last_char = (cursor_position > 1) ? strpart(last_inserted, cursor_position - 2, 1) : ''

    " Check for pairs
    if (char_before == ')' && second_last_char == '(') || (char_before == '"' && second_last_char == '"') || (char_before == '`' && second_last_char == '`') || (char_before == ']' && second_last_char == '[') || (char_before == '’' && second_last_char == '‘') || (char_before == '}' && second_last_char == '{')
        return "\<Left>"  " Move cursor left
    endif

    return ''
endfunction

" Create an autocmd that triggers the function on TextChangedI
augroup InsertPairs
    autocmd!
    autocmd TextChangedI * if (MoveCursorIfPair() != '') | execute "normal! " . MoveCursorIfPair() | endif
augroup END

" My Mappings
nmap oo o<Esc>k  " insert a newline below

" MISC
set noautoindent
set nosmartindent
set nocindent
set indentexpr=
filetype indent off
syntax off
set expandtab
set tabstop=4
set shiftwidth=4
highlight MatchParen ctermfg=cyan ctermbg=none
"set ignorecase " for searching
"set smartcase
"set autowrite
set timeoutlen=100  " for non-delayed O
