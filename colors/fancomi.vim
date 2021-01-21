highlight clear
if exists('syntax_on')
  syntax reset
endif

let s:has_termguicolors = (has('termguicolors') && &termguicolors) || has('gui_running')

let s:is_dark = &background == 'dark'

" ---------------------------------- Palette ----------------------------------

let s:palette = {}

" TODO: Support ascii color
if s:is_dark

    " Dark
    " background
    let s:palette.black = {'gui': '#00173A', 'cterm': '237'}
    let s:palette.bg0   = {'gui': '#000A19', 'cterm': '232'}
    let s:palette.bg1   = {'gui': '#00122C', 'cterm': '233'}
    let s:palette.bg2   = {'gui': '#001C45', 'cterm': '233'}
    let s:palette.bg3   = {'gui': '#00255E', 'cterm': '234'}
    let s:palette.bg4   = {'gui': '#003380', 'cterm': '234'}

    " Diff
    let s:palette.diff_red   = {'gui': '#801D75', 'cterm': '0'}
    let s:palette.diff_green = {'gui': '#618041', 'cterm': '0'}
    let s:palette.diff_blue  = {'gui': '#1D3580', 'cterm': '0'}

    " foreground
    let s:palette.fg          = {'gui': '#C8C6B7', 'cterm': '187'}
    let s:palette.red         = {'gui': '#C20706', 'cterm': '160'}
    let s:palette.red_light   = {'gui': '#C23F3E', 'cterm': '167'}
    let s:palette.green       = {'gui': '#80AA31', 'cterm': '70'}
    let s:palette.green_light = {'gui': '#8DAA55', 'cterm': '106'}
    let s:palette.orange      = {'gui': '#DB8B33', 'cterm': '172'}
    let s:palette.yellow      = {'gui': '#D9A45A', 'cterm': '178'}
    let s:palette.blue        = {'gui': '#4169AE', 'cterm': '25'}
    let s:palette.sky_blue    = {'gui': '#4DC8FF', 'cterm': '45'}
    let s:palette.cyan        = {'gui': '#41AEB4', 'cterm': '73'}
    let s:palette.grey        = {'gui': '#434C59', 'cterm': '239'}
    let s:palette.none        = {'gui': 'NONE',    'cterm': 'NONE'}

else

    " Light
    " background
    let s:palette.black = {'gui': '#00173A', 'cterm': '240'}
    let s:palette.bg0   = {'gui': '#F5EFDE', 'cterm': '255'}
    let s:palette.bg1   = {'gui': '#E2DCCD', 'cterm': '254'}
    let s:palette.bg2   = {'gui': '#CBC6B8', 'cterm': '254'}
    let s:palette.bg3   = {'gui': '#B5B0A4', 'cterm': '253'}
    let s:palette.bg4   = {'gui': '#969288', 'cterm': '253'}

    " Diff
    let s:palette.diff_red   = {'gui': '#D435C9', 'cterm': '0'}
    let s:palette.diff_green = {'gui': '#9BD330', 'cterm': '0'}
    let s:palette.diff_blue  = {'gui': '#3555D4', 'cterm': '0'}

    " foreground
    let s:palette.fg          = {'gui': '#33373C', 'cterm': '237'}
    let s:palette.red         = {'gui': '#C20706', 'cterm': '160'}
    let s:palette.red_light   = {'gui': '#C23F3E', 'cterm': '167'}
    let s:palette.green       = {'gui': '#6D912A', 'cterm': '28'}
    let s:palette.green_light = {'gui': '#678136', 'cterm': '64'}
    let s:palette.orange      = {'gui': '#F69000', 'cterm': '172'}
    let s:palette.yellow      = {'gui': '#D49845', 'cterm': '179'}
    let s:palette.blue        = {'gui': '#134C97', 'cterm': '25'}
    let s:palette.sky_blue    = {'gui': '#3B9AC4', 'cterm': '31'}
    let s:palette.cyan        = {'gui': '#38979C', 'cterm': '73'}
    let s:palette.grey        = {'gui': '#434C59', 'cterm': '239'}
    let s:palette.none        = {'gui': 'NONE',    'cterm': 'NONE'}

endif

" ---------------------------------- Highlight ---------------------------------

