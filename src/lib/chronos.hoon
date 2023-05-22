/+  re=regex
!:
|%
++  da2ju
  |=  =@da  ^-  @sd
  =,  si
  =/  date  (yore da)
  =/  y=@sd  (sun y.date)
  =/  m=@sd  (sun m.date)
  =/  d=@sd  (sun d.t.date)
  ;:  sum
    (fra (pro --1.461 :(sum y --4.800 (fra (sum m -14) --12))) --4)
    (fra (pro --367 :(sum m -2 (pro -12 (fra (sum m -14) --12)))) --12)
    (fra (pro -3 (fra :(sum y --4.900 (fra (sum m -14) --12)) --100)) --4)
    d
    -32.075
  ==
::
++  ju2da
  |=  =@sd  ^-  @da
  =,  si
  :: f = J + 1401 + (((4 × J + 274277) ÷ 146097) × 3) ÷ 4 - 38
  =/  f  ;:  sum
           sd
           --1.401
           (fra (pro (fra (sum (pro --4 sd) --274.277) --146.097) --3) --4)
           -38
         ==
  :: e = 4 × f + 3
  =/  e  (sum (pro --4 f) --3)
  :: g = mod(e, 1461) ÷ 4
  =/  g  (fra (mod e --1.461) --4)
  :: h = 5 × g + 2
  =/  h  (sum (pro --5 g) --2)
  :: D = (mod(h, 153)) ÷ 5 + 1
  =/  dy  (sum (fra (mod h --153) --5) --1)
  :: M = mod(h ÷ 153 + 2, 12) + 1
  =/  mn  (sum (mod (sum (fra h --153) --2) --12) --1)
  :: Y = (e ÷ p) - y + (n + m - M) ÷ n
  =/  yr  (sum (dif (fra e --1.461) --4.716) (fra (sum --12 (dif --2 mn)) --12))
  =/  dy=@ud  (div dy 2)
  =/  mn=@ud  (div mn 2)
  =/  yr=@ud  (div yr 2)
  (year [[a=(gth yr --0) yr] mn [dy 0 0 0 ~]])
::
::  ISO 8601-1:2019/Amd 1:2022 dates can assume the following forms:
::
::   1. YYYY            2000
::   2. ±YYYY           +2000
::   3. YYYY-MM-DD      2000-01-01
::   4. YYYY-MM         2000-01
::   5. YYYYMMDD        20000101
::   6. YYYY-Www        2000-W01, 2000-W1
::   7. YYYYWww         2000W01, 2000W1
::   8. YYYY-Www-D      2000-W01-1, 2000-W1-1
::   9. YYYYWwwD        2000W011
::  10. YYYY-DDD        2000-001, 2000-1
::  11. YYYYDDD         2000001, 2000001
::
::  There is more flexibility in the standard around dropping leading zeroes
::  but we'll leave that out here for manageable regex.
::
::  Times subsume even more attention, but have a `T` prefix that nicely sets
::  things off for our parser if a date is present first.
::
::  12. Thh:mm:ss.sss
::  13. Thhmmss.sss
::  14. Thh:mm:ss
::  15. Thhmmss
::  16. Thh:mm
::  17. Thhmm
::  18. Thh
::
::  `@da` is more general than ISO 8601, so there are definitely edge cases.
::  I suggest not using ISO 8601 for dates in the Dune universe or Hyborian Age.
::  We also do not handle Z+5 time zone markers here, saving that for %l10n.
::
::  We will simply handle cases in order:  if it is not a year alone, then it
::  is a year and a month or week, etc.  Ambiguity is not possible in the
::  current standard, so we simply disallow v2000-style YYMMDD and so forth.
::
++  iso-re  '^([\\+-]?\\d{4}(?!\\d{2}\\b))((-?)((0[1-9]|1[0-2])(\\3([12]\\d|0[1-9]|3[01]))?|W([0-4]\\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\\d|[12]\\d{2}|3([0-5]\\d|6[1-6])))([T\\s]((([01]\\d|2[0-3])((:?)[0-5]\\d)?|24\\:?00)([\\.,]\\d+(?!:))?)?(\\17[0-5]\\d([\\.,]\\d+)?)?([zZ]|([\\+-])([01]\\d|2[0-3]):?([0-5]\\d)?)?)?)?$'
++  iso-re-date  '^([\\+-]?\\d{4}(?!\\d{2}\\b))((-?)((0[1-9]|1[0-2])(\\3([12]\\d|0[1-9]|3[01]))?|W([0-4]\\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\\d|[12]\\d{2}|3([0-5]\\d|6[1-6])))?)?$'
++  iso-re-time  '^((([01]\\d|2[0-3])((:?)[0-5]\\d)?|24\\:?00)([\\.,]\\d+(?!:))?)?(\\17[0-5]\\d([\\.,]\\d+)?)?$'
::
++  iso-valid
  |=  dat=cord
  ?~((is:re (trip dat) (trip iso-re)) %.y %.n)
