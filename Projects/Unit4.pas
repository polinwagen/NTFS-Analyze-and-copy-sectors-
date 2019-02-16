unit Unit4;

interface

uses
  Classes,Windows, Messages, SysUtils, Variants,  Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl,ComCtrls, Buttons;

type
  ThrCopy = class(TThread)
  private
     ExitProcFlag:boolean;
     procedure CopySector;
    procedure DirSearch(Dir: string);
    procedure CopySectbysect;
  protected
    procedure Execute; override;
    destructor Destroy; override;
  end;
  var
  position:integer;

implementation
Uses Unit12,Unit11;


procedure ThrCopy.CopySectbysect;

begin
s:=Pchar('\\.\'+form11.DriveCombobox1.Drive+':');
s1:=Pchar('\\.\'+form11.DriveCombobox2.Drive+':');
SetCurrentDir(s1+'\');
position:=length(Filename)-length(CurrentName);
CreateDir(s1+'\'+CurrentName);
DirSearch(FileName);
 if ExitProcFlag then exit;
ShowMessage('����������� �������� "'+directory+'" � ��� ����������� ������� ���������!');
end;


procedure ThrCopy.DirSearch(Dir: string);
var
  SearchRec: TSearchRec;
  j:byte;

begin
  Dir := IncludeTrailingBackslash(Dir);
  FileName:=Dir;
  j:=0;


  if FindFirst(Dir + '*.*', faAnyFile, SearchRec) = 0 then
    repeat
      Application.ProcessMessages;

        if (SearchRec.Attr and faDirectory) <> 0 then begin
          if (SearchRec.name <> '.') and (SearchRec.name <> '..') then
          begin
            CreateDir(s1+'\'+copy(Dir,position+1,length(Dir)-position)+'\'+SearchRec.Name);
            DirSearch(Dir + SearchRec.name);
          end;
        end


      else
       begin
         if ExitProcFlag then exit;

       CurrentName:=Copy(Dir,position+1,length(Dir)-position);
       names:=ExtractFileName(SearchRec.Name);
       CopySector;
       names:='';



       end;


    until FindNext(SearchRec) <> 0;
  FindClose(SearchRec);
end;

procedure ThrCopy.CopySector;    //����������� �� ��������
var
  iFileHandle,iFileHandle1: Integer;
  iFileLength: Integer;
  iBytesRead: Integer;
  Buffer: PChar;
  i,j: Integer;
  m:integer;
begin

        I:=0;
      Form12.Memo1.Lines.Add('����������� �����:'+names);
      SetCurrentDir(s1+'\'+CurrentName);
     iFileHandle1:=CreateFile(Pchar(Names), GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_ALWAYS,0,0);
     FileClose(iFileHandle1);
      iFileHandle := FileOpen(FileName+'\'+Names, fmOpenRead);
      iFileLength := FileSeek(iFileHandle,0,2);
      iFileHandle1 := FileOpen(s1+'\'+CurrentName+'\'+Names, fmOpenWrite);
      Buffer := PChar(AllocMem(512 + 1));   //����������� �� ������ ������ ������ �������
         while I<=iFileLength do
         begin
          if ExitProcFlag then exit;


       FileSeek(iFileHandle,0,I);
       FileSeek(iFileHandle1,0,I);

      iBytesRead := FileRead(iFileHandle, Buffer^, 512);
      iBytesRead:=FileWrite(iFileHandle1, Buffer^, 512);


      m:=I div 512;
       Form12.Memo1.Lines.Add('���������� ������:'+inttostr(m));


      I:=I+512;

         end;

      FileClose(iFileHandle);
      FileClose(iFileHandle1);
      FreeMem(Buffer);
      inc(j);

  end;





procedure ThrCopy.Execute;
begin
CopySectbysect;
  { Place thread code here }
end;
destructor ThrCopy.Destroy;
begin
 ExitProcFlag:=true;
inherited Destroy;
end;
end.
