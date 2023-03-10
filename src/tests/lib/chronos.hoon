# ISO 8601 Test Cases
/+  *test,
    chronos,
    regex
|%
++  test-regex
  ;:  weld
  (valid:regex '/^([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\3([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24\:?00)([\.,]\d+(?!:))?)?(\17[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$/')
++  test-iso-8601
  ;:  weld
  %+  expect-eq
    !>  ~2009.1.12..12.34.00
    !>  (iso2da:chronos '2009-12T12:34')

    !>  (iso2da:chronos '2009')
    !>  (iso2da:chronos '2009-05-19')
    !>  (iso2da:chronos '2009-05-19')
    !>  (iso2da:chronos '20090519')
    !>  (iso2da:chronos '2009123')
    !>  (iso2da:chronos '2009-05')
    !>  (iso2da:chronos '2009-123')
    !>  (iso2da:chronos '2009-222')
    !>  (iso2da:chronos '2009-001')
    !>  (iso2da:chronos '2009-W01-1')
    !>  (iso2da:chronos '2009-W51-1')
    !>  (iso2da:chronos '2009-W511')
    !>  (iso2da:chronos '2009-W33')
    !>  (iso2da:chronos '2009W511')
    !>  (iso2da:chronos '2009-05-19')
    !>  (iso2da:chronos '2009-05-19 00:00')
    !>  (iso2da:chronos '2009-05-19 14')
    !>  (iso2da:chronos '2009-05-19 14:31')
    !>  (iso2da:chronos '2009-05-19 14:39:22')
    !>  (iso2da:chronos '2009-05-19T14:39Z')
    !>  (iso2da:chronos '2009-W21-2')
    !>  (iso2da:chronos '2009-W21-2T01:22')
    !>  (iso2da:chronos '2009-139')
    !>  (iso2da:chronos '2009-05-19 14:39:22-06:00')
    !>  (iso2da:chronos '2009-05-19 14:39:22+0600')
    !>  (iso2da:chronos '2009-05-19 14:39:22-01')
    !>  (iso2da:chronos '20090621T0545Z')
    !>  (iso2da:chronos '2007-04-06T00:00')
    !>  (iso2da:chronos '2007-04-05T24:00')
    !>  (iso2da:chronos '2010-02-18T16:23:48.5')
    !>  (iso2da:chronos '2010-02-18T16:23:48,444')
    !>  (iso2da:chronos '2010-02-18T16:23:48,3-06:00')
    !>  (iso2da:chronos '2010-02-18T16:23.4')
    !>  (iso2da:chronos '2010-02-18T16:23,25')
    !>  (iso2da:chronos '2010-02-18T16:23.33+0600')
    !>  (iso2da:chronos '2010-02-18T16.23334444')
    !>  (iso2da:chronos '2010-02-18T16,2283')
    !>  (iso2da:chronos '2009-05-19 143922.500')
    !>  (iso2da:chronos '2009-05-19 1439,55'
  %+  expect-fail
200905
2009367
2009-
2007-04-05T24:50
2009-000
2009-M511
2009M511
2009-05-19T14a39r
2009-05-19T14:3924
2009-0519
2009-05-1914:39
2009-05-19 14:
2009-05-19r14:39
2009-05-19 14a39a22
200912-01
2009-05-19 14:39:22+06a00
2009-05-19 146922.500
2010-02-18T16.5:23.35:48
2010-02-18T16:23.35:48
2010-02-18T16:23.35:48.45
2009-05-19 14.5.44
2010-02-18T16:23.33.600
2010-02-18T16,25:23:48,444
  ==

  
  --
