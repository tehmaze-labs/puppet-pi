(* /boot/cmdline.txt module for Augeas *)

module Boot_Cmdline =
  autoload xfm

  let word = /[^ \n\t]+/
  let cmdline = [ seq "cmdline" . Util.indent .
    [ label "parameter" . store  word ] .
  	[ label "parameter" . Sep.space . store word ]*
  . Util.eol ]

  let lns = cmdline

  let xfm = transform lns (incl "/boot/cmdline.txt")
