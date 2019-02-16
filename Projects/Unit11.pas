unit Unit11;

interface


uses
 Classes,Windows, Messages, SysUtils, Variants,  Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl,ComCtrls, Buttons, ShellAPI;

type
  TForm11 = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Button1: TButton;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    DriveComboBox2: TDriveComboBox;
    Label4: TLabel;
    BitBtn7: TBitBtn;
    BitBtn2: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);

  private
  public
   procedure Search;
     procedure UnPack;
    { Public declarations }
  end;

var

 SerialNum ,SerialNum1          : dword;
 VolumeName, FSName, VolumeName1, FSName1  : array [0..255] of ansichar;
 MaximumFNameLength,MaximumFNameLength1,
 FileSystemFlags,FileSystemFlags1     : dword;
 //
  Form11: TForm11;
  s,s1:PWidechar;
  sa,sa1: PAnsiChar;

  hDevice:THandle;
  buf1: array [0..108000] of byte;
  bResult:LongBool;
  lpBytesReturned:DWORD;
  FS: TFileStream;
  BS,attr,atrlenght:array [0..7] of byte;
  DATA:array [0..512] of byte;
  I,j,k,attrhead:byte;
  bootsect,mftbyte:int64;
  count,num,offset,t,first:integer;
  atroffset,atrhead,lenght:integer;
  select: array [0..20] of String;
  cloffs,frstcl,lstcl:array[0..10] of int64; // ��������.������ �������.��������� �������
  mfcloffs,mffrstcl,mflstcl:array[0..10] of int64;   // ������� ��� �������� �������� �������� DATA mft
  directoryf,CurrentName:string[100];
  FileName:string[50];
  DirectoryNames:array [1..20] of string[50];
  sr: TSearchRec;
  vl:byte;
implementation
 uses Unit12, ABOUT;
{$R *.dfm}

procedure TForm11.BitBtn2Click(Sender: TObject);
begin
 form11.Close;
end;

procedure TForm11.BitBtn7Click(Sender: TObject);
begin
ShellExecute(0, 'open', Pchar(ExtractFilePath(Application.ExeName) + 'help.chm'), nil, nil, SW_MAXIMIZE);
end;