" Change palette
if s:has_termguicolors
    let s:p = map(s:palette,  's:palette[v:key]["gui"]')

    function! s:HL(group, fg, bg, ...)
        let hl_str = 'highlight ' . a:group . ' guifg=' . a:fg . ' guibg=' . a:bg
        if a:0 == 2
            let hl_str = hl_str . ' gui=' . a:1 . ' cterm=' . a:1 . ' guisp=' . a:2
        elseif a:0 == 1
            let hl_str = hl_str . ' gui=' . a:1 . ' cterm=' . a:1
        else
            let hl_str = hl_str . ' gui=NONE' . ' cterm=NONE'
        endif
        exec hl_str
    endfunction
else
    let s:p = map(s:palette, 's:palette[v:key]["cterm"]')

    function! s:HL(group, fg, bg, ...)
        let hl_str = 'highlight ' . a:group . ' ctermfg=' . a:fg . ' ctermbg=' . a:bg
        if a:0 == 1
            if a:1 ==# 'undercurl'
                let hl_str = hl_str . ' cterm=underline'
            else
                let hl_str = hl_str . ' cterm=' . a:1
            endif
        else
            let hl_str = hl_str . ' cterm=NONE'
        endif
        exec hl_str
    endfunction
endif

" TODO: Toggle transparery
call s:HL('Normal',      s:p.fg,   s:p.bg0)
call s:HL('Terminal',    s:p.fg,   s:p.bg0)
call s:HL('EndOfBuffer', s:p.bg0,  s:p.bg0)
call s:HL('FoldColumn',  s:p.grey, s:p.bg1)
call s:HL('Folded',      s:p.grey, s:p.bg1)
call s:HL('SignColumn',  s:p.fg,   s:p.bg0)
call s:HL('ToolbarLine', s:p.fg,   s:p.bg2)
call s:HL('Conseal',     s:p.grey, s:p.none)

call s:HL('Cursor', s:p.none, s:p.none, 'reverse')

highlight! link vCursor  Cursor
highlight! link iCursor  Cursor
highlight! link lCursor  Cursor
highlight! link CursorIM Cursor

call s:HL('ColorColumn',  s:p.none,   s:p.bg1)
call s:HL('CursorColumn', s:p.none,   s:p.bg1)
call s:HL('CursorLine',   s:p.none,   s:p.bg1)
call s:HL('LineNr',       s:p.bg3,    s:p.none)
call s:HL('CursorLineNr', s:p.orange, s:p.bg1)

call s:HL('Directory',  s:p.blue,     s:p.none)
call s:HL('DiffAdd',    s:p.none,     s:p.diff_green) " FIXME: not yet
call s:HL('DiffChange', s:p.none,     s:p.diff_blue) " FIXME: not yet
call s:HL('DiffDelete', s:p.none,     s:p.diff_red) " FIXME: not yet
call s:HL('DiffText',   s:p.none,     s:p.none, 'reverse') " FIXME: not yet
call s:HL('ErrorMsg',   s:p.red,      s:p.none, 'bold,underline')
call s:HL('WarningMsg', s:p.orange,   s:p.none, 'bold')
call s:HL('ModeMsg',    s:p.fg,       s:p.none, 'bold')
call s:HL('MoreMsg',    s:p.blue,     s:p.none, 'bold')
call s:HL('IncSearch',  s:p.bg0,      s:p.red_light)
call s:HL('Search',     s:p.bg0,      s:p.orange)
call s:HL('MatchParen', s:p.sky_blue, s:p.none, 'underline')
call s:HL('NonText',    s:p.blue,     s:p.none)
call s:HL('Whitespace', s:p.blue,     s:p.none)
call s:HL('SpecialKey', s:p.blue,     s:p.none)

if s:is_dark
    call s:HL('Pmenu',      s:p.fg,   s:p.bg2)
    call s:HL('PmenuSbar',  s:p.fg,   s:p.bg2)
    call s:HL('PmenuSel',   s:p.bg0,  s:p.sky_blue)
    call s:HL('WildMenu',   s:p.bg0,  s:p.sky_blue)
    call s:HL('PmenuThumb', s:p.none, s:p.fg)
else
    call s:HL('Pmenu',      s:p.fg,   s:p.bg2)
    call s:HL('PmenuSbar',  s:p.fg,   s:p.bg2)
    call s:HL('PmenuSel',   s:p.bg0,  s:p.blue)
    call s:HL('WildMenu',   s:p.bg0,  s:p.blue)
    call s:HL('PmenuThumb', s:p.none, s:p.bg4)
endif

