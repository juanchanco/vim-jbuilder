" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match       jbError ")"
syn region      jbUnknown matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbOther,jbUnknown
syn region      jbUnknown matchgroup=Delimiter start="(\w\+"rs=s+1 matchgroup=Delimiter end=")" contains=jbOther,jbString,jbNumber,jbUnknown

syn region      jbVersionStx matchgroup=Delimiter start="(jbuild_version"rs=s+1 matchgroup=Delimiter end=")" contains=jbNumber,jbStansa,jbUnknown
syn region      jbOcamllexStz matchgroup=Delimiter start="(ocamllex"rs=s+1 matchgroup=Delimiter end=")" contains=jbTokenList,jbStansa,jbUnknown

syn region      jbLibraryStz matchgroup=Delimiter start="(library"rs=s+1 matchgroup=Delimiter end=")" contains=jbLibraryOptions,jbStansa,jbUnknown
syn region      jbLibraryOptions contained containedin=jbLibrary matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbLibraryOption,jbUnknown
syn region      jbLibraryOption contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbName,jbSynopsis,jbBuildOption,jbUnknown
syn region      jbExecutableStz matchgroup=Delimiter start="(executable"rs=s+1 matchgroup=Delimiter end=")" contains=jbExecutableOptions,jbStansa,jbUnknown
syn region      jbExecutableOptions contained containedin=jbExecutable matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbExecutableOption,jbUnknown
syn region      jbExecutableOption contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbName,jbSynopsis,jbBuildOption,jbUnknown
syn region      jbExecutablesStz matchgroup=Delimiter start="(executables"rs=s+1 matchgroup=Delimiter end=")" contains=jbExecutablesOptions,jbStansa,jbUnknown
syn region      jbExecutablesOptions contained containedin=jbExecutables matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbExecutablesOption,jbUnknown
syn region      jbExecutablesOption contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbPublic_names,jbNames,jbSynopsis,jbBuildOption,jbUnknown

syn region      jbTokenList contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbToken,jbUnknown
syn region      jbModuleList contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbToken,jbStandard,jbModule,jbUnknown
syn region      jbFlagList contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbStandard,jbFlag,jbToken,jbIncludeList,jbUnknown
syn region      jbIncludeList contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbInclude,jbUnknown
syn region      jbModeList contained matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=jbMode,jbUnknown


syn keyword     jbStansa contained jbuild_version library executable executables
syn keyword     jbStansa contained alias ocamllex


syn region      jbString matchgroup=String start=+"+ skip=+\\"+ end=+"+
syn match	jbOther	,[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
" why isn't "\w[\w-]*" working?
" TODO: different match for filenames
syn match       jbToken ,\w[0-9A-Za-z_\.-]*,
"syn match       jbTokens ,\w[0-9A-Za-z_\.-]*,
"syn match       jbTokens ,\w[0-9A-Za-z_\.-]*, nextgroup=jbTokens,jbToken skipwhite
syn match	jbNumber "[0-9]\+"
syn keyword	jbBoolean true false
syn keyword	jbMode byte native
syn keyword	jbKind normal ppx_rewriter ppx_deriver

syn match       jbStandard ":standard"hs=s+1
syn match       jbInclude "(\@<=:include"hs=s+1 nextgroup=jbToken skipwhite
syn match       jbFlag "-[0-9A-Za-z_-]\+"hs=s+1
syn match       jbFlag "--[0-9A-Za-z_-]\+"hs=s+2

syn match	jbName contained ,(\@<=name, nextgroup=jbToken skipwhite
syn match	jbName contained ,(\@<=public_name, nextgroup=jbToken skipwhite
syn match	jbNames contained ,(\@<=names, nextgroup=jbTokenList skipwhite
syn match	jbNames contained ,(\@<=public_names, nextgroup=jbTokenList skipwhite
syn match	jbSynopsis contained ,(\@<=synopsis, nextgroup=jbString skipwhite
"common (menhir)
syn match	jbBuildOption contained ,(\@<=flags, nextgroup=jbFlagList skipwhite
"common build
syn match	jbBuildOption contained ,(\@<=libraries, nextgroup=jbTokenList skipwhite 
syn match	jbBuildOption contained ,(\@<=modules, nextgroup=jbTokenList skipwhite
syn match	jbBuildOption contained ,(\@<=modes, nextgroup=jbModeList skipwhite
"syn match	jbBuildOption contained ,(\@<=preprocess, nextgroup=jbFlagList skipwhite
"syn match	jbBuildOption contained ,(\@<=preprocessor_deps, nextgroup=jbFlagList skipwhite
"syn match	jbBuildOption contained ,(\@<=js_of_ocaml, nextgroup=jbFlagList skipwhite

syn match	jbBuildOption contained ,(\@<=ocamlc_flags, nextgroup=jbFlagList skipwhite
syn match	jbBuildOption contained ,(\@<=ocampopt_flags, nextgroup=jbFlagList skipwhite

"library
syn match	jbBuildOption contained ,(\@<=wrapped, nextgroup=jbBoolean skipwhite
syn match	jbBuildOption contained ,(\@<=kind, nextgroup=jbKind skipwhite
syn match	jbBuildOption contained ,(\@<=optional\(\s*)\)\@=,
syn match	jbBuildOption contained ,(\@<=no_bynlink\(\s*)\)\@=,
syn match	jbBuildOption contained ,(\@<=ppx_runtime_librares, nextgroup=jbTokenList skipwhite
syn match	jbBuildOption contained ,(\@<=virtual_deps, nextgroup=jbTokenList skipwhite
syn match	jbBuildOption contained ,(\@<=self_build_stubs_archive, nextgroup=jbToken skipwhite

syn match	jbBuildOption contained ,(\@<=library_flags, nextgroup=jbFlagList skipwhite
syn match	jbBuildOption contained ,(\@<=c_flags, nextgroup=jbFlagList skipwhite
syn match	jbBuildOption contained ,(\@<=cxx_flags, nextgroup=jbFlagList skipwhite
syn match	jbBuildOption contained ,(\@<=c_library_flags, nextgroup=jbFlagList skipwhite
"TODO: filenames (without .c)
syn match	jbBuildOption contained ,(\@<=c_names, nextgroup=jbTokenList skipwhite
syn match	jbBuildOption contained ,(\@<=cxx_names, nextgroup=jbTokenList skipwhite
"TODO: filenames (with .h)
syn match	jbBuildOption contained ,(\@<=install_c_headers, nextgroup=jbTokenList skipwhite


"executable
syn match	jbBuildOption contained ,(\@<=link_flags, nextgroup=jbTokenList skipwhite
syn match	jbBuildOption contained ,(\@<=package, nextgroup=jbToken skipwhite
" stolen from the scheme syntax. is it appropriate?
" Synchronization and the wrapping up...
syn sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

hi def link jbStansa		Statement
hi def link jbOption	        Function
hi def link jbName              Function
hi def link jbNames             Function
hi def link jbSynopsis          Function
hi def link jbBuildOption       Function

hi def link jbString		String
hi def link jbCharacter	        Character
hi def link jbNumber		Number
hi def link jbBoolean		Boolean
hi def link jbMode		Boolean
hi def link jbKind		Boolean

hi def link jbDelimiter	        Delimiter
hi def link jbFlag		Type
hi def link jbStandard		Type
hi def link jbInclude		Type

hi def link jbError		Error

hi def link jbExtSyntax	        Type
hi def link jbToken		PreProc
"hi def link jbTokens		PreProc



let b:current_syntax = "jbuilder"

let &cpo = s:cpo_save
unlet s:cpo_save
