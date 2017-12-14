" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match       jbError ")"
syn region      jbUnknown matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbUnknown,jbOther
syn region      jbUnknown matchgroup=Delimiter start="(\w\+"rs=s+1 matchgroup=Delimiter end=")" contains=jbUnknown,jbOther,jbString,jbNumber

syn region      jbVersion matchgroup=Delimiter start="(jbuild_version"rs=s+1 matchgroup=Delimiter end=")" contains=jbNumber,jbStansa,jbUnknown

syn region      jbLibrary matchgroup=Delimiter start="(library"rs=s+1 matchgroup=Delimiter end=")" contains=jbLibraryOptions,jbStansa,jbUnknown
syn region      jbLibraryOptions contained containedin=jbLibrary matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbLibraryOption,jbUnknown
syn region      jbLibraryOption contained matchgroup=Delimiter start="("ms=s matchgroup=Delimiter end=")" contains=jbPublic_name,jbName,jbUnknown,jbSynopsis,jbLibraries,jbWrapped,jbFlags,jbModules
syn region      jbExecutable matchgroup=Delimiter start="(executable"rs=s+1 matchgroup=Delimiter end=")" contains=jbExecutableOptions,jbStansa,jbUnknown
syn region      jbExecutableOptions contained containedin=jbExecutable matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbExecutableOption,jbUnknown
syn region      jbExecutableOption contained matchgroup=Delimiter start="("ms=s matchgroup=Delimiter end=")" contains=jbPublic_name,jbName,jbUnknown,jbSynopsis,jbLibraries,jbWrapped,jbFlags,jbModules
syn region      jbExecutables matchgroup=Delimiter start="(executables"rs=s+1 matchgroup=Delimiter end=")" contains=jbExecutablesOptions,jbStansa,jbUnknown
syn region      jbExecutablesOptions contained containedin=jbExecutables matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbExecutablesOption,jbUnknown
syn region      jbExecutablesOption contained matchgroup=Delimiter start="("ms=s matchgroup=Delimiter end=")" contains=jbPublic_names,jbNames,jbUnknown,jbSynopsis,jbLibraries,jbWrapped,jbFlags,jbModules

syn region      jbList contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbToken,jbUnknown
syn region      jbFlagList contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbFlag,jbOcamlFlag,jbToken,jbUnknown,jbIncludeList
syn region      jbIncludeList contained matchgroup=Delimiter start="("ms=s matchgroup=Delimiter end=")" contains=jbInclude,jbUnknown


syn keyword     jbStansa contained jbuild_version library executable executables


syn region      jbString matchgroup=String start=+"+ skip=+\\"+ end=+"+
syn match	jbOther	,[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
" why isn't "\w[\w-]*" working?
syn match       jbToken ,\w[0-9A-Za-z_\.-]*,
"syn match       jbTokens ,\w[0-9A-Za-z_\.-]*,
"syn match       jbTokens ,\w[0-9A-Za-z_\.-]*, nextgroup=jbTokens,jbToken skipwhite
syn match	jbNumber "[0-9]\+"
syn keyword	jbBoolean true
syn keyword	jbBoolean false

syn match       jbFlag ":standard"hs=s+1
syn match       jbInclude "(\@<=:include"hs=s+1 nextgroup=jbToken skipwhite
syn match       jbOcamlFlag "-[0-9A-Za-z_-]\+"hs=s+1

syn match	jbName contained ,(\@<=name, nextgroup=jbToken skipwhite
syn match	jbPublic_name contained ,(\@<=public_name, nextgroup=jbToken skipwhite
syn match	jbNames contained ,(\@<=names, nextgroup=jbList skipwhite
syn match	jbPublic_names contained ,(\@<=public_names, nextgroup=jbList skipwhite
syn match	jbSynopsis contained ,(\@<=synopsis, nextgroup=jbString skipwhite
syn match	jbLibraries contained ,(\@<=libraries, nextgroup=jbList skipwhite
syn match	jbLibraries contained ,(\@<=c_names, nextgroup=jbList skipwhite
syn match	jbModules contained ,(\@<=c_names, nextgroup=jbList skipwhite
syn match	jbFlags contained ,(\@<=flags, nextgroup=jbFlagList skipwhite
syn match	jbFlags contained ,(\@<=c_flags, nextgroup=jbFlagList skipwhite
syn match	jbFlags contained ,(\@<=c_library_flags, nextgroup=jbFlagList skipwhite
syn match	jbWrapped contained ,(\@<=wrapped, nextgroup=jbBoolean skipwhite


" stolen from the scheme syntax. is it appropriate?
" Synchronization and the wrapping up...
syn sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

hi def link jbStansa		Statement
hi def link jbOption	        Function
hi def link jbPublic_name       Function
hi def link jbName              Function
hi def link jbPublic_names      Function
hi def link jbNames             Function
hi def link jbSynopsis          Function
hi def link jbLibraries         Function
hi def link jbWrapped           Function
hi def link jbFlags             Function
hi def link jbModules           Function

hi def link jbString		String
hi def link jbCharacter	        Character
hi def link jbNumber		Number
hi def link jbBoolean		Boolean

hi def link jbDelimiter	        Delimiter
hi def link jbOcamlFlag		Type
hi def link jbFlag		Type
hi def link jbInclude		Type

hi def link jbError		Error

hi def link jbExtSyntax	        Type
hi def link jbToken		PreProc
"hi def link jbTokens		PreProc



let b:current_syntax = "jbuilder"

let &cpo = s:cpo_save
unlet s:cpo_save