call s:HL('Question',         s:p.orange, s:p.none)
call s:HL('SpellBad',         s:p.red,    s:p.none, 'undercurl', s:p.red)
call s:HL('SpellCap',         s:p.orange, s:p.none, 'undercurl', s:p.orange)
call s:HL('SpellLocal',       s:p.blue,   s:p.none, 'undercurl', s:p.blue)
call s:HL('SpellRare',        s:p.blue,   s:p.none, 'undercurl', s:p.blue)
call s:HL('StatusLine',       s:p.fg,     s:p.bg3)
call s:HL('StatusLineTerm',   s:p.fg,     s:p.bg3)
call s:HL('StatusLineNC',     s:p.fg,     s:p.bg1)
call s:HL('StatusLineTermNC', s:p.fg,     s:p.bg1)
call s:HL('TabLine',          s:p.fg,     s:p.bg4)
call s:HL('TabLineFill',      s:p.fg,     s:p.bg1)
call s:HL('TabLineSel',       s:p.fg,     s:p.bg0)
call s:HL('VertSplit',        s:p.bg3,    s:p.none)
call s:HL('Visual',           s:p.none,   s:p.bg2)
call s:HL('VisualNOS',        s:p.none,   s:p.bg2,  'underline')
call s:HL('QuickFixLine',     s:p.blue,   s:p.none, 'bold')
call s:HL('Debug',            s:p.orange, s:p.none)
call s:HL('DebugPC',          s:p.bg0,    s:p.green)
call s:HL('DebugBreakPoint',  s:p.bg0,    s:p.red)
call s:HL('ToolbarButton',    s:p.bg0,    s:p.blue)

" TODO: toggle enable/disable italic
call s:HL('Type',         s:p.blue,     s:p.none, 'italic')
call s:HL('Structure',    s:p.blue,     s:p.none, 'italic')
call s:HL('StorageClass', s:p.blue,     s:p.none, 'italic')
call s:HL('Identifier',   s:p.sky_blue, s:p.none, 'italic')
call s:HL('Constant',     s:p.sky_blue, s:p.none, 'italic')

call s:HL('PreProc',     s:p.yellow,      s:p.none)
call s:HL('PreCondit',   s:p.yellow,      s:p.none)
call s:HL('PreInclude',  s:p.yellow,      s:p.none)
call s:HL('Keyword',     s:p.yellow,      s:p.none)
call s:HL('Define',      s:p.yellow,      s:p.none)
call s:HL('Typedef',     s:p.yellow,      s:p.none)
call s:HL('Exception',   s:p.yellow,      s:p.none)
call s:HL('Conditional', s:p.yellow,      s:p.none)
call s:HL('Repeat',      s:p.yellow,      s:p.none)
call s:HL('Statement',   s:p.yellow,      s:p.none)
call s:HL('Macro',       s:p.sky_blue,    s:p.none)
call s:HL('Error',       s:p.red,         s:p.none)
call s:HL('Label',       s:p.sky_blue,    s:p.none)
call s:HL('Special',     s:p.sky_blue,    s:p.none)
call s:HL('SpecialChar', s:p.sky_blue,    s:p.none)
call s:HL('Boolean',     s:p.sky_blue,    s:p.none)
call s:HL('String',      s:p.green_light, s:p.none)
call s:HL('Character',   s:p.green_light, s:p.none)
call s:HL('Number',      s:p.sky_blue,    s:p.none)
call s:HL('Float',       s:p.sky_blue,    s:p.none)
call s:HL('Function',    s:p.cyan,        s:p.none)
call s:HL('Operator',    s:p.red_light,   s:p.none)
call s:HL('Title',       s:p.red_light,   s:p.none, 'bold')
call s:HL('Tag',         s:p.orange,      s:p.none)
call s:HL('Delimiter',   s:p.fg,          s:p.none)

" TODO: toggle enable/disable italic
call s:HL('Comment',        s:p.grey,   s:p.none, 'italic')
call s:HL('SpecialComment', s:p.grey,   s:p.none, 'italic')
call s:HL('Todo',           s:p.orange, s:p.none, 'bold,italic')

call s:HL('Ignore',     s:p.grey, s:p.none)
call s:HL('Underlined', s:p.none, s:p.none, 'underline')

" Generic color
call s:HL('Fg',      s:p.fg,        s:p.none)
call s:HL('Grey',    s:p.grey,      s:p.none)
call s:HL('Red',     s:p.red_light, s:p.none)
call s:HL('Orange',  s:p.orange,    s:p.none)
call s:HL('Yellow',  s:p.yellow,    s:p.none)
call s:HL('Green',   s:p.green,     s:p.none)
call s:HL('Cyan',    s:p.cyan,      s:p.none)
call s:HL('Blue',    s:p.blue,      s:p.none)
call s:HL('SkyBlue', s:p.sky_blue,  s:p.none)