procedure TForm11.Button1Click(Sender: TObject);
begin
  s:=PChar('\\.\'+form11.DriveCombobox1.Drive+':');
  s1:=PChar('\\.\'+form11.DriveCombobox2.Drive+':');

  sa:=Pansichar('\\.\'+form11.DriveCombobox1.Drive+':');

   bResult:=GetVolumeInformationA(sa, VolumeName, SizeOf(VolumeName),
                         @SerialNum,
                         MaximumFNameLength,
                       FileSystemFlags,
                       FSName, SizeOf(FSName)) ;




   if s=('\\.\c:')
then begin
  MessageBox(0, '����� ���������� ����� ��� �������-��������', '������', MB_ICONWARNING or MB_OK);
  exit;
  end;





   if AnsiCompareText(FSName,'FAT32')=0
then begin
  MessageBox(0, '�������� ������� FAT32 �� ��������������!', '������', MB_ICONWARNING or MB_OK);

  exit;
  end;



   if AnsiCompareText(FSName1,'FAT32')=0
then begin
  MessageBox(0, '�������� ������� FAT32 �� ��������������!', '������', MB_ICONWARNING or MB_OK);
  exit;
  end;


  //������ Boot-������ �����-���������
hDevice:=CreateFile(s, GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
 if hDevice=INVALID_HANDLE_VALUE    then begin ShowMessage(IntToStr(GetLastError)); exit; end;
  FillChar(buf1,sizeof(buf1),0);
 if(hDevice<>INVALID_HANDLE_VALUE) then begin
  SetFilePointer(hDevice,0,nil,FILE_BEGIN);
 bResult:=ReadFile(hDevice,buf1,512,lpBytesReturned,nil);
 end;
  j:=0;   //BootSector
 for I := 48 to 55  do
 begin
 BS[j]:=buf1[I];
 inc(j);
  end;
j:=0;
bootsect:=int64(BS);  //������ ������� mft


mftbyte:=bootsect*8*512;
// ������� ������� data �� mft �������� ��� 80h
//������� ��� mft

  FillChar(buf1,sizeof(buf1),0);
 if(hDevice<>INVALID_HANDLE_VALUE) then begin
  SetFilePointerEx(hDevice,mftbyte,nil,FILE_BEGIN);
  bResult:=ReadFile(hDevice,buf1,1024,lpBytesReturned,nil); //������ mft
 end;

 attrhead:=$80;

  Search(); //��������� � ������ DATA ���������� �������� DATA

                //���������� ������ �������� DATA
   offset:=64; // ������ �������� ���������� �� �������� � �������� DATA � ������� 40h

   UnPack(); // �������� ������ �������� �������� DATA ������� mft
            //cloffs,frstcl,lstcl-���������� ��������,�������������,��������� �������


    for I := 0 to 10 do
  begin
   mfcloffs[I]:=  cloffs[I];
   mffrstcl[I]:= frstcl[I];
   mflstcl[I]:= lstcl[I];
  end;




 j:=1;
 k:=1;
 for I := 0 to 20 do
  select[i]:='';
  num:=0;
 CurrentName:=ExtractFileName(DirectoryListBox1.Directory); //��� ��������� ��������
 FileName:=ExtractFileDir(ExpandUNCFileName(CurrentName));
 first:=4;
 vl:=4;
 for I := 1 to length(FileName) do
 begin
  if FileName[first+I]='\' then
  begin
  DirectoryNames[j]:=copy(FileName,vl,k);
  vl:=vl+k+1;
  inc(j);
  k:=0;
  end
  else
  inc(k);
 end;
 j:=0;

 for I := 0 to (FileListBox1.Items.Count-1) do
 begin
   if FileListBox1.Selected[i] then
    begin
     select[num]:=ExtractFileName(FileListBox1.Items[i]); //����� ������ � �������
     num:=num+1;
    end;

 end;



 if select[0]='' then
 begin
 MessageBox(0, '�� ������ �� ���� ����', '������', MB_ICONWARNING or MB_OK);
  exit;
 end;

 Form12.Show ;

 end;


























procedure TForm11.DirectoryListBox1Change(Sender: TObject);
begin
FileListBox1.Directory := DirectoryListBox1.Directory;
end;

procedure TForm11.DriveComboBox1Change(Sender: TObject);
begin
DirectoryListBox1.Drive := DriveComboBox1.Drive;
end;



procedure TForm11.Search;  //��������� ������ ��������  DATA � ��� ���������� � ������
var
I,j:integer;

begin
 j:=0;   //�������� ������� ��������
 for I := 20 to 21  do
 begin
 attr[j]:=buf1[I];
 inc(j);
  end;
 j:=0;
 atroffset:=int64(attr);

  while buf1[atroffset]<>attrhead do
   begin
     j:=0;


        for I := atroffset+4 to atroffset+7 do  // ���� ��������� �� ������������� 80h ��,��������� ����� ���

             begin
              atrlenght[j]:=buf1[I];
              inc(j);
             end;



      atroffset:=int64(atrlenght)+atroffset;

  end;
        j:=0;


        for I := atroffset+4 to atroffset+7 do

             begin
              atrlenght[j]:=buf1[I];
              inc(j);
             end;

       lenght:=int64(atrlenght);


         j:=0;

          for I :=atroffset to atroffset+ lenght do  //��������� ��� DATA
             begin
              DATA[j]:=buf1[I];
              inc(j);
             end;



end;

procedure TForm11.SpeedButton1Click(Sender: TObject);
begin
AboutBox.ShowModal;
end;

procedure TForm11.UnPack;
 var
 lo,hi,analyz:byte;
 firstcluster,clusteroffset,lastcluster: array [0..7] of byte;
 I1,I,j:byte;


     begin
       I1:=0;
       j:=0;

         FillChar(firstcluster,sizeof(firstcluster),0);
         FillChar(clusteroffset,sizeof(clusteroffset),0);
         FillChar(lastcluster,sizeof(lastcluster),0);

       while DATA[offset]<>0 do
       begin
        analyz:=DATA[offset];
        hi:=(analyz and  $F0)shr 4; //������ ���������� �������� (������� 4 �������)
        lo:=analyz and $0F; //������ �������� (������� 4 �������)
         for I := offset+1 to offset+lo do
            begin
            clusteroffset[j]:=DATA[I];
            inc(j);
           end;
           j:=0;

           cloffs[I1]:=int64(clusteroffset);



         for I := offset+1+lo to offset+lo+hi do
           begin
            firstcluster[j]:=DATA[I];
            inc(j);
           end;
           j:=0;

           frstcl[I1]:=int64(firstcluster);

           if I1>0 then
            frstcl[I1]:=  frstcl[I1]+ frstcl[I1-1];

           lstcl[I1]:=frstcl[I1]+cloffs[I1];
           offset:=offset+lo+hi+1;
           inc(I1);

        end;

     end;



end.
