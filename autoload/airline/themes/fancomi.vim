let g:airline#themes#fancomi#palette = {}

" TODO: Support ascii color
if &background ==# 'dark'
  let s:foreground      = { 'gui': '#EBE6D8', 'cterm': 187 }
  let s:background      = { 'gui': '#000A19', 'cterm': 232 }
  let s:background_alt  = { 'gui': '#00122C', 'cterm': 233 }
  let s:background_grey = { 'gui': '#434C59', 'cterm': 234 }
  let s:red             = { 'gui': '#C23F3E', 'cterm': 167 }
  let s:yellow          = { 'gui': '#F1AD4E', 'cterm': 178 }
  let s:green           = { 'gui': '#8DAA55', 'cterm': 106 }
  let s:blue            = { 'gui': '#4169AE', 'cterm': 25 }
  let s:sky_blue        = { 'gui': '#4DC8FF', 'cterm': 45 }
elseif &background ==# 'light'
  let s:foreground      = { 'gui': '#33373C', 'cterm': 237 }
  let s:background      = { 'gui': '#E2DCCD', 'cterm': 255 }
  let s:background_alt  = { 'gui': '#CBC6B8', 'cterm': 254 }
  let s:background_grey = { 'gui': '#B5B0A4', 'cterm': 253 }
  let s:red             = { 'gui': '#C23F3E', 'cterm': 167 }
  let s:yellow          = { 'gui': '#D49845', 'cterm': 179 }
  let s:green           = { 'gui': '#6D912A', 'cterm': 64 }
  let s:blue            = { 'gui': '#134C97', 'cterm': 25 }
  let s:sky_blue        = { 'gui': '#3B9AC4', 'cterm': 31 }
endif

function! s:generate_airline_palette(mode)
  return [ a:mode[0].gui, a:mode[1].gui, a:mode[0].cterm, a:mode[1].cterm ]
endfunction

function! s:generate_airline_theme(mode)
  let airline_palette = s:generate_airline_palette(a:mode)
  return airline#themes#generate_color_map(airline_palette, s:info, s:statusline)
endfunction

let s:normal   = [ s:background, s:blue ]
let s:insert   = [ s:background, s:green ]
let s:visual   = [ s:background, s:yellow ]
let s:replace  = [ s:background, s:sky_blue ]
let s:inactive = [ s:foreground, s:background_grey ]

let s:info       = s:generate_airline_palette([ s:foreground, s:background_grey ])
let s:statusline = s:generate_airline_palette([ s:foreground, s:background_alt ])

let g:airline#themes#fancomi#palette.normal   = s:generate_airline_theme(s:normal)
let g:airline#themes#fancomi#palette.insert   = s:generate_airline_theme(s:insert)
let g:airline#themes#fancomi#palette.visual   = s:generate_airline_theme(s:visual)
let g:airline#themes#fancomi#palette.replace  = s:generate_airline_theme(s:replace)
let g:airline#themes#fancomi#palette.inactive = s:generate_airline_theme(s:inactive)