" TODO: toggle enable/disable italic
call s:HL('RedItalic',    s:p.red_light, s:p.none, 'italic')
call s:HL('BlueItalic',   s:p.blue,      s:p.none, 'italic')
call s:HL('OrangeItalic', s:p.orange,    s:p.none, 'italic')

" ------------------------------- TODO Terminal --------------------------------

if s:has_termguicolors
    let s:terminal = {
        \ 'black':    s:p.black,
        \ 'red':      s:p.red,
        \ 'yellow':   s:p.yellow,
        \ 'green':    s:p.green,
        \ 'cyan':     s:p.cyan,
        \ 'blue':     s:p.blue,
        \ 'sky_blue': s:p.sky_blue,
        \ 'white':    s:p.fg,
        \ }
    if !has('nvim')
        let g:terminal_ansi_colors = [s:terminal.black, s:terminal.red, s:terminal.green, s:terminal.yellow,
          \ s:terminal.blue, s:terminal.sky_blue, s:terminal.cyan, s:terminal.white, s:terminal.black, s:terminal.red,
          \ s:terminal.green, s:terminal.yellow, s:terminal.blue, s:terminal.sky_blue, s:terminal.cyan, s:terminal.white]
    else
        let g:terminal_color_0  = s:terminal.black
        let g:terminal_color_1  = s:terminal.red
        let g:terminal_color_2  = s:terminal.green
        let g:terminal_color_3  = s:terminal.yellow
        let g:terminal_color_4  = s:terminal.blue
        let g:terminal_color_5  = s:terminal.sky_blue
        let g:terminal_color_6  = s:terminal.cyan
        let g:terminal_color_7  = s:terminal.white
        let g:terminal_color_8  = s:terminal.black
        let g:terminal_color_9  = s:terminal.red
        let g:terminal_color_10 = s:terminal.green
        let g:terminal_color_11 = s:terminal.yellow
        let g:terminal_color_12 = s:terminal.blue
        let g:terminal_color_13 = s:terminal.sky_blue
        let g:terminal_color_14 = s:terminal.cyan
        let g:terminal_color_15 = s:terminal.white
    endif
endif

" ---------------------------------- Markdown ----------------------------------

call s:HL('markdownH1',              s:p.red,      s:p.none, 'bold')
call s:HL('markdownH2',              s:p.orange,   s:p.none, 'bold')
call s:HL('markdownH3',              s:p.yellow,   s:p.none, 'bold')
call s:HL('markdownH4',              s:p.green,    s:p.none, 'bold')
call s:HL('markdownH5',              s:p.blue,     s:p.none, 'bold')
call s:HL('markdownH6',              s:p.sky_blue, s:p.none, 'bold')
call s:HL('markdownUrl',             s:p.blue,     s:p.none, 'underline')
call s:HL('markdownItalic',          s:p.none,     s:p.none, 'italic')
call s:HL('markdownBold',            s:p.none,     s:p.none, 'bold')
call s:HL('markdownItalicDelimiter', s:p.grey,     s:p.none, 'italic')

highlight! link markdownCode              Green
highlight! link markdownCodeBlock         Green
highlight! link markdownCodeDelimiter     Green
highlight! link markdownBlockquote        Grey
highlight! link markdownListMarker        Red
highlight! link markdownOrderedListMarker Red
highlight! link markdownRule              SkyBlue
highlight! link markdownHeadingRule       Grey
highlight! link markdownUrlDelimiter      Grey
highlight! link markdownLinkDelimiter     Grey
highlight! link markdownLinkTextDelimiter Grey
highlight! link markdownHeadingDelimiter  Grey
highlight! link markdownLinkText          Red
highlight! link markdownUrlTitleDelimiter Green
highlight! link markdownIdDeclaration     markdownLinkText
highlight! link markdownBoldDelimiter     Grey
highlight! link markdownId                Yellow

" ------------------------------------ HTML ------------------------------------

