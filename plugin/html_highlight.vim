" setup a few variables
if !exists('g:html_theme')
  let g:html_theme = 'Zellner'
end
if !exists('g:html_font')
  let g:html_font = 'Menlo'
end
if !exists('g:html_size')
  let g:html_size = '12'
end

function! HtmlHighlight(line1,line2,...)
  if !executable('highlight')
    echoerr "Bummer! highlight not found."
    return
  endif

  let my_filetype = &filetype

  let content = join(getline(a:line1,a:line2),"\n")
  let filename = tempname() . ".md"

  new
  setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
  let firstline = '```' . my_filetype
  put=firstline
  put=content
  put='```'
  execute 'w' fnameescape(filename)
  q

  execute 'silent !open -a "Google Chrome"' filename
endfunction

" map it to a command
command! -nargs=0 -range=% HtmlHighlight :call HtmlHighlight(<line1>,<line2>,<f-args>)
