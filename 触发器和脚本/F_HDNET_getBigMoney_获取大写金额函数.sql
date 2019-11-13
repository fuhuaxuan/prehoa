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
    strRst := '��Բ��';
    Return strRst;
  End If;
  tabNumMapping(0) := '��';
  tabNumMapping(1) := 'Ҽ';
  tabNumMapping(2) := '��';
  tabNumMapping(3) := '��';
  tabNumMapping(4) := '��';
  tabNumMapping(5) := '��';
  tabNumMapping(6) := '½';
  tabNumMapping(7) := '��';
  tabNumMapping(8) := '��';
  tabNumMapping(9) := '��';
  tabUnitMapping(-2) := '��';
  tabUnitMapping(-1) := '��';
  tabUnitMapping(1) := '';
  tabUnitMapping(2) := 'ʰ';
  tabUnitMapping(3) := '��';
  tabUnitMapping(4) := 'Ǫ';
  tabUnitMapping(5) := '��';
  tabUnitMapping(6) := 'ʰ';
  tabUnitMapping(7) := '��';
  tabUnitMapping(8) := 'Ǫ';
  tabUnitMapping(9) := '��';
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
    strRstYuan := strRstYuan || 'Բ';
  End If;
  If strRstFen Is Null Then
    strRstYuan := strRstYuan || '��';
  Elsif length(strRstFen) = 2 And substr(strRstFen, 2) = '��' Then
    strRstFen := strRstFen || '��';
  End If;
  if Money < 0 then
    strRst := '��'|| strRstYuan || strRstFen;
  else
    strRst := strRstYuan || strRstFen;
  end if;
  --strRst := Replace(strRst, '����', '��');
  --strRst := Replace(strRst, '����', '��');
  Return strRst;
End;
/