::
::  Parse date
::
++  iso-date
  |=  dat=tape  ^-  @da
  ?~  dat  *@da
  ?~  (is:re (trip '^([\\+-]?\\d{4}(?!\\d{2}\\b))$') dat)
    :: 1. YYYY or 2. ±YYYY
    :: In this case, all we have is a year identifier, so the easiest thing to
    :: do is just interpolate it into text and send it to `@da`.  Probably not
    :: the fastest, but def. the easiest.
    `@da`(slav %da (crip :(weld "~" dat ".1.1")))
  ?~  (is:re (trip '^([\\+-]?\\d{4}(?!\\d{2}\\b))(-)(0[1-9]|1[0-2])$') dat)
    :: 4. YYYY-MM
    =/  len   (lent dat)
    =/  yyyy  (scag 4 `tape`dat)
    =/  mm    (slag (sub len ?:(=("0" i.dat) 1 2)) `tape`dat)
    `@da`(slav %da (crip :(weld "~" yyyy "." mm ".1")))
  ?~  (is:re (trip '^([\\+-]?\\d{4}(?!\\d{2}\\b))(-?)(0[1-9]|1[0-2])(\\3([12]\\d|0[1-9]|3[01]))?|W([0-4]\\d|5[0-2])$') dat)
    :: 6. YYYY-Www or 7. YYYYWww
    :: ISO week dates start from the week containing January 4, so they're a bit
    :: wonky to calculate.
    =/  len   (lent dat)
    =/  yyyy  (scag 4 `tape`dat)
    =/  ww    (slag (sub len ?:(=("0" i.dat) 1 2)) `tape`dat)
    =/  dd    5  :: TODO
    !!
    ::`@da`(slav %da (crip :(weld "~" yyyy "." mm ".1")))
  ~&  >  [`tape`dat (is:re (trip '^([\\+-]?\\d{4}(?!\\d{2}\\b))((-?)((0[1-9]|1[0-2])(\\3([12]\\d|0[1-9]|3[01]))?|3([0-5]\\d|6[1-6])))$') dat)]
  ?~  (is:re (trip '^([\\+-]?\\d{4}(?!\\d{2}\\b))((-?)((0[1-9]|1[0-2])(\\3([12]\\d|0[1-9]|3[01]))?|3([0-5]\\d|6[1-6])))$') dat)
    :: 3. YYYY-MM-DD or 5. YYYYMMDD
    =/  len   (lent dat)
    =/  yyyy  (scag 4 `tape`dat)
    =/  mt    (scag ?:(=((lent dat) 8) 6 7) `tape`dat)
    =/  m0y   =('0' (snag (sub (lent mt) 2) mt))
    =/  mm    ?~(mt "0" (slag (sub (lent mt) ?:(m0y 1 2)) `tape`mt))
    =/  dd    (slag (sub len ?:(=("0" i.dat) 1 2)) `tape`dat)
    `@da`(slav %da (crip :(weld "~" yyyy "." mm "." dd)))
  ?~  (is:re (trip '^([\\+-]?\\d{4}(?!\\d{2}\\b))((-?)((0[1-9]|1[0-2])(\\3([12]\\d|0[1-9]|3[01]))?|3([0-5]\\d|6[1-6])))$') dat)
    :: 8. YYYY-Www-D or 9. YYYYWwwD
    :: ISO week dates start from the week containing January 4, so they're a bit
    :: wonky to calculate.
    =/  len   (lent dat)
    =/  yyyy  (scag 4 `tape`dat)
    =/  ww    (slag (sub len ?:(=("0" i.dat) 1 2)) `tape`dat)
    =/  dd    5  ::TODO
    !!
    ::`@da`(slav %da (crip :(weld "~" yyyy "." mm ".1")))
  ?~  (is:re (trip '^([\\+-]?\\d{4}(?!\\d{2}\\b))((-?)((\\3([12]\\d|0[1-9]|3[01]))?|(00[1-9]|0[1-9]\\d|[12]\\d{2}|3([0-5]\\d|6[1-6])))?)?$') dat)
    :: 10. YYYY-DDD or 11. YYYYDDD
    :: For this one, we use the funny property of `@da` that it just corrects
    :: month overflows.
    =/  len   (lent dat)
    =/  yyyy  (scag 4 `tape`dat)
    =/  dd    (scow %ud (scan (slag 3 `tape`dat) dum:ag))
    `@da`(slav %da (crip :(weld "~" yyyy ".1." dd)))
  ~&  >  date+dat
  !!
