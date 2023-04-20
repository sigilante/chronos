  ::  ISO 8601 Test Cases
::::
::
/+  *test,
    chronos,
    regex
|%
::++  test-regex
::  ;:  weld
::  (valid:regex (crip "/^([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\3([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24\:?00)([\.,]\d+(?!:))?)?(\17[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$/"))
++  test-iso-8601
  ;:  weld
  %+  expect-eq
    !>  ~2009.1.12..12.34.00
    !>  (iso2da:chronos '2009-12T12:34')
  %+  expect-eq
    !>  ~2009.1.1
    !>  (iso2da:chronos '2009')
  %+  expect-eq
    !>  ~2009.5.19
    !>  (iso2da:chronos '2009-05-19')
  %+  expect-eq
    !>  ~2009.5.19
    !>  (iso2da:chronos '20090519')
  %+  expect-eq
    !>  ~2009.5.3
    !>  (iso2da:chronos '2009123')
  %+  expect-eq
    !>  ~2009.5.1
    !>  (iso2da:chronos '2009-05')
  %+  expect-eq
    !>  ~2009.5.3
    !>  (iso2da:chronos '2009-123')
  %+  expect-eq
    !>  ~2009.8.10
    !>  (iso2da:chronos '2009-222')
  %+  expect-eq
    !>  ~2009.1.1
    !>  (iso2da:chronos '2009-001')
  %+  expect-eq
    !>  !!
    !>  (iso2da:chronos '2009-W01-1')
  %+  expect-eq
    !>  !!
    !>  (iso2da:chronos '2009-W51-1')
  %+  expect-eq
    !>  !!
    !>  (iso2da:chronos '2009-W511')
  %+  expect-eq
    !>  !!
    !>  (iso2da:chronos '2009-W33')
  %+  expect-eq
    !>  !!
    !>  (iso2da:chronos '2009W511')
  %+  expect-eq
    !>  ~2009.5.19
    !>  (iso2da:chronos '2009-05-19')
  %+  expect-eq
    !>  ~2009.5.19
    !>  (iso2da:chronos '2009-05-19 00:00')
  %+  expect-eq
    !>  ~2009.5.19..14.00.00
    !>  (iso2da:chronos '2009-05-19 14')
  %+  expect-eq
    !>  ~2009.5.19..14.31.00
    !>  (iso2da:chronos '2009-05-19 14:31')
  %+  expect-eq
    !>  ~2009.5.19..14.39.22
    !>  (iso2da:chronos '2009-05-19 14:39:22')
  %+  expect-eq
    !>  ~2009.5.19..14.39.00
    !>  (iso2da:chronos '2009-05-19T14:39Z')
  %+  expect-eq
    !>  !!
    !>  (iso2da:chronos '2009-W21-2')
  %+  expect-eq
    !>  !!
    !>  (iso2da:chronos '2009-W21-2T01:22')
  %+  expect-eq
    !>  ~2009.5.19
    !>  (iso2da:chronos '2009-139')
  %+  expect-eq
    !>  ~2009.5.19..08.39.22
    !>  (iso2da:chronos '2009-05-19 14:39:22-06:00')
  %+  expect-eq
    !>  ~2009.5.19..20.39.22
    !>  (iso2da:chronos '2009-05-19 14:39:22+0600')
  %+  expect-eq
    !>  ~2009.5.19..13.39.22
    !>  (iso2da:chronos '2009-05-19 14:39:22-01')
  %+  expect-eq
    !>  ~2009.6.21..01.45.00
    !>  (iso2da:chronos '20090621T0545Z')
  %+  expect-eq
    !>  ~2007.4.6
    !>  (iso2da:chronos '2007-04-06T00:00')
  %+  expect-eq
    !>  ~2007.4.6
    !>  (iso2da:chronos '2007-04-05T24:00')
  %+  expect-eq
    !>  ~2010.2.18..16.23.48..8000
    !>  (iso2da:chronos '2010-02-18T16:23:48.5')
  %+  expect-eq
    !>  ~2010.2.18..16.23.48..71a9
    !>  (iso2da:chronos '2010-02-18T16:23:48,444')
  %+  expect-eq
    !>  ~2010.2.18..10.23.48..4ccc
    !>  (iso2da:chronos '2010-02-18T16:23:48,3-06:00')
  %+  expect-eq
    !>  ~2010.2.18..16.23.48..6666
    !>  (iso2da:chronos '2010-02-18T16:23.4')
  %+  expect-eq
    !>  ~2010.2.18..16.23.48..4000
    !>  (iso2da:chronos '2010-02-18T16:23,25')
  %+  expect-eq
    !>  ~2010.2.18..10.23.48..547a
    !>  (iso2da:chronos '2010-02-18T16:23.33+0600')
  %+  expect-eq
    !>  ~2010.2.18..10.23.48..3bbc
    !>  (iso2da:chronos '2010-02-18T16.23334444')
  %-  expect-fail
    |.  (iso2da:chronos '200905')
  %-  expect-fail
    |.  (iso2da:chronos '2009367')
  %-  expect-fail
    |.  (iso2da:chronos '2009-')
  %-  expect-fail
    |.  (iso2da:chronos '200905')
  %-  expect-fail
    |.  (iso2da:chronos '2007-04-05T24:50')
  %-  expect-fail
    |.  (iso2da:chronos '2009-000')
  %-  expect-fail
    |.  (iso2da:chronos '2009-M511')
  %-  expect-fail
    |.  (iso2da:chronos '2009M511')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-19T14a39r')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-19T14:3924')
  %-  expect-fail
    |.  (iso2da:chronos '2009-0519')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-1914:39')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-19 14:')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-19r14:39')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-19 14a39a22')
  %-  expect-fail
    |.  (iso2da:chronos '200912-01')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-19 14:39:22+06a00')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-19 146922.500')
  %-  expect-fail
    |.  (iso2da:chronos '2010-02-18T16.5:23.35:48')
  %-  expect-fail
    |.  (iso2da:chronos '2010-02-18T16:23.35:48')
  %-  expect-fail
    |.  (iso2da:chronos '2010-02-18T16:23.35:48.45')
  %-  expect-fail
    |.  (iso2da:chronos '2009-05-19 14.5.44')
  %-  expect-fail
    |.  (iso2da:chronos '2010-02-18T16:23.33.600')
  %-  expect-fail
    |.  (iso2da:chronos '2010-02-18T16,25:23:48,444')
  ==
--