call s:HL('htmlH1',                  s:p.red,      s:p.none, 'bold')
call s:HL('htmlH2',                  s:p.orange,   s:p.none, 'bold')
call s:HL('htmlH3',                  s:p.yellow,   s:p.none, 'bold')
call s:HL('htmlH4',                  s:p.green,    s:p.none, 'bold')
call s:HL('htmlH5',                  s:p.blue,     s:p.none, 'bold')
call s:HL('htmlH6',                  s:p.sky_blue, s:p.none, 'bold')
call s:HL('htmlLink',                s:p.blue,     s:p.none, 'underline')
call s:HL('htmlBold',                s:p.none,     s:p.none, 'bold')
call s:HL('htmlBoldUnderline',       s:p.none,     s:p.none, 'bold,underline')
call s:HL('htmlBoldItalic',          s:p.none,     s:p.none, 'bold,italic')
call s:HL('htmlBoldUnderlineItalic', s:p.none,     s:p.none, 'bold,underline,italic')
call s:HL('htmlUnderline',           s:p.none,     s:p.none, 'underline')
call s:HL('htmlUnderlineItalic',     s:p.none,     s:p.none, 'underline,italic')
call s:HL('htmlItalic',              s:p.none,     s:p.none, 'italic')

highlight! link htmlTag            Green
highlight! link htmlEndTag         Blue
highlight! link htmlTagN           RedItalic
highlight! link htmlTagName        RedItalic
highlight! link htmlArg            Blue
highlight! link htmlScriptTag      SkyBlue
highlight! link htmlSpecialTagName RedItalic
highlight! link htmlString         Green

" ----------------------------------- Scala ------------------------------------

highlight! link scalaNameDefinition        Fg
highlight! link scalaInterpolationBoundary SkyBlue
highlight! link scalaInterpolation         SkyBlue
highlight! link scalaTypeOperator          Red
highlight! link scalaOperator              Red
highlight! link scalaKeywordModifier       Red

" ------------------------------------ Vim ------------------------------------

highlight! link vimLet            Blue
highlight! link vimFunction       Green
highlight! link vimIsCommand      Fg
highlight! link vimUserFunc       Cyan
highlight! link vimFuncName       Cyan
highlight! link vimMap            BlueItalic
highlight! link vimNotation       SkyBlue
highlight! link vimMapLhs         Green
highlight! link vimMapRhs         Green
highlight! link vimSetEqual       BlueItalic
highlight! link vimSetSep         Fg
highlight! link vimOption         BlueItalic
highlight! link vimUserAttrbKey   BlueItalic
highlight! link vimUserAttrb      Green
highlight! link vimAutoCmdSfxList Orange
highlight! link vimSynType        Orange
highlight! link vimHiBang         Orange
highlight! link vimSet            BlueItalic
highlight! link vimSetSep         Grey

" --------------------------------- gitgutter ----------------------------------

highlight! link GitGutterAdd          Green
highlight! link GitGutterChange       Orange
highlight! link GitGutterDelete       Red
highlight! link GitGutterChangeDelete SkyBlue

" ---------------------------------- NERDTree ----------------------------------

highlight! link NERDTreeOpenable Green
highlight! link NERDTreeClosable Green
highlight! link NERDTreeUp       Blue
highlight! link NERDTreeDir      Blue
highlight! link NERDTreeFile     Fg
highlight! link NERDTreeDirSlash SkyBlue

" ---------------------------------- coc.nvim ----------------------------------

call s:HL('CocHighlightText', s:p.none,      s:p.none, 'underline')
call s:HL('CocHoverRange',    s:p.none,      s:p.none, 'bold,underline')
call s:HL('CocHintHighlight', s:p.none,      s:p.none, 'underline', s:p.green)
call s:HL('CocErrorFloat',    s:p.red_light, s:p.bg2)
call s:HL('CocWarningFloat',  s:p.yellow,    s:p.bg2)
call s:HL('CocInfoFloat',     s:p.blue,      s:p.bg2)
call s:HL('CocHintFloat',     s:p.green,     s:p.bg2)
call s:HL('CocHintSign',      s:p.sky_blue,  s:p.bg1)

" --------------------------------- easymotion ---------------------------------

highlight! link EasyMotionTarget Search
highlight! link EasyMotionShade  Grey

" ------------------------------ vim-visual-multi ------------------------------

let g:VM_Mono_hl   = 'Cursor'
let g:VM_Extend_hl = 'Visual'
let g:VM_Cursor_hl = 'Cursor'
let g:VM_Insert_hl = 'Cursor'

" ----------------------------- Yggdroot/indentLine ----------------------------

if s:has_termguicolors
    let g:indentLine_color_gui = s:p.grey
else
    " TODO: Support ascii color
    " let g:indentLine_color_term = s:palette.grey
endif

" vim: set ts=4 sts=4 sw=4 et :
