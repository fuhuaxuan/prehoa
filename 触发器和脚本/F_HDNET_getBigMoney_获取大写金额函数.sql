CREATE OR REPLACE Function F_HDNET_getBigMoney(Money In Number) Return Varchar2 Is
  strMoney      Varchar2(150);
  strYuan       Varchar2(150);
  strYuanFen    Varchar2(152);
  numLenYuan    Number;
  numLenYuanFen Number;
  strRstYuan    Varchar2(600);
  strRstFen     Varchar2(200);
  strRst        Varchar2(800);
  Type typeTabMapping Is Table Of Varchar2(2) Index By Binary_Integer;
  tabNumMapping  typeTabMapping;
  tabUnitMapping typeTabMapping;
  numUnitIndex   Number;
  i              Number;
  j              Number;
  charCurrentNum Char(1);
Begin
  strMoney := Money;
  If Money Is Null Then
    Return Null;
  End If;
  if Money < 0 then
    strMoney := abs(Money);
  else
    strMoney := Money;
  end if;
  strYuan := TO_CHAR(FLOOR(strMoney));
  If strYuan = '0' Then
    numLenYuan := 0;
    strYuanFen := lpad(TO_CHAR(FLOOR(strMoney * 100)), 2, '0');
  Else
    numLenYuan := length(strYuan);
    strYuanFen := TO_CHAR(FLOOR(strMoney * 100));
  End If;
  If strYuanFen = '0' Then
    numLenYuanFen := 0;
  Else
    numLenYuanFen := length(strYuanFen);
  End If;
  If numLenYuan = 0 Or numLenYuanFen = 0 Then
    strRst := 'ÁãÔ²Õû';
    Return strRst;
  End If;
  tabNumMapping(0) := 'Áã';
  tabNumMapping(1) := 'Ò¼';
  tabNumMapping(2) := '·¡';
  tabNumMapping(3) := 'Èþ';
  tabNumMapping(4) := 'ËÁ';
  tabNumMapping(5) := 'Îé';
  tabNumMapping(6) := 'Â½';
  tabNumMapping(7) := 'Æâ';
  tabNumMapping(8) := '°Æ';
  tabNumMapping(9) := '¾Á';
  tabUnitMapping(-2) := '·Ö';
  tabUnitMapping(-1) := '½Ç';
  tabUnitMapping(1) := '';
  tabUnitMapping(2) := 'Ê°';
  tabUnitMapping(3) := '°Û';
  tabUnitMapping(4) := 'Çª';
  tabUnitMapping(5) := 'Íò';
  tabUnitMapping(6) := 'Ê°';
  tabUnitMapping(7) := '°Û';
  tabUnitMapping(8) := 'Çª';
  tabUnitMapping(9) := 'ÒÚ';
  For i In 1 .. numLenYuan Loop
    j            := numLenYuan - i + 1;
    numUnitIndex := Mod(i, 8);
    If numUnitIndex = 0 Then
      numUnitIndex := 8;
    End If;
    If numUnitIndex = 1 And i > 1 Then
      strRstYuan := tabUnitMapping(9) || strRstYuan;
    End If;
    charCurrentNum := substr(strYuan, j, 1);
    If charCurrentNum <> 0 Then
      strRstYuan := tabNumMapping(charCurrentNum) ||
                    tabUnitMapping(numUnitIndex) || strRstYuan;
    Else
      If (i = 1 Or i = 5) Then
        If substr(strYuan, j - 3, 4) <> '0000' Then
          strRstYuan := tabUnitMapping(numUnitIndex) || strRstYuan;
        End If;
      Else
        If substr(strYuan, j + 1, 1) <> '0' Then
          strRstYuan := tabNumMapping(charCurrentNum) || strRstYuan;
        End If;
      End If;
    End If;
  End Loop;
  For i In -2 .. -1 Loop
    j              := numLenYuan - i;
    charCurrentNum := substr(strYuanFen, j, 1);
    If charCurrentNum <> '0' Then
      strRstFen := tabNumMapping(charCurrentNum) || tabUnitMapping(i) ||
                   strRstFen;
    End If;
  End Loop;
  If strRstYuan Is Not Null Then
    strRstYuan := strRstYuan || 'Ô²';
  End If;
  If strRstFen Is Null Then
    strRstYuan := strRstYuan || 'Õû';
  Elsif length(strRstFen) = 2 And substr(strRstFen, 2) = '½Ç' Then
    strRstFen := strRstFen || 'Õû';
  End If;
  if Money < 0 then
    strRst := '¸º'|| strRstYuan || strRstFen;
  else
    strRst := strRstYuan || strRstFen;
  end if;
  --strRst := Replace(strRst, 'ÒÚÁã', 'ÒÚ');
  --strRst := Replace(strRst, 'ÍòÁã', 'Íò');
  Return strRst;
End;
/