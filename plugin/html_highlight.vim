" setup a few variables
if !exists('g:html_theme')
  let g:html_theme = 'bipolar'
end
if !exists('g:html_font')
  let g:html_font = 'Menlo'
end
if !exists('g:html_size')
  let g:html_size = '24'
end

function! HtmlHighlight(line1,line2,...)
  if !executable('highlight')
    echoerr "Bummer! highlight not found."
    return
  endif

  let content = join(getline(a:line1,a:line2),"\n")
  let command = "highlight --syntax " . a:1 . " -s " . g:html_theme . " -Ohtml -k --include_style " . g:html_font . " -K " . g:html_size
  let output = system(command,content)
  " let @* = output
  " for some reason text copied this way
  " gets pasted as escaped plain text in keynote
  " but this works well with pbcopy
  let retval = system("pbcopy",output)
endfunction

" map it to a command
command! -nargs=1 -range=% HtmlHighlight :call HtmlHighlight(<line1>,<line2>,<f-args>)
