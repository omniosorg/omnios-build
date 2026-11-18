" Vim syntax file
" Language:	PKG(7) package manifest
" Maintainer:	sa@omnios.org
" Last Change:	2021 November 10

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shared

syn keyword p5m_todo contained
  \ XXX TODO WIP

syn match p5m_comment "#.*" contains=p5m_todo

syn region p5m_string start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline
syn region p5m_string start=+'+ skip=+\\\\\|\\'+ end=+'+ oneline

syn region p5m_token start=/\v\$\(/ end=/\v\)/ oneline
syn region p5m_token start=/\v\%\</ end=/\v\>/ oneline
syn region p5m_token start=/\v\%\(/ end=/\v\)/ oneline

hi def link p5m_todo		Todo
hi def link p5m_comment		Comment
hi def link p5m_string		String
hi def link p5m_token		Macro

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" actions

syn match p5ma_nl "\\\n\s*" contained nextgroup=p5ma_attr skipwhite
syn match p5ma_nl1 "\\\n\s*" contained nextgroup=p5ma_lit,p5ma_attr skipwhite

syn match p5ma_attr contained nextgroup=p5ma_val /\<algorithm=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<alias=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<arch=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<category=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<chash=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<class=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<clone_perms=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<com\.oracle\.[^=]*=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<dehydrate=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<desc=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<devlink=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<elfarch=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<elfbits=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<elfhash=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<facet.[^=]*=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<fmri=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<ftpuser=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<gcos-field=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<gid=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<group=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<groupname=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<home-dir=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<hotline=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<license=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<login-shell=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<mediator=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val
  \ /\<mediator-implementation=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<mediator-priority=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<mediator-version=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<mode=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<mountpoint=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<must-display=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<name=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<original_name=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<overlay=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<owner=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<password=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<path=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<perms=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<pkg=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<pkg\.content-hash=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<pkg\.csize=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<pkg\.linted=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<pkg\.size=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<policy=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<predicate=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<preserve=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<reboot-needed=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<refresh_fmri=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<release-note=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<restart_fmri=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<target=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<timestamp=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<type=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<uid=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<user=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<username=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<value=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<variant\.[^=]*=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<vendor=/he=e-1
syn match p5ma_attr contained nextgroup=p5ma_val /\<version=/he=e-1

syn match p5ma_val /\v\S+/
  \ contained
  \ contains=p5m_string,p5m_token
  \ nextgroup=p5ma_attr,p5ma_nl
  \ skipwhite

syn match p5ma_lit /\v[^[:space:]=\\]+(\s|$)@=/
  \ contained
  \ contains=p5m_string,p5m_token
  \ nextgroup=p5ma_attr,p5ma_nl
  \ skipwhite

syn match p5ma /\v^\s*(\$\([^)]+\))?\s*<(depend|dir|driver|group|hardlink|legacy|link|set|signature|user)>/
  \ contains=p5m_token
  \ nextgroup=p5ma_attr,p5ma_nl
  \ skipwhite

syn match p5ma /\v^\s*(\$\([^)]+\))?\s*<(file|license)>/
  \ contains=p5m_token
  \ nextgroup=p5ma_lit,p5ma_attr,p5ma_nl1
  \ skipwhite

hi def link p5ma		Keyword
hi def link p5ma_lit		Normal
hi def link p5ma_attr		Type
hi def link p5ma_val		Normal

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" transforms

syn match p5mx_nl "\s*\\\n\s*" contained
  \ nextgroup=p5mx_cond,p5mx_implies,p5mx_action
  \ skipwhite

syn match p5mx /\v\s*\<transform\s/hs=s+1,he=e-1
  \ nextgroup=p5mx_cond,p5mx_implies
  \ skipwhite

syn keyword p5mx_cond contained
  \ nextgroup=p5mx_cond,p5mx_implies,p5mx_nl
  \ file dir link hardlink
  \ depend driver group legacy set signature user
  \ skipwhite
syn match p5mx_cond contained /\v\w+\=/he=e-1
  \ nextgroup=p5mx_path
syn match p5mx_path /\v\S+/
  \ contained
  \ nextgroup=p5mx_cond,p5mx_implies,p5mx_nl
  \ contains=p5m_string,p5m_token
  \ skipwhite

syn match p5mx_implies /\v-\>/
  \ contained
  \ nextgroup=p5mx_action,p5mx_nl
  \ skipwhite

syn keyword p5mx_action contained
  \ add default delete drop edit emit exit print set
  \ nextgroup=p5mx_attr,p5mx_end
  \ skipwhite

syn match p5mx_attr /\v\S+/
  \ contained
  \ contains=p5m_token
  \ nextgroup=p5mx_val
  \ skipwhite

syn match p5mx_val /\v[a-z0-9\.]+/
  \ contained
  \ contains=p5m_token,p5m_string
  \ nextgroup=p5mx_end,p5mx_val
  \ skipwhite

syn match p5mx_end /\v>\>/
  \ contained

hi def link p5mx		Keyword
hi def link p5mx_cond		Type
hi def link p5mx_path		Normal
hi def link p5mx_implies	Keyword
hi def link p5mx_action		Keyword
hi def link p5mx_attr		Type
hi def link p5mx_val		Normal
hi def link p5mx_end		Normal

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" include

syn match p5mi /\v\s*\<include\s/hs=s+1,he=e-1
  \ nextgroup=p5mi_path,p5mi_end
  \ skipwhite

syn match p5mi_path /\v\S+/
  \ contained
  \ nextgroup=p5mi_end
  \ contains=p5m_string,p5m_token
  \ skipwhite

syn match p5mi_end /\v>\>/
  \ contained

hi def link p5mi		Keyword
hi def link p5mi_path		Normal
hi def link p5mi_end		Normal

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:current_syntax = "p5m"