::
::  Parse time
::
++  iso-time
  |=  tim=tape  ^-  @dr
  ?~  tim  `@dr`0
  ?~  (is:re (trip '^([01]\\d|2[0-4])$') tim)
    ::  18. hh
    (slav %dr (crip :(weld "~h" ?:(=("0" i.tim) t.tim tim))))
  ?~  (is:re (trip '^(([01]\\d|2[0-3])((:?)[0-5]\\d)?|24\\:?00)$') tim)
    :: 16. hh:mm or 17. hhmm
    =/  len   (lent tim)
    =/  hh  (scag 2 `tape`tim)
    =/  mm  (slag (sub len 2) `tape`tim)
    (slav %dr (crip :(weld "~h" hh ".m" mm)))
  ?~  (is:re (trip '^(([01]\\d|2[0-3])((:?)[0-5]\\d)?|24\\:?00)((:?)[0-5]\\d)$') tim)
    :: 14. hh:mm:ss or 15. hhmmss
    =/  len   (lent tim)
    =/  hh  (scag 2 `tape`tim)
    =/  mm  (slag 2 (scag ?:(=((lent tim) 6) 4 5) `tape`tim))
    =/  ss  (slag (sub len 2) `tape`tim)
    (slav %dr (crip :(weld "~h" hh ".m" mm ".s" ss)))
  ?~  (is:re (trip '^((([01]\\d|2[0-3])((:?)[0-5]\\d)?|24\\:?00)((:?)[0-5]\\d)([\\.,]\\d+(?!:))?)?$') tim)
    :: 12. hh:mm:ss.sss or 13. hhmmss.sss
    =/  hh  (scag 2 `tape`tim)
    =/  mm  (slag 2 (scag ?:(=((lent tim) 6) 4 5) `tape`tim))
    =/  ss  (slag 2 `tape`tim)
    (slav %dr (crip :(weld "~h" hh ".m" mm ".s" ss)))
  ~&  >  time+tim
  !!
::
++  iso2da
  |=  =tape  ::^-  @da
  ::  There are three cases:  date w/o time, date w/ time, and time alone.
  ::  We will split the string up if both are present.
  |^
  =+  [dat tim]=(split-iso tape)
  ~&  >>  iso+[dat tim]
  (add (iso-date dat) (iso-time tim))
  ++  split-iso
    |=  =^tape
    =/  idx  (find "T" tape)
    ?~  idx
      ::  No timestamp is present so either this is date w/o time or time alone.
      ?~  (is:re (trip iso-re-date) tape)  [tape ~]
      ?~  (is:re (trip iso-re-time) tape)  [~ tape]
      [tape ~]  :: the date can fall through
    [(scag (need (find "T" tape)) tape) (slag +((need (find "T" tape))) tape)]
  --
::
++  da2iso  !!
++  ju2iso  !!
++  iso2ju  !!
  
--
